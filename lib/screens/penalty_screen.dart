import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/models/player_model.dart';
import 'package:fpl_predictor/models/team_model.dart';
import 'package:fpl_predictor/screens/app_view_model.dart';
import 'package:fpl_predictor/screens/pre_game_screen.dart';
import 'package:fpl_predictor/utils/constant_strings.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';
import 'package:fpl_predictor/utils/enums.dart';
import 'package:fpl_predictor/utils/spacers.dart';
import 'package:fpl_predictor/widgets/custom_appbar.dart';
import 'package:fpl_predictor/widgets/custom_button.dart';
import 'package:fpl_predictor/widgets/custom_dropdown.dart';
import 'package:fpl_predictor/widgets/custom_team_dropdown1.dart';
import 'package:fpl_predictor/widgets/navigation_drawer.dart';
import 'package:fpl_predictor/widgets/title_underline.dart';

class PenaltyScreen extends StatefulWidget {
  // String selectedTeam = ConstantList.teams[0];
  static const routeName = '/penalty';
  const PenaltyScreen({super.key});

  @override
  State<PenaltyScreen> createState() => _PenaltyScreenState();
}

class _PenaltyScreenState extends State<PenaltyScreen> {
  bool isTeamLoading = false;
  bool isPlayerLoading = false;
  Team? selectedTeam;
  String? selectedPlayer;
  List<Team>? teams = [];
  List<Player>? players = [];
  @override
  void initState() {
    getAllTeams();
    super.initState();
  }

  Future<void> getAllTeams() async {
    setState(() {
      isTeamLoading = true;
    });
    teams = await AppViewModel.initWhoAmI().getAllTeams();

    setState(() {
      isTeamLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: CustomColors.whiteColor,
      drawer: const CustomNavigationDrawer(
        pageIndex: 5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpacer(20.h),
            const TitleUnderline(
              title: "SELECT PLAYERS",
            ),
            verticalSpacer(20.h),
            CustomTeamDropdown(
              title: "TEAM",
              // items: ConstantList.teams,
              selectedTeam: selectedTeam,
              items: teams ?? [],
              isLoading: isTeamLoading,
            ),
            verticalSpacer(50.h),
            const TitleUnderline(
              title: "BACK UP",
            ),
            verticalSpacer(20.h),
            CustomTeamDropdown(
              title: "TEAM",
              // items: ConstantList.teams,
              selectedTeam: selectedTeam,
              items: teams ?? [],
              isLoading: isTeamLoading,
            ),
            verticalSpacer(40.h),
            CustomButton(
              title: "Submit",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PreGameScreen(comp: FootballCompetition.penalty),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
