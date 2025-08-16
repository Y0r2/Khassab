import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'firebase_options.dart';
import 'constants/app_constants.dart';
import 'pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase مع الإعدادات الصحيحة
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const KhassabApp());
}

/// التطبيق الرئيسي لمشروع خصب البيئي الذكي
class KhassabApp extends StatelessWidget {
  const KhassabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${AppStrings.appName} - ${AppStrings.appSlogan}',
      debugShowCheckedModeBanner: false,

      // إعدادات اللغة العربية وRTL
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // نمط التطبيق بالألوان الخضراء الطبيعية
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: AppColors.darkGreen,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGreen,
          brightness: Brightness.light,
        ),

        // النصوص باللغة العربية
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textPrimary),
          displayLarge: TextStyle(color: AppColors.textPrimary),
          displayMedium: TextStyle(color: AppColors.textPrimary),
          headlineLarge: TextStyle(color: AppColors.textPrimary),
          headlineMedium: TextStyle(color: AppColors.textPrimary),
        ),

        // أزرار خضراء مستديرة
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusButton),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingXLarge,
              vertical: AppDimensions.paddingMedium,
            ),
          ),
        ),

        // حقول النص بتصميم أنيق
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            borderSide: const BorderSide(color: AppColors.primaryGreen),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            borderSide: const BorderSide(color: AppColors.backgroundCard),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            borderSide:
                const BorderSide(color: AppColors.primaryGreen, width: 2),
          ),
        ),

        useMaterial3: true,
      ),

      // الصفحة الرئيسية هي صفحة تسجيل الدخول
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundLight,
              AppColors.backgroundCard,
              AppColors.primaryGreen
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              children: [
                const SizedBox(height: AppDimensions.spacingXLarge),

                // شعار التطبيق
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusLarge),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.all(AppDimensions.paddingMedium),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.eco,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingMedium),
                      Text(
                        AppStrings.welcomeBack,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingSmall),
                      Text(
                        AppStrings.appSlogan,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.spacingXLarge),

                // نموذج تسجيل الدخول
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusLarge),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'تسجيل الدخول',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreen,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacingLarge),

                        // البريد الإلكتروني
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textDirection: TextDirection.ltr,
                          decoration: const InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            hintText: 'example@email.com',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال البريد الإلكتروني';
                            }
                            if (!value.contains('@')) {
                              return 'يرجى إدخال بريد إلكتروني صحيح';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppDimensions.spacingMedium),

                        // كلمة المرور
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            hintText: '••••••••',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور';
                            }
                            if (value.length < 6) {
                              return AppStrings.passwordTooShort;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppDimensions.spacingXLarge),

                        // زر تسجيل الدخول
                        ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : const Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.spacingLarge),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ليس لديك حساب؟ ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'إنشاء حساب',
                        style: TextStyle(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const MapPageAseer(),
    const ChatPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'خريطة عسير',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'الدعم',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الملف الشخصي',
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            children: [
              // ترحيب
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryGreen, Color(0xFF66BB6A)],
                  ),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'أهلاً وسهلاً، أحمد',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.spacingSmall),
                          const Text(
                            'لنحمي بيئة عسير الجميلة معاً! 🌱',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMedium),
                      ),
                      child: const Icon(Icons.landscape,
                          size: 40, color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.spacingLarge),

              // النقاط والإحصائيات
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      Icons.stars,
                      '2,450',
                      'نقطة خضراء',
                      const Color(0xFFFFB300),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  Expanded(
                    child: _buildStatCard(
                      Icons.landscape,
                      'المستوى 7',
                      'شجرتك في عسير',
                      AppColors.primaryGreen,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.spacingLarge),

              // مسح QR Code
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF81C784), AppColors.primaryGreen],
                  ),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusLarge),
                    onTap: () => _showQRSuccessDialog(context),
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(
                                AppDimensions.paddingSmall),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.paddingSmall),
                            ),
                            child: const Icon(Icons.qr_code_scanner,
                                size: 32, color: Colors.white),
                          ),
                          const SizedBox(width: AppDimensions.spacingMedium),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'مسح رمز QR',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'امسح رمز العربة الذكية في منطقة عسير',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.spacingLarge),

              // نصيحة بيئية خاصة بعسير
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline,
                            color: AppColors.primaryGreen),
                        SizedBox(width: AppDimensions.spacingSmall),
                        Text(
                          'نصيحة بيئية - منطقة عسير',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreen,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.spacingSmall),
                    Text(
                      'أشجار العرعر في جبال عسير تحتاج لسماد طبيعي خاص. تخلص من نفاياتك العضوية في العربات الذكية لإنتاج أفضل سماد لهذه الأشجار النادرة.',
                      style:
                          TextStyle(fontSize: 14, color: AppColors.darkGreen),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.spacingLarge),

              // إحصائيات منطقة عسير
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'إحصائيات منطقة عسير البيئية',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingMedium),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMiniStatCard(
                            '8',
                            'عربات ذكية',
                            Icons.delete_outline,
                          ),
                        ),
                        const SizedBox(width: AppDimensions.spacingSmall),
                        Expanded(
                          child: _buildMiniStatCard(
                            '7',
                            'حدائق مخصبة',
                            Icons.local_florist,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spacingSmall),
                    Row(
                      children: [
                        Expanded(
                          child: _buildMiniStatCard(
                            '142',
                            'مستخدم نشط',
                            Icons.people,
                          ),
                        ),
                        const SizedBox(width: AppDimensions.spacingSmall),
                        Expanded(
                          child: _buildMiniStatCard(
                            '3.2 طن',
                            'نفايات معاد تدويرها',
                            Icons.recycling,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: AppDimensions.spacingSmall),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingXSmall),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryGreen, size: 20),
          const SizedBox(height: AppDimensions.spacingXSmall),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  void _showQRSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              decoration: const BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 48, color: Colors.white),
            ),
            const SizedBox(height: AppDimensions.spacingMedium),
            const Text(
              'تم بنجاح!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingSmall),
            const Text(
              'حصلت على +50 نقطة خضراء!\nشكراً لمساهمتك في حماية بيئة عسير الجميلة 🌱',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: AppDimensions.spacingLarge),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('رائع!'),
            ),
          ],
        ),
      ),
    );
  }
}

