import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.title.toString(),
                    softWrap: true,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.data.author.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(
                    32,
                  ),
                ),
                child: Image.network(widget.data.urlToImage.toString()),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                widget.data.description.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.data.content.toString(),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        DateFormat().format(
                          DateTime.parse(
                            widget.data.publishedAt.toString(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Official site',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
