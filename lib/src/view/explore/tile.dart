import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int index;
  final Group group;
  final String userId;

  const Tile(
      {super.key,
      required this.index,
      required this.group,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    bool isMember = group.members.map((e) => e.userId).contains(userId);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
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
                      group.imageUrl, // Load group image from the URL
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.title,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: kcSecondaryVariant,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      verticalSpace(2),
                      Text(
                        group.description,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: kcSecondaryVariant,
                              fontWeight: FontWeight.w500,
                            ),
                        maxLines: 2, // Limit description to 2 lines
                        overflow: TextOverflow
                            .ellipsis, // Add ellipsis if text is too long
                      ),
                      verticalSpace(12),
                      Row(
                        children: [
                          Text(
                            group.members.length == 1
                                ? '1 member'
                                : '${group.members.length} members',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          if (isMember)
            Positioned(
                top: 0,
                left: 5,
                child: Chip(
                  label: Text(
                    "Joined",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: kcPrimary, fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: kcPrimary.withOpacity(0.1),
                ))
        ],
      ),
    );
  }
}
