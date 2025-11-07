import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({
    super.key,
    this.label =
        'Kapan anda ingin diingatkan', // Label yang ditampilkan di atas input
    this.placeholder =
        'Pilih tanggal dan waktu', // Placeholder ketika tidak ada tanggal atau waktu
    this.allowTime = true, // Menentukan apakah pengguna dapat memilih waktu
  });

  final String label;
  final String placeholder;
  final bool allowTime;

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // Format tanggal dan waktu
  String get _formattedDate =>
      _selectedDate != null
          ? DateFormat('dd MMMM yyyy').format(_selectedDate!)
          : widget.placeholder;

  String get _formattedTime =>
      _selectedTime != null ? _selectedTime!.format(context) : '';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        // Menampilkan dialog untuk memilih tanggal dan waktu
        _selectDateAndTime(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label di atas input
          Text(
            widget.label,
            style: tt.labelLarge?.copyWith(
              color: cs.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),

          // Row untuk ikon dan teks
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: cs.onPrimaryContainer.withAlpha(90), width: 1.4),
              color: cs.primary.withAlpha(20),
            ),
            child: Row(
              children: [
                // Ikon SVG untuk memilih tanggal
                SvgPicture.asset(
                  'assets/icon/calendar.svg', // Path untuk ikon kalender
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(cs.primary, BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                // Tanggal dan Waktu yang dipilih
                Expanded(
                  child: Text(
                    // Gabungkan tanggal dan waktu dalam satu teks
                    _selectedDate == null
                        ? widget.placeholder
                        : '$_formattedDate${_selectedTime != null ? ', $_formattedTime' : ''}',
                    style: tt.labelLarge?.copyWith(
                      color: cs.onSurface.withAlpha(80),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk memilih tanggal dan waktu
  Future<void> _selectDateAndTime(BuildContext context) async {
    // Pilih tanggal
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });

      // Pilih waktu jika tanggal dipilih dan allowTime true
      if (widget.allowTime) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null && pickedTime != _selectedTime) {
          setState(() {
            _selectedTime = pickedTime;
          });
        }
      }
    }
  }
}
