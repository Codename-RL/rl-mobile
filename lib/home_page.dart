import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final themeC = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Preview Theme')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Kartu pakai surface & onSurface
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(children: [
                  Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.person, color: cs.onPrimaryContainer),
                  ),
                  const SizedBox(width: 12),
                  Text('Sample Title', style: Theme.of(context).textTheme.titleMedium),
                ]),
              ),
            ),
            const SizedBox(height: 16),

            // Buttons
            Wrap(spacing: 12, runSpacing: 12, children: [
              ElevatedButton(onPressed: () {}, child: const Text('Primary')),
              FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
              OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
            ]),
            const SizedBox(height: 16),

            // Chips
            Wrap(spacing: 8, children: const [
              Chip(label: Text('secondary')),
              Chip(label: Text('tag')),
              Chip(label: Text('info')),
            ]),
            const SizedBox(height: 16),

            // ListTile pakai ListTileTheme
            ListTile(
              leading: Icon(Icons.event, color: cs.onSurface),
              title: const Text('ListTile Title'),
              subtitle: const Text('Subtitle uses onSurfaceVariant'),
              trailing: const Icon(Icons.chevron_right),
            ),
            const Divider(),

            // Color preview
            const SizedBox(height: 8),
            _Swatch(label: 'primary',      color: cs.primary,      on: cs.onPrimary),
            _Swatch(label: 'secondary',    color: cs.secondary,    on: cs.onSecondary),
            _Swatch(label: 'tertiary',     color: cs.tertiary,     on: cs.onTertiary),
            _Swatch(label: 'surface',      color: cs.surface,      on: cs.onSurface, border: cs.outline),
            _Swatch(label: 'surfaceVariant', color: cs.surfaceVariant, on: cs.onSurfaceVariant, border: cs.outlineVariant),
            _Swatch(label: 'error',        color: cs.error,        on: cs.onError),

            const SizedBox(height: 24),
            Text('Theme Mode', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(spacing: 12, children: [
              ElevatedButton.icon(
                onPressed: themeC.setLight,
                icon: const Icon(Icons.light_mode),
                label: const Text('Light'),
              ),
              ElevatedButton.icon(
                onPressed: themeC.setDark,
                icon: const Icon(Icons.dark_mode),
                label: const Text('Dark'),
              ),
              ElevatedButton.icon(
                onPressed: themeC.setSystem,
                icon: const Icon(Icons.settings_suggest),
                label: const Text('System'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.label, required this.color, required this.on, this.border, super.key});
  final String label;
  final Color color;
  final Color on;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: border != null ? Border.all(color: border!) : null,
      ),
      child: Text(label, style: TextStyle(color: on, fontWeight: FontWeight.w600)),
    );
  }
}
