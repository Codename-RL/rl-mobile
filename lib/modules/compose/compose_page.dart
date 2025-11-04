import 'package:flutter/material.dart';
import '../../nav/navbar.dart';

class ComposePage extends StatelessWidget {
  const ComposePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Jurnal')),
      body: const Center(child: Text('Buat Jurnal Page')),
      bottomNavigationBar: const Navbar(),
    );
  }
}
