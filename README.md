# Topic 12 – Study Planner

Ứng dụng quản lý nhiệm vụ học tập được xây dựng bằng **Flutter Web**, **Provider**, **ChangeNotifier**, kiến trúc **Clean Code + MVVM** và **Supabase Database**.

Ứng dụng chạy trên Google Chrome; nhiệm vụ được lưu trên PostgreSQL của Supabase để không mất khi tải lại trang hoặc mở trên thiết bị khác.

## 1. Chức năng

- Xem danh sách nhiệm vụ học tập.
- Thêm nhiệm vụ với tên, môn học và thứ thực hiện.
- Xóa nhiệm vụ.
- Đánh dấu hoàn thành / chưa hoàn thành.
- Lọc theo môn học.
- Tự tính tổng nhiệm vụ và tiến độ.
- Chuyển giao diện sáng / tối.
- Lưu và tải dữ liệu từ Supabase.

## 2. Công nghệ

- Flutter Web / Dart
- Provider và ChangeNotifier
- Supabase Flutter SDK
- Supabase PostgreSQL và Row Level Security (RLS)
- Clean Code và MVVM

## 3. Cấu trúc thư mục

```text
lib/
  data/
    repositories/
      study_repository.dart
  domain/
    models/
      study_task.dart
  presentation/
    viewmodels/
      study_view_model.dart
      theme_view_model.dart
    views/
      study_page.dart
  main.dart
```

- **Model:** định nghĩa dữ liệu nhiệm vụ và chuyển đổi JSON.
- **Repository:** đọc, thêm, cập nhật, xóa dữ liệu trong Supabase.
- **ViewModel:** quản lý trạng thái, tiến độ và nghiệp vụ.
- **View:** hiển thị giao diện và nhận thao tác người dùng.
- **Provider:** cung cấp ViewModel cho các màn hình.

## 4. Cấu hình Supabase

Dự án đã kết nối với project Supabase `topic-12-study-planner`.

Bảng dữ liệu: `public.study_tasks`

| Cột | Kiểu | Ý nghĩa |
|---|---|---|
| id | text | Mã nhiệm vụ |
| title | text | Tên nhiệm vụ |
| subject | text | Môn học |
| due_label | text | Thứ thực hiện |
| is_done | boolean | Trạng thái hoàn thành |
| created_at | timestamptz | Thời điểm tạo |

Bảng bật Row Level Security (RLS). Đây là bản demo dùng chung không có đăng nhập, vì vậy các policy hiện cho phép vai trò `anon` đọc/ghi/xóa dữ liệu. Không sử dụng dữ liệu cá nhân hoặc bí mật trong bản demo công khai. Nếu triển khai nhiều người dùng thực tế, cần bổ sung Supabase Auth và policy giới hạn theo `user_id`.

Ứng dụng Flutter chỉ sử dụng publishable key; tuyệt đối không đưa `service_role` hoặc secret key vào mã nguồn phía trình duyệt.

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