// صفحة الخريطة المبسطة لعسير
class MapPageAseer extends StatelessWidget {
  const MapPageAseer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'خريطة منطقة عسير',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundLight,
              AppColors.primaryGreen.withOpacity(0.1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            children: [
              // بطاقة معلومات المنطقة
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLarge),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.landscape,
                      size: 64,
                      color: AppColors.primaryGreen,
                    ),
                    const SizedBox(height: AppDimensions.spacingMedium),
                    const Text(
                      'منطقة عسير',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingSmall),
                    const Text(
                      'جنة الطبيعة في المملكة العربية السعودية',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingMedium),
                    Container(
                      padding:
                          const EdgeInsets.all(AppDimensions.paddingMedium),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundCard,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusSmall),
                      ),
                      child: const Text(
                        'خريطة Google Maps ستعرض مواقع العربات الذكية والحدائق المخصبة في جميع محافظات منطقة عسير الجميلة',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.spacingLarge),

              // محافظات منطقة عسير
              const Text(
                'محافظات منطقة عسير',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: AppDimensions.spacingMedium),

              _buildCityCard(
                'أبها',
                'العاصمة الإدارية - مدينة الضباب',
                'عربتان ذكيتان، منتزه عسير الوطني',
                Icons.location_city,
                '75% متاحة',
              ),

              _buildCityCard(
                'خميس مشيط',
                'المدينة التوأم - المركز التجاري',
                'عربتان ذكيتان، حديقة الملك عبدالله',
                Icons.business,
                '85% متاحة',
              ),

              _buildCityCard(
                'بيشة',
                'بوابة عسير الشمالية',
                'عربة ذكية واحدة، مشاتل بيشة',
                Icons.agriculture,
                '55% متاحة',
              ),

              _buildCityCard(
                'النماص',
                'مدينة الضباب والورود',
                'عربة ذكية واحدة، حدائق جبلية',
                Icons.local_florist,
                '90% متاحة',
              ),

              _buildCityCard(
                'تنومة',
                'المدرجات الزراعية التراثية',
                'عربة ذكية واحدة، مزارع مدرجة',
                Icons.terrain,
                '70% متاحة',
              ),

              _buildCityCard(
                'محايل عسير',
                'الوادي الأخضر',
                'عربة ذكية واحدة، مزارع استوائية',
                Icons.nature,
                '65% متاحة',
              ),

              _buildCityCard(
                'السودة',
                'أعلى قمة في المملكة (3015م)',
                'غابات العرعر البرية النادرة',
                Icons.forest,
                'تم التسميد اليوم',
              ),

              const SizedBox(height: AppDimensions.spacingXLarge),

              // رسالة تطوير
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLarge),
                  border: Border.all(
                      color: AppColors.primaryGreen.withOpacity(0.3)),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.construction,
                      size: 48,
                      color: AppColors.primaryGreen,
                    ),
                    SizedBox(height: AppDimensions.spacingMedium),
                    Text(
                      'خريطة Google Maps قيد التطوير',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    SizedBox(height: AppDimensions.spacingSmall),
                    Text(
                      'سيتم عرض خريطة تفاعلية تظهر جميع العربات الذكية والحدائق المخصبة في منطقة عسير قريباً',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCityCard(String cityName, String description, String facilities,
      IconData icon, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingMedium),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingSmall),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryGreen,
              size: 32,
            ),
          ),
          const SizedBox(width: AppDimensions.spacingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cityName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingXSmall),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingXSmall),
                Text(
                  facilities,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingSmall,
              vertical: AppDimensions.spacingXSmall,
            ),
            decoration: BoxDecoration(
              color: status.contains('متاحة')
                  ? Colors.green.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: status.contains('متاحة') ? Colors.green : Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// صفحة الدردشة
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم والمساعدة'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat, size: 64, color: AppColors.primaryGreen),
            SizedBox(height: AppDimensions.spacingMedium),
            Text(
              'نظام الدردشة',
              style: TextStyle(fontSize: 18, color: AppColors.primaryGreen),
            ),
            SizedBox(height: AppDimensions.spacingSmall),
            Text(
              'دردشة مباشرة مع فريق الدعم',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// صفحة الملف الشخصي
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryGreen, AppColors.backgroundLight],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Text(
                          'أ.م',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingMedium),
                      const Text(
                        'أحمد محمد',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingSmall),
                      const Text(
                        'مقيم في منطقة عسير - انضم في يناير 2024',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'إنجازاتي البيئية في عسير',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreen,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacingMedium),

                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(Icons.delete_outline, '15',
                                  'مرات التخلص\nمن النفايات'),
                            ),
                            const SizedBox(width: AppDimensions.spacingSmall),
                            Expanded(
                              child: _buildStatCard(Icons.local_florist, '23',
                                  'نبتة في عسير\nساعدت في تسميدها'),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.spacingMedium),

                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                  Icons.landscape, '5', 'مواقع في عسير\nزرتها'),
                            ),
                            const SizedBox(width: AppDimensions.spacingSmall),
                            Expanded(
                              child: _buildStatCard(
                                  Icons.eco, '2.3 كغ', 'سماد طبيعي\nأنتجته'),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.spacingXLarge),

                        // زر تسجيل الخروج
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false,
                              );
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text('تسجيل الخروج'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppDimensions.paddingMedium),
                            ),
                          ),
                        ),

                        const SizedBox(height: AppDimensions.spacingMedium),

                        const Center(
                          child: Text(
                            'تطبيق خصب - نحو بيئة أفضل لمنطقة عسير الجميلة 🌱',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryGreen, size: 24),
          const SizedBox(height: AppDimensions.spacingSmall),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingXSmall),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
