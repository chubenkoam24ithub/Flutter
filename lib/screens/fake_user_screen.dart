import 'package:flutter/material.dart';
import '../models/fake_user.dart';

class FakeUserScreen extends StatelessWidget {
  const FakeUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as FakeUser?;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Ошибка")),
        body: const Center(child: Text("Пользователь не найден")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(user.avatarPath),
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(user.city, style: const TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 20),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Отзывы пользователя", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: user.posts.length,
              itemBuilder: (context, index) {
                PostWithMovie postWithMovie = user.posts[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(postWithMovie.review),
                    ),
                    subtitle: Text(
                      "🎥 ${postWithMovie.movie.title} (${postWithMovie.movie.year}) • ⭐️ ${postWithMovie.movie.rating}",
                      style: const TextStyle(fontSize: 12, color: Colors.blueGrey, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}