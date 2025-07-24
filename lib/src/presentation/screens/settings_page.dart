import 'package:books_shop/src/presentation/custom_botton/custom_button.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;
  const SettingsPage({super.key, required this.onThemeChanged});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode _currentMode = ThemeMode.light;
  void _toggleTheme() {
    setState(() {
      if (_currentMode == ThemeMode.light) {
        _currentMode = ThemeMode.dark;
      } else {
        _currentMode = ThemeMode.light;
      }
    });
    widget.onThemeChanged(_currentMode);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sozlamalar",
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                textStyle: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 14,
                ),
                onPressedButton: _toggleTheme,
                matn: "Dark or Light rejim",
                icon: isDark ? Icons.dark_mode : Icons.light_mode,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Ilova versiyasi: 0.1",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
