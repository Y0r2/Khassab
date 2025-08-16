import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';

// صفحة الخريطة المتقدمة لعسير مع Google Maps Toolkit
class MapPageAseer extends StatefulWidget {
  const MapPageAseer({super.key});

  @override
  State<MapPageAseer> createState() => _MapPageAseerState();
}

class _MapPageAseerState extends State<MapPageAseer> {
  GoogleMapController? mapController;

  // مراكز مناطق عسير
  static const CameraPosition _aseerCenter = CameraPosition(
    target: LatLng(18.2166, 42.5000), // إحداثيات منطقة عسير
    zoom: 10.0,
  );

  // إعدادات الخريطة المتقدمة
  Set<Marker> _markers = {};
  Set<Polygon> _regions = {};
  Set<Circle> _circles = {};
  BitmapDescriptor? _truckIcon;
  BitmapDescriptor? _gardenIcon;
  BitmapDescriptor? _treeIcon;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
  }

  // تحميل أيقونات مخصصة للعلامات
  Future<void> _loadCustomMarkers() async {
    _truckIcon = await _createCustomMarkerIcon('🚛', Colors.green);
    _gardenIcon = await _createCustomMarkerIcon('🏞️', Colors.blue);
    _treeIcon = await _createCustomMarkerIcon('🌳', Colors.orange);

    _createMarkers();
    _createRegions();
    _createServiceAreas();

    setState(() {
      _isLoading = false;
    });
  }

  // إنشاء أيقونة مخصصة
  Future<BitmapDescriptor> _createCustomMarkerIcon(
      String emoji, Color backgroundColor) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = backgroundColor.withOpacity(0.8);

    // رسم الدائرة الخلفية
    canvas.drawCircle(const Offset(50, 50), 45, paint);

    // رسم حدود بيضاء
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(const Offset(50, 50), 45, borderPaint);

    // إضافة الإيموجي
    final textPainter = TextPainter(
      text: TextSpan(
        text: emoji,
        style: const TextStyle(
          fontSize: 40,
          fontFamily: 'Noto Color Emoji',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(25, 25));

    final ui.Image image =
        await pictureRecorder.endRecording().toImage(100, 100);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  // إنشاء العلامات على الخريطة
  void _createMarkers() {
    _markers = {
      // عربات النظافة الذكية
      Marker(
        markerId: const MarkerId('truck1'),
        position: const LatLng(18.2166, 42.5000),
        icon: _truckIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: '🚛 عربة نظافة ذكية',
          snippet: 'أبها المركز - متاحة الآن\n📍 حي الأندلس',
        ),
        onTap: () => _showLocationDetails('عربة نظافة', 'أبها المركز'),
      ),
      Marker(
        markerId: const MarkerId('truck2'),
        position: const LatLng(18.0735, 42.6326),
        icon: _truckIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: '🚛 عربة نظافة ذكية',
          snippet: 'خميس مشيط - متاحة الآن\n📍 حي الراقي',
        ),
        onTap: () => _showLocationDetails('عربة نظافة', 'خميس مشيط'),
      ),
      Marker(
        markerId: const MarkerId('truck3'),
        position: const LatLng(17.9695, 42.6653),
        icon: _truckIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: '🚛 عربة نظافة ذكية',
          snippet: 'بيشة - متاحة الآن\n📍 حي الشفا',
        ),
        onTap: () => _showLocationDetails('عربة نظافة', 'بيشة'),
      ),

      // الحدائق المخصبة
      Marker(
        markerId: const MarkerId('garden1'),
        position: const LatLng(18.2444, 42.5118),
        icon: _gardenIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: '🏞️ حديقة مخصبة',
          snippet: 'حديقة الأندلس - أبها\n🌱 حديقة عضوية متكاملة',
        ),
        onTap: () => _showLocationDetails('حديقة مخصبة', 'حديقة الأندلس'),
      ),
      Marker(
        markerId: const MarkerId('garden2'),
        position: const LatLng(18.3058, 42.5053),
        icon: _gardenIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: '🏞️ منتزه السودة',
          snippet: 'منتزه السودة البيئي\n🌿 مساحات خضراء طبيعية',
        ),
        onTap: () => _showLocationDetails('منتزه طبيعي', 'منتزه السودة'),
      ),
      Marker(
        markerId: const MarkerId('garden3'),
        position: const LatLng(18.0919, 42.6301),
        icon: _gardenIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: '🏞️ الجبل الأخضر',
          snippet: 'منتزه الجبل الأخضر\n🌺 حدائق مدرجة جميلة',
        ),
        onTap: () => _showLocationDetails('منتزه', 'الجبل الأخضر'),
      ),

      // مناطق زراعة الأشجار
      Marker(
        markerId: const MarkerId('trees1'),
        position: const LatLng(18.1284, 42.5890),
        icon: _treeIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: '🌳 مشروع التشجير',
          snippet: 'وادي الرياش\n🌲 مساحة للزراعة والتطوع',
        ),
        onTap: () => _showLocationDetails('مشروع تشجير', 'وادي الرياش'),
      ),
      Marker(
        markerId: const MarkerId('trees2'),
        position: const LatLng(18.2797, 42.3397),
        icon: _treeIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: '🌳 غابة رغدان',
          snippet: 'غابة رغدان الطبيعية\n🍃 محمية طبيعية',
        ),
        onTap: () => _showLocationDetails('محمية طبيعية', 'غابة رغدان'),
      ),
      Marker(
        markerId: const MarkerId('trees3'),
        position: const LatLng(18.4059, 42.4516),
        icon: _treeIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: '🌳 مشروع سودة',
          snippet: 'مشروع تشجير جبل سودة\n🏔️ مبادرة السعودية الخضراء',
        ),
        onTap: () => _showLocationDetails('مبادرة تشجير', 'جبل سودة'),
      ),
    };
  }

  // إنشاء مناطق ملونة للمحافظات
  void _createRegions() {
    _regions = {
      // منطقة أبها
      Polygon(
        polygonId: const PolygonId('abha_region'),
        points: const [
          LatLng(18.1500, 42.4500),
          LatLng(18.2800, 42.4500),
          LatLng(18.2800, 42.5800),
          LatLng(18.1500, 42.5800),
        ],
        fillColor: Colors.green.withOpacity(0.1),
        strokeColor: Colors.green,
        strokeWidth: 2,
      ),
      // منطقة خميس مشيط
      Polygon(
        polygonId: const PolygonId('khamis_region'),
        points: const [
          LatLng(18.0200, 42.5800),
          LatLng(18.1200, 42.5800),
          LatLng(18.1200, 42.7000),
          LatLng(18.0200, 42.7000),
        ],
        fillColor: Colors.blue.withOpacity(0.1),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      ),
    };
  }

  // إنشاء دوائر لمناطق الخدمة
  void _createServiceAreas() {
    _circles = {
      Circle(
        circleId: const CircleId('service_area_1'),
        center: const LatLng(18.2166, 42.5000),
        radius: 3000, // 3 كم
        fillColor: AppColors.primaryGreen.withOpacity(0.1),
        strokeColor: AppColors.primaryGreen,
        strokeWidth: 1,
      ),
      Circle(
        circleId: const CircleId('service_area_2'),
        center: const LatLng(18.0735, 42.6326),
        radius: 2500,
        fillColor: Colors.blue.withOpacity(0.1),
        strokeColor: Colors.blue,
        strokeWidth: 1,
      ),
    };
  }

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
        elevation: 2,
        shadowColor: AppColors.primaryGreen.withOpacity(0.3),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location, color: AppColors.primaryGreen),
            onPressed: () {
              if (mapController != null) {
                mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(_aseerCenter),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // معلومات الخريطة
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: AppColors.primaryGreen.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: AppColors.primaryGreen),
                    const SizedBox(width: 8),
                    const Text(
                      'مواقع الخدمات البيئية في عسير',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGreen,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLegendItem(
                        '🚛', 'عربات النظافة', AppColors.primaryGreen),
                    _buildLegendItem('🏞️', 'الحدائق المخصبة', Colors.blue),
                    _buildLegendItem('🌳', 'مناطق التشجير', Colors.orange),
                  ],
                ),
              ],
            ),
          ),
          // الخريطة
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: _aseerCenter,
                  markers: _markers,
                  mapType: MapType.hybrid,
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                ),
              ),
            ),
          ),
          // معلومات إضافية
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.touch_app,
                  color: AppColors.primaryGreen,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'اضغط على العلامات لعرض تفاصيل المواقع',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // عرض تفاصيل الموقع
  void _showLocationDetails(String type, String name) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIconForType(type),
                    color: AppColors.primaryGreen,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.directions),
                    label: const Text('الاتجاهات'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.info_outline),
                    label: const Text('المزيد'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryGreen,
                      side: const BorderSide(color: AppColors.primaryGreen),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'عربة نظافة':
        return Icons.local_shipping;
      case 'حديقة مخصبة':
      case 'منتزه طبيعي':
      case 'منتزه':
        return Icons.park;
      case 'مشروع تشجير':
      case 'محمية طبيعية':
      case 'مبادرة تشجير':
        return Icons.forest;
      default:
        return Icons.location_on;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'خريطة منطقة عسير التفاعلية',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: AppColors.primaryGreen.withOpacity(0.3),
        actions: [
          IconButton(
            icon: const Icon(Icons.layers, color: AppColors.primaryGreen),
            onPressed: () => _showMapTypeSelector(),
          ),
          IconButton(
            icon: const Icon(Icons.my_location, color: AppColors.primaryGreen),
            onPressed: () {
              if (mapController != null) {
                mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(_aseerCenter),
                );
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'جاري تحميل الخريطة...',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // شريط المعلومات العلوي
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryGreen.withOpacity(0.1),
                        AppColors.primaryGreen.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: AppColors.primaryGreen.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGreen,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.eco,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'مواقع الخدمات البيئية في منطقة عسير',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkGreen,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildAdvancedLegendItem(
                              '🚛',
                              'عربات ذكية',
                              AppColors.primaryGreen,
                              '${_markers.where((m) => m.markerId.value.startsWith('truck')).length}'),
                          _buildAdvancedLegendItem(
                              '🏞️',
                              'حدائق مخصبة',
                              Colors.blue,
                              '${_markers.where((m) => m.markerId.value.startsWith('garden')).length}'),
                          _buildAdvancedLegendItem(
                              '🌳',
                              'مناطق تشجير',
                              Colors.orange,
                              '${_markers.where((m) => m.markerId.value.startsWith('trees')).length}'),
                        ],
                      ),
                    ],
                  ),
                ),

                // الخريطة التفاعلية
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: _aseerCenter,
                        markers: _markers,
                        polygons: _regions,
                        circles: _circles,
                        mapType: MapType.hybrid,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        compassEnabled: true,
                        scrollGesturesEnabled: true,
                        zoomGesturesEnabled: true,
                        rotateGesturesEnabled: true,
                        tiltGesturesEnabled: true,
                        trafficEnabled: false,
                        buildingsEnabled: true,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: true,
                        style: '''[
                          {
                            "featureType": "poi.park",
                            "elementType": "geometry.fill",
                            "stylers": [
                              {
                                "color": "#a5b076"
                              }
                            ]
                          },
                          {
                            "featureType": "poi.park",
                            "elementType": "labels.text.fill",
                            "stylers": [
                              {
                                "color": "#447530"
                              }
                            ]
                          }
                        ]''',
                      ),
                    ),
                  ),
                ),

                // شريط الأدوات السفلي
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.touch_app,
                          color: AppColors.primaryGreen,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'اضغط على العلامات لعرض تفاصيل المواقع والحصول على الاتجاهات',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildAdvancedLegendItem(
      String emoji, String label, Color color, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showMapTypeSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'نوع الخريطة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child:
                      _buildMapTypeOption('عادية', MapType.normal, Icons.map),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMapTypeOption(
                      'القمر الصناعي', MapType.satellite, Icons.satellite),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMapTypeOption(
                      'مختلطة', MapType.hybrid, Icons.layers),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapTypeOption(String title, MapType type, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // تغيير نوع الخريطة (سيتم تنفيذه لاحقاً)
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryGreen.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryGreen, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
