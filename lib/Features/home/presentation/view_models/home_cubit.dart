import 'package:bloc/bloc.dart';
import 'package:graduation_project/Data/repository/activity_repository.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ActivityRepository activityRepository;

  HomeCubit(this.activityRepository) : super(HomeInitial());

  void logActivity({required Map<String, dynamic> queryParameters}) async {
    print('HomeCubit: Starting logActivity with queryParameters: $queryParameters');
    emit(HomeLoading());
    try {
      final carbonValue = await activityRepository.logActivity(
        queryParameters: queryParameters,
      );
      print('HomeCubit: Successfully fetched carbonValue: $carbonValue');
      emit(HomeLoaded(carbonValue: carbonValue));
    } catch (e) {
      print('HomeCubit: Error occurred: $e');
      emit(HomeError(errorMessage: e.toString()));
    }
  }

  void fetchStatistics(String period) async {
    print('HomeCubit: Starting fetchStatistics with period: $period');
    emit(HomeLoading());
    try {
      final statistics = await activityRepository.fetchStatistics(period);
      print('HomeCubit: Successfully fetched statistics: $statistics');
      emit(HomeStatisticsLoaded(statistics: statistics));
    } catch (e) {
      print('HomeCubit: Error occurred: $e');
      emit(HomeError(errorMessage: e.toString()));
    }
  }
}