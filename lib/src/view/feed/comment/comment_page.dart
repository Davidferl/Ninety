import 'dart:math';

import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Comment {
  final String username;
  final String timeAgo;
  final String message;

  Comment(
      {required this.username, required this.timeAgo, required this.message});
}

List<Comment> generateComments(int numComments) {
  List<Comment> comments = [];
  List<String> usernames = [
    "John",
    "Jane",
    "Tom",
    "Alice",
    "Bob",
    "Sue",
    "Mike",
    "Emily",
    "David",
    "Sophia",
    "James",
    "Olivia",
    "Chris",
    "Megan",
    "Daniel",
    "Isabella",
    "Matthew",
    "Charlotte",
    "Ethan",
    "Liam",
    "Lucas",
    "Amelia",
    "Grace",
    "Henry",
    "Ella",
    "Jack",
    "Mia",
    "Ryan",
    "Madison",
    "Aiden",
    "Chloe",
    "Benjamin",
    "Lily",
    "Jacob",
    "Zoe",
    "Alexander",
    "Samantha",
    "William",
    "Natalie",
    "Sebastian",
    "Hannah",
    "Joseph",
    "Mia",
    "Leo",
    "Victoria",
    "Harper",
    "Andrew",
    "Scarlett",
    "Oliver",
    "Emily",
    "Abigail",
    "Joshua",
    "Avery",
    "Sophia",
    "Carter",
    "Anna",
    "Matthew",
    "Sarah",
    "Noah",
    "Leah",
    "David",
    "Ellie",
    "Wyatt",
    "Daniel",
    "Madeline",
    "Gabriel",
    "Julia",
    "Benjamin",
    "Sophia",
    "Amos",
    "Abigail",
    "Gabrielle",
    "Ryan"
  ];
  List<String> messages = [
    "Start your day with a morning stretch, your body will thank you!",
    "Did you get 8 hours of sleep last night? Your body needs it to recharge!",
    "Drink a glass of water as soon as you wake up to kickstart your metabolism!",
    "Take a 5-minute walk after meals, it's great for digestion and your health!",
    "Don’t skip breakfast, it’s the most important meal of the day!",
    "A balanced diet is the key to a healthy life, aim for more veggies today!",
    "Why not try a quick workout today? Your body will feel stronger and more energized!",
    "Start small: aim for 30 minutes of exercise every day!",
    "Good sleep is just as important as good nutrition for your body’s well-being.",
    "Don’t forget to take breaks throughout your day, even just to stretch!",
    "Cut down on processed foods and focus on whole, nutrient-rich meals!",
    "Start each day with a healthy breakfast to fuel your body for success!",
    "Move your body, whether it’s yoga, running, or dancing, just keep moving!",
    "Sleep well tonight to wake up refreshed and energized tomorrow!",
    "Replace sugary drinks with water or herbal teas for a healthier lifestyle!",
    "Remember, consistency is key to healthy habits – take it one day at a time!",
    "Prioritize your health: a well-balanced meal will give you more energy!",
    "Take care of your mental health just as much as your physical health!",
    "A healthy routine includes plenty of water and nutritious food – make it a habit!",
    "Try to get outside for 15 minutes today and enjoy the fresh air!",
    "Set aside time for relaxation – good mental health supports a healthy body!",
    "Eating well isn’t about being perfect, it’s about making better choices every day!",
    "Sleep is the foundation of good health – aim for a consistent bedtime!",
    "Switch to whole grains today for more energy and better digestion!",
    "Move your body in a way that makes you feel good, whether it’s dancing or walking!",
    "You’ve got this! Every healthy choice you make adds up to long-term benefits!",
    "Prioritize sleep: it’s the best way to reset your body and mind for tomorrow.",
    "The best time to start your fitness journey is today – just start small!",
    "Good nutrition = good energy. Eat colorful fruits and veggies today!",
    "Stretching daily can improve flexibility and reduce stress. Give it a try!"
  ];

  List<String> timesAgo = [
    "2 min",
    "5 min",
    "10 min",
    "15 min",
    "20 min",
    "30 min"
  ];

  Random rand = Random();
  for (int i = 0; i < numComments; i++) {
    String username = usernames[rand.nextInt(usernames.length)];
    String message = messages[rand.nextInt(messages.length)];
    String timeAgo = timesAgo[rand.nextInt(timesAgo.length)];

    comments
        .add(Comment(username: username, message: message, timeAgo: timeAgo));
  }

  return comments;
}

List<Comment> getRandomComments(List<Comment> allComments, int numToDisplay) {
  Random rand = Random();
  List<Comment> selectedComments = [];

  // Ensure we don't select more comments than available
  numToDisplay =
      numToDisplay > allComments.length ? allComments.length : numToDisplay;

  for (int i = 0; i < numToDisplay; i++) {
    int randomIndex = rand.nextInt(allComments.length);
    selectedComments.add(allComments[randomIndex]);
    allComments
        .removeAt(randomIndex); // Remove selected comment to prevent duplicates
  }

  return selectedComments;
}

class CommentPage extends HookWidget {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = generateComments(80);
    int numComments = Random().nextInt(10) + 1;
    final List<Comment> comments = getRandomComments(c, numComments);

    const colorPalette =
        BoringAvatarPalette([kcPrimary, kcSecondaryVariant, kcLightPrimary]);

    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Padding(
          padding: EdgeInsets.only(top: 24.0),
          child: Align(
            alignment: Alignment
                .center, // This will center the child inside the AppBar
            child: SectionName(name: "Comments"),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Wrap ListView with a SingleChildScrollView to prevent overflow
          Padding(
            padding: const EdgeInsets.only(
                bottom: 100), // Add bottom padding to make space for input
            child: ListView.separated(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading: CircleAvatar(
                      radius: 24,
                      child: BoringAvatar(
                        palette: colorPalette,
                        shape: const OvalBorder(),
                        name: comment.username,
                        type: BoringAvatarType.beam,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          comment.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          comment.timeAgo,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.message,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.grey,
                  indent: 20, // Space before the divider starts
                  endIndent: 20,
                );
              },
            ),
          ),

          // Comment input box at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextField(
                        controller: controller,
                        style: const TextStyle(
                          color: Colors
                              .black, // Change the color of the input text
                          fontSize: 16, // Optional: Adjust the font size
                          fontWeight: FontWeight
                              .w500, // Optional: Adjust the font weight
                        ),
                        decoration: const InputDecoration(
                          hintText: "Write a comment...",
                          hintStyle: TextStyle(
                            fontSize: 16, // Change the font size
                            color: Colors.grey, // Change the hint text color
                            fontStyle: FontStyle
                                .italic, // Optionally, make the hint text italic
                            fontWeight:
                                FontWeight.w500, // Set the weight of the font
                          ),
                          border: InputBorder.none,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.teal,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        // Handle sending comment here
                        print('Comment: ${controller.text}');
                        controller.clear(); // Clear input after sending
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
