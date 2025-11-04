// layout/main_scaffold.dart
import 'package:flutter/material.dart';
import 'package:sapa_mobile/widget/navbar.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.body, this.title});
  final Widget body;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null ? AppBar(title: Text(title!)) : null,
      body: SafeArea(child: body),
      bottomNavigationBar: const Navbar(), // selalu tampil
    );
  }
}
