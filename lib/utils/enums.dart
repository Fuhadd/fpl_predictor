import 'package:flutter/foundation.dart';

enum DropdownType {
  team,
  player,
}

enum FootballCompetition {
  unknown,
  goalScorer,
  assist,
  cleanSheet,
  penalty,
}

extension FootballCompetitionDescription on FootballCompetition {
  String get name => describeEnum(this);
  String get description {
    switch (this) {
      case FootballCompetition.unknown:
        return 'Unknown';
      case FootballCompetition.goalScorer:
        return 'Goal Scorer';
      case FootballCompetition.assist:
        return 'Assist';
      case FootballCompetition.cleanSheet:
        return 'Clean Sheet';
      case FootballCompetition.penalty:
        return 'Penalty';
    }
  }

  String get id {
    switch (this) {
      case FootballCompetition.unknown:
        return 'Unknown';
      case FootballCompetition.goalScorer:
        return 'umhhXlB1kcrXLcu6hYIQ';
      case FootballCompetition.assist:
        return '9DSs5TpMhPtMK7sNT4Jn';
      case FootballCompetition.cleanSheet:
        return 'DDm7B5AXVHsLDrpe4LCy';
      case FootballCompetition.penalty:
        return 'OtNqHfvsdG9EsACPdatb';
    }
  }
}

enum Sport {
  unknown,
  football,
  nfl,
}

extension SportDescription on Sport {
  String get name => describeEnum(this);
  String get description {
    switch (this) {
      case Sport.unknown:
        return 'Unknown';
      case Sport.football:
        return 'Football';
      case Sport.nfl:
        return 'NFL';
    }
  }
}

enum FootballLeague {
  unknown,
  premierLeague,
}

extension FootballLeagueDescription on FootballLeague {
  String get name => describeEnum(this);
  String get description {
    switch (this) {
      case FootballLeague.unknown:
        return 'Unknown';
      case FootballLeague.premierLeague:
        return 'Premier League';
    }
  }
}
