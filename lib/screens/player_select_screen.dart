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
import 'package:fpl_predictor/widgets/selected_player_container.dart';
import 'package:fpl_predictor/widgets/title_underline.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayerSelectScreen extends StatefulHookConsumerWidget {
  // String selectedTeam = ConstantList.teams[0];
  static const routeName = '/goal';
  const PlayerSelectScreen(
      {super.key, required this.title, required this.comp});
  final String title;
  final FootballCompetition comp;

  @override
  ConsumerState<PlayerSelectScreen> createState() => _PlayerSelectScreenState();
}

class _PlayerSelectScreenState extends ConsumerState<PlayerSelectScreen> {
  bool isTeamLoading = false;
  bool isPlayerLoading = false;
  Team? selectedTeam;
  String? selectedPlayer;
  List<Team>? teams = [];
  List<Player>? players = [];
  // bool hasTeams
  @override
  void initState() {
    if (teams == null || teams!.isEmpty) {
      getAllTeams();
    }

    super.initState();
  }

  Future<void> getAllTeams() async {
    setState(() {
      isTeamLoading = true;
    });
    teams = await AppViewModel.initWhoAmI().getAllTeams();
    // ref.read(selectedPlayerProvider.notifier).state = null;

    setState(() {
      isTeamLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerSelectVM = ref.watch(appViewProvider);
    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: CustomColors.whiteColor,
      drawer: CustomNavigationDrawer(
        pageIndex: widget.comp == FootballCompetition.goalScorer
            ? 3
            : widget.comp == FootballCompetition.assist
                ? 4
                : widget.comp == FootballCompetition.penalty
                    ? 5
                    : widget.comp == FootballCompetition.cleanSheet
                        ? 6
                        : 3,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.sh -
              (customAppBar().preferredSize.height) -
              (MediaQuery.of(context).padding.top) -
              (MediaQuery.of(context).padding.bottom),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    verticalSpacer(20.h),
                    TitleUnderline(
                      title: widget.title.toUpperCase(),
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
                      title: "SELECTION",
                    ),
                    // verticalSpacer(100.h),
                    Expanded(
                      child: Center(
                        child: SelectedPlayerContainer(
                          selectedPlayer: selectedPlayer,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Consumer(builder: (context, ref2, child) {
                return CustomButton(
                  isLoading: playerSelectVM.isLoading,
                  title: "Submit",
                  onTap: (ref2.watch(selectedPlayerIdProvider) == null) ||
                          (ref2.watch(selectedPlayerProvider) == null)
                      ? null
                      : () async {
                          await playerSelectVM.saveUserSelection(
                            playerId: ref2.watch(selectedPlayerIdProvider)!,
                            playerName: ref2.watch(selectedPlayerProvider)!,
                            compId: widget.comp.id,
                            compName: widget.comp.description,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PreGameScreen(comp: widget.comp),
                            ),
                          );
                        },
                );
              }),
              verticalSpacer(10),
            ],
          ),
        ),
      ),
    );
  }
}
