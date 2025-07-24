import 'package:flutter/material.dart';
import 'package:books_shop/src/presentation/widgets/custom_button.dart';

class SettingsPage extends StatefulWidget {
  final void Function(ThemeMode) onThemeChanged;
  const SettingsPage({super.key, required this.onThemeChanged});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode _currentMode = ThemeMode.light;

  void _toggleTheme() {
    _currentMode = _currentMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    widget.onThemeChanged(_currentMode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sozlamalar", style: theme.textTheme.bodyLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.iconTheme,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Center(
            child: CustomButton(
              matn: "Ilova rejimi: Yorugʻ yoki Qorongʻi",
              icon: isDark ? Icons.dark_mode : Icons.light_mode,
              textStyle: theme.textTheme.bodyLarge!.copyWith(fontSize: 14),
              onPressedButton: _toggleTheme,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Ilova versiyasi: 0.1",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
