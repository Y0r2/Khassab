import 'package:flutter/material.dart';

class EnvironmentalTipsPage extends StatelessWidget {
  const EnvironmentalTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'نصائح بيئية',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF1F8E9), Color(0xFFE8F5E8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildTipCard(
              icon: Icons.eco,
              title: 'زراعة الأشجار',
              description:
                  'ازرع شجرة واحدة على الأقل شهرياً لتحسين جودة الهواء',
              color: const Color(0xFF4CAF50),
            ),
            _buildTipCard(
              icon: Icons.recycling,
              title: 'إعادة التدوير',
              description:
                  'افصل النفايات واستخدم الحاويات الذكية للحصول على نقاط',
              color: const Color(0xFF2196F3),
            ),
            _buildTipCard(
              icon: Icons.water_drop,
              title: 'توفير المياه',
              description: 'استخدم المياه بحكمة واجمع مياه الأمطار للري',
              color: const Color(0xFF03A9F4),
            ),
            _buildTipCard(
              icon: Icons.wb_sunny,
              title: 'الطاقة المتجددة',
              description: 'استخدم الطاقة الشمسية كلما أمكن ذلك',
              color: const Color(0xFFFF9800),
            ),
            _buildTipCard(
              icon: Icons.pedal_bike,
              title: 'التنقل المستدام',
              description: 'استخدم الدراجة أو المشي للمسافات القصيرة',
              color: const Color(0xFF8BC34A),
            ),
            _buildTipCard(
              icon: Icons.local_florist,
              title: 'النباتات المحلية',
              description: 'ازرع النباتات المحلية التي تتكيف مع مناخ عسير',
              color: const Color(0xFF689F38),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
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
}
