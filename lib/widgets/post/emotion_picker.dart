import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmotionPicker extends StatefulWidget {
  const EmotionPicker({
    super.key,
    this.initialEmotion, // emotion default yang dipilih (opsional)
  });

  final String? initialEmotion; // parameter untuk memilih emosi awal

  @override
  _EmotionPickerState createState() => _EmotionPickerState();
}

class _EmotionPickerState extends State<EmotionPicker> {
  bool _isHolding = false;
  String? _selectedEmotion;

  final List<String> emotions = [
    'assets/icon/emotion/love.svg', // default love stroke
    'assets/icon/emotion/angry.svg',
    'assets/icon/emotion/happy.svg',
    'assets/icon/emotion/laugh.svg',
    'assets/icon/emotion/sad.svg',
  ];

  @override
  void initState() {
    super.initState();
    // Inisialisasi jika ada emosi awal yang diberikan
    _selectedEmotion = widget.initialEmotion ?? 'assets/icon/love_stroke.svg';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isHolding = true;
        });
      },
      onLongPressEnd: (details) {
        setState(() {
          _isHolding = false;
        });
      },
      onTap: () {
        if (_isHolding && _selectedEmotion != null) {
          // Aksi saat memilih emosi, misalnya mengirim emosi
          print('Selected Emotion: $_selectedEmotion');
        }
      },
      child: Stack(
        children: [
          // Tampilkan pilihan emosi di tengah layar
          if (_isHolding)
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      emotions.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedEmotion = emotions[index];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SvgPicture.asset(
                            emotions[index],
                            width: 40,
                            height: 40,
                            colorFilter: _selectedEmotion == emotions[index]
                                ? ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          // Tampilkan ikon yang dipilih atau default
          GestureDetector(
            onTap: () {
              setState(() {
                _isHolding = true;
              });
            },
            child: Center(
              child: SvgPicture.asset(
                _selectedEmotion!,
                width: 60,
                height: 60,
                // Tanpa colorFilter, ikon akan tampil dengan warna asli
              ),
            ),
          ),
        ],
      ),
    );
  }
}
