# Topic 12 – Provider & ChangeNotifier

Study Planner là ứng dụng Flutter Web demo quản lý nhiệm vụ học tập, được xây dựng theo Clean Code và MVVM.

## Chức năng
- Xem tổng quan số nhiệm vụ và tiến độ học tập.
- Xem danh sách nhiệm vụ theo môn học.
- Thêm nhiệm vụ học tập mới.
- Đánh dấu hoàn thành / chưa hoàn thành.
- Lọc nhiệm vụ theo môn học.
- Chuyển giao diện sáng / tối.
- Responsive, chạy trên Chrome.

## Kiến thức Provider
- MultiProvider: đăng ký nhiều ViewModel.
- ChangeNotifierProvider: cung cấp StudyViewModel và ThemeViewModel.
- Consumer: cập nhật giao diện khi dữ liệu thay đổi.
- Selector: chỉ rebuild phần tiến độ khi tỷ lệ hoàn thành đổi.
- context.watch: lắng nghe trạng thái.
- context.read: gọi hành động mà không đăng ký lắng nghe.

## Cấu trúc Clean Code + MVVM
- domain/models: StudyTask – mô hình nhiệm vụ học tập.
- data/repositories: StudyRepository – cung cấp dữ liệu ban đầu.
- presentation/viewmodels: StudyViewModel – quản lý state và nghiệp vụ.
- presentation/views: StudyPage – màn hình chính.
- presentation/widgets: các thành phần giao diện có thể tái sử dụng.

## Chạy local
```bash
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
flutter build web --release
```

## Deploy Vercel
Vercel sử dụng `build.sh` để cài Flutter SDK và build thư mục `build/web`.
