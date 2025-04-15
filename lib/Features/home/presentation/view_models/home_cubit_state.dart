
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final double carbonValue;

  HomeLoaded({required this.carbonValue});
}

class HomeError extends HomeState {
  final String errorMessage;

  HomeError({required this.errorMessage});
}
class HomeStatisticsLoaded extends HomeState {
  final Map<String, dynamic> statistics;

  HomeStatisticsLoaded({required this.statistics});
}
class HomeStatisticsError extends HomeState {
  final String message;

  HomeStatisticsError({required this.message});
}