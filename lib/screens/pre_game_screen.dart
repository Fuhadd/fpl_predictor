import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/locator.dart';
import 'package:fpl_predictor/models/competition_details_model.dart';
import 'package:fpl_predictor/repositories/user_repo.dart';
import 'package:fpl_predictor/screens/result_screen.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';
import 'package:fpl_predictor/utils/enums.dart';
import 'package:fpl_predictor/utils/spacers.dart';
import 'package:fpl_predictor/widgets/custom_appbar.dart';
import 'package:fpl_predictor/widgets/custom_button.dart';
import 'package:fpl_predictor/widgets/game_list.dart';
import 'package:fpl_predictor/widgets/game_list_title.dart';
import 'package:fpl_predictor/widgets/title_underline.dart';

class PreGameScreen extends StatelessWidget {
  // String selectedTeam = ConstantList.teams[0];

  // static const routeName = '/pregame';
  const PreGameScreen({super.key, required this.comp});
  final FootballCompetition comp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(isBack: true),
      backgroundColor: CustomColors.whiteColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.sh -
              (customAppBar().preferredSize.height) -
              (MediaQuery.of(context).padding.top) -
              (MediaQuery.of(context).padding.bottom) -
              30,
          child: FutureBuilder<CompetitionDetailsModel?>(
              future: locator<UserRepository>().getCompDetails(comp.id),
              builder: (context, rideSnapshot) {
                if (rideSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (rideSnapshot.hasError) {
                  return Text('Error loading ride: ${rideSnapshot.error}');
                } else if (rideSnapshot.hasData) {
                  // Display information in a container
                  var result = rideSnapshot.data!;
                  print(result);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpacer(20.h),
                          const TitleUnderline(
                            title: "PRE GAME WEEK",
                          ),
                          verticalSpacer(25.h),
                          const GameListTitle(
                            number: " ",
                            title: "Team Name",
                            subTitle1: "Pick",
                            subTitle2: "Back Up",
                          ),
                          verticalSpacer(14.h),
                          ListView.builder(
                              itemCount: result.userSelections!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var userSelections =
                                    result.userSelections![index];
                                return GameList(
                                  number: "${index + 1}.",
                                  title: userSelections.userName,
                                  subTitle1: userSelections.playerName,
                                  subTitle2: "Selected",
                                );
                              }),
                        ],
                      ),
                      CustomButton(
                        title: "Done",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(comp: comp),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return const Text('No data available');
                }
              }),
        ),
      ),
    );
  }
}
