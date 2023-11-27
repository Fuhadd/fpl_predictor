import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';

class LeagueContainer extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String image;
  final String routeName;
  const LeagueContainer(
      {super.key,
      required this.image,
      required this.title,
      this.subTitle,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 28.w, right: 28.w, bottom: 20.h),
        child: Container(
          width: double.infinity,
          height: 140.h,
          decoration: BoxDecoration(
            // color: CustomColors.blackColor.withOpacity(0.85),
            color: CustomColors.darkBlueTextColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: subTitle == null
                ? Center(
                    child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30.sp,
                        color: Colors.white),
                  ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30.sp,
                            color: Colors.white),
                      ),
                      Text(
                        subTitle!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 17.sp,
                            color: Colors.white),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
