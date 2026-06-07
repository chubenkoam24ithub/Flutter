import 'package:flutter/material.dart';
import '../repositories/fake_data.dart';
import '../models/fake_user.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Лента отзывов")),
      body: ListView.builder(
        itemCount: fakeUsers.length,
        itemBuilder: (context, index) {
          FakeUser user = fakeUsers[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/fakeUser',
                arguments: user,
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(user.avatarPath),
                      radius: 25,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person, color: Colors.white), // Заглушка, если нет картинки
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: user.posts.map((postWithMovie) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(postWithMovie.review, style: const TextStyle(fontSize: 14)),
                                    const SizedBox(height: 4),
                                    Text(
                                      "🎥 ${postWithMovie.movie.title} (${postWithMovie.movie.year}) • ⭐️ ${postWithMovie.movie.rating}",
                                      style: const TextStyle(fontSize: 12, color: Colors.blueGrey, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}