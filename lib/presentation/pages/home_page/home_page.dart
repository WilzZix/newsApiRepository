import 'dart:math';
import 'package:flutter/material.dart';
import 'package:infinite_scroll/application/bloc/news_bloc.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/presentation/pages/detail_page.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NewsBloc bloc = NewsBloc();

  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.done_all_rounded),
            )
          ],
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Global news',
                  style: TextStyle(fontSize: 32),
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          buildWhen: (context, state) {
            return state is NewsLoadedState;
          },
          builder: (context, state) {
            if (state is CountryNewsLoadedState) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWidget(
                        data:
                            state.data[Random().nextInt(state.data.length - 1)],
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
            if (state is NewsLoadedState) {
              print('line 233');
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWidget(
                        data:
                            state.data[Random().nextInt(state.data.length - 1)],
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              data: data,
            ),
          ),
        );
      },
      child: Column(
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
                width: 110,
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
      ),
    );
  }
}
