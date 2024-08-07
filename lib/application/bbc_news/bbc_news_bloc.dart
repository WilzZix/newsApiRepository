import 'package:bloc/bloc.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/infrastructure/local_database_repository/local_data_source.dart';
import 'package:infinite_scroll/infrastructure/repasitory/news_repository.dart';
import 'package:meta/meta.dart';

part 'bbc_news_event.dart';

part 'bbc_news_state.dart';

class BbcNewsBloc extends Bloc<BbcNewsEvent, BbcNewsState> {
  NewsRepository repository = NewsRepository();
  final _hiveStorageRepository = LocalDataRepository();

  BbcNewsBloc() : super(BbcNewsInitial()) {
    on<GetBBCNewsEvent>((event, emit) async {
      try {
        emit(BBCNewsLoading());
        final List<News> data = await repository.getBBCNews();
        await _hiveStorageRepository.setBBCNews(data: data);
        emit(BBCNewsLoaded(data));
      } catch (e) {}
    });
  }
}
