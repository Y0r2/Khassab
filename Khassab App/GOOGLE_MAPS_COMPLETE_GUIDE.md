# دليل شامل لـ Google Maps API - تطبيق خصب منطقة عسير

## 🗺️ نظرة عامة
هذا الدليل يشرح كيفية الحصول على Google Maps API Key واستخدامها في تطبيق خصب البيئي لمنطقة عسير.

## 📋 متطلبات أساسية
- حساب Google Cloud Platform
- مشروع Firebase (اختياري)
- Android Studio أو VS Code
- Flutter SDK

## 🔑 الحصول على Google Maps API Key

### الخطوة 1: إنشاء مشروع في Google Cloud Console
1. اذهب إلى [Google Cloud Console](https://console.cloud.google.com/)
2. انقر على "إنشاء مشروع" أو "Create Project"
3. أدخل اسم المشروع: "خصب-عسير" أو "Khassab Aseer"
4. اختر منطقة جغرافية مناسبة (المملكة العربية السعودية)

### الخطوة 2: تفعيل Google Maps APIs
1. في لوحة التحكم، اذهب إلى "APIs & Services" > "Library"
2. ابحث عن وفعل الـ APIs التالية:
   - **Maps SDK for Android** (للأندرويد)
   - **Maps SDK for iOS** (للآيفون)
   - **Places API** (للأماكن)
   - **Geocoding API** (لتحويل العناوين)
   - **Directions API** (للاتجاهات)

### الخطوة 3: إنشاء API Key
1. اذهب إلى "APIs & Services" > "Credentials"
2. انقر على "Create Credentials" > "API key"
3. سيتم إنشاء مفتاح API جديد
4. انسخ المفتاح واحفظه في مكان آمن

### الخطوة 4: تقييد API Key (مهم للأمان)
1. انقر على API Key الذي أنشأته
2. في قسم "Application restrictions":
   - للأندرويد: اختر "Android apps"
   - أدخل Package name: `com.khassab.app`
   - أدخل SHA-1 fingerprint الخاص بتطبيقك
3. في قسم "API restrictions":
   - اختر "Restrict key"
   - حدد APIs المطلوبة فقط

## 🛠️ إعداد التطبيق

### إعداد Android

#### 1. إضافة API Key في android/app/src/main/AndroidManifest.xml:
```xml
<application
    android:label="خصب - Khassab"
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher">
    
    <!-- إضافة Google Maps API Key -->
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="YOUR_API_KEY_HERE"/>
    
    <!-- بقية الكود... -->
</application>
```

#### 2. إضافة الصلاحيات المطلوبة:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### إعداد iOS

#### 1. إضافة API Key في ios/Runner/AppDelegate.swift:
```swift
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

#### 2. إضافة الصلاحيات في ios/Runner/Info.plist:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>يحتاج التطبيق للموقع لإظهار العربات الذكية والحدائق في منطقة عسير</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>يحتاج التطبيق للموقع لإظهار العربات الذكية والحدائق في منطقة عسير</string>
```

## 📦 إعداد pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.5.0
  location: ^5.0.3
  geolocator: ^10.1.0
  geocoding: ^2.1.1
```

## 🎯 نموذج تطبيقي - خريطة عسير

### الكود الأساسي:
```dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPageAseer extends StatefulWidget {
  @override
  _MapPageAseerState createState() => _MapPageAseerState();
}

class _MapPageAseerState extends State<MapPageAseer> {
  GoogleMapController? mapController;
  
  // إحداثيات منطقة عسير
  static const LatLng _aseerCenter = LatLng(18.2465, 42.5059); // أبها
  
  Set<Marker> _markers = {};
  
  @override
  void initState() {
    super.initState();
    _addAseerMarkers();
  }
  
  void _addAseerMarkers() {
    _markers = {
      // أبها
      Marker(
        markerId: MarkerId('abha'),
        position: LatLng(18.2465, 42.5059),
        infoWindow: InfoWindow(title: 'أبها', snippet: 'عاصمة عسير'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
      // خميس مشيط
      Marker(
        markerId: MarkerId('khamis'),
        position: LatLng(18.3059, 42.7295),
        infoWindow: InfoWindow(title: 'خميس مشيط'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
      // بيشة
      Marker(
        markerId: MarkerId('bisha'),
        position: LatLng(20.0077, 42.6051),
        infoWindow: InfoWindow(title: 'بيشة'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('خريطة منطقة عسير'),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _aseerCenter,
          zoom: 8.0,
        ),
        markers: _markers,
        mapType: MapType.hybrid,
      ),
    );
  }
}
```

## 🔒 أمان API Key

### 1. إخفاء API Key في الكود:
قم بإنشاء ملف `lib/config/api_keys.dart`:
```dart
class ApiKeys {
  static const String googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
    defaultValue: 'YOUR_DEFAULT_KEY_HERE'
  );
}
```

### 2. تشغيل التطبيق مع المتغير:
```bash
flutter run --dart-define=GOOGLE_MAPS_API_KEY=your_actual_api_key_here
```

## 📊 مراقبة الاستخدام والتكلفة

### في Google Cloud Console:
1. اذهب إلى "APIs & Services" > "Quotas"
2. راقب استخدامك اليومي والشهري
3. ضع حدود للاستخدام لتجنب الرسوم غير المتوقعة

### الحدود المجانية:
- **Maps SDK for Android/iOS**: 28,500 استدعاء شهرياً
- **Places API**: 17,000 استدعاء شهرياً
- **Geocoding API**: 40,000 استدعاء شهرياً

## 🌟 ميزات متقدمة لتطبيق عسير

### 1. إضافة العربات الذكية:
```dart
void _addSmartBins() {
  _markers.add(
    Marker(
      markerId: MarkerId('smart_bin_1'),
      position: LatLng(18.2465, 42.5059),
      infoWindow: InfoWindow(
        title: 'عربة ذكية',
        snippet: 'متاحة - 65% ممتلئة',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
  );
}
```

### 2. إضافة الحدائق المخصبة:
```dart
void _addGardens() {
  _markers.add(
    Marker(
      markerId: MarkerId('garden_1'),
      position: LatLng(18.2500, 42.5100),
      infoWindow: InfoWindow(
        title: 'حديقة مخصبة',
        snippet: 'آخر تخصيب: منذ 3 أيام',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ),
  );
}
```

## 🔧 استكشاف الأخطاء

### مشاكل شائعة:

#### 1. "Map fails to load" (الخريطة لا تظهر):
- تأكد من صحة API Key
- تأكد من تفعيل Maps SDK في Google Cloud Console
- تحقق من Package name في Android

#### 2. "API Key restriction error":
- تأكد من إضافة Package name الصحيح
- تأكد من SHA-1 fingerprint الصحيح
- تحقق من تفعيل APIs المطلوبة

#### 3. "Location permission denied":
```dart
Future<void> _requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
}
```

## 📱 اختبار التطبيق

### 1. على المحاكي:
```bash
flutter run
```

### 2. على جهاز حقيقي:
```bash
flutter run --release
```

### 3. اختبار Google Maps:
- تأكد من ظهور الخريطة
- اختبر التكبير والتصغير
- اختبر النقر على العلامات

## 🎨 تخصيص الخريطة لعسير

### ألوان مناسبة لطبيعة عسير:
```dart
// ألوان جبال عسير الخضراء
static const Color aseerGreen = Color(0xFF2E7D32);
static const Color aseerBrown = Color(0xFF5D4037);
static const Color aseerBlue = Color(0xFF1976D2);
```

### خريطة مخصصة (اختياري):
```dart
String mapStyle = '''[
  {
    "featureType": "landscape",
    "elementType": "geometry",
    "stylers": [{"color": "#2E7D32"}]
  }
]''';

GoogleMap(
  onMapCreated: (controller) {
    controller.setMapStyle(mapStyle);
  },
  // باقي الإعدادات...
)
```

## 📋 قائمة التحقق النهائية

- [ ] إنشاء مشروع Google Cloud
- [ ] تفعيل Maps SDK for Android/iOS  
- [ ] إنشاء وتقييد API Key
- [ ] إضافة API Key في AndroidManifest.xml
- [ ] إضافة API Key في iOS AppDelegate
- [ ] إضافة الصلاحيات المطلوبة
- [ ] تحديث pubspec.yaml
- [ ] اختبار التطبيق على المحاكي
- [ ] اختبار التطبيق على جهاز حقيقي
- [ ] مراقبة الاستخدام والتكلفة

## 🆘 الدعم والمساعدة

### في حالة المشاكل:
1. راجع [وثائق Google Maps Flutter](https://pub.dev/packages/google_maps_flutter)
2. تحقق من [Google Cloud Console](https://console.cloud.google.com/) للأخطاء
3. راجع سجلات التطبيق: `flutter logs`

### API Key الحالي المستخدم في التطبيق:
```
AIzaSyB5Tgq8SdDcT_p4ZouLx8S2vKF3nD8MHoI
```

**ملاحظة هامة**: هذا المفتاح مُحدث ومُعد للعمل مع تطبيق خصب منطقة عسير.

---

**تم إعداد هذا الدليل خصيصاً لتطبيق خصب البيئي في منطقة عسير 🌱**
