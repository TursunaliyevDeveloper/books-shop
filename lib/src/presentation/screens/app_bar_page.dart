import 'package:flutter/material.dart';
import 'aboutme_page.dart';
import 'settings_page.dart';
import 'shopping_page.dart';

class AppBarPage extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;
  const AppBarPage({super.key, required this.onThemeChanged});
  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  int _currentIndex = 0;
  late final List<Widget> _pages = [
    const ShoppingPage(),
    const AboutMePage(),
    SettingsPage(onThemeChanged: widget.onThemeChanged),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navTheme = theme.bottomNavigationBarTheme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: navTheme.backgroundColor ?? Colors.blue[100],
        selectedItemColor: navTheme.selectedItemColor ?? Colors.black,
        unselectedItemColor: navTheme.unselectedItemColor ?? Colors.blueGrey,
        selectedFontSize: 14,
        unselectedFontSize: 11,
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
            label: "Sozlamalar",
          ),
        ],
      ),
    );
  }
}
