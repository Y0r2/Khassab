import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // الحصول على المستخدم الحالي
  User? get currentUser => _auth.currentUser;

  // Stream للاستماع لتغييرات حالة المصادقة
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // تسجيل مستخدم جديد
  Future<UserCredential?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    String? city,
  }) async {
    try {
      // إنشاء حساب في Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user != null) {
        // حفظ بيانات المستخدم في Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'fullName': fullName,
          'phone': phone,
          'city': city ?? 'أبها', // المدينة الافتراضية
          'points': 0,
          'level': 1,
          'createdAt': FieldValue.serverTimestamp(),
          'isActive': true,
          'wasteDisposals': 0,
          'plantsHelped': 0,
          'locationsVisited': [],
          'achievements': [],
        });

        // تحديث اسم المستخدم
        await user.updateDisplayName(fullName);
      }

      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'حدث خطأ غير متوقع: ${e.toString()}';
    }
  }

  // تسجيل الدخول
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'حدث خطأ غير متوقع: ${e.toString()}';
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw 'فشل في تسجيل الخروج: ${e.toString()}';
    }
  }

  // إرسال رابط إعادة تعيين كلمة المرور
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'فشل في إرسال رابط إعادة التعيين: ${e.toString()}';
    }
  }

  // الحصول على بيانات المستخدم من Firestore
  Future<DocumentSnapshot?> getUserData() async {
    if (currentUser != null) {
      try {
        return await _firestore.collection('users').doc(currentUser!.uid).get();
      } catch (e) {
        throw 'فشل في الحصول على بيانات المستخدم: ${e.toString()}';
      }
    }
    return null;
  }

  // تحديث بيانات المستخدم
  Future<void> updateUserData(Map<String, dynamic> data) async {
    if (currentUser != null) {
      try {
        await _firestore.collection('users').doc(currentUser!.uid).update(data);
      } catch (e) {
        throw 'فشل في تحديث البيانات: ${e.toString()}';
      }
    }
  }

  // إضافة نقاط للمستخدم
  Future<void> addPoints(int points, String activityType) async {
    if (currentUser != null) {
      try {
        DocumentReference userRef =
            _firestore.collection('users').doc(currentUser!.uid);

        await _firestore.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(userRef);

          if (snapshot.exists) {
            Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
            int currentPoints = data['points'] ?? 0;
            int newPoints = currentPoints + points;
            int newLevel = (newPoints ~/ 500) + 1; // كل 500 نقطة = مستوى جديد

            transaction.update(userRef, {
              'points': newPoints,
              'level': newLevel,
              'lastActivity': FieldValue.serverTimestamp(),
            });

            // إضافة النشاط إلى مجموعة الأنشطة
            transaction.set(_firestore.collection('activities').doc(), {
              'userId': currentUser!.uid,
              'type': activityType,
              'points': points,
              'timestamp': FieldValue.serverTimestamp(),
              'location': null, // يمكن إضافة الموقع لاحقاً
            });
          }
        });
      } catch (e) {
        throw 'فشل في إضافة النقاط: ${e.toString()}';
      }
    }
  }

  // معالجة أخطاء Firebase Auth
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً';
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم من قبل';
      case 'invalid-email':
        return 'البريد الإلكتروني غير صحيح';
      case 'user-not-found':
        return 'المستخدم غير موجود';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'user-disabled':
        return 'تم تعطيل هذا الحساب';
      case 'too-many-requests':
        return 'تم تجاوز عدد المحاولات المسموح. حاول لاحقاً';
      case 'operation-not-allowed':
        return 'عملية غير مسموحة';
      case 'invalid-credential':
        return 'بيانات الاعتماد غير صحيحة';
      default:
        return 'حدث خطأ في المصادقة: ${e.message}';
    }
  }
}
