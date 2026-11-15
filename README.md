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


## 8. Triển khai

Mã nguồn được lưu trữ trên GitHub và có thể triển khai dưới dạng Flutter Web trên Vercel.

- **GitHub**: https://github.com/hoangnd675/Topic-12-Week-14
- **Ứng dụng demo**: https://topic-12-week-14.vercel.app
