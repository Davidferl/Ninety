import 'package:bonne_reponse/src/group/domain/post_with_user_and_group.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  final PostWithUserAndGroup postWithUserAndGroup;
  const PostContent({super.key, required this.postWithUserAndGroup});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 151, 149, 149),
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(40, 167, 234, 211)
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                      postWithUserAndGroup
                          .post.image, // Load group image from the URL
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postWithUserAndGroup.objectiveName,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: kcSecondaryVariant),
                        ),
                        Text(
                          "Third day in a row",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: kcSecondaryVariant),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 125,
                          child: Text(
                            postWithUserAndGroup.post.description,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: kcSecondaryVariant),
                          ),
                        )
                      ],
                    ),
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
