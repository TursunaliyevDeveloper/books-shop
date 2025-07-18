import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final TextStyle? textStyle; // ixtiyoriy qildik
  final VoidCallback onPressedButton;
  final String matn;
  final IconData? icon;
  final String? image;
  final Color? backgroundColor; // ixtiyoriy rang qo‘llab-quvvatlash
  const CustomButton({
    super.key,
    required this.onPressedButton,
    required this.matn,
    this.icon,
    this.image,
    this.textStyle,
    this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color defaultBgColor =
        backgroundColor ?? (isDark ? Colors.grey[800]! : Colors.blue[100]!);
    final Color defaultTextColor = isDark ? Colors.white : Colors.black;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 80,
      width: MediaQuery.sizeOf(context).width * 0.95,
      decoration: BoxDecoration(
        color: defaultBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressedButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                matn,
                style:
                    textStyle ??
                    TextStyle(fontSize: 16, color: defaultTextColor),
                textAlign: TextAlign.center,
              ),
            ),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(icon, size: 30, color: defaultTextColor),
              ),
            if (image != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Image.asset(image!, height: 30, width: 30),
              ),
          ],
        ),
      ),
    );
  }
}
