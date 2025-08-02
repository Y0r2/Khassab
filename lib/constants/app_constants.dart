import 'package:flutter/material.dart';

/// ألوان التطبيق الثابتة - يمكن استخدامها في جميع أنحاء التطبيق
class AppColors {
  // الألوان الأساسية
  static const Color primaryGreen = Color(0xFF4CAF50); // أخضر طبيعي
  static const Color darkGreen = Color(0xFF2E7D32); // أخضر داكن
  static const Color lightGreen = Color(0xFF66BB6A); // أخضر فاتح
  static const Color veryLightGreen = Color(0xFFF1F8E9); // أخضر فاتح جداً
  static const Color accentGreen = Color(0xFF81C784); // أخضر مميز

  // ألوان الخلفية
  static const Color backgroundLight = Color(0xFFF1F8E9);
  static const Color backgroundCard = Color(0xFFE8F5E8);
  static const Color backgroundGradientTop = Color(0xFFF1F8E9);
  static const Color backgroundGradientMiddle = Color(0xFFE8F5E8);
  static const Color backgroundGradientBottom = Color(0xFFC8E6C9);

  // ألوان النص
  static const Color textPrimary = Color(0xFF1B5E20);
  static const Color textSecondary = Color(0xFF4CAF50);
  static const Color textLight = Color(0xFF757575);

  // ألوان الحالة
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB300);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // ألوان الظلال
  static Color shadowLight = Colors.black.withOpacity(0.05);
  static Color shadowMedium = Colors.black.withOpacity(0.1);
  static Color shadowDark = Colors.black.withOpacity(0.15);

  // ألوان مواقع الخريطة
  static const Color smartBinAvailable = Color(0xFF4CAF50);
  static const Color smartBinFull = Color(0xFFFF5722);
  static const Color plantLocation = Color(0xFF66BB6A);
}

/// أيقونات التطبيق المستخدمة بكثرة
class AppIcons {
  // أيقونات رئيسية
  static const IconData home = Icons.home;
  static const IconData homeOutlined = Icons.home_outlined;
  static const IconData map = Icons.map;
  static const IconData mapOutlined = Icons.map_outlined;
  static const IconData chat = Icons.chat;
  static const IconData chatOutlined = Icons.chat_outlined;
  static const IconData profile = Icons.person;
  static const IconData profileOutlined = Icons.person_outline;

  // أيقونات بيئية
  static const IconData tree = Icons.park;
  static const IconData leaf = Icons.eco;
  static const IconData recycle = Icons.recycling;
  static const IconData flower = Icons.local_florist;
  static const IconData seed = Icons.grass;

  // أيقونات العمليات
  static const IconData qrScan = Icons.qr_code_scanner;
  static const IconData location = Icons.location_on;
  static const IconData locationOutlined = Icons.location_on_outlined;
  static const IconData points = Icons.stars;
  static const IconData waste = Icons.delete_outline;

  // أيقونات التفاعل
  static const IconData send = Icons.send;
  static const IconData share = Icons.share;
  static const IconData filter = Icons.filter_list;
  static const IconData search = Icons.search;
  static const IconData myLocation = Icons.my_location;

  // أيقونات المعلومات
  static const IconData email = Icons.email_outlined;
  static const IconData phone = Icons.phone_outlined;
  static const IconData time = Icons.schedule;
  static const IconData help = Icons.help_outline;
  static const IconData support = Icons.contact_support;

  // أيقونات الإعدادات
  static const IconData settings = Icons.settings;
  static const IconData notifications = Icons.notifications_outlined;
  static const IconData privacy = Icons.privacy_tip_outlined;
  static const IconData logout = Icons.logout;

  // أيقونات الحالة
  static const IconData check = Icons.check;
  static const IconData error = Icons.error_outline;
  static const IconData warning = Icons.warning_outlined;
  static const IconData info = Icons.info_outline;

  // أيقونات التسجيل
  static const IconData lock = Icons.lock_outline;
  static const IconData visibility = Icons.visibility;
  static const IconData visibilityOff = Icons.visibility_off;
  static const IconData personAdd = Icons.person_add;
}

/// أحجام النصوص المستخدمة في التطبيق
class AppTextSizes {
  // أحجام العناوين
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 28.0;
  static const double headlineSmall = 24.0;

