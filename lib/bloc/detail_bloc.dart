import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:movie_app/event/detail_event.dart';
import 'package:movie_app/state/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {

  DetailBloc() : super(DetailStateInitial());

  @override
  Stream<Transition<DetailEvent, DetailState>> transformEvents(
      Stream<DetailEvent> events,
      TransitionFunction<DetailEvent, DetailState> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 200)),
      transitionFn,
    );
  }

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is ReadMore) {
      yield DetailStateReadMore();
    }
  }
}
