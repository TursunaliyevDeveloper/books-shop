import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressedButton;
  final String matn;
  final IconData? icon;
  final String? image;
  final TextStyle? textStyle;
  final Color? backgroundColor;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor =
        backgroundColor ?? (isDark ? Colors.grey[800]! : Colors.blue[100]!);
    final textColor =
        textStyle?.color ?? (isDark ? Colors.white : Colors.black);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 80,
      width: MediaQuery.sizeOf(context).width * 0.95,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
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
                textAlign: TextAlign.center,
                style: textStyle ?? TextStyle(fontSize: 16, color: textColor),
              ),
            ),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(icon, size: 30, color: textColor),
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
