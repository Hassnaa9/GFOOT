import 'package:bloc/bloc.dart';
import 'package:graduation_project/Data/repository/activity_repository.dart';
import 'package:graduation_project/Features/home/presentation/view_models/home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ActivityRepository activityRepository;

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
}