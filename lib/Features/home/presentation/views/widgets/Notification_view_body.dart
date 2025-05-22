import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notifications = [
      {
        "name": "Dr. Youssef Brostito",
        "message": "send you a report",
        "time": "1m",
        "image": Assets.assetsDribrahim, // استبدل بالصورة الفعلية
        "isRead": false, // غير مقروء
      },
      {
        "name": "Dr. Kareem Ahmed",
        "message": "send you a report",
        "time": "23h",
        "image": Assets.assetsDrKareem, // استبدل بالصورة الفعلية
        "isRead": true, // مقروء
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        var notification = notifications[index];

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: notification["isRead"] ? Colors.white : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (!notification["isRead"])
                const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Icon(Icons.circle, size: 8, color: Color(0xff134FA2)),
                ),
              SizedBox(
                width: 8,
              ),
              // صورة الطبيب
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(notification["image"]),
              ),
              const SizedBox(width: 12),

              // النص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: notification["name"],
                              style: TextStyles.bold13w400),
                          const TextSpan(text: " "),
                          TextSpan(
                            text: notification["message"],
                            style: TextStyles.bold12w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // وقت الإشعار
              Text(
                notification["time"],
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),

              // علامة الإشعار غير المقروء
            ],
          ),
        );
      },
    );
  }
}
