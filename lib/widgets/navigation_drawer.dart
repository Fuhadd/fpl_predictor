import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fpl_predictor/screens/assist_screen.dart';
import 'package:fpl_predictor/screens/clean_sheet_screen.dart';
import 'package:fpl_predictor/screens/goals_screen.dart';
import 'package:fpl_predictor/screens/home_screen.dart';
import 'package:fpl_predictor/screens/league_screen.dart';
import 'package:fpl_predictor/screens/penalty_screen.dart';
import 'package:fpl_predictor/screens/player_select_screen.dart';
import 'package:fpl_predictor/utils/constant_strings.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';
import 'package:fpl_predictor/utils/enums.dart';
import 'package:fpl_predictor/utils/spacers.dart';

class CustomNavigationDrawer extends StatefulWidget {
  final int pageIndex;
  const CustomNavigationDrawer({Key? key, required this.pageIndex})
      : super(key: key);

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 240,
      backgroundColor: CustomColors.darkBlueColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpacer(MediaQuery.of(context).padding.top),
            verticalSpacer(30.h),
            buildHeader(context),
            verticalSpacer(30.h),
            buildMenuItems(
              context,
              widget.pageIndex,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).size.height * 0.25,
    decoration: const BoxDecoration(
      color: CustomColors.darkBlueColor,
    ),
    child: Image.asset(
      ConstantString.appLogo1,
      height: 120,
      fit: BoxFit.cover,
    ),
  );
// //
}

class SideMenus extends StatelessWidget {
  SideMenus({
    this.padding = 16,
    this.color = Colors.white,
    required this.onClick,
    // required this.iconUrl,
    required this.title,
    this.isSubMenu = false,
    //required onClick,
    Key? key,
  }) : super(key: key);
  // final String iconUrl;
  final String title;
  double padding;
  Color color;
  VoidCallback onClick;
  final bool isSubMenu;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isSubMenu
          ? const EdgeInsets.only(left: 20)
          : const EdgeInsets.only(top: 5.0),
      child: ListTile(
        horizontalTitleGap: 4,
        // contentPadding: EdgeInsets.symmetric(horizontal: padding),
        // leading: SvgPicture.asset(
        //   iconUrl,
        //   color: Colors.grey,
        //   height: 30,
        //   // height: 30,
        // ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w700, color: color, fontSize: 19),
        ),
        onTap: onClick,
      ),
    );
  }
}

Widget buildMenuItems(
  BuildContext context,
  int pageIndex,
) {
  return Column(
    children: [
      // SideDivider(),
      // verticalSpacer(10),
      SideMenus(
          color: pageIndex == 1
              ? CustomColors.blackColor
              : CustomColors.whiteColor,
          // iconUrl: 'assets/icons/profile_icon.svg',
          title: 'HOME',
          onClick: pageIndex == 1
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                }),

      // SideDivider(),
      SideMenus(
          color: pageIndex == 2
              ? CustomColors.blackColor
              : CustomColors.whiteColor,
          // iconUrl: 'assets/icons/issues_icon.svg',
          title: 'COMPETITIONS',
          onClick: pageIndex == 2
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                }),
      SideMenus(
          color: pageIndex == 3
              ? CustomColors.blackColor
              : CustomColors.whiteColor,
          // iconUrl: 'assets/icons/checklist_icon.svg',
          title: 'GOAL SCORER',
          isSubMenu: true,
          padding: 40,
          onClick: pageIndex == 3
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlayerSelectScreen(
                        title: "Goal Scorer",
                        comp: FootballCompetition.goalScorer,
                      ),
                    ),
                  );
                }),
      SideMenus(
          color: pageIndex == 4
              ? CustomColors.blackColor
              : CustomColors.whiteColor,
          // iconUrl: 'assets/icons/checklist_icon.svg',
          title: 'ASSIST',
          isSubMenu: true,
          padding: 40,
          onClick: pageIndex == 4
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlayerSelectScreen(
                        title: "Assist",
                        comp: FootballCompetition.assist,
                      ),
                    ),
                  );
                }),
      SideMenus(
          color: pageIndex == 5
              ? CustomColors.blackColor
              : CustomColors.whiteColor,
          // iconUrl: 'assets/icons/clock_icon.svg',
          title: 'PENALTY',
          padding: 40,
          isSubMenu: true,
          onClick: pageIndex == 5
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlayerSelectScreen(
                        title: "Penalty",
                        comp: FootballCompetition.penalty,
                      ),
                    ),
                  );
                }),
      SideMenus(
          color: pageIndex == 6
              ? CustomColors.blackColor
              : CustomColors.whiteColor,
          // iconUrl: 'assets/icons/clock_icon.svg',

          title: 'CLEAN SHEET',
          padding: 40,
          isSubMenu: true,
          onClick: pageIndex == 6
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlayerSelectScreen(
                        title: "Clean Sheet",
                        comp: FootballCompetition.cleanSheet,
                      ),
                    ),
                  );
                }),
      SideMenus(
          color: pageIndex == 7
              ? CustomColors.blackColor
              : CustomColors.whiteColor,
          // iconUrl: 'assets/icons/clock_icon.svg',
          title: 'SETTINGS',
          padding: 40,
          onClick: pageIndex == 7
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  FirebaseAuth.instance.signOut();
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  // Navigator.pushReplacementNamed(
                  //     context, TimeLogScreen.routeName);
                }),
    ],
  );
}
