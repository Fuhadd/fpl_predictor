import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/locator.dart';
import 'package:fpl_predictor/models/result_model.dart';
import 'package:fpl_predictor/repositories/user_repo.dart';
import 'package:fpl_predictor/screens/home_screen.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';
import 'package:fpl_predictor/utils/enums.dart';
import 'package:fpl_predictor/utils/spacers.dart';
import 'package:fpl_predictor/widgets/custom_appbar.dart';
import 'package:fpl_predictor/widgets/custom_button.dart';
import 'package:fpl_predictor/widgets/game_list.dart';
import 'package:fpl_predictor/widgets/game_list_title.dart';
import 'package:fpl_predictor/widgets/title_underline.dart';

class ResultScreen extends StatelessWidget {
  // String selectedTeam = ConstantList.teams[0];
  // static const routeName = '/result';
  const ResultScreen({super.key, required this.comp});
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
          child: FutureBuilder<List<ResultModel>?>(
              future: locator<UserRepository>().getResultDetails(comp.id),
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
                            title: "RESULTS",
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
                              itemCount: result.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var userSelections = result[index];
                                return GameList(
                                  number: "${index + 1}.",
                                  title: userSelections.data.userName,
                                  subTitle1: userSelections.data.playerName,
                                  subTitle2: "Jesus",
                                  subTitle1Color:
                                      userSelections.isAccurate == true
                                          ? CustomColors.greenColor
                                          : CustomColors.redColor,
                                  subTitle2Color: CustomColors.redColor,
                                );
                              }),
                        ],
                      ),
                      const CustomButton(
                        title: "Done",
                        routeName: HomeScreen.routeName,
                      ),
                    ],
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpacer(20.h),
                        const TitleUnderline(
                          title: "RESULTS",
                        ),
                        verticalSpacer(25.h),
                        const GameListTitle(
                          number: " ",
                          title: "Team Name",
                          subTitle1: "Pick",
                          subTitle2: "Back Up",
                        ),
                        verticalSpacer(14.h),
                        const GameList(
                          number: "1.",
                          title: "Avengers",
                          subTitle1: "Salah",
                          subTitle2: "Jesus",
                          subTitle1Color: CustomColors.greenColor,
                          subTitle2Color: CustomColors.redColor,
                        ),
                        const GameList(
                          number: "2.",
                          title: "BB Team",
                          subTitle1: "Diaz",
                          subTitle2: "Sterling",
                          subTitle1Color: CustomColors.redColor,
                          subTitle2Color: CustomColors.redColor,
                        ),
                        const GameList(
                          number: "3.",
                          title: "Avengers",
                          subTitle1: "Salah",
                          subTitle2: "Saka",
                          subTitle1Color: CustomColors.greenColor,
                          subTitle2Color: CustomColors.greenColor,
                        ),
                        const GameList(
                          number: "4.",
                          title: "BB Team",
                          subTitle1: "Foden",
                          subTitle2: "Jesus",
                          subTitle1Color: CustomColors.redColor,
                          subTitle2Color: CustomColors.redColor,
                        ),
                        const GameList(
                          number: "5.",
                          title: "Avengers",
                          subTitle1: "Haaland",
                          subTitle2: "Rashford",
                          subTitle1Color: CustomColors.greenColor,
                          subTitle2Color: CustomColors.redColor,
                        ),
                        const GameList(
                          number: "6.",
                          title: "BB Team",
                          subTitle1: "Foden",
                          subTitle2: "Fernandes",
                          subTitle1Color: CustomColors.redColor,
                          subTitle2Color: CustomColors.redColor,
                        ),
                        const GameList(
                          number: "7.",
                          title: "Avengers",
                          subTitle1: "Salah",
                          subTitle2: "Saka",
                          subTitle1Color: CustomColors.greenColor,
                          subTitle2Color: CustomColors.greenColor,
                        ),
                        const GameList(
                          number: "8.",
                          title: "BB Team",
                          subTitle1: "Haaland",
                          subTitle2: "Diaz",
                          subTitle1Color: CustomColors.greenColor,
                          subTitle2Color: CustomColors.redColor,
                        ),
                      ],
                    ),
                    CustomButton(
                      title: "DONE",
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false,
                        );
                      },
                      // routeName: HomeScreen.routeName,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
