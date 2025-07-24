import 'dart:convert';
import 'package:books_shop/src/domain/models/books_model.dart';
import 'package:books_shop/src/presentation/screens/shopping_page.dart';
import 'package:books_shop/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuyPage extends StatefulWidget {
  final Book book;
  const BuyPage({super.key, required this.book});
  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  final _ismController = TextEditingController();
  final _familiyaController = TextEditingController();
  final _kitobNomiController = TextEditingController();
  final _telefonController = TextEditingController();
  final _izohController = TextEditingController();
  final String apiUrl =
      "https://script.google.com/macros/s/AKfycbxfyghc4fvWEOPwnPlk4nkn7bCr8tCX1IE_fzsNev2Mfx-BB_ULmiHYuiW5zilpZo0/exec";
  @override
  void initState() {
    super.initState();
    _kitobNomiController.text = widget.book.title;
  }

  Future<void> malumotJonatish() async {
    final Map<String, dynamic> data = {
      "kitob_nomi": _kitobNomiController.text,
      "familiya": _familiyaController.text,
      "ism": _ismController.text,
      "telefon_raqam": _telefonController.text,
      "izoh": _izohController.text,
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        showCenterAlert("Buyurtma yuborildi!");
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
    }
  }

  void showCenterAlert(String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: IgnorePointer(
          ignoring: true,
          child: Container(
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final book = widget.book;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Buyurtma berish")),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 24),
          TextField(
            controller: _ismController,
            decoration: const InputDecoration(
              hintText: "Ism",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _familiyaController,
            decoration: const InputDecoration(
              hintText: "Familiya",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _kitobNomiController,
            readOnly: true,
            decoration: const InputDecoration(
              hintText: "Kitob nomi",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _telefonController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: "Telefon raqam",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _izohController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "Izoh",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            matn: "Xarid qilish uchun\nariza qoldirish",
            onPressedButton: malumotJonatish,
            icon: Icons.shopping_cart,
            textStyle: TextStyle(fontSize: 16, color: textColor),
          ),
          if (book.images.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 260,
                child: PageView.builder(
                  itemCount: book.images.length > 2 ? 2 : book.images.length,
                  itemBuilder: (context, index) {
                    final imageUrl = book.images[index].toDriveUrl();
                    return Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, size: 48),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
