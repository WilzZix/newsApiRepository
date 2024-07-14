import 'package:bloc/bloc.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/infrastructure/local_database_repository/local_data_source.dart';
import 'package:infinite_scroll/infrastructure/repasitory/news_repository.dart';
import 'package:meta/meta.dart';

part 'sport_event.dart';

part 'sport_state.dart';

class SportBloc extends Bloc<SportEvent, SportState> {
  SportBloc() : super(SportInitial()) {
    NewsRepository repository = NewsRepository();
    final hiveStorageRepository = LocalDataRepository();
    on<GetSportNewsEvent>((event, emit) async {
      try {
        emit(SportNewsLoading());
        final List<News> data = await repository.getSportNews();
        await hiveStorageRepository.setSportNews(data: data);
        emit(SportNewsLoaded(data));
      } catch (e) {}
    });
  }
}
