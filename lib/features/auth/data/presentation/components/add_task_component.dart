import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';

class AddTaskComponent extends StatelessWidget {
  AddTaskComponent(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.suffixIcon,
      this.readOnly = false,
      this.validator});
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final bool readOnly;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        TextFormField(
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            // enabled border
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // fouced border
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // hint
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.displayMedium,
            suffixIcon: suffixIcon,
            // fill color
            fillColor: AppColors.lightBlack, filled: true,
          ),
        ),
      ],
    );
  }
}
