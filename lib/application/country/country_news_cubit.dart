import 'package:bloc/bloc.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/repasitory/news_repository.dart';
import 'package:meta/meta.dart';

part 'country_news_state.dart';

class CountryNewsCubit extends Cubit<CountryNewsState> {
  CountryNewsCubit() : super(CountryNewsInitial());

  List<News> news = [];
  final NewsRepository repository = NewsRepository();

  Future getCountryNews(String country) async {
    emit(CountryNewsLoading());
    try {
      news = await repository.getNewsByCountry(country: country);
      emit(CountryNewsLoadedState(news));
    } catch (e) {
      emit(CountryNewsLoadingErrorState(e.toString()));
    }
  }
}
