import 'package:flutter/material.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color backgroundColor = Colors.blue;  // Initial background color
  double fontSize = 16.0;
  String fontFamily = 'Roboto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Main Screen',
          style: TextStyle(fontFamily: fontFamily),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Container(
        color: backgroundColor,  // Use backgroundColor here
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'This is the Main Screen',
                style: TextStyle(fontSize: fontSize, fontFamily: fontFamily),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final settings = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(
                        currentColor: backgroundColor,
                        currentFontSize: fontSize,
                        currentFontFamily: fontFamily,
                      ),
                    ),
                  );
                  if (settings != null) {
                    setState(() {
                      backgroundColor = settings['color'];  // Update the background color
                      fontSize = settings['fontSize'];      // Update the font size
                      fontFamily = settings['fontFamily'];  // Update the font family
                    });
                  }
                },
                child: Text(
                  'Go to Settings',
                  style: TextStyle(fontFamily: fontFamily),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
