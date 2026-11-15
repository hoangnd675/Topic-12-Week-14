# Topic 12 – Study Planner

Ứng dụng **Study Planner** được xây dựng bằng Flutter Web nhằm minh họa cách quản lý trạng thái với **Provider** và **ChangeNotifier**, kết hợp cách tổ chức mã nguồn theo **Clean Code** và mô hình **MVVM**.

Ứng dụng có thể chạy trên trình duyệt Google Chrome.

## 1. Chức năng chính

- Hiển thị danh sách nhiệm vụ học tập mẫu.
- Thêm nhiệm vụ mới với tên nhiệm vụ, môn học và thứ cần thực hiện.
- Xóa nhiệm vụ khỏi danh sách.
- Đánh dấu nhiệm vụ đã hoàn thành hoặc chưa hoàn thành.
- Lọc nhiệm vụ theo môn học.
- Tự động cập nhật tổng số nhiệm vụ, số nhiệm vụ đã hoàn thành và phần trăm tiến độ.
- Chuyển đổi giữa giao diện sáng và giao diện tối.

> Dữ liệu nhiệm vụ hiện được lưu trong bộ nhớ ứng dụng. Danh sách sẽ được khởi tạo lại khi khởi động lại ứng dụng; phiên bản này chưa sử dụng cơ sở dữ liệu để lưu trữ lâu dài.

## 2. Công nghệ sử dụng

- **Flutter**: xây dựng giao diện ứng dụng.
- **Dart**: ngôn ngữ lập trình.
- **Provider**: quản lý và cung cấp trạng thái cho giao diện.
- **ChangeNotifier**: thông báo khi dữ liệu trong ViewModel thay đổi.
- **Google Chrome**: chạy ứng dụng ở chế độ Web.
- **Vercel**: triển khai ứng dụng Web.

## 3. Cài đặt và chạy ứng dụng

### Yêu cầu

- Đã cài đặt Flutter SDK.
- Đã bật hỗ trợ Flutter Web.
- Đã cài đặt Google Chrome.

### Các bước thực hiện

Tải mã nguồn:

```bash
git clone https://github.com/hoangnd675/Topic-12-Week-14.git
cd Topic-12-Week-14
```

Cài đặt các thư viện:

```bash
flutter pub get
```

Chạy ứng dụng trên Chrome:

```bash
flutter run -d chrome
```

## 4. Kiểm thử và biên dịch

Chạy các bài kiểm thử:

```bash
flutter test
```

Kiểm tra mã nguồn:

```bash
flutter analyze
```

Biên dịch phiên bản Web:

```bash
flutter build web --release
```

Sau khi biên dịch thành công, thư mục đầu ra là:

```text
build/web/
```

## 5. Cấu trúc thư mục

```text
lib/
├── data/
│   └── repositories/
│       └── study_repository.dart
├── domain/
│   └── models/
│       └── study_task.dart
├── presentation/
│   ├── viewmodels/
│   │   ├── study_view_model.dart
│   │   └── theme_view_model.dart
│   └── views/
│       └── study_page.dart
└── main.dart

test/
├── study_view_model_test.dart
└── theme_view_model_test.dart
```

### Vai trò của từng phần

| Thành phần | Nhiệm vụ |
|---|---|
| `domain/models` | Khai báo mô hình dữ liệu nhiệm vụ học tập. |
| `data/repositories` | Cung cấp dữ liệu nhiệm vụ cho ứng dụng. |
| `presentation/viewmodels` | Xử lý trạng thái và logic tương tác của giao diện. |
| `presentation/views` | Hiển thị giao diện và nhận thao tác từ người dùng. |
| `main.dart` | Khởi tạo ứng dụng, Theme và các Provider. |
| `test/` | Chứa các bài kiểm thử tự động. |

## 6. Các kiến thức Provider được minh họa

- **MultiProvider**: đăng ký nhiều Provider tại cấp ứng dụng.
- **ChangeNotifierProvider**: tạo và cung cấp ViewModel cho các màn hình.
- **context.watch**: theo dõi trạng thái và cập nhật giao diện khi dữ liệu thay đổi.
- **context.read**: truy cập ViewModel để gọi các hàm xử lý, chẳng hạn thêm hoặc xóa nhiệm vụ.
- **Consumer**: xây dựng lại phần giao diện phụ thuộc vào trạng thái Theme.
- **Selector**: chỉ cập nhật phần giao diện cần thiết khi giá trị tiến độ thay đổi.

## 7. Mô hình MVVM

Ứng dụng phân chia trách nhiệm thành các phần:

- **Model**: `StudyTask` mô tả dữ liệu của một nhiệm vụ học tập.
- **View**: `StudyPage` hiển thị dữ liệu và tiếp nhận thao tác của người dùng.
- **ViewModel**: `StudyViewModel` quản lý danh sách nhiệm vụ, bộ lọc và tiến độ; `ThemeViewModel` quản lý giao diện sáng/tối.

Cách tổ chức này giúp tách biệt giao diện với logic xử lý trạng thái, giúp mã nguồn dễ đọc, kiểm thử và bảo trì hơn.

## 8. Triển khai

Mã nguồn được lưu trữ trên GitHub và có thể triển khai dưới dạng Flutter Web trên Vercel.

- **GitHub**: https://github.com/hoangnd675/Topic-12-Week-14
- **Ứng dụng demo**: https://topic-12-week-14-hoangnd675.vercel.app

---
**Topic 12 – Study Planner** | Flutter Web | Provider | ChangeNotifier | Clean Code | MVVM
