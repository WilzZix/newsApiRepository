import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_news_info_event.dart';

part 'detail_news_info_state.dart';

class DetailNewsInfoBloc
    extends Bloc<DetailNewsInfoEvent, DetailNewsInfoState> {
  DetailNewsInfoBloc() : super(DetailNewsInfoInitial()) {
    on<DetailNewsInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
