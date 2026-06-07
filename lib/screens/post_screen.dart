import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data'; // Используем байты вместо dart:io

import '../blocs/profile/profile_bloc.dart';
import '../blocs/movie/movie_state.dart';
import '../blocs/movie/movie_bloc.dart';
import '../models/comment.dart';
import 'profile_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Uint8List? _avatarBytes; // Храним картинку в байтах для Web-совместимости

  void _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Читаем файл как байты
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _avatarBytes = bytes;
      });
    }
  }

  void _showCommentDialog(BuildContext context) {
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Опубликовать отзыв"),
          content: TextField(
            controller: commentController,
            maxLength: 120,
            decoration: const InputDecoration(hintText: "Напишите ваши впечатления..."),
          ),
          actions: [
            TextButton(
              child: const Text("Отмена"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Опубликовать"),
              onPressed: () {
                if (commentController.text.isNotEmpty) {
                  context.read<ProfileBloc>().add(AddCommentEvent(commentController.text));
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, movieState) {
        String movieContext = "Фильм не выбран. Воспользуйтесь поиском.";

        if (movieState is MovieLoaded) {
          movieContext = "${movieState.movie.title} (${movieState.movie.year}) • Оценка: ${movieState.movie.imdbRating}";
        }

        return Scaffold(
          appBar: AppBar(title: const Text("Профиль")),
          body: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  // Используем MemoryImage для вывода байтов
                  backgroundImage: _avatarBytes != null ? MemoryImage(_avatarBytes!) : null,
                  child: _avatarBytes == null ? const Icon(Icons.person, size: 50) : null,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _showCommentDialog(context),
                child: const Text("Опубликовать отзыв о фильме"),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, profileState) {
                    if (profileState is ProfileLoaded) {
                      int displayedComments = profileState.comments.length > 6 
                          ? 6 
                          : profileState.comments.length;

                      return ListView.builder(
                        itemCount: displayedComments,
                        itemBuilder: (context, index) {
                          Comment comment = profileState.comments[index];

                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: ListTile(
                              title: Text(comment.text),
                              subtitle: Text(
                                movieContext,
                                style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: Text("Нет отзывов"));
                  },
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
                    child: const Text("Редактировать профиль"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}