import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:infinite_scroll/application/bloc/news_bloc.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
        endDrawer: Drawer(
          backgroundColor: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {Navigator.of(context).pop();},
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Выберите страну',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Россия',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'UnitedStates',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Australia',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'India',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Southern Africa',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Turkish',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Россия',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Global news',
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  DateFormat.yMMMd()
                      .format(DateTime.parse(DateTime.now().toString())),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          // actions: [
          //   const Icon(
          //     Icons.search,
          //     size: 32,
          //   ),
          //   const SizedBox(
          //     width: 16,
          //   ),
          //   // GestureDetector(
          //   //   onTap: () {
          //   //
          //   //   },
          //   //   child: const Icon(
          //   //     Icons.menu,
          //   //     size: 32,
          //   //   ),
          //   // ),
          //   const SizedBox(
          //     width: 8,
          //   ),
          // ],
        ),
        body: BlocProvider(
          create: (context) => NewsBloc(),
          child: BlocBuilder<NewsBloc, NewsState>(
            bloc: bloc..add(GetNewsEvent()),
            builder: (context, state) {
              if (state is NewsLoadedState) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderWidget(
                          data: state
                              .data[Random().nextInt(state.data.length - 1)],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return LIstVIewItem(
                              data: state.data[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is NewsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final News data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  data.urlToImage.toString(),
                )),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          DateFormat.yMMMd().format(DateTime.parse(DateTime.now().toString())),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          data.title.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          data.description.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}

class LIstVIewItem extends StatelessWidget {
  const LIstVIewItem({
    Key? key,
    required this.data,
  }) : super(key: key);
  final News data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMd()
                      .format(DateTime.parse(DateTime.now().toString())),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    data.title.toString(),
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              width: 120,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(data.urlToImage.toString())),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Divider()
      ],
    );
  }
}
