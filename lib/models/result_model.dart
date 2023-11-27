import 'package:fpl_predictor/models/competition_details_model.dart';
import 'package:fpl_predictor/models/user_selection_model.dart';

class ResultModel {
  final UserSelectionModel data;
  final bool isAccurate;

  ResultModel({
    required this.data,
    required this.isAccurate,
  });
}
