import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/feed/comment/comment_tile.dart';
import 'package:bonne_reponse/src/view/widgets/button.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class Comment {
  final String message;

  Comment({required this.message});
}

class CommentPage extends HookWidget {
  final List<Comment> comments = [
    Comment(message: "Hello"),
    Comment(message: "World!"),
    Comment(message: "Ok thom.")
  ];

  CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => context.pop(''),
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SectionName(name: "Comments"),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: [
                          const Divider(
                            color: kcDarkGray,
                          ),
                          CommentTile(
                            name: "name",
                            message: comment.message,
                            time: "24 mins",
                          ),
                        ],
                      ));
                },
              )),
              const Spacer(),
              Container(
                color: kcGray,
                child: Row(
                  children: [RoundedButton(onPressed: () {  }, buttonText: '',)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
