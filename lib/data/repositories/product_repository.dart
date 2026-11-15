import '../../domain/models/product.dart';

class ProductRepository {
  const ProductRepository();

  List<Product> getProducts() => const [
    Product(id: 'p1', name: 'Tai nghe không dây', category: 'Phụ kiện', price: 590000, emoji: '🎧', description: 'Âm thanh rõ, pin bền.'),
    Product(id: 'p2', name: 'Bàn phím cơ', category: 'Phụ kiện', price: 890000, emoji: '⌨️', description: 'Gõ êm, thiết kế gọn.'),
    Product(id: 'p3', name: 'Chuột công thái học', category: 'Phụ kiện', price: 420000, emoji: '🖱️', description: 'Thoải mái khi làm việc.'),
    Product(id: 'p4', name: 'Đèn bàn LED', category: 'Gia dụng', price: 350000, emoji: '💡', description: 'Ánh sáng dịu, tiết kiệm điện.'),
    Product(id: 'p5', name: 'Bình giữ nhiệt', category: 'Gia dụng', price: 210000, emoji: '🥤', description: 'Giữ nóng và lạnh tiện lợi.'),
    Product(id: 'p6', name: 'Sổ ghi chú', category: 'Văn phòng', price: 65000, emoji: '📒', description: 'Nhỏ gọn cho ý tưởng mỗi ngày.'),
  ];
}
