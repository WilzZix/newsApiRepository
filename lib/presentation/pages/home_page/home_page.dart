import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll/application/home_page_news_bloc/news_bloc.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/presentation/pages/category/category_page.dart';
import 'package:infinite_scroll/presentation/pages/settings_page/settings_page.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NewsBloc bloc = NewsBloc();
  int selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
    super.initState();
  }

  static const List<Widget> _pages = [
    HomePageBottomNavBar(),
    CategoryPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          selectedIndex = value;
          setState(() {});
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Category',
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: _pages.elementAt(selectedIndex),
    );
  }
}

class HomePageBottomNavBar extends StatelessWidget {
  const HomePageBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<NewsBloc>(context).add(GetNewsEvent());
        },
        child: BlocBuilder<NewsBloc, NewsState>(
          buildWhen: (context, state) {
            return state is NewsLoadedState || state is NewsLoadingErrorState;
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
                        data: state.data,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return ListViewItem(
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
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWidget(
                        data: state.data,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return ListViewItem(
                            data: state.data[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is NewsLoadingErrorState) {
              return Center(
                child: Text(state.message),
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
  final List<News> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: CarouselSlider(
        items: data.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return i.urlToImage != null
                  ? GestureDetector(
                      onTap: () {
                        context.pushNamed('/detail', extra: i);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => DetailPage(
                        //       data: i,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: i.urlToImage != null
                                ? NetworkImage(
                                    i.urlToImage!,
                                  )
                                : const NetworkImage(
                                    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpotterhenry37.medium.com%2Fwhat-is-a-404-page-not-found-error-and-how-can-you-fix-it-a29ed9d6bc2a&psig=AOvVaw2e8GgTMLLnSqTom_xmreMS&ust=1720689551387000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCICj6J2SnIcDFQAAAAAdAAAAABAJ',
                                  ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${i.title}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          );
        }).toList(),
        options: CarouselOptions(autoPlay: true, height: 200.0),
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    Key? key,
    required this.data,
  }) : super(key: key);
  final News data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('/detail', extra: data);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DetailPage(
        //       data: data,
        //     ),
        //   ),
        // );
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
