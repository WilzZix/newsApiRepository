import 'package:flutter/material.dart';
import 'package:infinite_scroll/application/bloc/news_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';

import 'components/news_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NewsBloc bloc = NewsBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(
                      Icons.arrow_back,
                      size: 35,
                    ),
                    Icon(
                      Icons.more_vert,
                      size: 35,
                    )
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
              BlocProvider(
                create: (context) => NewsBloc(),
                child: BlocBuilder(
                  bloc: bloc..add(GetNewsEvent()),
                  builder: (BuildContext context, state) {
                    if (state is NewsLoadedState) {
                      List<News> data = state.data;
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: NewsCard(
                                data: data[index],
                              ),
                            );
                          },
                          childCount: data.length,
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
