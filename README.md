# Topic 12 – Provider & ChangeNotifier

Flutter Web demo tối giản cho bài thực hành quản lý trạng thái.

## Chức năng
- Danh sách sản phẩm mẫu và lọc theo danh mục.
- Thêm/bớt/xóa giỏ hàng, tự tính số lượng và tổng tiền.
- Chuyển Dark/Light theme toàn cục.
- Responsive cho mobile, tablet, desktop; chạy trên Chrome.

## Kiến thức thể hiện
- MultiProvider đăng ký nhiều state.
- ChangeNotifierProvider cung cấp ViewModel.
- Consumer lắng nghe và cập nhật UI.
- Selector giới hạn rebuild cho số lượng giỏ hàng.
- context.watch/read đọc state và gọi action.

## Kiến trúc
- domain/models: mô hình dữ liệu.
- data/repositories: nguồn dữ liệu.
- presentation/viewmodels: state và nghiệp vụ.
- presentation/views: màn hình.
- presentation/widgets: widget tái sử dụng.

## Chạy local
```bash
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
flutter build web --release
```

## Vercel
Vercel chạy bash build.sh và phục vụ thư mục build/web.
