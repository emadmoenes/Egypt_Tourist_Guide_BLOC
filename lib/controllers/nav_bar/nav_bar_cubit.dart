import 'package:egypt_tourist_guide/controllers/nav_bar/nav_bar_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavBarCubit extends Cubit<NavBarStates> {
  NavBarCubit():super(NavBarInitial());

  int currentNavBarIndex = 0;

  void changeIndex(int index) {
    currentNavBarIndex = index;
    emit(NavBarChangeIndex(currentNavBarIndex));
  }

}