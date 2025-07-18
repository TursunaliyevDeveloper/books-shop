import 'package:ziyo_book_shop/src/presentation/books_list/books_list.dart';
import 'package:ziyo_book_shop/src/presentation/custom_botton/buy_bottom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BooksPage extends StatefulWidget {
  final List<BooksList> books;
  const BooksPage({super.key, required this.books});
  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.decimalPattern('uz');
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Kitob sotib oling", style: TextStyle(color: textColor)),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.iconTheme,
      ),
      body: ListView.builder(
        itemCount: widget.books.length,
        itemBuilder: (context, index) {
          final book = widget.books[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BuyPage(book: book)),
              );
            },
            child: Card(
              color: theme.cardColor,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 180,
                      child: PageView.builder(
                        itemCount: book.images.length,
                        itemBuilder: (context, i) =>
                            Image.asset(book.images[i], fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      book.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(book.description, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "${formatCurrency.format(book.discountPrice)} so'm",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${formatCurrency.format(book.price)} so'm",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
