import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/utils/spacers.dart';

class GameListTitle extends StatelessWidget {
  final String title;
  final String subTitle1;
  final String subTitle2;
  final String number;
  const GameListTitle(
      {super.key,
      required this.subTitle1,
      required this.subTitle2,
      required this.title,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 50.w, right: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              ),
              horizontalSpacer(20),
              Expanded(
                child: Text(
                  title,
                  style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 17.sp),
                ),
              ),
              Expanded(
                child: Text(
                  subTitle1,
                  style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 17.sp),
                ),
              ),
              // Expanded(
              //   child: Text(
              //     subTitle2,
              //     style:
              //         TextStyle(fontWeight: FontWeight.w800, fontSize: 17.sp),
              //   ),
              // ),
            ],
          ),
        ),
        verticalSpacer(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: const Divider(
            color: Colors.black,
            thickness: 1.4,
          ),
        ),
        verticalSpacer(20.h),
      ],
    );
  }
}
