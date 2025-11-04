import 'package:flutter/material.dart';
import '../../nav/navbar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting')),
      body: const Center(child: Text('Setting Page')),
      bottomNavigationBar: const Navbar(),
    );
  }
}
