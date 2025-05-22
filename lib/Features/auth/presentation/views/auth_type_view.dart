import 'package:dentalog/Features/auth/presentation/views/widgets/auth_type_view_body.dart';
import 'package:flutter/material.dart';

class AuthTypeView extends StatelessWidget {
  const AuthTypeView({super.key, required this.type});
final String type ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthTypeViewBody(type: type,),
    );
  }
}
