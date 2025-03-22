import 'package:cloud_firestore/cloud_firestore.dart';

class MonitoringService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Record app usage
  Future<void> recordAppUsage(String childId, String appName, int duration) async {
    final date = DateTime.now().toIso8601String().split('T')[0];
    
    await _db
        .collection('usage')
        .doc(childId)
        .collection('daily')
        .doc(date)
        .set({
          'apps': {
            appName: FieldValue.increment(duration),
          },
          'totalTime': FieldValue.increment(duration),
        }, SetOptions(merge: true));
  }

  // Get daily usage
  Stream<DocumentSnapshot> getDailyUsage(String childId) {
    final date = DateTime.now().toIso8601String().split('T')[0];
    return _db
        .collection('usage')
        .doc(childId)
        .collection('daily')
        .doc(date)
        .snapshots();
  }

  // Update screen time limit
  Future<void> updateScreenTimeLimit(String childId, int limitInMinutes) async {
    await _db.collection('users').doc(childId).update({
      'settings.screenTimeLimit': limitInMinutes,
    });
  }
}
