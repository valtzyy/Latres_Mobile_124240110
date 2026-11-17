import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userC = TextEditingController();
  final _passC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final sp = await SharedPreferences.getInstance();
    if ((sp.getBool('isLogin') ?? false) && mounted) {
      Get.offAll(() => const MainPage());
    }
  }

  Future<void> _login() async {
    if (_userC.text.trim() == kNim && _passC.text.trim() == kPassword) {
      final sp = await SharedPreferences.getInstance();
      await sp.setBool('isLogin', true);
      await sp.setString('username', _userC.text.trim());
      if (mounted) Get.offAll(() => const MainPage());
    } else {
      Get.snackbar('Login gagal', 'Username atau password salah',
          backgroundColor: Colors.red.shade900, colorText: Colors.white);
    }
  }

  @override
  void dispose() {
    _userC.dispose();
    _passC.dispose();
    super.dispose();
  }

  InputDecoration _deco(String label, IconData icon) => InputDecoration(
        hintText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.movie_filter, size: 72, color: kAccent),
              const SizedBox(height: 8),
              const Text('NontonSkuy!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              TextField(
                  controller: _userC,
                  decoration: _deco('Username', Icons.person)),
              const SizedBox(height: 14),
              TextField(
                  controller: _passC,
                  obscureText: true,
                  onSubmitted: (_) => _login(),
                  decoration: _deco('Password', Icons.lock)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
