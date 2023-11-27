// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpl_predictor/models/competition_details_model.dart';
import 'package:fpl_predictor/models/player_model.dart';
import 'package:fpl_predictor/models/result_model.dart';
import 'package:fpl_predictor/models/team_model.dart';
import 'package:fpl_predictor/models/user_data.dart';
import 'package:fpl_predictor/utils/enums.dart';
import '../view_model/local_cache/local_cache.dart';

abstract class UserRepository {
  Future<User?> createUserWithEmail(String email, String password);
  Future<User?> loginWithEmail(String email, String password);
//   Future<User?> loginWithEmail1(String email, String password);
  Future isUserSignedIn();
  Future logOut();
  Future resetPassword(String email);
  Future<UserDataModel?> getUsersCredentials();
  Future<CompetitionDetailsModel?> getCompDetails(String compId);
  Future<List<ResultModel>?> getResultDetails(String compId);
  Future<String?> saveUserCredentials(
      String email, String teamName, String password, DateTime accountCreated);
  Future<String?> savePlayer(
      {required String name, required String position, required String teamId});
  Future<List<Team>?> getAllTeams();
  Future<List<Player>?> getAllTeamPlayers(String teamId);
  Future<bool> createCompetition({
    required FootballCompetition comp,
    required Sport sport,
    required FootballLeague league,
  });
  Future<bool> saveUserSelection({
    required String userId,
    required String userName,
    required String playerId,
    required String playerName,
    required String compId,
    required String compName,
  });
  Future<String?> deletePlayersNotInTeamList();
}

class UserRepositoryImpl implements UserRepository {
  late LocalCache cache;

  UserRepositoryImpl({
    required this.cache,
  }) : super();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('users');
  CollectionReference teamsFirebaseFirestore =
      FirebaseFirestore.instance.collection('teams');
  CollectionReference playerFirebaseFirestore =
      FirebaseFirestore.instance.collection('players');
  CollectionReference competitionsFirebaseFirestore =
      FirebaseFirestore.instance.collection('competitions');

  @override
  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (error) {
      var message = error.message;
      switch (error.code) {
        case 'invalid-email:':
          message = 'Email is Invalid!';
          break;
        case 'email-already-in-use':
          message =
              'The email address already exists.Please proceed to login Screen ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      print(error.code);
      throw Exception(message);
    }
  }

  @override
  Future isUserSignedIn() async {
    User? user = firebaseAuth.currentUser;
    return user != null && user.uid.isNotEmpty;
  }

  @override
  Future logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (error) {
      var message = error.message; // default message
      switch (error.code) {
        case 'user-disabled':
          message =
              'This user has been temporarily disabled, Contact Support for more information';
          break;
        case 'user-not-found':
          message =
              'The email address is not assocciated with a user.Try another Email up or Register with this email address ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
        case 'INVALID_LOGIN_CREDENTIALS':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      throw Exception(message);
    }
    return null;
  }

