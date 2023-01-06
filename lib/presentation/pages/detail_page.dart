import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final News data;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFC46EDB),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFC46EDB),
                  Color(0xFFAA3F91),
                  Color(0xFFB7277A),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.go('/');
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          Icons.star_border,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 24,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: ClipOval(
                            child: Image.network(
                              widget.data.urlToImage.toString(),
                              width: 80,
                              height: 80,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.data.description.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26),
                              ),
                              Text(
                                widget.data.author.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 24,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(
                          32,
                        ),
                      ),
                      child: Image.network(
                        widget.data.urlToImage.toString()
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 24,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: RichText(
                      text:  TextSpan(
                        text:widget.data.content.toString(),
                        style:const TextStyle(color: Colors.white),
                        children:const [
                          TextSpan(
                            text: '...read all',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
