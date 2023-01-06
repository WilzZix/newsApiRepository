import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';


class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.data,
  }) : super(key: key);
  final News data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/detail', extra: data);
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF6C9AF2),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(data.urlToImage.toString()),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        data.author.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        softWrap: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.author.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        // Row(
                        //   children: const [
                        //     Icon(
                        //       Icons.star,
                        //       color: Colors.amber,
                        //     ),
                        //     // Text(
                        //     //   '6.6',
                        //     //   style: TextStyle(
                        //     //       fontWeight: FontWeight.bold,
                        //     //       fontSize: 12,
                        //     //       color: Colors.white),
                        //     // )
                        //   ],
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
