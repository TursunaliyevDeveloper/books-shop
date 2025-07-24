import 'package:flutter/material.dart';
import 'package:books_shop/src/presentation/screens/about_me.dart';
import 'package:books_shop/src/presentation/screens/settings_page.dart';

class HomePage extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;
  const HomePage({super.key, required this.onThemeChanged});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  void onPressedBottom(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ⚠ widget.onThemeChanged ni build ichida ishlat
    final List<Widget> buildPages = [
      HomePage(onThemeChanged: widget.onThemeChanged),
      AboutMe_Page(),
      SettingsPage(onThemeChanged: widget.onThemeChanged),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
            Colors.blue[100],
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor ??
            Colors.black,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ??
            Colors.blueGrey,
        selectedFontSize: 14,
        unselectedFontSize: 11,
        currentIndex: currentIndex,
        onTap: onPressedBottom,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: "Kitoblar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: "Biz haqimizda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Ilova sozlamalari",
          ),
        ],
      ),
      body: buildPages[currentIndex],
    );
  }
}
