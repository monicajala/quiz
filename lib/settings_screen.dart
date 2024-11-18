import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Color currentColor;
  final double currentFontSize;
  final String currentFontFamily;

  SettingsScreen({
    required this.currentColor,
    required this.currentFontSize,
    required this.currentFontFamily,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Color selectedColor;
  late double selectedFontSize;
  late String selectedFontFamily;

  // Daftar warna untuk palet
  final List<Color> colorPalette = [
    Colors.teal,
    Colors.white,
    Colors.grey,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  // Daftar gaya font
  final List<String> fontFamilyOptions = [
    'Roboto',
    'EduAu',
    'Geist',
    'SourGum',
  ];

  @override
  void initState() {
    super.initState();
    selectedColor = widget.currentColor;
    selectedFontSize = widget.currentFontSize;
    selectedFontFamily = widget.currentFontFamily;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontFamily: selectedFontFamily),
        ),
        backgroundColor: selectedColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Palet Warna
              Text(
                'Color Palette',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: selectedFontFamily,
                ),
              ),
              SizedBox(height: 10),
              _buildColorPalette(),
              SizedBox(height: 20),

              // Pilihan Ukuran Font
              Text(
                'Choose Font Size',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: selectedFontFamily,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              _buildFontSizeOptions(),
              SizedBox(height: 20),

              // Pilihan Gaya Font
              Text(
                'Choose Font Style',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: selectedFontFamily,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              _buildFontStyleOptions(),
              SizedBox(height: 20),

              // Tombol Apply Changes
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context, {
                      'color': selectedColor,
                      'fontSize': selectedFontSize,
                      'fontFamily': selectedFontFamily,
                    });
                  },
                  icon: Icon(Icons.save),
                  label: Text(
                    'Apply Changes',
                    style: TextStyle(fontFamily: selectedFontFamily),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: _getButtonColor(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: selectedColor,  // Update background color based on the selected color
    );
  }

  // Widget untuk palet warna
  Widget _buildColorPalette() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // Jumlah kolom
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: colorPalette.length,
      itemBuilder: (context, index) {
        final color = colorPalette[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedColor = color; // Update selected color
            });
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(
                color: selectedColor == color ? Colors.black : Colors.transparent,
                width: 3,
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget untuk ukuran font
  Widget _buildFontSizeOptions() {
    final List<double> fontSizeOptions = [16.0, 24.0, 28.0, 32.0]; // Daftar ukuran font

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // Jumlah kolom
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true, 
      physics: const NeverScrollableScrollPhysics(),
      itemCount: fontSizeOptions.length,
      itemBuilder: (context, index) {
        final size = fontSizeOptions[index];
        return _fontSizeOption(size, size.toInt().toString()); 
      },
    );
  }

  Widget _fontSizeOption(double size, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFontSize = size;
        });
      },
      child: Container(
        width: 60, // Ukuran elemen
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedFontSize == size ? Colors.blueAccent : Colors.grey,
            width: 3,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: size,
              fontFamily: selectedFontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk gaya font
  Widget _buildFontStyleOptions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Scroll ke samping
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: fontFamilyOptions.map((font) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFontFamily = font;
              });
            },
            child: Container(
              width: 80, // Lebar elemen lebih kecil
              height: 80, // Tinggi elemen tetap
              margin: const EdgeInsets.symmetric(horizontal: 2.0), // Jarak antar elemen lebih kecil
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selectedFontFamily == font ? Colors.blueAccent : Colors.grey,
                  width: 3,
                ),
              ),
              child: Center(
                child: Text(
                  font,
                  style: TextStyle(
                    fontFamily: font,
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Ukuran font lebih kecil agar proporsional
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Fungsi warna teks kontras
  Color _getContrastingTextColor() {
    return selectedColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  // Warna tombol berdasarkan tema
  Color _getButtonColor() {
    return selectedColor.computeLuminance() > 0.5 ? Colors.blue : Colors.white;
  }
}