  @override
  Future resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<String?> saveUserCredentials(String email, String teamName,
      String password, DateTime accountCreated) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    int accountBalance = 10000;
    await firebaseFirestore.doc(uid.toString()).set(
        {
          'id': uid.toString(),
          'email': email,
          'password': password,
          'teamName': teamName,
          'accountBalance': accountBalance,
          'Leagues': [],
          'Selections': [],
          'competitions': [],
        },
        SetOptions(
          merge: true,
        ));
    return uid;
  }

  @override
  Future<CompetitionDetailsModel?> getCompDetails(String compId) async {
    try {
      final appUser = competitionsFirebaseFirestore.doc(compId);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return CompetitionDetailsModel.fromJson(snapshot.data());
      }
    } catch (error) {}
    return null;
  }

  @override
  Future<List<ResultModel>?> getResultDetails(String compId) async {
    try {
      List<ResultModel> result = [];
      final appUser = competitionsFirebaseFirestore.doc(compId);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        var competitionDetails =
            CompetitionDetailsModel.fromJson(snapshot.data());

        for (var competitionDetail in competitionDetails.userSelections!) {
          if (competitionDetails.finalResults!
              .contains(competitionDetail.playerId)) {
            ResultModel data =
                ResultModel(data: competitionDetail, isAccurate: true);
            result.add(data);
          } else {
            ResultModel data =
                ResultModel(data: competitionDetail, isAccurate: false);
            result.add(data);
          }
        }
      }

      return result;
    } catch (error) {}
    return null;
  }

  @override
  Future<UserDataModel?> getUsersCredentials() async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return UserDataModel.fromJson(snapshot.data());
      }
    } catch (error) {}
    return null;
  }

  @override
  Future<String?> savePlayer(
      {required String name,
      required String position,
      required String teamId}) async {
    final docUser = playerFirebaseFirestore.doc();
    await docUser.set(
        {
          'id': docUser.id,
          'name': name,
          'position': position,
          'teamId': teamId,
        },
        SetOptions(
          merge: true,
        ));
    await teamsFirebaseFirestore.doc(teamId).update(
      {
        'players': FieldValue.arrayUnion([docUser.id]),
        'dateCreated': Timestamp.now()
      },
    );
    return null;
  }

  @override
  Future<List<Team>?> getAllTeams() async {
    try {
      //     // final sharedPreferences = await SharedPreferences.getInstance();
      List<Team> allTeams = [];
      final data = teamsFirebaseFirestore;
      final properties = await data.get();
      if (properties.docs.isNotEmpty) {
        List<Team> allTeams =
            properties.docs.map((doc) => Team.fromJson(doc)).toList();

        print(allTeams);
        return allTeams;
      }
    } catch (error) {
      print(error);
      // handle the error
    }
    return null;
  }

  @override
  Future<List<Player>?> getAllTeamPlayers(String teamId) async {
    try {
      try {
        final players =
            playerFirebaseFirestore.where("teamId", isEqualTo: teamId);
        final snapshot = await players.get();
        if (snapshot.docs.isEmpty) {
          return null;
        }
        List<Player> allPlayers =
            snapshot.docs.map((doc) => Player.fromJson(doc)).toList();
        return allPlayers;
      } catch (error) {
        print(1);
        print(error.toString());
      }
      return null;
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<bool> createCompetition({
    required FootballCompetition comp,
    required Sport sport,
    required FootballLeague league,
  }) async {
    try {
      final docUser = competitionsFirebaseFirestore.doc();
      await docUser.set(
          {
            'id': docUser.id,
            'leagueId': league.index,
            'leagueName': league.description,
            'sportId': sport.index,
            'sportName': sport.description,
            'compName': comp.description,
            'userSelections': [],
            'finalResults': [],
            'dateCreated': Timestamp.now()
          },
          SetOptions(
            merge: true,
          ));
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> saveUserSelection({
    required String userId,
    required String userName,
    required String playerId,
    required String playerName,
    required String compId,
    required String compName,
  }) async {
    try {
      var userSelectionMap = {
        'userId': userId,
        'userName': userName,
        'playerId': playerId,
        'playerName': playerName
      };

      var userCompetitionMap = {
        'playerId': playerId,
        'playerName': playerName,
        'compId': compId,
        'compName': compName
      };
      await competitionsFirebaseFirestore.doc(compId).update(
        {
          'userSelections': FieldValue.arrayUnion([userSelectionMap]),
          'dateModified': Timestamp.now()
        },
      );

      await firebaseFirestore.doc(userId).update(
        {
          'competitions': FieldValue.arrayUnion([userCompetitionMap]),
        },
      );
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<String?> deletePlayersNotInList(List<String> allowedIds) async {
  //   // Step 1: Retrieve all documents in the collection
  //   List<String> allowedIds = [
  //     "6a4Kzxno2xi63F41izLo",
  //     "8uKQrYZk62SGTmN8nJyl",
  //     "WpCHVHCMm0mBWFTJRwjV",
  //     "goSEkJ1eH5kDAJxrAZz9",
  //     "ppBwViFMQHmPbJvS6KBO",
  //   ];
  //   final QuerySnapshot querySnapshot = await playerFirebaseFirestore.get();

  //   // Step 2: Filter out documents with IDs in the allowed list
  //   final List<String> idsToDelete = [];
  //   for (var doc in querySnapshot.docs) {
  //     final docId = doc.id;
  //     if (!allowedIds.contains(docId)) {
  //       idsToDelete.add(docId);
  //     }
  //   }

  //   // Step 3: Delete the remaining documents
  //   for (final id in idsToDelete) {
  //     final docToDelete = playerFirebaseFirestore.doc(id);
  //     await docToDelete.delete();
  //   }

  //   return null;
  // }

  @override
  Future<String?> deletePlayersNotInTeamList() async {
    // Step 1: Retrieve all documents in the collection
    List<String> allowedTeamIds = [
      "6a4Kzxno2xi63F41izLo",
      "8uKQrYZk62SGTmN8nJyl",
      "WpCHVHCMm0mBWFTJRwjV",
      "goSEkJ1eH5kDAJxrAZz9",
      "ppBwViFMQHmPbJvS6KBO",
    ];
    final QuerySnapshot querySnapshot = await playerFirebaseFirestore.get();

    // Step 2: Filter out documents with "teamId" not in the allowed list
    final List<String> idsToDelete = [];

    for (var doc in querySnapshot.docs) {
      try {
        final teamId = doc['teamId'] as String?;

        // Check if "teamId" exists and is not in the allowed list
        if (teamId != null && !allowedTeamIds.contains(teamId)) {
          idsToDelete.add(doc.id);
        }
      } catch (e) {
        continue;
      }
    }

    // Step 3: Delete the remaining documents
    for (final id in idsToDelete) {
      final docToDelete = playerFirebaseFirestore.doc(id);
      await docToDelete.delete();
    }

    return null;
  }
}
