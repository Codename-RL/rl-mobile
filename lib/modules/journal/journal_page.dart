import 'package:flutter/material.dart';
import '../../nav/navbar.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jurnal')),
      body: const Center(child: Text('Jurnal Page')),
      bottomNavigationBar: const Navbar(),
    );
  }
}
