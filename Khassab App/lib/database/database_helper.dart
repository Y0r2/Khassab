import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'khassab_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // جدول المستخدمين
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        phone TEXT,
        points INTEGER DEFAULT 0,
        level INTEGER DEFAULT 1,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // جدول الأنشطة البيئية
    await db.execute('''
      CREATE TABLE activities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        activity_type TEXT NOT NULL,
        points_earned INTEGER NOT NULL,
        location TEXT,
        description TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // جدول العربات الذكية
    await db.execute('''
      CREATE TABLE smart_bins (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        capacity INTEGER DEFAULT 100,
        current_fill INTEGER DEFAULT 0,
        last_emptied TEXT,
        is_active INTEGER DEFAULT 1
      )
    ''');

    // جدول الحدائق المخصبة
    await db.execute('''
      CREATE TABLE gardens (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        plants_count INTEGER DEFAULT 0,
        fertilizer_used REAL DEFAULT 0.0,
        is_active INTEGER DEFAULT 1
      )
    ''');

    // إدراج بيانات تجريبية
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    // إضافة مستخدم تجريبي
    await db.insert('users', {
      'name': 'سارة أحمد',
      'email': 'sara@khassab.app',
      'phone': '0501234567',
      'points': 2450,
      'level': 7,
    });

    // إضافة العربات الذكية في عسير
    final smartBins = [
      {
        'name': 'عربة ذكية - مركز أبها',
        'latitude': 18.2164,
        'longitude': 42.5048,
        'capacity': 100,
        'current_fill': 45,
      },
      {
        'name': 'عربة ذكية - خميس مشيط',
        'latitude': 18.3113,
        'longitude': 42.7287,
        'capacity': 150,
        'current_fill': 78,
      },
      {
        'name': 'عربة ذكية - بيشة',
        'latitude': 19.9948,
        'longitude': 42.6069,
        'capacity': 120,
        'current_fill': 23,
      },
    ];

    for (var bin in smartBins) {
      await db.insert('smart_bins', bin);
    }

    // إضافة الحدائق المخصبة
    final gardens = [
      {
        'name': 'حديقة مخصبة - النماص',
        'latitude': 19.1759,
        'longitude': 42.2365,
        'plants_count': 150,
        'fertilizer_used': 45.5,
      },
      {
        'name': 'حديقة مخصبة - السودة',
        'latitude': 18.2732,
        'longitude': 42.3647,
        'plants_count': 200,
        'fertilizer_used': 67.2,
      },
    ];

    for (var garden in gardens) {
      await db.insert('gardens', garden);
    }

    // إضافة أنشطة تجريبية
    final activities = [
      {
        'user_id': 1,
        'activity_type': 'waste_disposal',
        'points_earned': 50,
        'location': 'أبها',
        'description': 'التخلص من النفايات العضوية في العربة الذكية',
      },
      {
        'user_id': 1,
        'activity_type': 'tree_planting',
        'points_earned': 100,
        'location': 'النماص',
        'description': 'زراعة شجرة عرعر في حديقة النماص',
      },
      {
        'user_id': 1,
        'activity_type': 'recycling',
        'points_earned': 75,
        'location': 'خميس مشيط',
        'description': 'إعادة تدوير مواد بلاستيكية',
      },
    ];

    for (var activity in activities) {
      await db.insert('activities', activity);
    }
  }

  // الحصول على بيانات المستخدم
  Future<Map<String, dynamic>?> getUser(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // الحصول على العربات الذكية
  Future<List<Map<String, dynamic>>> getSmartBins() async {
    final db = await database;
    return await db.query('smart_bins', where: 'is_active = ?', whereArgs: [1]);
  }

  // الحصول على الحدائق
  Future<List<Map<String, dynamic>>> getGardens() async {
    final db = await database;
    return await db.query('gardens', where: 'is_active = ?', whereArgs: [1]);
  }

  // الحصول على أنشطة المستخدم
  Future<List<Map<String, dynamic>>> getUserActivities(int userId) async {
    final db = await database;
    return await db.query(
      'activities',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
      limit: 10,
    );
  }

  // إضافة نشاط جديد
  Future<int> addActivity({
    required int userId,
    required String activityType,
    required int pointsEarned,
    String? location,
    String? description,
  }) async {
    final db = await database;

    // إضافة النشاط
    int activityId = await db.insert('activities', {
      'user_id': userId,
      'activity_type': activityType,
      'points_earned': pointsEarned,
      'location': location,
      'description': description,
    });

    // تحديث نقاط المستخدم
    await db.rawUpdate('''
      UPDATE users 
      SET points = points + ?, 
          level = CASE 
            WHEN points + ? >= 5000 THEN 10
            WHEN points + ? >= 4000 THEN 9  
            WHEN points + ? >= 3000 THEN 8
            WHEN points + ? >= 2000 THEN 7
            WHEN points + ? >= 1500 THEN 6
            WHEN points + ? >= 1000 THEN 5
            WHEN points + ? >= 700 THEN 4
            WHEN points + ? >= 400 THEN 3
            WHEN points + ? >= 200 THEN 2
            ELSE 1
          END
      WHERE id = ?
    ''', [
      pointsEarned,
      pointsEarned,
      pointsEarned,
      pointsEarned,
      pointsEarned,
      pointsEarned,
      pointsEarned,
      pointsEarned,
      pointsEarned,
      pointsEarned,
      userId
    ]);

    return activityId;
  }

  // تحديث حالة العربة الذكية
  Future<void> updateBinFillLevel(int binId, int fillLevel) async {
    final db = await database;
    await db.update(
      'smart_bins',
      {'current_fill': fillLevel},
      where: 'id = ?',
      whereArgs: [binId],
    );
  }

  // إحصائيات عامة
  Future<Map<String, dynamic>> getStatistics() async {
    final db = await database;

    final totalBins = await db.rawQuery(
        'SELECT COUNT(*) as count FROM smart_bins WHERE is_active = 1');
    final totalGardens = await db
        .rawQuery('SELECT COUNT(*) as count FROM gardens WHERE is_active = 1');
    final totalUsers = await db.rawQuery('SELECT COUNT(*) as count FROM users');
    final totalWasteProcessed = await db.rawQuery('''
      SELECT SUM(points_earned) * 0.02 as total 
      FROM activities 
      WHERE activity_type = "waste_disposal"
    ''');

    return {
      'smart_bins': totalBins.first['count'] ?? 0,
      'gardens': totalGardens.first['count'] ?? 0,
      'active_users': totalUsers.first['count'] ?? 0,
      'waste_processed': totalWasteProcessed.first['total'] ?? 0.0,
    };
  }
}
