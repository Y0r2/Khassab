# 🗝️ دليل الحصول على مفتاح Google Maps API

## الخطوة 1: إنشاء مشروع Google Cloud

### 1. الدخول إلى Google Cloud Console
- اذهب إلى: https://console.cloud.google.com/
- سجل الدخول بحساب Google الخاص بك

### 2. إنشاء مشروع جديد
```
1. انقر على "Select a project" في الأعلى
2. انقر على "New Project"
3. اسم المشروع: "Khassab Environmental App"
4. انقر على "Create"
```

## الخطوة 2: تفعيل APIs المطلوبة

### 1. الانتقال إلى مكتبة APIs
```
الشريط الجانبي → APIs & Services → Library
```

### 2. تفعيل الخدمات التالية:
```
1. ابحث عن "Maps SDK for Android" → انقر Enable
2. ابحث عن "Maps SDK for iOS" → انقر Enable  
3. ابحث عن "Places API" → انقر Enable
4. ابحث عن "Geocoding API" → انقر Enable
```

## الخطوة 3: إنشاء API Key

### 1. إنشاء المفتاح
```
الشريط الجانبي → APIs & Services → Credentials
انقر على "+ CREATE CREDENTIALS"
اختر "API Key"
انسخ المفتاح الجديد
```

### 2. تأمين المفتاح (مهم!)
```
1. انقر على "RESTRICT KEY"
2. في "Application restrictions":
   - اختر "Android apps"
   - انقر "Add an item"
   - Package name: com.khassab.app
   - SHA-1: (اتركه فارغاً للتطوير)

3. في "API restrictions":
   - اختر "Restrict key"
   - حدد هذه الخدمات:
     ✓ Maps SDK for Android
     ✓ Maps SDK for iOS
     ✓ Places API
     ✓ Geocoding API

4. انقر "Save"
```

## الخطوة 4: إضافة المفتاح للمشروع

### Android (مطلوب):
```xml
<!-- في android/app/src/main/AndroidManifest.xml -->
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY_HERE" />
```

### iOS (للمستقبل):
```swift
// في ios/Runner/AppDelegate.swift
GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
```

## ✅ اختبار المفتاح

بعد إضافة المفتاح:
1. قم بـ Hot Restart للتطبيق
2. اذهب لتبويب الخريطة
3. يجب أن تظهر خريطة عسير بوضوح

## 🆘 حل المشاكل

### المشكلة: "For development purposes only"
```
السبب: المفتاح غير مقيد بشكل صحيح
الحل: أضف تقييدات Android apps مع package name
```

### المشكلة: خريطة رمادية
```
السبب: الخدمات غير مفعلة أو المفتاح خاطئ
الحل: تأكد من تفعيل جميع الخدمات الأربع المذكورة
```

### المشكلة: "API key not valid"
```
السبب: Package name مختلف أو المفتاح لا يدعم Android
الحل: تأكد من package name = com.khassab.app
```

## 💰 التكلفة

- **مجاني**: 28,500 تحميل خريطة شهرياً
- **تطبيق خصب**: سيعمل ضمن الحد المجاني
- **لا حاجة لبطاقة ائتمان** للاستخدام المحدود

---

## 📞 إذا واجهت صعوبة:

1. تأكد من تفعيل جميع الخدمات الأربع
2. تأكد من package name = com.khassab.app  
3. أعد تشغيل التطبيق بالكامل
4. راجع Android Studio logs للأخطاء

**المفتاح الحالي للاختبار**: AIzaSyDVQlhSwov2h88nCt5Gd40BNPHIr39Pn7w
