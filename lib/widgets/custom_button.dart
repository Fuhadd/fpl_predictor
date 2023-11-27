import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String? routeName;
  final bool isLoading;
  final void Function()? onTap;
  const CustomButton({
    required this.title,
    this.routeName,
    this.onTap,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: GestureDetector(
        onTap: onTap ??
            () {
              Navigator.pushNamed(context, routeName!);
              // Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
        child: Container(
          height: 72.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: CustomColors.darkBlueColor,
              borderRadius: BorderRadius.circular(8.sp)),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: CustomColors.whiteColor,
                  )
                : Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22.sp,
                        color: CustomColors.whiteColor),
                  ),
          ),
        ),
      ),
    );
  }
}
