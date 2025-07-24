class Book {
  final String id;
  final String title;
  final String description;
  final double price;
  final double discountPrice;
  final List<String> images;
  final bool deleted;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.images,
    required this.deleted,
  });

  factory Book.fromMap(Map<String, dynamic> map, String documentId) {
    return Book(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      discountPrice: (map['discountPrice'] ?? 0).toDouble(),
      images: List<String>.from(map['images'] ?? []),
      deleted: map['deleted'] ?? false,
    );
  }
}
