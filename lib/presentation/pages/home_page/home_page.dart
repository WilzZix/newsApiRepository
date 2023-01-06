import 'dart:developer';

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
  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      bloc.add(GetNewsEvent());
      log('REACH THE BOTTOM');
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      log('REACH THE TOP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            controller: scrollController,
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
                child: BlocConsumer<NewsBloc, NewsState>(
                  listener: (context, state) {
                    // if (state is NewsLoadedState) {
                    //   setState(() {
                    //   });
                    // }
                  },
                  builder: (context, state) {
                    return BlocBuilder(
                      buildWhen: (context, state) =>
                          state != NewsLoadedState,
                      bloc: bloc..add(GetNewsEvent()),
                      builder: (BuildContext context, state) {
                        if (state is NewsLoadedState) {
                        List<News>  data = state.data;
                          log('${data.length}');
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index < data.length) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: NewsCard(
                                      data: data[index],
                                    ),
                                  );
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                              childCount: data.length + 1,
                            ),
                          );
                        }
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
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
