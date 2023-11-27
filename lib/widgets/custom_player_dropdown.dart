import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/models/player_model.dart';
import 'package:fpl_predictor/screens/app_view_model.dart';
import 'package:fpl_predictor/utils/spacers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomPlayerDropdown extends StatefulHookConsumerWidget {
  final String title;
  final List<Player> items;
  Player? selectedPlayer;
  bool isLoading;
  CustomPlayerDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.selectedPlayer,
    this.isLoading = false,
  });

  @override
  ConsumerState<CustomPlayerDropdown> createState() =>
      _CustomPlayerDropdownState();
}

class _CustomPlayerDropdownState extends ConsumerState<CustomPlayerDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
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
                child: DropdownButton<Player>(
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
                  hint: const Text("Select a player"),
                  value: widget.selectedPlayer,
                  onChanged: (Player? newValue) async {
                    // Update the selected team when the user selects a different team.
                    if (newValue != null) {
                      widget.selectedPlayer = newValue;
                      setState(() {});
                      ref.read(selectedPlayerProvider.notifier).state =
                          newValue.name;
                      ref.read(selectedPlayerIdProvider.notifier).state =
                          newValue.id;
                    }
                  },
                  items: widget.items
                      .map<DropdownMenuItem<Player>>((Player player) {
                    return DropdownMenuItem<Player>(
                      value: player,
                      child: Text(player.name),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
