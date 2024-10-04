import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionController {

  SessionController._internal();
  static final SessionController _instance = SessionController._internal();
  static SessionController get instance => _instance;

  String? userId;
  String? token;
  DateTime? expiryDate;

  bool get isSessionActive {
    if (token == null || expiryDate == null) return false;
    return DateTime.now().isBefore(expiryDate!);
  }

  void setSession(String userId, String token, DateTime expiryDate) async {
    this.userId = userId;
    this.token = token;
    this.expiryDate = expiryDate;

    final storage = const FlutterSecureStorage();
    await storage.write( key: 'userId', value: userId);
    await storage.write(key:'token', value:token);
    await storage.write(key: 'expiryDate',value: expiryDate.toIso8601String());
  }

  Future<void> loadSession() async {
    final storage = const FlutterSecureStorage();
    final response = await Future.wait([
      storage.read(key: 'userId'),
      storage.read(key: 'token'),
      storage.read(key: 'expiryDate')
    ]);
    userId = response[0];
    token = response[1];
    String? expiryDateString = response[2];
    if (expiryDateString != null) {
      expiryDate = DateTime.parse(expiryDateString);
    }
  }

  void clearSession() async {
    userId = null;
    token = null;
    expiryDate = null;

    final storage = const FlutterSecureStorage();
    await Future.wait([
      storage.delete(key: 'userId'),
      storage.delete(key: 'token'),
      storage.delete(key: 'expiryDate')
    ]);
  }
}

