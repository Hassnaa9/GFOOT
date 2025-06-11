import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/Core/models/statistics_model.dart';
import 'package:graduation_project/Core/models/user_model.dart';
import 'package:graduation_project/Data/repository/activity_repository.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ActivityRepository activityRepository;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  UserModel? _user; // Persist user data

  HomeCubit(this.activityRepository) : super(HomeInitial());

  Future<void> logActivity({required Map<String, dynamic> queryParameters}) async {
    try {
      print('HomeCubit: Starting logActivity with queryParameters: $queryParameters');
      emit(HomeLoading());

      await activityRepository.logActivity(queryParameters: queryParameters);
      print('HomeCubit: Activity logged successfully');

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
      if (token == null) {
        throw Exception('No access token found');
      }
      print('HomeCubit: Fetching ranks with token: $token');
      final rank = await activityRepository.getRanks(token);
      if (_user == null) {
        print('HomeCubit: User not loaded, fetching profile');
        await fetchUserProfile();
      }
      emit(HomeRanksLoaded(rank: rank, user: _user));
    } catch (e) {
      print('HomeCubit: Error in fetchRanks: $e');
      emit(HomeError(e.toString(), errorMessage: 'Failed to load rankings'));
    }
  }

  Future<void> fetchUserProfile() async {
    emit(HomeLoading());
    try {
      final token = await secureStorage.read(key: 'accessToken');
      if (token == null) {
        throw Exception('No access token found');
      }
      print('HomeCubit: Fetching user profile with token: $token');
      final user = await activityRepository.getUserProfile(token);
      _user = user; // Persist user data
      print('HomeCubit: User profile fetched: ${user.displayName ?? user.userName ?? 'No name'}');
      emit(HomeProfileLoaded(user: user));
    } catch (e) {
      print('HomeCubit: Error in fetchUserProfile: $e');
      emit(HomeError(e.toString(), errorMessage: 'Failed to fetch user profile'));
    }
  }Future<void> updateProfile({
    required String displayName,
    required String phoneNumber,
    required String country,
    required String city,
  }) async {
    emit(HomeLoading());
    try {
      await activityRepository.updateProfile(
        displayName: displayName,
        phoneNumber: phoneNumber,
        country: country,
        city: city,
      );
      await fetchUserProfile(); // Refresh user profile after update
      emit(HomeProfileLoaded(user: _user!)); // Emit updated profile state
    } catch (e) {
      emit(HomeError(e.toString(), errorMessage: 'Failed to update profile'));
    }
  }
}