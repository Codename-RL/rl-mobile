import 'package:flutter/material.dart';
import '../../nav/navbar.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengingat')),
      body: const Center(child: Text('Pengingat Page')),
      bottomNavigationBar: const Navbar(),
    );
  }
}
