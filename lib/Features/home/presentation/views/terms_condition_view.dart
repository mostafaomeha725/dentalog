
import 'package:dentalog/Features/home/presentation/views/widgets/terms_condition_view_body.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsConditionView extends StatelessWidget {
  const TermsConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF0062CC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left_sharp,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                      CanPopWidgets(). handleBackButton(context);
                },
              ),
            ),
          ),
            title: const Text("Terms & Conditions",
            
            style: TextStyles.bold20w600,
            ),
            centerTitle: true,
          ),
      body: TermsConditionViewBody(
        
      ),
    );
  }
}




class CanPopWidgets {
   void handleBackButton(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.pushReplacement(AppRouter.kProfileView);
    }
  }
}