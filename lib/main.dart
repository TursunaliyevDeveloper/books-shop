import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:books_shop/src/presentation/screens/app_bar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkMode') ?? false;
  runApp(MyApp(isDarkMode: isDark));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  const MyApp({super.key, required this.isDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;
  @override
  void initState() {
    super.initState();
    _themeMode = widget.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void _toggleTheme(ThemeMode mode) async {
    setState(() => _themeMode = mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', mode == ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: HomePage(onThemeChanged: _toggleTheme),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : Colors.blue[100],
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 20,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : Colors.white,
        selectedItemColor: isDark ? Colors.tealAccent : Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: isDark ? Colors.white : Colors.black),
        bodyMedium: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
      ),
      iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
    );
  }
}
