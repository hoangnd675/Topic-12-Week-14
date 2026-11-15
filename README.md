# Chủ đề 12 — Quản lý trạng thái với Provider & ChangeNotifier

Ứng dụng Flutter Web minh họa dashboard giám sát CPU, RAM, Network và trạng thái thiết bị bằng Provider + ChangeNotifier, tổ chức theo MVVM và Clean Code.

## 1. Yêu cầu môi trường

- Flutter SDK (stable)
- Dart SDK đi kèm Flutter
- Google Chrome
- VS Code hoặc Android Studio (không bắt buộc)

## 2. Chạy trên Chrome

Mở terminal tại thư mục dự án:

```bash
flutter doctor
flutter config --enable-web
flutter pub get
flutter run -d chrome
```

Build bản web:

```bash
flutter build web --release
```

Thư mục phát hành: `build/web`.

## 3. Cấu trúc thư mục

```text
lib/
├── core/
│   └── theme/
│       └── app_theme.dart
├── data/
│   └── services/
│       └── metrics_simulator_service.dart
├── domain/
│   └── models/
│       ├── device.dart
│       └── system_metrics.dart
├── presentation/
│   ├── viewmodels/
│   │   ├── dashboard_view_model.dart
│   │   └── theme_view_model.dart
│   ├── views/
│   │   └── dashboard_page.dart
│   └── widgets/
│       ├── device_list.dart
│       ├── metric_chart.dart
│       ├── metric_tile.dart
│       └── provider_explainer.dart
└── main.dart
```

## 4. Ánh xạ MVVM / Clean Code

- **Model (Domain):** `SystemMetrics`, `Device` mô tả dữ liệu.
- **Service (Data):** `MetricsSimulatorService` tạo dữ liệu giả lập, không đặt logic này trong Widget.
- **ViewModel:** `DashboardViewModel` giữ state, xử lý cập nhật, gọi `notifyListeners()`. `ThemeViewModel` quản lý theme toàn cục.
- **View:** `DashboardPage` và các Widget chỉ hiển thị dữ liệu, gửi hành động đến ViewModel.
- **Dependency injection:** `MultiProvider` khởi tạo và cung cấp các ViewModel ở gốc ứng dụng.

## 5. Luồng dữ liệu

```text
MetricsSimulatorService
        │ tạo metrics mới
        ▼
DashboardViewModel (ChangeNotifier)
        │ cập nhật state
        │ notifyListeners()
        ▼
Provider / InheritedWidget
        │ thông báo các listener
        ▼
Selector / Consumer / context.watch
        │ chọn dữ liệu cần quan sát
        ▼
Widget được chọn rebuild
```

## 6. Cách demo các API theo đề bài

- `ChangeNotifier`: lớp `DashboardViewModel` kế thừa `ChangeNotifier`.
- `ChangeNotifierProvider`: đăng ký ViewModel trong `main.dart`.
- `Consumer`: có thể dùng để lắng nghe một vùng UI; ví dụ dự án ưu tiên `Selector` để chọn đúng dữ liệu.
- `context.watch<T>()`: đọc state và đăng ký lắng nghe thay đổi.
- `context.read<T>()`: lấy ViewModel để gọi lệnh như `toggleMonitoring()` mà không đăng ký lắng nghe.
- `Selector<T, R>`: chỉ rebuild khi giá trị được chọn thay đổi, giúp hạn chế rebuild không cần thiết.
- `MultiProvider`: cung cấp đồng thời DashboardViewModel và ThemeViewModel.

## 7. So sánh truyền dữ liệu và chia sẻ trạng thái

**Truyền dữ liệu (parent → child):** truyền giá trị qua constructor. Phù hợp khi dữ liệu chỉ cần đi qua một vài tầng Widget. Nếu nhiều Widget ở nhiều nhánh cần cùng state, phải truyền tham số qua các tầng trung gian (prop drilling).

**Chia sẻ trạng thái với Provider:** ViewModel được cung cấp ở một ancestor chung. Các Widget con lấy đúng state từ context, không cần truyền tham số xuyên qua mọi tầng. Khi `notifyListeners()` chạy, các listener liên quan được thông báo.

## 8. Kịch bản thuyết trình 15 phút

1. (2 phút) Giới thiệu vấn đề: nhiều Widget cần dùng chung trạng thái.
2. (3 phút) Giải thích Model, Service, ViewModel, View.
3. (3 phút) Mở `main.dart`, chỉ `MultiProvider` và `ChangeNotifierProvider`.
4. (3 phút) Mở `dashboard_view_model.dart`, giải thích state và `notifyListeners()`.
5. (2 phút) Demo bật/tắt giám sát, cập nhật CPU/RAM/Network và danh sách thiết bị.
6. (2 phút) Chỉ ba State Probe cùng đổi số; giải thích `Selector`, `read`, `watch` và giảm rebuild.

## 9. Kiểm thử

```bash
flutter analyze
flutter test
```

Dữ liệu dashboard là dữ liệu mô phỏng, không phải số đo phần cứng thực tế.
