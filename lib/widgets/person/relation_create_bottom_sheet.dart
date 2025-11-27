import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapa_mobile/widgets/button/action_button.dart';
import 'package:sapa_mobile/widgets/form/text_field.dart';

class RelationOption {
  const RelationOption({required this.name, required this.color});

  final String name;
  final Color color;
}

Future<RelationOption?> showRelationCreateBottomSheet(
  BuildContext context, {
  List<Color>? colorChoices,
}) {
  final colors = colorChoices ??
      const [
        Color(0xFF42A5F5),
        Color(0xFFAB47BC),
        Color(0xFF26A69A),
        Color(0xFFFF7043),
        Color(0xFFFFB300),
      ];
  return showModalBottomSheet<RelationOption>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(sheetContext).maybePop(),
            child: const SizedBox.expand(),
          ),
        ),
        _RelationCreateSheet(colors: colors),
      ],
    ),
  );
}

class _RelationCreateSheet extends StatefulWidget {
  const _RelationCreateSheet({required this.colors});

  final List<Color> colors;

  @override
  State<_RelationCreateSheet> createState() => _RelationCreateSheetState();
}

class _RelationCreateSheetState extends State<_RelationCreateSheet> {
  final TextEditingController _nameC = TextEditingController();
  int _selectedColor = 0;
  String? _error;

  @override
  void dispose() {
    _nameC.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameC.text.trim();
    if (name.isEmpty) {
      setState(() => _error = 'Nama relasi wajib diisi');
      return;
    }
    Navigator.of(context).pop(
      RelationOption(
        name: name,
        color: widget.colors[_selectedColor],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 64,
                      height: 6,
                      decoration: BoxDecoration(
                        color: cs.outlineVariant.withAlpha(160),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Relasi Baru',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: cs.primary,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Nama Relasi',
                    controller: _nameC,
                    type: AppTextFieldType.text,
                    hintText: 'Misal: Mentor',
                    onChanged: (_) => setState(() => _error = null),
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        _error!,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: cs.error),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    'Pilih Warna',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: cs.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: [
                      for (var i = 0; i < widget.colors.length; i++)
                        _ColorDot(
                          color: widget.colors[i],
                          selected: _selectedColor == i,
                          onTap: () => setState(() => _selectedColor = i),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ActionButton(
                    label: 'Simpan',
                    height: 48,
                    fullWidth: true,
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? Colors.white : Colors.transparent;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 3),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: color.withAlpha(120),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
