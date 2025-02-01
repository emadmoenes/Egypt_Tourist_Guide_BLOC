abstract class NavBarStates{}
class NavBarInitial extends NavBarStates{}
class NavBarChangeIndex extends NavBarStates{
  final int index;
  NavBarChangeIndex(this.index);
}