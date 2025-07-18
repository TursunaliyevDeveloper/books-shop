class BooksList {
  final List<String> images;
  final String title;
  final String description;
  final int price;
  final int discountPrice;
  BooksList({
    required this.images,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPrice,
  });
}

List<BooksList> books = [
  BooksList(
    images: [
      'assets/books_images/meni_eshityabdimi.png',
      'assets/books_images/meni_kimdir_eshityabdimi1.png',
      'assets/books_images/meni_kimdir_eshityabdimi2.png',
    ],
    title: 'МЕНИ КИМДИР ЭШИТЯПТИМИ?',
    description: "Eng yangi kitoblar!",
    price: 149000,
    discountPrice: 129000,
  ),
  BooksList(
    images: [
      'assets/books_images/paygambar_izidan.png',
      'assets/books_images/paygambar_izidan2.png',
    ],
    title: 'ПАЙҒАМБАР ИЗИДАН',
    description:
        "💭 Мен бу сатрларни ваҳий нозил\nбўлганида, титраб турганингизда\nбағримга ололмаганимга...",
    price: 85000,
    discountPrice: 39000,
  ),
  BooksList(
    images: [
      'assets/books_images/propaganda.png',
      'assets/books_images/propaganda2.png',
    ],
    title: '🚨 PROPAGANDA 🚨',
    description:
        "🧠 Bugun biz yashayotgan raqamli,\nshovqinli dunyoda, kimdir sizning\nqarorlaringizga ta'sir qilayotganini\nsezmasligingiz mumkin emas.",
    price: 80000,
    discountPrice: 59000,
  ),
  BooksList(
    images: [
      'assets/books_images/qora_pul1.png',
      'assets/books_images/qora_pul2.png',
      'assets/books_images/qora_pul3.png',
    ],
    title: '📕 ҚОРА ПУЛ ИМПЕРИЯСИ',
    description: "Яширин кучлар, марказий банклар в\nдунё назорати ҳақида",
    price: 56000,
    discountPrice: 26000,
  ),
  BooksList(
    images: [
      'assets/books_images/sevdirib_yashash1.png',
      'assets/books_images/sevdirib_yashash2.png',
      'assets/books_images/sevdirib_yashash3.png',
    ],
    title: '📘 SEVDIRIB TARBIYALANG',
    description:
        "«💥 Агар жазолашга тўғри келаётган\nбўлса, демак, тарбияда хатога\nйўл қўйилган.",
    price: 96000,
    discountPrice: 74900,
  ),
  BooksList(
    images: [
      'assets/books_images/intiqom1.png',
      'assets/books_images/dahshatli_intiqom1.png',
    ],
    title: '📕 INTIҚOM',
    description:
        "“Gap O‘rta dengiz haqida ketganida,\ninglizlar betaraf bo‘lishga urinadi,\nbiroq ko‘pincha buning uddasidan chiqa\nolmaydi. Ispanlarning hurmat qilishga\narzigulik halolligi bor, biroq\nularning ba'zi masalalarida o‘ta\nnoto‘g‘ri tasavvurlari\nham yo‘q emas. 🇪🇸",
    price: 85000,
    discountPrice: 39000,
  ),
];
