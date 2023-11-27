import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpl_predictor/screens/app_view_model.dart';
import 'package:fpl_predictor/screens/assist_screen.dart';
import 'package:fpl_predictor/screens/clean_sheet_screen.dart';
import 'package:fpl_predictor/screens/goals_screen.dart';
import 'package:fpl_predictor/screens/login_screen.dart';
import 'package:fpl_predictor/screens/penalty_screen.dart';
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

class RegisterScreen extends StatefulHookConsumerWidget {
  static const routeName = '/register';
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final registerVM = ref.watch(appViewProvider);
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.sh,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: (MediaQuery.of(context).padding.top) + 50.h),
                  child: Image.asset(
                    ConstantString.appLogo,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    customTextField(
                      "teamName",
                      hintText: 'Team Name',
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText: 'Team name field cannot be empty '),
                        ],
                      ),
                    ),
                    verticalSpacer(40.h),
                    customTextField(
                      "email",
                      hintText: 'Email',
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.email(
                              errorText: 'Provided email not valid '),
                          FormBuilderValidators.required(
                              errorText: 'Email field cannot be empty '),
                        ],
                      ),
                    ),
                    verticalSpacer(40.h),
                    customTextField(
                      "password",
                      hintText: 'Password',
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText: 'Password field cannot be empty '),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: (MediaQuery.of(context).padding.bottom) + 10.h),
                  child: Column(
                    children: [
                      CustomButton(
                        title: "SUBMIT",
                        isLoading: registerVM.isLoading,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          bool? validate = _formKey.currentState?.validate();
                          print(validate);
                          if (validate == true) {
                            // String? companyId = _formKey
                            //     .currentState?.fields['companyId']?.value
                            //     .toString()
                            //     .trim();

                            // if (companyId!.isEmpty || companyId == "null") {
                            //   companyId = "0";
                            // }
                            _formKey.currentState?.save();

                            var email = _formKey
                                .currentState?.fields['email']?.value
                                .toString()
                                .trim();

                            var teamName = _formKey
                                .currentState?.fields['teamName']?.value
                                .toString()
                                .trim();
                            // var companyid = int.parse(companyId);

                            var password = _formKey
                                .currentState?.fields['password']?.value;
                            registerVM.signUp(
                                email: email!,
                                teamName: teamName!,
                                password: password,

                                // email, password,firstName,lastName,companyId
                                context: context);
                          }
                        },
                        // routeName: HomeScreen.routeName,
                      ),
                      verticalSpacer(25.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: Text(
                          "Already Registered? Login",

                          // textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: const Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
