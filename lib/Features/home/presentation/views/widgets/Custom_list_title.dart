import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomListTitle extends StatefulWidget {
  const   CustomListTitle({
    super.key,
    this.isEdit = false,
  });

  final bool isEdit;

  @override
  State<CustomListTitle> createState() => _CustomListTitleState();
}

class _CustomListTitleState extends State<CustomListTitle> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
       if (state is ProfileSuccess) {
  final userData = Map<String, dynamic>.from(state.profileData);
  return _buildProfileCard(userData);
} else if (state is ProfileFailure) {
          return _buildErrorState(state.errMessage);
        } else {
          return _buildLoadingState();
        }
      },
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> userData) {
    final String? imageUrl = userData['image'];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          !widget.isEdit
              ? BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 5,
                  offset: const Offset(0, 5),
                )
              : BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
        ],
      ),
      child: Column(
        children: [
          if (widget.isEdit)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                     GoRouter.of(context).push(AppRouter.kEditprofileView , extra: userData);
                  },
                  child:  Icon(
                    Icons.edit_square,
                    size: 14,
                    color: Color(0xff134FA2),
                  ),
                ),
              ),
            ),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
                    ? NetworkImage(imageUrl)
                    : const AssetImage(Assets.assetsProfileAvater) as ImageProvider,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userData['name'] ?? '', style: TextStyles.bold16w600),
                  const SizedBox(height: 6),
                  Text(
                    userData['email'] ?? '',
                    style: TextStyles.bold10w400.copyWith(
                      color: const Color(0xff999898),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Error: $errorMessage',
        style: TextStyles.bold14w400.copyWith(color: Colors.red),
      ),
    );
  }
}
