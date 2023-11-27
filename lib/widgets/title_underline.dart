import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';

class TitleUnderline extends StatelessWidget {
  final String title;
  const TitleUnderline({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF4F4F4),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 19.sp,
                color: CustomColors.darkBlueTextColor),
          ),
        ),
      ),
    );
  }
}
