import 'package:flutter/material.dart';

class TreePlantingPage extends StatefulWidget {
  const TreePlantingPage({super.key});

  @override
  State<TreePlantingPage> createState() => _TreePlantingPageState();
}

class _TreePlantingPageState extends State<TreePlantingPage> {
  int selectedTreeIndex = 0;

  final List<Map<String, dynamic>> trees = [
    {
      'name': 'شجرة العرعر',
      'price': 150,
      'description': 'شجرة محلية تتكيف مع مناخ عسير الجبلي',
      'icon': Icons.park,
      'color': Color(0xFF2E7D32),
      'benefits': ['تنقية الهواء', 'مقاومة للجفاف', 'جمال طبيعي'],
    },
    {
      'name': 'شجرة الزيتون',
      'price': 200,
      'description': 'شجرة مباركة ومفيدة للبيئة والاقتصاد',
      'icon': Icons.eco,
      'color': Color(0xFF689F38),
      'benefits': ['إنتاج الزيتون', 'تحسين التربة', 'ظل طبيعي'],
    },
    {
      'name': 'شجرة الطلح',
      'price': 120,
      'description': 'شجرة صحراوية قوية ومقاومة',
      'icon': Icons.local_florist,
      'color': Color(0xFF8BC34A),
      'benefits': ['مقاومة الرياح', 'توفير الظل', 'علف للحيوانات'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'زراعة الأشجار',
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
        child: Column(
          children: [
            // بطاقة النقاط
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_florist,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'نقاطك الخضراء: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    '2,450',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'المستوى 7',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // قائمة الأشجار
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: trees.length,
                itemBuilder: (context, index) {
                  final tree = trees[index];
                  final isSelected = selectedTreeIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTreeIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              isSelected ? tree['color'] : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? tree['color'].withOpacity(0.3)
                                : Colors.black.withOpacity(0.1),
                            blurRadius: isSelected ? 15 : 5,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: tree['color'].withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    tree['icon'],
                                    color: tree['color'],
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tree['name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2E2E2E),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        tree['description'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: tree['color'],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${tree['price']} نقطة',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (isSelected) ...[
                              const SizedBox(height: 16),
                              const Text(
                                'الفوائد:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E2E2E),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...tree['benefits']
                                  .map<Widget>(
                                    (benefit) => Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: tree['color'],
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            benefit,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            _showPlantingConfirmation();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: trees[selectedTreeIndex]['color'],
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'ازرع ${trees[selectedTreeIndex]['name']}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showPlantingConfirmation() {
    final selectedTree = trees[selectedTreeIndex];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              selectedTree['icon'],
              color: selectedTree['color'],
              size: 24,
            ),
            const SizedBox(width: 12),
            const Text('تأكيد الزراعة'),
          ],
        ),
        content: Text(
          'هل تريد زراعة ${selectedTree['name']} مقابل ${selectedTree['price']} نقطة خضراء؟',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSuccessMessage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedTree['color'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'ازرع الآن',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم زراعة ${trees[selectedTreeIndex]['name']} بنجاح! 🌱'),
        backgroundColor: trees[selectedTreeIndex]['color'],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
