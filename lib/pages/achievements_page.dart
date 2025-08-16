import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الإنجازات والشارات',
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
            // إحصائيات المستخدم
            _buildStatsCard(),
            const SizedBox(height: 20),

            // الشارات المكتسبة
            const Text(
              'الشارات المكتسبة',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 16),

            _buildAchievementCard(
              icon: Icons.eco,
              title: 'مزارع مبتدئ',
              description: 'زرعت أول شجرة لك',
              isUnlocked: true,
              color: const Color(0xFF4CAF50),
            ),

            _buildAchievementCard(
              icon: Icons.recycling,
              title: 'محافظ على البيئة',
              description: 'استخدمت 10 حاويات ذكية',
              isUnlocked: true,
              color: const Color(0xFF2196F3),
            ),

            _buildAchievementCard(
              icon: Icons.emoji_events,
              title: 'بطل البيئة',
              description: 'حصلت على 1000 نقطة خضراء',
              isUnlocked: false,
              color: const Color(0xFFFF9800),
            ),

            _buildAchievementCard(
              icon: Icons.military_tech,
              title: 'سفير عسير الأخضر',
              description: 'حصلت على 5000 نقطة خضراء',
              isUnlocked: false,
              color: const Color(0xFF9C27B0),
            ),

            _buildAchievementCard(
              icon: Icons.star,
              title: 'نجم البيئة',
              description: 'ساهمت في زراعة 100 شجرة',
              isUnlocked: false,
              color: const Color(0xFFFFEB3B),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text(
                'إحصائياتك البيئية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(Icons.local_florist, '2,450', 'نقطة خضراء'),
                  _buildStatItem(Icons.eco, '12', 'شجرة مزروعة'),
                  _buildStatItem(Icons.recycling, '45', 'مرة إعادة تدوير'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isUnlocked,
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
            colors: isUnlocked
                ? [Colors.white, color.withOpacity(0.1)]
                : [Colors.grey[100]!, Colors.grey[200]!],
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
                  color: isUnlocked ? color.withOpacity(0.2) : Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: isUnlocked ? color : Colors.grey[500],
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
                        color: isUnlocked ? Colors.grey[800] : Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isUnlocked ? Colors.grey[600] : Colors.grey[400],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (isUnlocked)
                Icon(
                  Icons.check_circle,
                  color: color,
                  size: 24,
                )
              else
                Icon(
                  Icons.lock,
                  color: Colors.grey[400],
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
