import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../constants/app_constants.dart';
import '../services/auth_service.dart';
import '../services/location_service.dart';

/// صفحة إنشاء حساب جديد - تحتوي على نموذج التسجيل الكامل مع Firebase
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final _locationService = LocationService();

  // Controllers للحقول
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // متغيرات الحالة
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _agreeToTerms = false;
  String _selectedCity = 'أبها';
  bool _shareLocation = false;

  // مدن منطقة عسير
  final List<String> _aseerCities = [
    'أبها',
    'خميس مشيط',
    'بيشة',
    'النماص',
    'تنومة',
    'محايل عسير',
    'السودة',
    'رجال ألمع',
    'ظهران الجنوب',
    'طريب',
    'المجاردة',
    'سراة عبيدة',
    'أحد رفيدة',
    'بللسمر',
    'تثليث',
    'وادي بن هشبل',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreeToTerms) {
      _showSnackBar('يرجى الموافقة على الشروط والأحكام', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // تسجيل المستخدم في Firebase
      await _authService.registerWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        fullName: _fullNameController.text.trim(),
        phone: _phoneController.text.trim(),
        city: _selectedCity,
      );

      // إذا تم تمكين مشاركة الموقع، حفظ الموقع الحالي
      if (_shareLocation) {
        try {
          final locationData = await _locationService.getCurrentLocation();
          if (locationData != null) {
            await _authService.updateUserData({
              'currentLocation': {
                'latitude': locationData.latitude,
                'longitude': locationData.longitude,
                'timestamp': DateTime.now().toIso8601String(),
              }
            });
          }
        } catch (e) {
          // فشل الموقع لا يمنع التسجيل
          debugPrint('فشل في حفظ الموقع: $e');
        }
      }

      setState(() => _isLoading = false);

      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar(e.toString(), isError: true);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
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
              'مرحباً بك في خصب! 🌱',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingSmall),
            Text(
              'تم إنشاء حسابك بنجاح!\nأهلاً بك في رحلة حماية بيئة عسير الجميلة',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: AppDimensions.spacingLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // إغلاق الحوار
                  Navigator.pop(context); // العودة لصفحة تسجيل الدخول
                },
                child: const Text('ابدأ الآن'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : AppColors.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
      ),
    );
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
                const SizedBox(height: AppDimensions.spacingMedium),

                // العودة وشعار التطبيق
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.primaryGreen),
                    ),
                  ],
                ),

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
                        child: const Icon(Icons.person_add,
                            size: 48, color: Colors.white),
                      ),
                      const SizedBox(height: AppDimensions.spacingMedium),
                      const Text(
                        'انضم إلى خصب',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingSmall),
                      const Text(
                        'كن جزءاً من التغيير البيئي الإيجابي في عسير',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.spacingLarge),

                // نموذج التسجيل
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
                          'إنشاء حساب جديد',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreen,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacingLarge),

                        // الاسم الكامل
                        TextFormField(
                          controller: _fullNameController,
                          decoration: const InputDecoration(
                            labelText: 'الاسم الكامل',
                            hintText: 'أدخل اسمك الكامل',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال الاسم الكامل';
                            }
                            if (value.trim().length < 3) {
                              return 'الاسم يجب أن يكون 3 أحرف على الأقل';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppDimensions.spacingMedium),

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
                            if (value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال البريد الإلكتروني';
                            }
                            if (!EmailValidator.validate(value.trim())) {
                              return 'يرجى إدخال بريد إلكتروني صحيح';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppDimensions.spacingMedium),

                        // رقم الهاتف
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textDirection: TextDirection.ltr,
                          decoration: const InputDecoration(
                            labelText: 'رقم الهاتف',
                            hintText: '05xxxxxxxx',
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال رقم الهاتف';
                            }
                            // التحقق من تنسيق رقم الهاتف السعودي
                            String phone = value.trim();
                            if (!RegExp(r'^(05|5)[0-9]{8}$').hasMatch(phone)) {
                              return 'يرجى إدخال رقم هاتف سعودي صحيح';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppDimensions.spacingMedium),

                        // اختيار المدينة
                        DropdownButtonFormField<String>(
                          value: _selectedCity,
                          decoration: const InputDecoration(
                            labelText: 'المدينة في منطقة عسير',
                            prefixIcon: Icon(Icons.location_city),
                          ),
                          items: _aseerCities.map((city) {
                            return DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedCity = value);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى اختيار المدينة';
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
                            if (value.length < 8) {
                              return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
                            }
                            if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)')
                                .hasMatch(value)) {
                              return 'كلمة المرور يجب أن تحتوي على أحرف كبيرة وصغيرة وأرقام';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppDimensions.spacingMedium),

                        // تأكيد كلمة المرور
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            labelText: 'تأكيد كلمة المرور',
                            hintText: '••••••••',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () => setState(() =>
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى تأكيد كلمة المرور';
                            }
                            if (value != _passwordController.text) {
                              return 'كلمة المرور غير متطابقة';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppDimensions.spacingMedium),

                        // مشاركة الموقع
                        Container(
                          padding:
                              const EdgeInsets.all(AppDimensions.paddingMedium),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundCard,
                            borderRadius: BorderRadius.circular(
                                AppDimensions.radiusSmall),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _shareLocation,
                                    onChanged: (value) => setState(
                                        () => _shareLocation = value ?? false),
                                    activeColor: AppColors.primaryGreen,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => setState(() =>
                                          _shareLocation = !_shareLocation),
                                      child: const Text(
                                        'السماح بالوصول للموقع لإظهار أقرب العربات الذكية',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (_shareLocation)
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'سيساعدك هذا في العثور على أقرب العربات الذكية والحدائق في منطقة عسير',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primaryGreen,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppDimensions.spacingMedium),

                        // الموافقة على الشروط
                        Row(
                          children: [
                            Checkbox(
                              value: _agreeToTerms,
                              onChanged: (value) => setState(
                                  () => _agreeToTerms = value ?? false),
                              activeColor: AppColors.primaryGreen,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(
                                    () => _agreeToTerms = !_agreeToTerms),
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(text: 'أوافق على '),
                                      TextSpan(
                                        text: 'الشروط والأحكام',
                                        style: TextStyle(
                                          color: AppColors.primaryGreen,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: ' و'),
                                      TextSpan(
                                        text: 'سياسة الخصوصية',
                                        style: TextStyle(
                                          color: AppColors.primaryGreen,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.spacingXLarge),

                        // زر إنشاء الحساب
                        ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister,
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
                                  'إنشاء الحساب',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                      'لديك حساب بالفعل؟ ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'تسجيل الدخول',
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
