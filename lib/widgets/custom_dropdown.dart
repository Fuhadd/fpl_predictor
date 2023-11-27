// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fpl_predictor/utils/spacers.dart';

// class CustomDropdown extends StatefulWidget {
//   final String title;
//   final List<String> items;
//   String selectedTeam;
//   CustomDropdown({
//     super.key,
//     required this.title,
//     required this.items,
//     required this.selectedTeam,
//   });

//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 30.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.title,
//             style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
//           ),
//           verticalSpacer(10.h),
//           Container(
//             width: double.infinity,
//             height: 50,
//             decoration: BoxDecoration(
//               color: const Color(0xffF4F4F4),
//               border:
//                   Border.all(color: Colors.black.withOpacity(0.1), width: 1.0),
//               borderRadius: BorderRadius.circular(5.r),
//             ),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   value: widget.selectedTeam,
//                   onChanged: (String? newValue) {
//                     // Update the selected team when the user selects a different team.
//                     if (newValue != null) {
//                       widget.selectedTeam = newValue;
//                       setState(() {});
//                     }
//                   },
//                   items:
//                       widget.items.map<DropdownMenuItem<String>>((String team) {
//                     return DropdownMenuItem<String>(
//                       value: team,
//                       child: Text(team),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