  // أحجام النصوص الرئيسية
  static const double titleLarge = 22.0;
  static const double titleMedium = 18.0;
  static const double titleSmall = 16.0;

  // أحجام النصوص العادية
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;

  // أحجام النصوص الصغيرة
  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 10.0;
}

/// مسافات وأبعاد التطبيق
class AppDimensions {
  // المسافات الصغيرة
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // نصف أقطار الزوايا
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;
  static const double radiusButton = 25.0;

  // ارتفاعات الشاشات
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 60.0;
  static const double cardHeight = 120.0;

  // عرض وارتفاع الأيقونات
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;

  // الحواف والحشو
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // الظلال
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
}

/// سلاسل نصية ثابتة للتطبيق
class AppStrings {
  // عناوين التطبيق
  static const String appName = 'خصب';
  static const String appSlogan = 'التطبيق البيئي الذكي';
  static const String appDescription = 'نحو بيئة أفضل للجميع';

  // عناوين الصفحات
  static const String loginTitle = 'تسجيل الدخول';
  static const String registerTitle = 'إنشاء حساب جديد';
  static const String homeTitle = 'الرئيسية';
  static const String mapTitle = 'خريطة خصب';
  static const String chatTitle = 'الدعم والمساعدة';
  static const String profileTitle = 'الملف الشخصي';

  // رسائل الترحيب
  static const String welcomeBack = 'أهلاً بعودتك';
  static const String welcomeMessage = 'نورتنا من جديد';
  static const String joinFamily = 'انضم لعائلة خصب';
  static const String contributeMessage =
      'ساهم في حماية البيئة واكسب نقاط خضراء';

  // النقاط والإنجازات
  static const String greenPoints = 'نقطة خضراء';
  static const String treeLevel = 'مستوى الشجرة';
  static const String virtualTree = 'شجرتك الافتراضية';
  static const String wasteCollected = 'مرة تخلص من النفايات';
  static const String plantsHelped = 'نبتة ساعدت في تسميدها';

  // رسائل التشجيع
  static const String greatJob = 'عمل رائع!';
  static const String keepGoing = 'واصل العمل الجيد';
  static const String environmentalImpact = 'تأثيرك البيئي الإيجابي';

  // رسائل الأخطاء
  static const String emailRequired = 'يرجى إدخال البريد الإلكتروني';
  static const String passwordRequired = 'يرجى إدخال كلمة المرور';
  static const String invalidEmail = 'يرجى إدخال بريد إلكتروني صحيح';
  static const String passwordTooShort =
      'كلمة المرور يجب أن تكون 8 أحرف على الأقل';

  // رسائل النجاح
  static const String loginSuccess = 'تم تسجيل الدخول بنجاح';
  static const String registerSuccess =
      'تم إنشاء الحساب بنجاح! أهلاً بك في خصب';
  static const String qrScanSuccess = 'حصلت على +50 نقطة خضراء!';
  static const String thanksContribution = 'شكراً لمساهمتك في حماية البيئة';
}

/// قيم ثابتة للتطبيق
class AppConstants {
  // أرقام النقاط
  static const int pointsPerQRScan = 50;
  static const int pointsPerBinUse = 25;
  static const int pointsToNextLevel = 500;

  // حدود الإدخال
  static const int maxMessageLength = 500;
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;

  // معلومات الاتصال
  static const String supportEmail = 'support@khassab.com';
  static const String supportPhone = '+966 11 234 5678';
  static const String websiteUrl = 'https://khassab.com';

  // إعدادات الخريطة
  static const double defaultLatitude = 24.7136;
  static const double defaultLongitude = 46.6753;
  static const double defaultZoom = 13.0;

  // مدد الانتظار
  static const Duration loginDelay = Duration(seconds: 2);
  static const Duration chatResponseDelay = Duration(seconds: 2);
  static const Duration animationDuration = Duration(milliseconds: 300);
}

/// أنماط الخلفيات المتدرجة
class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppColors.primaryGreen, AppColors.lightGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.backgroundGradientTop,
      AppColors.backgroundGradientMiddle,
      AppColors.backgroundGradientBottom,
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [AppColors.accentGreen, AppColors.primaryGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
