import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/locator.dart';
import 'package:fpl_predictor/repositories/user_repo.dart';
import 'package:fpl_predictor/screens/app_view_model.dart';
import 'package:fpl_predictor/screens/assist_screen.dart';
import 'package:fpl_predictor/screens/clean_sheet_screen.dart';
import 'package:fpl_predictor/screens/goals_screen.dart';
import 'package:fpl_predictor/screens/penalty_screen.dart';
import 'package:fpl_predictor/screens/player_select_screen.dart';
import 'package:fpl_predictor/utils/constant_strings.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';
import 'package:fpl_predictor/utils/enums.dart';
import 'package:fpl_predictor/utils/spacers.dart';
import 'package:fpl_predictor/widgets/custom_appbar.dart';
import 'package:fpl_predictor/widgets/home_container.dart';
import 'package:fpl_predictor/widgets/navigation_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await locator<UserRepository>().deletePlayersNotInTeamList();
                setState(() {
                  isLoading = false;
                });
              },
              child: Container(
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
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Column(
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
            ),
            verticalSpacer(50.h),
            const HomeContainer(
              // title: "Anytime",
              title: "Goal Scorer",
              image: ConstantString.salah,
              route: PlayerSelectScreen(
                title: "Goal Scorer",
                comp: FootballCompetition.goalScorer,
              ),
            ),
            const HomeContainer(
              // title: "Anytime",
              title: "Assist",
              image: ConstantString.bruno,
              route: PlayerSelectScreen(
                title: "Assist",
                comp: FootballCompetition.assist,
              ),
            ),
            const HomeContainer(
              title: "Clean Sheet",
              image: ConstantString.allison,
              route: PlayerSelectScreen(
                title: "Clean Sheet",
                comp: FootballCompetition.cleanSheet,
              ),
            ),
            const HomeContainer(
              title: "Penalty",
              image: ConstantString.haaland,
              route: PlayerSelectScreen(
                title: "Penalty",
                comp: FootballCompetition.penalty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
