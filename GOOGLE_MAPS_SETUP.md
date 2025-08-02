# دليل إعداد Google Maps للتطبيق

## 📍 الخدمات المطلوبة لتطبيق خصب

### 1. **Maps SDK for Android** 
- **الغرض**: عرض الخرائط في التطبيق على Android
- **الحالة**: ⚠️ يجب تفعيلها

### 2. **Maps SDK for iOS**
- **الغرض**: عرض الخرائط في التطبيق على iOS  
- **الحالة**: ⚠️ يجب تفعيلها

### 3. **Places API**
- **الغرض**: البحث عن الأماكن والمواقع
- **الحالة**: ⚠️ يجب تفعيلها

---

## 🛠️ خطوات التفعيل

### الخطوة 1: إنشاء مشروع في Google Cloud
1. اذهب إلى: https://console.cloud.google.com/
2. انقر على "Select a project" أو "إنشاء مشروع"
3. أنشئ مشروع جديد باسم "khassab-app"

### الخطوة 2: تفعيل APIs المطلوبة
انتقل إلى "APIs & Services" > "Library" وابحث عن:

#### أ) Maps SDK for Android
- ابحث عن: "Maps SDK for Android"
- انقر على النتيجة الأولى
- انقر على "Enable"

#### ب) Maps SDK for iOS  
- ابحث عن: "Maps SDK for iOS"
- انقر على النتيجة الأولى
- انقر على "Enable"

#### ج) Places API
- ابحث عن: "Places API"
- انقر على النتيجة الأولى
- انقر على "Enable"

### الخطوة 3: إنشاء API Key
1. اذهب إلى "APIs & Services" > "Credentials"
2. انقر على "Create Credentials" > "API Key"
3. انسخ المفتاح الجديد
4. انقر على "Restrict Key" لتأمينه

### الخطوة 4: تقييد API Key (مهم للأمان)
في إعدادات API Key:
- **Application restrictions**: Android apps
- **API restrictions**: اختر:
  - Maps SDK for Android
  - Maps SDK for iOS
  - Places API

### الخطوة 5: إضافة package name للتطبيق
في Android restrictions:
- Package name: `com.example.khassab_app`
- SHA-1 certificate fingerprint: (احصل عليه من Android Studio)

---

## 🔧 تحديث المفتاح في التطبيق

بعد الحصول على المفتاح الجديد، استبدل المفتاح القديم في:

### Android:
`android/app/src/main/AndroidManifest.xml`
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_NEW_API_KEY_HERE" />
```

### iOS (عند الحاجة):
`ios/Runner/AppDelegate.swift`

---

## ✅ اختبار التطبيق

بعد التحديث:
1. قم بـ Hot Restart للتطبيق
2. اذهب لتبويب "الخريطة"
3. يجب أن تظهر خريطة منطقة عسير مع العلامات

---

## 🆘 حل المشاكل الشائعة

### مشكلة: "For development purposes only"
- **السبب**: API Key غير مقيد
- **الحل**: قيد API Key حسب الخطوة 4

### مشكلة: خريطة رمادية فارغة
- **السبب**: API Key غير صحيح أو غير مفعل
- **الحل**: تحقق من صحة المفتاح والخدمات المفعلة

### مشكلة: "API key not valid"
- **السبب**: المفتاح لا يدعم Maps SDK for Android
- **الحل**: أضف الخدمة في API restrictions

---

## 💰 التكلفة

- **الاستخدام المجاني**: 28,500 تحميل خريطة شهرياً
- **تطبيق خصب**: استخدام محدود ومقبول ضمن الحد المجاني
- **لا توجد تكلفة** للاستخدام العادي للتطبيق

---

## 📞 الدعم

إذا واجهت مشاكل:
1. تأكد من تفعيل جميع الخدمات الثلاث
2. تحقق من صحة package name
3. أعد تشغيل التطبيق بالكامل
4. راجع Android Studio logs للأخطاء
