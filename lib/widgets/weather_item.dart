import 'package:flutter/material.dart';


class weatherItem extends StatelessWidget {
  // Khởi tạo các tham số: value, text, unit, imageUrl
  const weatherItem({
    Key? key,
    required this.value, // Giá trị cần hiển thị (như nhiệt độ, tốc độ gió, độ ẩm...)
    required this.text, // Văn bản mô tả (Wind Speed, Humidity, v.v.)
    required this.unit, // Đơn vị (C, km/h, %...)
    required this.imageUrl, // Đường dẫn tới hình ảnh liên quan (biểu tượng)
  }) : super(key: key);

  // Các thuộc tính
  final int value; // Giá trị cần hiển thị
  final String text; // Văn bản mô tả
  final String unit; // Đơn vị
  final String imageUrl; // Đường dẫn hình ảnh

  @override
  Widget build(BuildContext context) {
    return Column(  // Dùng Column để xếp các widget theo chiều dọc
      children: [
        // Văn bản mô tả
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(  // Khoảng cách giữa các widget
          height: 8,
        ),
        // Hộp chứa hình ảnh
        Container(
          padding: const EdgeInsets.all(10.0),  // Khoảng cách xung quanh hình ảnh
          height: 60,  // Chiều cao của hộp
          width: 60,   // Chiều rộng của hộp
          decoration: const BoxDecoration(
            color: Color(0xffE0E8FB),  // Màu nền hộp (màu xanh nhạt)
            borderRadius: BorderRadius.all(Radius.circular(15)),  // Bo góc hộp
          ),
          child: Image.asset(imageUrl),  // Hiển thị hình ảnh từ đường dẫn
        ),
        const SizedBox(  // Khoảng cách dưới hình ảnh
          height: 8,
        ),
        // Hiển thị giá trị
        Text(
          value.toString() + unit,  // Kết hợp giá trị và đơn vị
          style: const TextStyle(
            fontWeight: FontWeight.bold,  // Chữ đậm
          ),
        )
      ],
    );
  }
}
