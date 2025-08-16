import 'dart:math' as math;
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  final Location _location = Location();

  // التحقق من الأذونات والحصول على الموقع الحالي
  Future<LocationData?> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // التحقق من تفعيل خدمة الموقع
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw 'خدمة الموقع غير مفعلة';
      }
    }

    // التحقق من الأذونات
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw 'لم يتم منح إذن الوصول للموقع';
      }
    }

    try {
      return await _location.getLocation();
    } catch (e) {
      throw 'فشل في الحصول على الموقع الحالي: ${e.toString()}';
    }
  }

  // تحويل الإحداثيات إلى عنوان
  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(latitude, longitude,
              localeIdentifier: 'ar_SA');

      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks[0];
        return '${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}';
      }
      return 'موقع غير محدد';
    } catch (e) {
      return 'فشل في تحديد العنوان';
    }
  }

  // البحث عن موقع بالاسم
  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      List<geocoding.Location> locations =
          await geocoding.locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations[0].latitude, locations[0].longitude);
      }
      return null;
    } catch (e) {
      throw 'فشل في العثور على الموقع: ${e.toString()}';
    }
  }

  // حساب المسافة بين نقطتين (بالكيلومتر)
  double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371; // نصف قطر الأرض بالكيلومتر

    double lat1Rad = point1.latitude * (math.pi / 180);
    double lat2Rad = point2.latitude * (math.pi / 180);
    double deltaLatRad = (point2.latitude - point1.latitude) * (math.pi / 180);
    double deltaLngRad =
        (point2.longitude - point1.longitude) * (math.pi / 180);

    double a = math.sin(deltaLatRad / 2) * math.sin(deltaLatRad / 2) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            math.sin(deltaLngRad / 2) *
            math.sin(deltaLngRad / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  // مواقع العربات الذكية في عسير
  List<Map<String, dynamic>> getAseerSmartBins() {
    return [
      {
        'id': 'bin_abha_1',
        'name': 'عربة ذكية - مركز أبها',
        'location': const LatLng(18.2164, 42.5048),
        'address': 'أبها، منطقة عسير',
        'capacity': 85,
        'type': 'mixed',
        'status': 'available',
      },
      {
        'id': 'bin_abha_2',
        'name': 'عربة ذكية - منتزه عسير الوطني',
        'location': const LatLng(18.2500, 42.4800),
        'address': 'منتزه عسير الوطني، أبها',
        'capacity': 60,
        'type': 'organic',
        'status': 'available',
      },
      {
        'id': 'bin_khamis_1',
        'name': 'عربة ذكية - خميس مشيط المركز',
        'location': const LatLng(18.3113, 42.7287),
        'address': 'خميس مشيط، منطقة عسير',
        'capacity': 75,
        'type': 'mixed',
        'status': 'available',
      },
      {
        'id': 'bin_khamis_2',
        'name': 'عربة ذكية - حديقة الملك عبدالله',
        'location': const LatLng(18.3200, 42.7400),
        'address': 'حديقة الملك عبدالله، خميس مشيط',
        'capacity': 90,
        'type': 'recyclable',
        'status': 'available',
      },
      {
        'id': 'bin_bisha_1',
        'name': 'عربة ذكية - بيشة المركز',
        'location': const LatLng(19.9948, 42.6069),
        'address': 'بيشة، منطقة عسير',
        'capacity': 55,
        'type': 'mixed',
        'status': 'maintenance',
      },
      {
        'id': 'bin_namas_1',
        'name': 'عربة ذكية - النماص',
        'location': const LatLng(19.1759, 42.2365),
        'address': 'النماص، منطقة عسير',
        'capacity': 70,
        'type': 'organic',
        'status': 'available',
      },
      {
        'id': 'bin_tanomah_1',
        'name': 'عربة ذكية - تنومة',
        'location': const LatLng(18.9200, 42.1500),
        'address': 'تنومة، منطقة عسير',
        'capacity': 65,
        'type': 'mixed',
        'status': 'available',
      },
      {
        'id': 'bin_mahayel_1',
        'name': 'عربة ذكية - محايل عسير',
        'location': const LatLng(18.4500, 42.0300),
        'address': 'محايل عسير، منطقة عسير',
        'capacity': 80,
        'type': 'organic',
        'status': 'available',
      },
    ];
  }

  // الحدائق المخصبة في عسير
  List<Map<String, dynamic>> getAseerGardens() {
    return [
      {
        'id': 'garden_alsuda',
        'name': 'حديقة السودة الطبيعية',
        'location': const LatLng(18.2732, 42.3647),
        'address': 'السودة، أبها',
        'type': 'natural_reserve',
        'plants': ['العرعر', 'الأكاسيا', 'الزيتون البري'],
        'area': 15.5, // بالهكتار
        'status': 'active',
      },
      {
        'id': 'garden_abha_park',
        'name': 'حديقة أبها العامة',
        'location': const LatLng(18.2200, 42.4900),
        'address': 'أبها، منطقة عسير',
        'type': 'public_garden',
        'plants': ['الورد الطائفي', 'النخيل', 'الرياحين'],
        'area': 8.2,
        'status': 'active',
      },
      {
        'id': 'garden_namas',
        'name': 'حديقة النماص الجبلية',
        'location': const LatLng(19.1800, 42.2400),
        'address': 'النماص، منطقة عسير',
        'type': 'mountain_garden',
        'plants': ['الخزامى', 'البرسيم الجبلي', 'النعناع البري'],
        'area': 12.0,
        'status': 'active',
      },
      {
        'id': 'garden_tanomah',
        'name': 'مزارع تنومة المدرجة',
        'location': const LatLng(18.9100, 42.1400),
        'address': 'تنومة، منطقة عسير',
        'type': 'terraced_farms',
        'plants': ['القمح', 'الشعير', 'البرسيم'],
        'area': 25.8,
        'status': 'active',
      },
      {
        'id': 'garden_mahayel',
        'name': 'بساتين محايل الاستوائية',
        'location': const LatLng(18.4400, 42.0200),
        'address': 'محايل عسير، منطقة عسير',
        'type': 'tropical_garden',
        'plants': ['المانجو', 'البابايا', 'النخيل'],
        'area': 18.7,
        'status': 'active',
      },
    ];
  }

  // العثور على أقرب عربة ذكية
  Map<String, dynamic>? findNearestSmartBin(LatLng userLocation) {
    List<Map<String, dynamic>> bins = getAseerSmartBins();
    Map<String, dynamic>? nearestBin;
    double shortestDistance = double.infinity;

    for (var bin in bins) {
      if (bin['status'] == 'available') {
        double distance = calculateDistance(userLocation, bin['location']);
        if (distance < shortestDistance) {
          shortestDistance = distance;
          nearestBin = bin;
          nearestBin['distance'] = distance;
        }
      }
    }

    return nearestBin;
  }

  // العثور على أقرب حديقة
  Map<String, dynamic>? findNearestGarden(LatLng userLocation) {
    List<Map<String, dynamic>> gardens = getAseerGardens();
    Map<String, dynamic>? nearestGarden;
    double shortestDistance = double.infinity;

    for (var garden in gardens) {
      if (garden['status'] == 'active') {
        double distance = calculateDistance(userLocation, garden['location']);
        if (distance < shortestDistance) {
          shortestDistance = distance;
          nearestGarden = garden;
          nearestGarden['distance'] = distance;
        }
      }
    }

    return nearestGarden;
  }
}
