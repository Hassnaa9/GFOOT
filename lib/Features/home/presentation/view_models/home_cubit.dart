import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/Core/models/statistics_model.dart';
import 'package:graduation_project/Data/repository/activity_repository.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ActivityRepository activityRepository;
    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();


  HomeCubit(this.activityRepository) : super(HomeInitial());

 Future<void> logActivity({required Map<String, dynamic> queryParameters}) async {
    try {
      print('HomeCubit: Starting logActivity with queryParameters: $queryParameters');
      emit(HomeLoading());

      // Step 1: Log the activity
      await activityRepository.logActivity(queryParameters: queryParameters);
      print('HomeCubit: Activity logged successfully');

      // Step 2: Fetch the footprint value
      final carbonValue = await activityRepository.getFootprint();
      print('HomeCubit: Successfully fetched carbonValue: $carbonValue');

      emit(HomeLoaded(carbonValue: carbonValue));
    } catch (e) {
      print('HomeCubit: Error occurred: $e');
      emit(HomeError(e.toString(), errorMessage: 'An error occurred while logging activity'));
    }
  }
  Future<void> getCarbonFootprint() async {
    emit(HomeLoading());

    try {
      final carbonValue = await activityRepository.getFootprint();
      emit(HomeLoaded(carbonValue: carbonValue));
    } catch (e) {
      emit(HomeError(e.toString(), errorMessage: 'Failed to fetch carbon footprint'));
    }
  }
 Future<void> fetchStatistics(String type) async {
    emit(HomeLoading());

    try {
      final token = await secureStorage.read(key: 'accessToken');
      final data = await activityRepository.getStatistics(token!);

      // choose the correct list based on tab
      List<EmissionEntry> list;
      switch (type) {
        case 'Daily':
          list = data.daily;
          break;
        case 'Monthly':
          list = data.monthly;
          break;
        case 'Yearly':
          list = data.yearly;
          break;
        default:
          list = data.daily;
      }

      emit(HomeStatisticsLoaded(statistics: list));
    } catch (e) {
      emit(HomeStatisticsError(e.toString(), message: 'Failed to fetch statistics'));
    }
  }
  Future<void> fetchRecommendations() async {
  emit(HomeLoading());
  try {
    final token = await secureStorage.read(key: 'accessToken');
    final recs = await activityRepository.getRecommendations(token!);
    emit(HomeRecommendationsLoaded(recommendations: recs));
  } catch (e) {
    emit(HomeError(e.toString(), errorMessage: 'Failed to load recommendations'));
  }
}
Future<void> fetchRanks() async {
  emit(HomeLoading());
  try {
    final token = await secureStorage.read(key: 'accessToken');
    final rank = await activityRepository.getRanks(token!);
    emit(HomeRanksLoaded(rank: rank));
  } catch (e) {
    emit(HomeError(e.toString(), errorMessage: 'Failed to load rankings'));
  }
}
}