import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/screens/app_view_model.dart';
import 'package:fpl_predictor/screens/assist_screen.dart';
import 'package:fpl_predictor/screens/clean_sheet_screen.dart';
import 'package:fpl_predictor/screens/goals_screen.dart';
import 'package:fpl_predictor/screens/home_screen.dart';
import 'package:fpl_predictor/screens/penalty_screen.dart';
import 'package:fpl_predictor/utils/constant_strings.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';
import 'package:fpl_predictor/utils/spacers.dart';
import 'package:fpl_predictor/widgets/custom_appbar.dart';
import 'package:fpl_predictor/widgets/home_container.dart';
import 'package:fpl_predictor/widgets/league_container.dart';
import 'package:fpl_predictor/widgets/navigation_drawer.dart';

class LeagueScreen extends StatefulWidget {
  static const routeName = '/league';
  const LeagueScreen({super.key});

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: CustomColors.whiteColor,
      drawer: const CustomNavigationDrawer(
        pageIndex: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpacer(10.h),
            //// VERY IMPORTANT
            // ElevatedButton(
            //     onPressed: () async {
            //       setState(() {
            //         isLoading = true;
            //       });
            //       await AppViewModel.initWhoAmI().savePlayers();
            //       setState(() {
            //         isLoading = false;
            //       });
            //     },
            //     child: isLoading
            //         ? const CircularProgressIndicator()
            //         : const Text("Upload Data")),
            // verticalSpacer(10.h),
            Container(
              width: double.infinity,
              height: 140.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff260448),
                      const Color(0xff000E8D).withOpacity(0.83),
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "POINTS",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        color: Colors.white),
                  ),
                  Text(
                    "10,000",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40.sp,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            verticalSpacer(50.h),
            const LeagueContainer(
              title: "Goal Scorer",
              // subTitle: "5,000 POINTS",
              image: ConstantString.salah,
              routeName: HomeScreen.routeName,
            ),
            const LeagueContainer(
              title: "Assist",
              // subTitle: "5,000 POINTS",
              image: ConstantString.bruno,
              routeName: HomeScreen.routeName,
            ),
            const LeagueContainer(
              title: "Clean Sheet",
              // subTitle: "5,000 POINTS",
              image: ConstantString.allison,
              routeName: HomeScreen.routeName,
            ),
            const LeagueContainer(
              title: "Team Win",
              // subTitle: "5,000 POINTS",
              image: ConstantString.haaland,
              routeName: HomeScreen.routeName,
            ),
          ],
        ),
      ),
    );
  }
}
