import 'package:fpl_predictor/screens/assist_screen.dart';
import 'package:fpl_predictor/screens/clean_sheet_screen.dart';
import 'package:fpl_predictor/screens/goals_screen.dart';
import 'package:fpl_predictor/screens/home_screen.dart';
import 'package:fpl_predictor/screens/league_screen.dart';
import 'package:fpl_predictor/screens/login_screen.dart';
import 'package:fpl_predictor/screens/penalty_screen.dart';
import 'package:fpl_predictor/screens/pre_game_screen.dart';
import 'package:fpl_predictor/screens/register_screen.dart';
import 'package:fpl_predictor/screens/result_screen.dart';

var appRoutes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  GoalScreen.routeName: (context) => const GoalScreen(),
  // PreGameScreen.routeName: (context) => const PreGameScreen(),
  // ResultScreen.routeName: (context) => const ResultScreen(),
  AssistScreen.routeName: (context) => const AssistScreen(),
  CleanSheetScreen.routeName: (context) => const CleanSheetScreen(),
  PenaltyScreen.routeName: (context) => const PenaltyScreen(),
  LeagueScreen.routeName: (context) => const LeagueScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
};
