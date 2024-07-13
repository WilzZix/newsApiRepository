import 'package:flutter/material.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:infinite_scroll/presentation/pages/home_page/home_page.dart';

class CategoryListNews extends StatefulWidget {
  const CategoryListNews({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final List<News> data;

  @override
  State<CategoryListNews> createState() => _CategoryListNewsState();
}

class _CategoryListNewsState extends State<CategoryListNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return ListViewItem(
              data: widget.data[index],
            );
          },
        ),
      ),
    );
  }
}
