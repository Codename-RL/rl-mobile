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
  String? _selectedEmotion;

  // Path ke emosi yang sesuai
  final List<String> emotions = [
    'assets/icon/emotion/love.svg', // default love stroke (belum dipilih)
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
      onTap: () {
        setState(() {
          // Jika hanya menekan (tanpa menahan), ganti ke love filled
          if (_selectedEmotion == 'assets/icon/love_stroke.svg') {
            _selectedEmotion = 'assets/icon/emotion/love.svg'; // Love filled
          }else {
            _selectedEmotion = 'assets/icon/love_stroke.svg'; // Kembali ke love stroke
          }
        });
      },
      onLongPress: () {
        // Tampilkan pilihan emosi saat menahan
        _showEmotionPicker(context);
      },
      child: Center(
        child: SvgPicture.asset(
          _selectedEmotion!,
          width: 18,
          height: 18,
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan modal bottom sheet dengan pilihan emosi
  void _showEmotionPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            // Jangan menutup pop-up jika mengklik di luar modal
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  emotions.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedEmotion = emotions[index]; // Pilih emosi
                        });
                        Navigator.pop(context); // Tutup bottom sheet setelah memilih
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SvgPicture.asset(
                          emotions[index],
                          width: 50,
                          height: 50,
                          // colorFilter: _selectedEmotion == emotions[index]
                          //     ? ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                          //     : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
