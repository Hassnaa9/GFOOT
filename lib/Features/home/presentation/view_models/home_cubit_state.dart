import 'package:graduation_project/Core/models/rank_model.dart';
import 'package:graduation_project/Core/models/recommendations_model.dart';
import 'package:graduation_project/Core/models/statistics_model.dart';
import 'package:graduation_project/Core/models/user_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final double carbonValue;

  HomeLoaded({required this.carbonValue});
}

class HomeError extends HomeState {
  final String errorMessage;

  HomeError(String string, {required this.errorMessage});
}

class HomeStatisticsLoaded extends HomeState {
  final List<EmissionEntry> statistics;

  HomeStatisticsLoaded({required this.statistics});
}

class HomeStatisticsError extends HomeState {
  final String message;

  HomeStatisticsError(String string, {required this.message});
}

class HomeRecommendationsLoaded extends HomeState {
  final List<Recommendation> recommendations;

  HomeRecommendationsLoaded({required this.recommendations});
}

class HomeRanksLoaded extends HomeState {
  final RankModel rank;
  final UserModel? user;

  HomeRanksLoaded({required this.rank, this.user});
}

class HomeNoData extends HomeState {
  final String message;

  HomeNoData({this.message = 'No carbon footprint data available'});
}

class HomeProfileLoaded extends HomeState {
  final UserModel user;

  HomeProfileLoaded({required this.user});
}