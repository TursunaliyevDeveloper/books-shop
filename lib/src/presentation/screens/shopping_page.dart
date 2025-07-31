import 'package:ziyo_yaypan_kitoblar/src/data/sources/remote/firestore_book_datasource.dart';
import 'package:ziyo_yaypan_kitoblar/src/domain/models/books_model.dart';
import 'package:ziyo_yaypan_kitoblar/src/presentation/widgets/buy_bottom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShoppingPage extends StatefulWidget {
  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final _bookService = FirestoreBookDataSource();
  final _searchController = TextEditingController();
  final _formatCurrency = NumberFormat.decimalPattern('uz');
  bool _isSearching = false;
  String _searchText = '';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: textColor),
                decoration: const InputDecoration(
                  hintText: "Kitob izlash...",
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() {
                  _searchText = value.toLowerCase();
                }),
              )
            : Text(
                "Ziyo – Kitob orqali ma'rifatga",
                style: TextStyle(color: textColor),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () => setState(() {
              _isSearching = !_isSearching;
              _searchText = '';
              _searchController.clear();
            }),
          ),
        ],
      ),
      body: StreamBuilder<List<Book>>(
        stream: _bookService.getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Xatolik yuz berdi"));
          }
          final books = _filterBooks(snapshot.data ?? []);
          if (books.isEmpty) {
            return const Center(child: Text("Mos kitob topilmadi"));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: books.length,
            itemBuilder: (_, i) => _buildBookCard(books[i]),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          );
        },
      ),
    );
  }

  List<Book> _filterBooks(List<Book> books) {
    if (_searchText.isEmpty) return books;
    return books
        .where((book) => book.title.toLowerCase().contains(_searchText))
        .toList();
  }

  Widget _buildBookCard(Book book) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Card(
      color: theme.appBarTheme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BuyPage(book: book)),
            );
          },
          child: Row(
            children: [
              // 🖼️ Rasm qismini PageView qilib
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 120,
                  width: 90,
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

              const SizedBox(width: 16),

              // 📚 Matn qismi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      book.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "${_formatCurrency.format(book.price)} so'm",
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${_formatCurrency.format(book.discountPrice)} so'm",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension DriveImageUrl on String {
  String toDriveUrl() {
    try {
      final uri = Uri.parse(this);
      final segments = uri.pathSegments;
      if (segments.contains('file') && segments.contains('d')) {
        final fileId = segments[segments.indexOf('d') + 1];
        return 'https://drive.google.com/uc?export=view&id=$fileId';
      }
      if (length == 33 && !contains('/')) {
        return 'https://drive.google.com/uc?export=view&id=$this';
      }
      return this;
    } catch (_) {
      return this;
    }
  }
}
