# Topic 12 – Study Planner

Ứng dụng quản lý nhiệm vụ học tập được xây dựng bằng **Flutter Web**, **Provider**, **ChangeNotifier**, kiến trúc **Clean Code + MVVM** và **Supabase Database**.

Ứng dụng chạy trên Google Chrome.

## 1. Chức năng

- Xem danh sách nhiệm vụ học tập.
- Thêm nhiệm vụ với tên, môn học và thứ thực hiện.
- Xóa nhiệm vụ.
- Đánh dấu hoàn thành / chưa hoàn thành.
- Lọc theo môn học.
- Tự tính tổng nhiệm vụ và tiến độ.
- Chuyển giao diện sáng / tối.
- Lưu và tải dữ liệu từ Supabase.

## 5. Cài đặt và chạy

Cài Flutter SDK và bật hỗ trợ Web, sau đó chạy:

```bash
git clone https://github.com/hoangnd675/Topic-12-Week-14.git
cd Topic-12-Week-14
flutter pub get
flutter run -d chrome
```

## 6. Kiểm thử và build

```bash
flutter test
flutter build web --release
```

Thư mục đầu ra: `build/web/`.

Vercel sử dụng `build.sh` để cài Flutter, tải dependencies, chạy test và build Web.

## 7. Triển khai

- GitHub: https://github.com/hoangnd675/Topic-12-Week-14
- Supabase: https://supabase.com/dashboard/project/wvsuvofgchmbsyucrdfy
- Demo: https://topic-12-week-14-hoangnd675.vercel.app
