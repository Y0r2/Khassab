import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// صفحة الخريطة - تعرض مواقع العربات الذكية والنباتات المخصبة في منطقة عسير
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // الموقع الافتراضي (أبها - منطقة عسير)
  static const LatLng _defaultLocation = LatLng(18.2164, 42.5048);

  // مواقع العربات الذكية في منطقة عسير ومحافظاتها
  final Set<Marker> _smartBinsMarkers = {
    // أبها - العاصمة الإدارية
    const Marker(
      markerId: MarkerId('bin_abha_1'),
      position: LatLng(18.2164, 42.5048), // وسط أبها
      infoWindow: InfoWindow(
        title: 'عربة ذكية - أبها المركز',
        snippet: 'متاحة - مساحة فارغة 75%',
      ),
    ),
    const Marker(
      markerId: MarkerId('bin_abha_2'),
      position: LatLng(18.2300, 42.5200), // حي الشفا
      infoWindow: InfoWindow(
        title: 'عربة ذكية - حي الشفا',
        snippet: 'متاحة - مساحة فارغة 60%',
      ),
    ),
    // خميس مشيط
    const Marker(
      markerId: MarkerId('bin_khamis_1'),
      position: LatLng(18.3000, 42.7285), // خميس مشيط
      infoWindow: InfoWindow(
        title: 'عربة ذكية - خميس مشيط',
        snippet: 'متاحة - مساحة فارغة 85%',
      ),
    ),
    const Marker(
      markerId: MarkerId('bin_khamis_2'),
      position: LatLng(18.3100, 42.7400), // حي المطار
      infoWindow: InfoWindow(
        title: 'عربة ذكية - حي المطار',
        snippet: 'ممتلئة - في انتظار الجمع',
      ),
    ),
    // بيشة
    const Marker(
      markerId: MarkerId('bin_bisha_1'),
      position: LatLng(20.0121, 42.6043), // بيشة
      infoWindow: InfoWindow(
        title: 'عربة ذكية - بيشة',
        snippet: 'متاحة - مساحة فارغة 55%',
      ),
    ),
    // النماص
    const Marker(
      markerId: MarkerId('bin_namas_1'),
      position: LatLng(19.1450, 42.1500), // النماص
      infoWindow: InfoWindow(
        title: 'عربة ذكية - النماص',
        snippet: 'متاحة - مساحة فارغة 90%',
      ),
    ),
    // تنومة
    const Marker(
      markerId: MarkerId('bin_tanomah_1'),
      position: LatLng(18.9200, 42.1500), // تنومة
      infoWindow: InfoWindow(
        title: 'عربة ذكية - تنومة',
        snippet: 'متاحة - مساحة فارغة 70%',
      ),
    ),
    // محايل عسير
    const Marker(
      markerId: MarkerId('bin_muhayil_1'),
      position: LatLng(18.5100, 42.0500), // محايل عسير
      infoWindow: InfoWindow(
        title: 'عربة ذكية - محايل عسير',
        snippet: 'متاحة - مساحة فارغة 65%',
      ),
    ),
  };

  // مواقع النباتات والحدائق المخصبة في منطقة عسير
  final Set<Marker> _plantsMarkers = {
    // حدائق أبها
    const Marker(
      markerId: MarkerId('plant_abha_1'),
      position: LatLng(18.2200, 42.5100), // منتزه عسير الوطني
      infoWindow: InfoWindow(
        title: 'منتزه عسير الوطني',
        snippet: 'تم التسميد قبل يومين - أشجار العرعر',
      ),
    ),
    const Marker(
      markerId: MarkerId('plant_abha_2'),
      position: LatLng(18.2400, 42.5300), // حديقة الأندلس
      infoWindow: InfoWindow(
        title: 'حديقة الأندلس',
        snippet: 'تم التسميد قبل أسبوع - ورود وأزهار',
      ),
    ),
    // السودة
    const Marker(
      markerId: MarkerId('plant_souda_1'),
      position: LatLng(18.2738, 42.3647), // السودة
      infoWindow: InfoWindow(
        title: 'غابات السودة',
        snippet: 'تم التسميد اليوم - أشجار العرعر البرية',
      ),
    ),
    // خميس مشيط
    const Marker(
      markerId: MarkerId('plant_khamis_1'),
      position: LatLng(18.3050, 42.7300), // حديقة الملك عبدالله
      infoWindow: InfoWindow(
        title: 'حديقة الملك عبدالله',
        snippet: 'تم التسميد قبل 3 أيام - نخيل وأشجار مثمرة',
      ),
    ),
    // النماص
    const Marker(
      markerId: MarkerId('plant_namas_1'),
      position: LatLng(19.1500, 42.1600), // حدائق النماص
      infoWindow: InfoWindow(
        title: 'حدائق النماص الجبلية',
        snippet: 'تم التسميد قبل 5 أيام - أشجار اللوز والخوخ',
      ),
    ),
    // تنومة
    const Marker(
      markerId: MarkerId('plant_tanomah_1'),
      position: LatLng(18.9300, 42.1600), // مزارع تنومة
      infoWindow: InfoWindow(
        title: 'مزارع تنومة المدرجة',
        snippet: 'تم التسميد قبل يوم - زراعات تقليدية',
      ),
    ),
    // بيشة
    const Marker(
      markerId: MarkerId('plant_bisha_1'),
      position: LatLng(20.0200, 42.6100), // مشاتل بيشة
      infoWindow: InfoWindow(
        title: 'مشاتل بيشة',
        snippet: 'تم التسميد قبل 4 أيام - نباتات عطرية',
      ),
    ),
  };

  bool _showSmartBins = true;
  bool _showPlants = true;

  Set<Marker> get _displayedMarkers {
    Set<Marker> markers = {};

    if (_showSmartBins) {
      markers.addAll(_smartBinsMarkers);
    }

    if (_showPlants) {
      markers.addAll(_plantsMarkers);
    }

    return markers;
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'تصفية الخريطة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 20),

            // خيار العربات الذكية
            CheckboxListTile(
              title: const Text('العربات الذكية'),
              subtitle: const Text(
                'عرض مواقع العربات المتاحة للاستخدام',
                style: TextStyle(fontSize: 12),
              ),
              value: _showSmartBins,
              activeColor: const Color(0xFF4CAF50),
              onChanged: (value) {
                setState(() {
                  _showSmartBins = value ?? true;
                });
                Navigator.pop(context);
              },
            ),

            // خيار النباتات
            CheckboxListTile(
              title: const Text('النباتات المخصبة'),
              subtitle: const Text(
                'عرض مواقع النباتات التي تم تسميدها',
                style: TextStyle(fontSize: 12),
              ),
              value: _showPlants,
              activeColor: const Color(0xFF4CAF50),
              onChanged: (value) {
                setState(() {
                  _showPlants = value ?? true;
                });
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'خريطة خصب - منطقة عسير',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF4CAF50)),
            onPressed: _showFilterOptions,
            tooltip: 'تصفية',
          ),
          IconButton(
            icon: const Icon(Icons.my_location, color: Color(0xFF4CAF50)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('سيتم تحديد موقعك الحالي قريباً')),
              );
            },
            tooltip: 'موقعي',
          ),
        ],
      ),
      body: Stack(
        children: [
          // الخريطة تركز على منطقة عسير
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _defaultLocation, // أبها - عاصمة عسير
              zoom: 8.0, // تكبير مناسب لإظهار المنطقة كاملة
            ),
            markers: _displayedMarkers,
            mapType: MapType.terrain, // نمط التضاريس لإظهار الجبال
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
          ),

          // شريط المعلومات العلوي - منطقة عسير
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // أيقونة الجبال لمنطقة عسير
                  const Icon(
                    Icons.landscape,
                    color: Color(0xFF4CAF50),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'منطقة عسير',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // مؤشر العربات الذكية
                  if (_showSmartBins) ...[
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'عربات ذكية',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],

                  // مؤشر النباتات
                  if (_showPlants) ...[
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF66BB6A),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'حدائق مخصبة',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ],

                  const Spacer(),

                  Text(
                    '${_displayedMarkers.length} موقع',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // قائمة المواقع السفلية في منطقة عسير
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _LocationCard(
                    title: 'عربة ذكية - أبها',
                    subtitle: 'متاحة - وسط المدينة',
                    icon: Icons.delete_outline,
                    color: const Color(0xFF4CAF50),
                    onTap: () => _showLocationDialog(
                      'عربة ذكية - أبها المركز',
                      'عربة ذكية في وسط مدينة أبها، عاصمة منطقة عسير الجميلة. متاحة للاستخدام بمساحة فارغة 75%. مكان مثالي للتخلص من النفايات العضوية والحصول على نقاط بيئية في قلب المدينة الجبلية.',
                    ),
                  ),
                  _LocationCard(
                    title: 'منتزه عسير الوطني',
                    subtitle: 'تم التسميد - أشجار العرعر',
                    icon: Icons.local_florist,
                    color: const Color(0xFF66BB6A),
                    onTap: () => _showLocationDialog(
                      'منتزه عسير الوطني',
                      'أكبر منتزه وطني في المملكة العربية السعودية يقع في أبها. تم تسميد أشجار العرعر البرية النادرة بالسماد الطبيعي المنتج من النفايات العضوية. شكراً لمساهمتك في حماية هذا التراث الطبيعي الفريد!',
                    ),
                  ),
                  _LocationCard(
                    title: 'عربة ذكية - خميس مشيط',
                    subtitle: 'متاحة - المدينة التوأم',
                    icon: Icons.delete_outline,
                    color: const Color(0xFF4CAF50),
                    onTap: () => _showLocationDialog(
                      'عربة ذكية - خميس مشيط',
                      'عربة ذكية في مدينة خميس مشيط، المدينة التوأم لأبها والمركز التجاري لمنطقة عسير. متاحة للاستخدام بمساحة فارغة 85%. ساهم في حماية البيئة الجبلية الجميلة.',
                    ),
                  ),
                  _LocationCard(
                    title: 'غابات السودة',
                    subtitle: 'تم التسميد اليوم - العرعر البري',
                    icon: Icons.local_florist,
                    color: const Color(0xFF66BB6A),
                    onTap: () => _showLocationDialog(
                      'غابات السودة الطبيعية',
                      'أعلى قمة في المملكة (3015م فوق سطح البحر) وأبرد منطقة في الصيف. تم تسميد أشجار العرعر البرية النادرة بالسماد الطبيعي. هذه الغابات تمثل كنزاً بيئياً فريداً يجب المحافظة عليه للأجيال القادمة.',
                    ),
                  ),
                  _LocationCard(
                    title: 'عربة ذكية - النماص',
                    subtitle: 'متاحة - المدينة الجبلية',
                    icon: Icons.delete_outline,
                    color: const Color(0xFF4CAF50),
                    onTap: () => _showLocationDialog(
                      'عربة ذكية - النماص',
                      'عربة ذكية في مدينة النماص الجبلية الباردة، المشهورة بأشجار اللوز والخوخ. متاحة بمساحة فارغة 90%. ساهم في حماية البيئة الجبلية والمناخ المعتدل في هذه المنطقة الجميلة.',
                    ),
                  ),
                  _LocationCard(
                    title: 'مزارع تنومة المدرجة',
                    subtitle: 'تم التسميد - زراعات تقليدية',
                    icon: Icons.local_florist,
                    color: const Color(0xFF66BB6A),
                    onTap: () => _showLocationDialog(
                      'مزارع تنومة المدرجة',
                      'مزارع تقليدية مدرجة على سفوح الجبال في تنومة، تشتهر بالزراعات التراثية. تم تسميدها بالسماد الطبيعي المنتج من النفايات العضوية. هذه المزارع تحافظ على التراث الزراعي لمنطقة عسير.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إغلاق'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('سيتم فتح التنقل قريباً')),
                        );
                      },
                      child: const Text(
                        'التنقل',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
}

/// بطاقة موقع في القائمة السفلية
class _LocationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _LocationCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
