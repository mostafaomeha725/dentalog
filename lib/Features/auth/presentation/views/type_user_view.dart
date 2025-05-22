import 'package:dentalog/Features/auth/presentation/views/widgets/type_user_view_body.dart';
import 'package:flutter/material.dart';

class TypeUserView extends StatelessWidget {
  const TypeUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TypeUserViewBody(),
    );
  }
}
