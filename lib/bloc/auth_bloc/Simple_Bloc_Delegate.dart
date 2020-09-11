
import 'package:bloc/bloc.dart';

class SimpleDelegate extends BlocObserver
{

  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
  }
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
  }


}