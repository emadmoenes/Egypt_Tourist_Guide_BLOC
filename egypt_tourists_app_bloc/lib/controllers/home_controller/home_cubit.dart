// import 'package:egypt_tourist_guide/controllers/home_controller/home_states.dart';
// import 'package:egypt_tourist_guide/data.dart';
// import 'package:egypt_tourist_guide/models/place_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class HomeCubit extends Cubit<HomeStates> {
//   HomeCubit() : super(HomeInitialState());
//   int currentPageIndex = 0;
//   // List<PlacesModel> get places => PLACES;
//
//   void fetchHomeData() {
//     emit(HomeLoadingState());
//     emit(HomeSuccessState(data: PLACES));
//   }
//
//   void togglingFavourite({required PlacesModel place,required bool isArabic}) {
//     final index = PLACES.indexWhere((p) => p.id == place.id);
//     if(isArabic){
//       ARABICPLACES[index].isFav = !ARABICPLACES[index].isFav;
//       emit(HomeSuccessState(data: ARABICPLACES));
//     }
//     if (index != -1) {
//       PLACES[index].isFav = !PLACES[index].isFav;
//       emit(HomeSuccessState(data: PLACES));
//     }
//   }
// }
