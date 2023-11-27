import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/screens/app_view_model.dart';
import 'package:fpl_predictor/screens/assist_screen.dart';
import 'package:fpl_predictor/screens/clean_sheet_screen.dart';
import 'package:fpl_predictor/screens/goals_screen.dart';
import 'package:fpl_predictor/screens/penalty_screen.dart';
import 'package:fpl_predictor/screens/register_screen.dart';
import 'package:fpl_predictor/utils/constant_strings.dart';
import 'package:fpl_predictor/utils/custom_colors.dart';
import 'package:fpl_predictor/utils/spacers.dart';
import 'package:fpl_predictor/widgets/custom_appbar.dart';
import 'package:fpl_predictor/widgets/custom_button.dart';
import 'package:fpl_predictor/widgets/home_container.dart';
import 'package:fpl_predictor/widgets/my_textfield.dart';
import 'package:fpl_predictor/widgets/navigation_drawer.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  //bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: Center(
        child: Image.asset(
          ConstantString.appLogo,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
