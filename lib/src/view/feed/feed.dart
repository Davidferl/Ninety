import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/view/feed/picture_profile.dart';
import 'package:bonne_reponse/src/view/feed/tile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';

class ProfileProp {
  final String imageUrl;
  final bool visited;

  ProfileProp({required this.imageUrl, required this.visited});
}

class Feed extends HookWidget {
  final List<ProfileProp> profileProps = [
    ProfileProp(
        imageUrl:
            "https://wallpapers.com/images/featured/cute-aesthetic-profile-pictures-pjfl391j3q0f7rlz.jpg",
        visited: true),
    ProfileProp(
        imageUrl:
            "https://wallpapers.com/images/featured/cute-aesthetic-profile-pictures-pjfl391j3q0f7rlz.jpg",
        visited: false),
    ProfileProp(
        imageUrl:
            "https://wallpapers.com/images/featured/cute-aesthetic-profile-pictures-pjfl391j3q0f7rlz.jpg",
        visited: false),
    ProfileProp(
        imageUrl:
            "https://wallpapers.com/images/featured/cute-aesthetic-profile-pictures-pjfl391j3q0f7rlz.jpg",
        visited: false),
    ProfileProp(
        imageUrl:
            "https://wallpapers.com/images/featured/cute-aesthetic-profile-pictures-pjfl391j3q0f7rlz.jpg",
        visited: false),
    ProfileProp(
        imageUrl:
            "https://wallpapers.com/images/featured/cute-aesthetic-profile-pictures-pjfl391j3q0f7rlz.jpg",
        visited: false),
  ];

  Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SectionName(name: "Feed"),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: profileProps
                      .map(
                        (prop) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: ProfilePicture(
                            imageUrl: prop.imageUrl,
                            visited: prop.visited,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            verticalSpaceMedium,
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 36.0),
                    child: Tile(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
