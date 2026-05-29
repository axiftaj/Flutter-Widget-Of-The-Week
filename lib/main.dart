import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const EarnWithAdsApp());
}

class AppColors {
  static const primary = Color(0xFF0D47A1);
  static const secondary = Color(0xFF1976D2);
  static const accent = Color(0xFF00C853);
  static const background = Color(0xFFF5F5F5);
}

class EarnWithAdsApp extends StatelessWidget {
  const EarnWithAdsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EarnWithAds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: AppColors.primary, scaffoldBackgroundColor: AppColors.background),
      home: const AuthWrapper(),
    );
  }
}

// --- AUTH LOGIC ---
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        if (snapshot.hasData) return const MainNavigation();
        return const LoginScreen();
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool _isAdminMode = false;

  Future<void> _googleSignIn() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? gAuth = await gUser?.authentication;
      if (gAuth == null) return;
      final credential = GoogleAuthProvider.credential(accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      UserCredential userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userCred.user!.uid);
      final doc = await userDoc.get();
      if (!doc.exists) {
        await userDoc.set({'uid': userCred.user!.uid, 'name': userCred.user!.displayName, 'email': userCred.user!.email, 'photoUrl': userCred.user!.photoURL, 'earnings': 0.0, 'withdrawn': 0.0, 'premiumStatus': 'free', 'isAdmin': false});
      }
    } catch (e) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()))); }
  }

  void _adminLogin() async {
    if (_email.text == "admin@gmail.com" && _pass.text == "admin") {
      try { await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text.trim(), password: _pass.text.trim()); }
      catch (e) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed"))); }
    } else { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Access Denied"))); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.ads_click, size: 80, color: AppColors.primary),
        const Text("EarnWithAds", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        if (!_isAdminMode) ...[
          ElevatedButton(onPressed: _googleSignIn, style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)), child: const Text("Sign in with Google")),
          TextButton(onPressed: () => setState(() => _isAdminMode = true), child: const Text("Admin Access"))
        ] else ...[
          TextField(controller: _email, decoration: const InputDecoration(labelText: "Admin Email")),
          TextField(controller: _pass, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _adminLogin, style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)), child: const Text("Admin Login")),
          TextButton(onPressed: () => setState(() => _isAdminMode = false), child: const Text("Back"))
        ]
      ])),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;
  bool _isAdmin = false;
  @override
  void initState() { super.initState(); _checkAdmin(); }
  void _checkAdmin() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (mounted) setState(() => _isAdmin = doc.data()?['isAdmin'] ?? false);
    }
  }
  @override
  Widget build(BuildContext context) {
    if (_isAdmin) return const AdminPanel();
    return Scaffold(
      body: [const DashboardScreen(), const AdsScreen(), const HistoryScreen(), const ProfileScreen()][_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index, type: BottomNavigationBarType.fixed, selectedItemColor: AppColors.primary,
        onTap: (i) => setState(() => _index = i),
        items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"), BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: "Ads"), BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"), BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")],
      ),
    );
  }
}

// --- USER DASHBOARD ---
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text("Welcome, ${user?.displayName?.split(' ')[0]}")),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          var data = snap.data!;
          return SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
            _card("Account Type", data['premiumStatus'].toString().toUpperCase(), Colors.orange),
            _card("Total Earnings", "PKR ${data['earnings']}", Colors.green),
            _card("Withdrawn", "PKR ${data['withdrawn']}", Colors.blue),
            const SizedBox(height: 20),
            const Align(alignment: Alignment.centerLeft, child: Text("Sponsored Ads", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('ads').where('active', isEqualTo: true).snapshots(),
              builder: (context, adSnap) {
                if (!adSnap.hasData) return const Text("Loading ads...");
                return Column(children: adSnap.data!.docs.map((d) => ListTile(leading: const Icon(Icons.ads_click), title: Text(d['title']), onTap: () => _showAd(context, d['adCode']))).toList());
              },
            )
          ]));
        },
      ),
    );
  }
  Widget _card(String t, String v, Color c) => Card(child: ListTile(title: Text(t), trailing: Text(v, style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 18))));
  void _showAd(context, code) => showDialog(context: context, builder: (c) => AlertDialog(content: SizedBox(height: 300, child: WebViewWidget(controller: WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadHtmlString(code)))));
}

// --- ADS WATCHING ---
class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});
  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  bool _loading = false;
  int _timer = 30;
  void _startAd() async {
    setState(() => _loading = true);
    Timer.periodic(const Duration(seconds: 1), (t) async {
      if (_timer > 0) { setState(() => _timer--); }
      else {
        t.cancel();
        final settings = await FirebaseFirestore.instance.collection('adminSettings').doc('config').get();
        double rate = (settings.data()?['adRatePerView'] ?? 1.0).toDouble();
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'earnings': FieldValue.increment(rate)});
        if (mounted) setState(() { _loading = false; _timer = 30; });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Reward Added!")));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Watch Ads")),
      body: Center(child: _loading ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Watching Ad: $_timer", style: const TextStyle(fontSize: 40)), const Text("Don't close the app")]) : ElevatedButton(onPressed: _startAd, child: const Text("Start Watching (30s)"))),
    );
  }
}

// --- HISTORY & PROFILE ---
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Withdraw History")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('withdrawals').where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(children: snap.data!.docs.map((d) => ListTile(title: Text("PKR ${d['amount']}"), subtitle: Text(d['method']), trailing: Text(d['status']))).toList());
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final amt = TextEditingController();
    final det = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(children: [
        CircleAvatar(radius: 40, backgroundImage: NetworkImage(user?.photoURL ?? '')),
        const SizedBox(height: 10),
        Text(user?.displayName ?? ''),
        const Divider(),
        const Text("Withdraw Funds", style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(controller: amt, decoration: const InputDecoration(labelText: "Amount")),
        TextField(controller: det, decoration: const InputDecoration(labelText: "Details (Account No)")),
        ElevatedButton(onPressed: () async {
          await FirebaseFirestore.instance.collection('withdrawals').add({'userId': user!.uid, 'amount': double.parse(amt.text), 'method': 'Manual', 'status': 'pending', 'timestamp': FieldValue.serverTimestamp()});
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Requested")));
        }, child: const Text("Withdraw")),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => FirebaseAuth.instance.signOut(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Logout"))
      ])),
    );
  }
}

// --- ADMIN PANEL ---
class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Console"), actions: [IconButton(onPressed: () => FirebaseAuth.instance.signOut(), icon: const Icon(Icons.logout))]),
      body: GridView.count(crossAxisCount: 2, children: [
        _btn(context, "Withdrawals", const AdminWithdrawals()),
        _btn(context, "Premium Req", const AdminPremium()),
        _btn(context, "Manage Ads", const AdminAds()),
        _btn(context, "Settings", const AdminSettings()),
      ]),
    );
  }
  Widget _btn(context, txt, page) => InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => page)), child: Card(child: Center(child: Text(txt))));
}

// (Yahan Admin ke screens ki logic short mein hai - full functionality ke liye main.dart mein pehle wali logic use karein)
class AdminWithdrawals extends StatelessWidget { const AdminWithdrawals({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Withdrawals"))); }
class AdminPremium extends StatelessWidget { const AdminPremium({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Premium"))); }
class AdminAds extends StatelessWidget { const AdminAds({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Ads"))); }
class AdminSettings extends StatelessWidget { const AdminSettings({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("Settings"))); }
