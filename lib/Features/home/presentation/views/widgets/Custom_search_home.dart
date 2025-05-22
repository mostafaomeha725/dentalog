import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomSearchHome extends StatelessWidget {
  const CustomSearchHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // ظل أقوى وأكثر وضوحًا
            blurRadius: 15, // زيادة الضبابية
            spreadRadius: 5, // توسيع الظل
            offset: Offset(0, 5), // جعل الظل يظهر أسفل العنصر
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyles.bold16w400inter,
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: Icon(Icons.filter_list, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
