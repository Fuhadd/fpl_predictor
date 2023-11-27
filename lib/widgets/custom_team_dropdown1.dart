import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/models/player_model.dart';
import 'package:fpl_predictor/models/team_model.dart';
import 'package:fpl_predictor/screens/app_view_model.dart';
import 'package:fpl_predictor/utils/enums.dart';
import 'package:fpl_predictor/utils/spacers.dart';
import 'package:fpl_predictor/widgets/custom_player_dropdown.dart';

class CustomTeamDropdown extends StatefulWidget {
  final String title;
  final List<Team> items;
  Team? selectedTeam;
  bool isLoading;
  CustomTeamDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.selectedTeam,
    required this.isLoading,
  });

  @override
  State<CustomTeamDropdown> createState() => _CustomTeamDropdownState();
}

class _CustomTeamDropdownState extends State<CustomTeamDropdown> {
  Player? selectedPlayer;
  bool isPlayerLoading = false;
  List<Player>? players = [];

  Future<void> getAllTeamPlayers(String teamId) async {
    setState(() {
      isPlayerLoading = true;
    });
    players = await AppViewModel.initWhoAmI().getAllTeamPlayers(teamId);

    setState(() {
      isPlayerLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          verticalSpacer(10.h),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xffF4F4F4),
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1.0),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Team>(
                  icon: widget.isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : const Icon(Icons.arrow_drop_down),
                  hint: const Text("Select a team"),
                  value: widget.selectedTeam,
                  onChanged: (Team? newValue) async {
                    // Update the selected team when the user selects a different team.
                    if (newValue != null) {
                      widget.selectedTeam = newValue;
                      getAllTeamPlayers(newValue.id!);
                      setState(() {});
                    }
                  },
                  items: widget.items.map<DropdownMenuItem<Team>>((Team team) {
                    return DropdownMenuItem<Team>(
                      value: team,
                      child: Text(team.name),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          verticalSpacer(40.h),
          CustomPlayerDropdown(
            title: "PLAYER",
            items: widget.selectedTeam == null ? [] : players!,
            selectedPlayer: selectedPlayer,
          ),
        ],
      ),
    );
  }
}
