import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppLoadedState) {
      yield AppLoadedState();
    } else if (event is AppLoadingEvent) {
      yield AppLoadedState();
    } else if (event is AppLoadFailEvent) {
      yield AppErrorState(event.msg);
    } else if (event is AppLoadSuccessEvent) {
      yield AppLoadedState();
    }
  }
}
