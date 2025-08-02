
// كود Arduino متكامل لعربة "خصب" الذكية للتسميد
// العربة تستقبل النفايات، تُغلق الغطاء أوتوماتيكياً، تقيس الوزن، وتحدث بيانات الشجرة

#include <Servo.h>
#include <HX711.h>       // حساس الوزن
#include <SoftwareSerial.h>
#include <TinyGPS++.h>   // GPS
#include <Wire.h>

// ======================== الإعداد ==========================
#define TRIG_PIN 9       // حساس المسافة
#define ECHO_PIN 8
#define SERVO_PIN 3      // محرك فتح وإغلاق الغطاء
#define LOADCELL_DOUT_PIN 5
#define LOADCELL_SCK_PIN 6
#define GPS_RX 4
#define GPS_TX 7

Servo lidServo;
HX711 scale;
SoftwareSerial gpsSerial(GPS_RX, GPS_TX);
TinyGPSPlus gps;

float weight = 0;
long lastUpdate = 0;

// ======================== الإعداد ==========================
void setup() {
  Serial.begin(9600);
  gpsSerial.begin(9600);

  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

  lidServo.attach(SERVO_PIN);
  lidServo.write(0); // الغطاء مغلق

  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);
  scale.set_scale();            // ضبط الحساسية
  scale.tare();                 // تصفير الوزن

  Serial.println("🚀 نظام خصب الذكي جاهز");
}

// ======================== الحلقة الرئيسية ==========================
void loop() {
  if (detectWaste()) {
    openLid();
    delay(5000); // مهلة لوضع النفايات
    closeLid();

    float currentWeight = measureWeight();
    Serial.print("♻️ تم رمي نفايات بوزن: "); Serial.println(currentWeight);

    if (millis() - lastUpdate > 10000) {
      updateTreeLocation();
      lastUpdate = millis();
    }
  }
  delay(1000);
}

// ======================== الدوال المساعدة ==========================
bool detectWaste() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  long duration = pulseIn(ECHO_PIN, HIGH);
  int distance = duration * 0.034 / 2;

  return distance < 15; // إذا اقترب المستخدم
}

void openLid() {
  lidServo.write(90);
  Serial.println("✅ فتح الغطاء");
}

void closeLid() {
  lidServo.write(0);
  Serial.println("❌ إغلاق الغطاء");
}

float measureWeight() {
  return scale.get_units();
}

void updateTreeLocation() {
  while (gpsSerial.available() > 0) {
    gps.encode(gpsSerial.read());
    if (gps.location.isUpdated()) {
      Serial.print("📍 موقع الشجرة: ");
      Serial.print(gps.location.lat(), 6);
      Serial.print(", ");
      Serial.println(gps.location.lng(), 6);
      break;
    }
  }
}
