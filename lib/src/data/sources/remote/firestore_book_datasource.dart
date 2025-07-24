import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:books_shop/src/domain/models/books_model.dart';

class FirestoreBookDataSource {
  final CollectionReference booksRef = FirebaseFirestore.instance.collection(
    'books',
  );

  Stream<List<Book>> getBooks() {
    return booksRef.where('deleted', isEqualTo: false).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) {
        return Book.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
