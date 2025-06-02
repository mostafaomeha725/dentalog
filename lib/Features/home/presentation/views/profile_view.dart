import 'package:dentalog/Features/auth/presentation/manager/cubit/sign_out_cubit/signout_cubit.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/Custom_list_title.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatelessWidget {
   ProfileView({super.key});
String? role ;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingHorizontal = screenWidth * 0.04;
    double sectionSpacing = screenHeight * 0.02;
    double itemSpacing = screenHeight * 0.015;
    double dividerSpacing = screenHeight * 0.005;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          CustomListTitle(
          
            isEdit: true,
          
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(vertical: sectionSpacing),
            child: Text("Personal Information", style: TextStyles.bold16w500),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: itemSpacing),
                    buildSectionTitle("Preference"),
                    SizedBox(height: itemSpacing),
                    _buildListTile(Icons.notifications, "Notification", onTap: () {
                      GoRouter.of(context).push(AppRouter.kNotificationView);
                    }),
                    SizedBox(height: dividerSpacing),
                    _buildDivider(),
                    SizedBox(height: itemSpacing),
                
                    buildSectionTitle("Others"),
                    SizedBox(height: itemSpacing),
                    _buildListTile(Icons.summarize_outlined, "Reports", onTap: () {
                      GoRouter.of(context).push(AppRouter.kHistoryView);
                    }),
                    SizedBox(height: dividerSpacing),
                    _buildDivider(),
                    SizedBox(height: itemSpacing),
                    _buildListTile(Icons.privacy_tip, "Privacy Policy",onTap: () {
                      GoRouter.of(context).push(AppRouter.kPrivacyPolicyview);
                    },),
                    SizedBox(height: dividerSpacing),
                    _buildDivider(),
                    SizedBox(height: itemSpacing),
                    _buildListTile(Icons.help_outline, "Terms of Use",onTap: () {
                                            GoRouter.of(context).push(AppRouter.kTermsConditionView);

                    },),
                    SizedBox(height: dividerSpacing),
                    _buildDivider(),
                    SizedBox(height: itemSpacing),
                   BlocProvider(
  create: (context) => SignoutCubit(ApiService(), SharedPreference()),
  child: BlocConsumer<SignoutCubit, SignoutState>(
    listener: (context, state)async {
      if (state is SignoutSuccess) {
                
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged out successfully')),
        );
        GoRouter.of(context).pushReplacement(AppRouter.kLoginView,extra:role );
      } else if (state is SignoutFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
      else if (state is SignoutLoading)
      {
          final prefs = await SharedPreferences.getInstance();
             role = prefs.getString("role");
      }
    },
    builder: (context, state) {
      return _buildListTile(
        Icons.logout,
        state is SignoutLoading ? 'Logging out...' : "Log out",
        onTap: state is SignoutLoading
            ? null
            : () {
                context.read<SignoutCubit>().signOut();
              },
      );
    },
  ),
),

                    SizedBox(height: dividerSpacing),
                    _buildDivider(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
      child: Text(title, style: TextStyles.bold14w500),
    );
  }

  Widget _buildListTile(IconData icon, String title, {void Function()? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      dense: true,
      visualDensity: const VisualDensity(vertical: -4),
      leading: Icon(icon, color: const Color(0xff134FA2), size: 20),
      title: Text(title, style: TextStyles.bold12w400),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xff134FA2)),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      indent: 16,
      endIndent: 16,
      height: 1,
      thickness: 1,
      color: Colors.grey.shade300,
    );
  }
}
