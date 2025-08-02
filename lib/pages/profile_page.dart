import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

/// صفحة الملف الشخصي - تعرض معلومات المستخدم وإحصائياته البيئية
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // بيانات المستخدم (مؤقتة)
  final String userName = 'أحمد محمد';
  final String userEmail = 'ahmed.mohamed@email.com';
  final String userPhone = '+966 50 123 4567';
  final String joinDate = 'انضم في يناير 2024';

  // الإحصائيات البيئية
  final int totalPoints = 2450;
  final int treeLevel = 7;
  final int wasteCollected = 15;
  final int plantsHelped = 23;
  final int daysActive = 45;
  final double co2Saved = 12.5; // كيلوجرام

  /// تسجيل الخروج
  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'تسجيل الخروج',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
          style: GoogleFonts.cairo(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء', style: GoogleFonts.cairo()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: Text(
              'تسجيل الخروج',
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// مشاركة الإنجازات
  void _shareAchievements() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.share,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'مشاركة الإنجازات',
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'شارك إنجازاتك البيئية مع الأصدقاء وشجعهم على الانضمام لحماية البيئة!',
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('إلغاء', style: GoogleFonts.cairo()),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: تطبيق مشاركة الإنجازات
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('سيتم تطبيق المشاركة قريباً')),
                        );
                      },
                      child: Text(
                        'مشاركة',
                        style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
              Color(0xFF4CAF50),
              Color(0xFFF1F8E9),
            ],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // قسم معلومات المستخدم العلوي
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // الصورة الشخصية
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color(0xFFE8F5E8),
                          child: Text(
                            userName
                                .split(' ')
                                .map((name) => name[0])
                                .take(2)
                                .join(),
                            style: GoogleFonts.cairo(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // اسم المستخدم
                      Text(
                        userName,
                        style: GoogleFonts.cairo(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // تاريخ الانضمام
                      Text(
                        joinDate,
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // النقاط ومستوى الشجرة
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '$totalPoints',
                                    style: GoogleFonts.cairo(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'نقطة خضراء',
                                    style: GoogleFonts.cairo(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'المستوى $treeLevel',
                                    style: GoogleFonts.cairo(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'شجرتك البيئية',
                                    style: GoogleFonts.cairo(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // المحتوى الرئيسي
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F8E9),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الإحصائيات البيئية
                        Text(
                          'إحصائياتي البيئية',
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // بطاقات الإحصائيات
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                Icons.delete_outline,
                                '$wasteCollected',
                                'مرات التخلص\nمن النفايات',
                                const Color(0xFF4CAF50),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                Icons.local_florist,
                                '$plantsHelped',
                                'نبتة ساعدت\nفي تسميدها',
                                const Color(0xFF66BB6A),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                Icons.calendar_today,
                                '$daysActive',
                                'يوم نشاط\nفي التطبيق',
                                const Color(0xFF81C784),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                Icons.eco,
                                '${co2Saved}kg',
                                'كربون محفوظ\nمن الانبعاث',
                                const Color(0xFF4CAF50),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // معلومات الحساب
                        Text(
                          'معلومات الحساب',
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
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
                              _buildAccountInfoTile(
                                Icons.email_outlined,
                                'البريد الإلكتروني',
                                userEmail,
                              ),
                              const Divider(height: 1),
                              _buildAccountInfoTile(
                                Icons.phone_outlined,
                                'رقم الجوال',
                                userPhone,
                              ),
                              const Divider(height: 1),
                              _buildAccountInfoTile(
                                Icons.location_on_outlined,
                                'الموقع',
                                'الرياض، المملكة العربية السعودية',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // الإعدادات والخيارات
                        Text(
                          'الإعدادات',
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
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
                              _buildSettingsTile(
                                Icons.share_outlined,
                                'مشاركة الإنجازات',
                                'شارك إنجازاتك مع الأصدقاء',
                                _shareAchievements,
                              ),
                              const Divider(height: 1),
                              _buildSettingsTile(
                                Icons.notifications_outlined,
                                'الإشعارات',
                                'إدارة إشعارات التطبيق',
                                () {
                                  // TODO: صفحة إعدادات الإشعارات
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'سيتم تطبيق إعدادات الإشعارات قريباً')),
                                  );
                                },
                              ),
                              const Divider(height: 1),
                              _buildSettingsTile(
                                Icons.privacy_tip_outlined,
                                'الخصوصية والأمان',
                                'إدارة خصوصية حسابك',
                                () {
                                  // TODO: صفحة الخصوصية
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'سيتم تطبيق إعدادات الخصوصية قريباً')),
                                  );
                                },
                              ),
                              const Divider(height: 1),
                              _buildSettingsTile(
                                Icons.help_outline,
                                'المساعدة والدعم',
                                'احصل على المساعدة',
                                () {
                                  // الانتقال لصفحة الدعم
                                  DefaultTabController.of(context)
                                      ?.animateTo(2);
                                },
                              ),
                              const Divider(height: 1),
                              _buildSettingsTile(
                                Icons.logout,
                                'تسجيل الخروج',
                                'الخروج من حسابك',
                                _logout,
                                isDestructive: true,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // معلومات التطبيق
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'تطبيق خصب - الإصدار 1.0.0',
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'نحو بيئة أفضل للجميع 🌱',
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                  color: const Color(0xFF4CAF50),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
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

  Widget _buildStatCard(
      IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 12,
              color: Colors.grey[700],
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF4CAF50),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2E7D32),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.cairo(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (isDestructive ? Colors.red : const Color(0xFF4CAF50))
              .withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isDestructive ? Colors.red : const Color(0xFF4CAF50),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.w600,
          color: isDestructive ? Colors.red : const Color(0xFF2E7D32),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.cairo(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }
}
