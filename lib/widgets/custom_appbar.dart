import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fpl_predictor/utils/constant_strings.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';

PreferredSizeWidget customAppBar({bool isBack = false}) {
  return AppBar(
    elevation: 0,
    automaticallyImplyLeading: false,
    // iconTheme: const IconThemeData(color: kMainColor),
    backgroundColor: CustomColors.whiteColor,
    centerTitle: false,
    title: isBack
        ? Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: SizedBox(
                  height: 30.h,
                  width: 30.w,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            );
          })
        : Builder(builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: SizedBox(
                height: 30.h,
                width: 30.w,
                child: SvgPicture.asset(
                  ConstantString.menu,
                ),
              ),
            );
          }),

    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: CircleAvatar(
          radius: 25.r,
          backgroundImage: const AssetImage(
            ConstantString.profileImage,
          ),
        ),
      ),
    ],
  );
}
