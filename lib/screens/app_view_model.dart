import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpl_predictor/models/player_model.dart';
import 'package:fpl_predictor/models/team_model.dart';
import 'package:fpl_predictor/models/user_data.dart';
import 'package:fpl_predictor/screens/home_screen.dart';
import 'package:fpl_predictor/screens/league_screen.dart';
import 'package:fpl_predictor/utils/constant_strings.dart';
import 'package:fpl_predictor/utils/enums.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../view_model/base_change_notifier.dart';

final appViewProvider = ChangeNotifierProvider.autoDispose<AppViewModel>((ref) {
  return AppViewModel.initWhoAmI();
});

class AppViewModel extends BaseChangeNotifier {
  bool _isloading;

  String authorized = 'Not Authorized';

  AppViewModel.initWhoAmI()
      : _isloading = false,
        _userId = "",
        _userName = "",
        _password = "",
        _email = "";
  AppViewModel.profile()
      : _userId = "",
        _userName = "",
        _email = "",
        _password = "",
        _isloading = false;

  bool get isLoading => _isloading;
  String _email, _userId, _userName, _password = "";

  String get email => _email;
  String get password => _password;
  String get userId => _userId;

  String get userName => _userName;

  set isLoading(bool isloading) {
    _isloading = isloading;
    notifyListeners();
  }

  Future<List<Team>?> getAllTeams() async {
    try {
      isLoading = true;
      // UserDataModel data = localCache.getUserData();
      final properties = await userRepository.getAllTeams();

      if (properties != null) {
        isLoading = false;
        return properties;
      } else {
        isLoading = false;
        return [];
      }
    } catch (e, stacktrace) {
      isLoading = false;
      print(e.toString());
      // ScaffoldMessenger.of(context!)
      //   ..removeCurrentSnackBar()
      //   ..showSnackBar(SnackBar(
      //     content: Text(e.toString()),
      //     backgroundColor: Colors.red,
      //   ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
    return null;
  }

  Future<List<Player>?> getAllTeamPlayers(String teamId) async {
    try {
      isLoading = true;
      // UserDataModel data = localCache.getUserData();
      final properties = await userRepository.getAllTeamPlayers(teamId);

      if (properties != null) {
        isLoading = false;
        return properties;
      } else {
        isLoading = false;
        return [];
      }
    } catch (e, stacktrace) {
      isLoading = false;
      print(e.toString());
      // ScaffoldMessenger.of(context!)
      //   ..removeCurrentSnackBar()
      //   ..showSnackBar(SnackBar(
      //     content: Text(e.toString()),
      //     backgroundColor: Colors.red,
      //   ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
    return null;
  }

  Future<void> createCompetition() async {
    try {
      isLoading = true;
      // UserDataModel data = localCache.getUserData();
      final comp = await userRepository.createCompetition(
          comp: FootballCompetition.penalty,
          sport: Sport.football,
          league: FootballLeague.premierLeague);

      if (comp) {
        isLoading = false;
      }
    } catch (e, stacktrace) {
      isLoading = false;
      print(e.toString());
      // ScaffoldMessenger.of(context!)
      //   ..removeCurrentSnackBar()
      //   ..showSnackBar(SnackBar(
      //     content: Text(e.toString()),
      //     backgroundColor: Colors.red,
      //   ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
    return;
  }

  Future<void> saveUserSelection({
    required String playerId,
    required String playerName,
    required String compId,
    required String compName,
  }) async {
    try {
      isLoading = true;
      UserDataModel data = localCache.getUserData();
      final comp = await userRepository.saveUserSelection(
        userId: data.id,
        userName: data.teamName,
        playerId: playerId,
        playerName: playerName,
        compId: compId,
        compName: compName,
      );

      if (comp) {
        isLoading = false;
      }
    } catch (e, stacktrace) {
      isLoading = false;
      print(e.toString());
      // ScaffoldMessenger.of(context!)
      //   ..removeCurrentSnackBar()
      //   ..showSnackBar(SnackBar(
      //     content: Text(e.toString()),
      //     backgroundColor: Colors.red,
      //   ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
    return;
  }

  // FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> signUp(
      {required String email,
      required String password,
      required String teamName,
      BuildContext? context}) async {
    try {
      isLoading = true;

      final user = await userRepository.createUserWithEmail(
        email,
        password,
      );

      if (user != null) {
        _email = email;
        var userId = await userRepository.saveUserCredentials(
            email, teamName, password, DateTime.now());

        if (userId != null) {
          UserDataModel user = UserDataModel(
              id: userId, teamName: teamName, email: email, password: password);
          final userJson = json.encode(user.toJson());
          localCache.saveToLocalCache(
              key: ConstantString.userJson, value: userJson);
        }

        isLoading = false;
        Navigator.of(context!).pushReplacementNamed(
          HomeScreen.routeName,
        );

        // navigationHandler.pushNamed(
        //   ProfileScreen.routeName,
        // );
      } else {
        isLoading = false;

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> signIn(email, password, {BuildContext? context}) async {
    try {
      isLoading = true;
      final user = await userRepository.loginWithEmail(
        email,
        password,
      );

      if (user != null) {
        _email = email;
        var user = await userRepository.getUsersCredentials();

        if (user != null) {
          final userJson = json.encode(user.toJson());
          localCache.saveToLocalCache(
              key: ConstantString.userJson, value: userJson);
        }

        isLoading = false;

        // navigationHandler.pushNamed(
        //   ProfileScreen.routeName,
        // );
        Navigator.of(context!).pushReplacementNamed(
          HomeScreen.routeName,
        );
      } else {
        isLoading = false;
      }
    } catch (e, stacktrace) {
      isLoading = false;
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

/////VERYYY IMPORTANT
  // Future savePlayers() async {
  //   try {
  //     List<List<String>> players = [
  //       ['Keylor Navas', 'Goalkeeper'],
  //       ['Achraf Hakimi', 'Right-Back'],
  //       ['Presnel Kimpembe', 'Centre-Back'],
  //       ['Manuel Ugarte', 'Defensive Midfield'],
  //       ['Marquinhos', 'Centre-Back'],
  //       ['Kylian Mbappé', 'Centre-Forward'],
  //       ['Fabián Ruiz', 'Central Midfield'],
  //       ['Gonçalo Ramos', 'Centre-Forward'],
  //       ['Ousmane Dembélé', 'Right Winger'],
  //       ['Marco Asensio', 'Left Winger'],
  //     ];
  //     for (List<String> player in players) {
  //       String name = player[0];
  //       String position = player[1];
  //       await userRepository.savePlayer(
  //         name: name,
  //         position: position,
  //         teamId: 'rSieZYAEgDUJhHsSD3Mb',
  //       );
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}

final selectedPlayerProvider =
    StateProvider.autoDispose<String?>((ref) => null);
final selectedPlayerIdProvider =
    StateProvider.autoDispose<String?>((ref) => null);
final roomNameProvider = StateProvider.autoDispose<String?>((ref) => null);
final tvCheck = StateProvider.autoDispose<bool>((ref) => false);
final fanCheck = StateProvider.autoDispose<bool>((ref) => false);
