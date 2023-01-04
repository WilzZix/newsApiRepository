import 'package:flutter/material.dart';
import 'package:infinite_scroll/application/bloc/news_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
              // const SliverToBoxAdapter(
              //   child: Text(
              //     'August',
              //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              //   ),
              // ),
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
                    if(state is NewsLoadedState){}
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: NewsCard(),
                          );
                        },
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
