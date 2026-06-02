import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== ATTENDANCE ====================
  
  // Add attendance record
  Future<bool> addAttendance(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('attendance').add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get attendance by student
  Stream<QuerySnapshot> getStudentAttendance(String studentId) {
    return _firestore
        .collection('attendance')
        .where('studentId', isEqualTo: studentId)
        .orderBy('date', descending: true)
        .snapshots();
  }

  // Get attendance by class
  Stream<QuerySnapshot> getClassAttendance(String classId, DateTime date) {
    return _firestore
        .collection('attendance')
        .where('classId', isEqualTo: classId)
        .where('date', isEqualTo: Timestamp.fromDate(date))
        .snapshots();
  }

  // ==================== HOMEWORK ====================
  
  // Add homework
  Future<String?> addHomework(Map<String, dynamic> data) async {
    try {
      DocumentReference doc = await _firestore.collection('homework').add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return doc.id;
    } catch (e) {
      return null;
    }
  }

  // Update homework
  Future<bool> updateHomework(String homeworkId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('homework').doc(homeworkId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get homework by class
  Stream<QuerySnapshot> getClassHomework(String classId) {
    return _firestore
        .collection('homework')
        .where('classId', isEqualTo: classId)
        .orderBy('dueDate', descending: false)
        .snapshots();
  }

  // Get homework by student
  Stream<QuerySnapshot> getStudentHomework(String studentId) {
    return _firestore
        .collection('homework')
        .where('studentIds', arrayContains: studentId)
        .orderBy('dueDate', descending: false)
        .snapshots();
  }

  // Submit homework
  Future<bool> submitHomework(String homeworkId, String studentId, Map<String, dynamic> submission) async {
    try {
      await _firestore.collection('homework').doc(homeworkId).collection('submissions').doc(studentId).set({
        ...submission,
        'submittedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== EXAMS & MARKS ====================
  
  // Add exam
  Future<String?> addExam(Map<String, dynamic> data) async {
    try {
      DocumentReference doc = await _firestore.collection('exams').add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return doc.id;
    } catch (e) {
      return null;
    }
  }

  // Get exams by class
  Stream<QuerySnapshot> getClassExams(String classId) {
    return _firestore
        .collection('exams')
        .where('classId', isEqualTo: classId)
        .orderBy('examDate', descending: false)
        .snapshots();
  }

  // Add marks
  Future<bool> addMarks(String examId, String studentId, Map<String, dynamic> marks) async {
    try {
      await _firestore.collection('exams').doc(examId).collection('marks').doc(studentId).set({
        ...marks,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get student marks
  Stream<QuerySnapshot> getStudentMarks(String studentId) {
    return _firestore
        .collectionGroup('marks')
        .where('studentId', isEqualTo: studentId)
        .snapshots();
  }

  // ==================== NOTIFICATIONS ====================
  
  // Add notification
  Future<bool> addNotification(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('notifications').add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
        'isRead': false,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get user notifications
  Stream<QuerySnapshot> getUserNotifications(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots();
  }

  // Mark notification as read
  Future<bool> markNotificationRead(String notificationId) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).update({
        'isRead': true,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== MESSAGES ====================
  
  // Send message
  Future<bool> sendMessage(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('messages').add({
        ...data,
        'sentAt': FieldValue.serverTimestamp(),
        'isRead': false,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get conversation messages
  Stream<QuerySnapshot> getMessages(String senderId, String receiverId) {
    return _firestore
        .collection('messages')
        .where('participants', arrayContains: senderId)
        .orderBy('sentAt', descending: false)
        .snapshots();
  }

  // ==================== LEAVE APPLICATIONS ====================
  
  // Apply for leave
  Future<String?> applyLeave(Map<String, dynamic> data) async {
    try {
      DocumentReference doc = await _firestore.collection('leaves').add({
        ...data,
        'status': 'pending',
        'appliedAt': FieldValue.serverTimestamp(),
      });
      return doc.id;
    } catch (e) {
      return null;
    }
  }

  // Update leave status
  Future<bool> updateLeaveStatus(String leaveId, String status, String? remarks) async {
    try {
      await _firestore.collection('leaves').doc(leaveId).update({
        'status': status,
        'remarks': remarks,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get student leaves
  Stream<QuerySnapshot> getStudentLeaves(String studentId) {
    return _firestore
        .collection('leaves')
        .where('studentId', isEqualTo: studentId)
        .orderBy('appliedAt', descending: true)
        .snapshots();
  }

  // ==================== TIMETABLE ====================
  
  // Add timetable
  Future<bool> addTimetable(String classId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('timetables').doc(classId).set({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get class timetable
  Stream<DocumentSnapshot> getClassTimetable(String classId) {
    return _firestore.collection('timetables').doc(classId).snapshots();
  }

  // ==================== FEES ====================
  
  // Add fee record
  Future<bool> addFeeRecord(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('fees').add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get student fees
  Stream<QuerySnapshot> getStudentFees(String studentId) {
    return _firestore
        .collection('fees')
        .where('studentId', isEqualTo: studentId)
        .orderBy('dueDate', descending: false)
        .snapshots();
  }

  // Update fee payment
  Future<bool> updateFeePayment(String feeId, Map<String, dynamic> payment) async {
    try {
      await _firestore.collection('fees').doc(feeId).update({
        'paid': true,
        'paymentDate': FieldValue.serverTimestamp(),
        'paymentDetails': payment,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // ==================== CLASSES ====================
  
  // Add class
  Future<String?> addClass(Map<String, dynamic> data) async {
    try {
      DocumentReference doc = await _firestore.collection('classes').add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return doc.id;
    } catch (e) {
      return null;
    }
  }

  // Get all classes
  Stream<QuerySnapshot> getAllClasses() {
    return _firestore.collection('classes').orderBy('name').snapshots();
  }

  // Get teacher classes
  Stream<QuerySnapshot> getTeacherClasses(String teacherId) {
    return _firestore
        .collection('classes')
        .where('teacherId', isEqualTo: teacherId)
        .snapshots();
  }

  // ==================== EVENTS ====================
  
  // Add event
  Future<String?> addEvent(Map<String, dynamic> data) async {
    try {
      DocumentReference doc = await _firestore.collection('events').add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return doc.id;
    } catch (e) {
      return null;
    }
  }

  // Get all events
  Stream<QuerySnapshot> getAllEvents() {
    return _firestore
        .collection('events')
        .orderBy('eventDate', descending: false)
        .snapshots();
  }

  // ==================== GENERIC METHODS ====================
  
  // Get document by ID
  Future<DocumentSnapshot> getDocument(String collection, String docId) {
    return _firestore.collection(collection).doc(docId).get();
  }

  // Delete document
  Future<bool> deleteDocument(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Batch write
  Future<bool> batchWrite(List<Map<String, dynamic>> operations) async {
    try {
      WriteBatch batch = _firestore.batch();
      
      for (var operation in operations) {
        DocumentReference ref = _firestore.collection(operation['collection']).doc(operation['docId']);
        if (operation['type'] == 'set') {
          batch.set(ref, operation['data']);
        } else if (operation['type'] == 'update') {
          batch.update(ref, operation['data']);
        } else if (operation['type'] == 'delete') {
          batch.delete(ref);
        }
      }
      
      await batch.commit();
      return true;
    } catch (e) {
      return false;
    }
  }
}
