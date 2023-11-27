import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/models/player_model.dart';
import 'package:fpl_predictor/models/team_model.dart';
import 'package:fpl_predictor/screens/app_view_model.dart';
import 'package:fpl_predictor/utils/enums.dart';
import 'package:fpl_predictor/utils/spacers.dart';
import 'package:fpl_predictor/widgets/custom_player_dropdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedPlayerContainer extends StatelessWidget {
  const SelectedPlayerContainer({super.key, required this.selectedPlayer});
  final String? selectedPlayer;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xffF4F4F4),
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1.0),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    ref.watch(selectedPlayerProvider) ?? "Player Name",
                    style: const TextStyle(fontSize: 14),
                  ),
                )),
          ));
    });
  }
}
