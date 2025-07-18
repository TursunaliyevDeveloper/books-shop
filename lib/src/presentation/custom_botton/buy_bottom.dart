import 'dart:convert';
import 'package:ziyo_book_shop/src/presentation/books_list/books_list.dart';
import 'package:ziyo_book_shop/src/presentation/custom_botton/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuyPage extends StatefulWidget {
  final BooksList book;
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
      "narxi": widget.book.discountPrice,
      "familiya": _familiyaController.text,
      "ism": _ismController.text,
      "telefon_raqam": _telefonController.text,
      "izoh": _izohController.text,
      "rasm_url": widget.book.images[0],
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
    }
  }

  void showCenterAlert(BuildContext context, String message) {
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
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title, style: TextStyle(fontSize: 14)),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          SizedBox(height: 40),
          SizedBox(
            height: 180,
            width: 140,
            child: Image.asset(widget.book.images[0], fit: BoxFit.cover),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _ismController,
            decoration: InputDecoration(hintText: "Ism"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _familiyaController,
            decoration: InputDecoration(hintText: "Familiya"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _kitobNomiController,
            readOnly: true,
            decoration: InputDecoration(hintText: "Kitob nomi"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _telefonController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(hintText: "Telefon raqam"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _izohController,
            decoration: InputDecoration(hintText: "Izoh"),
          ),
          SizedBox(height: 30),

          /// 🔘 Tugma (matn rangi theme asosida o‘zgaradi)
          CustomButton(
            matn: "Xarid qilish uchun\nariza qoldirish",
            onPressedButton: malumotJonatish,
            icon: Icons.shopping_cart,
            textStyle: TextStyle(fontSize: 16, color: textColor),
          ),
        ],
      ),
    );
  }
}
