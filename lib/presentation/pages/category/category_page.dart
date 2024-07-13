import 'package:flutter/material.dart';
import 'package:infinite_scroll/application/bbc_news/bbc_news_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll/application/home_page_news_bloc/news_bloc.dart';
import 'package:infinite_scroll/application/sport/sport_bloc.dart';
import 'package:infinite_scroll/presentation/pages/category/category_list_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Global News',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<BbcNewsBloc, BbcNewsState>(
              builder: (context, state) {
                if (state is BBCNewsLoaded) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'BBC News',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryListNews(
                                      data: state.data,
                                      title: 'BBC News',
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text('All'),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            state.data[index].urlToImage ??
                                                "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpotterhenry37.medium.com%2Fwhat-is-a-404-page-not-found-error-and-how-can-you-fix-it-a29ed9d6bc2a&psig=AOvVaw2e8GgTMLLnSqTom_xmreMS&ust=1720689551387000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCICj6J2SnIcDFQAAAAAdAAAAABAJ",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Text(
                                        state.data[index].title!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 16),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SportBloc, SportState>(
              builder: (context, state) {
                if (state is SportNewsLoaded) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sport News',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryListNews(
                                      data: state.data,
                                      title: 'Sport News',
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text('All'),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            state.data[index].urlToImage ??
                                                "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpotterhenry37.medium.com%2Fwhat-is-a-404-page-not-found-error-and-how-can-you-fix-it-a29ed9d6bc2a&psig=AOvVaw2e8GgTMLLnSqTom_xmreMS&ust=1720689551387000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCICj6J2SnIcDFQAAAAAdAAAAABAJ",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Text(
                                        state.data[index].title!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 16),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoadedState) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Top headlines',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryListNews(
                                      data: state.data,
                                      title: 'Top headlines',
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text('All'),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            state.data[index].urlToImage ??
                                                "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpotterhenry37.medium.com%2Fwhat-is-a-404-page-not-found-error-and-how-can-you-fix-it-a29ed9d6bc2a&psig=AOvVaw2e8GgTMLLnSqTom_xmreMS&ust=1720689551387000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCICj6J2SnIcDFQAAAAAdAAAAABAJ",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Text(
                                        state.data[index].title!,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 16),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
