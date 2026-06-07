import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

// Обновленные импорты экранов
import 'screens/search_screen.dart';
import 'screens/post_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/fake_user_screen.dart';

// Обновленные импорты BLoC, репозиториев и сервисов
import 'blocs/movie/movie_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
import 'blocs/user/user_bloc.dart';
import 'blocs/settings/settings_bloc.dart'; 
import 'blocs/settings/settings_event.dart'; 
import 'blocs/settings/settings_state.dart'; 
import 'repositories/movie_repository.dart';
import 'repositories/user_repository.dart';
import 'repositories/settings_repository.dart'; 
import 'services/movie_service.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA9_3iAAZuvELhoCBgmPK6LMUbL-T8BE4A",
        appId: "1:569489620687:web:5074e62dc39f43f25e41ba",
        projectId: "cinemate-d547b",
        authDomain: "cinemate-d547b.firebaseapp.com",
        storageBucket: "cinemate-d547b.firebasestorage.app",
        messagingSenderId: "569489620687",
        measurementId: "G-VHNQV4JE6T",
        databaseURL: null // Для Firestore не требуется
      )
    );
    print("Firebase успешно инициализирован");
  } catch (e) {
    print("Ошибка инициализации Firebase: $e");
  }  

  final firebaseService = FirebaseService();
  final userRepository = UserRepository();

  runApp(CineMateApp(
    firebaseService: firebaseService, 
    userRepository: userRepository
  ));
}

class CineMateApp extends StatelessWidget {
  final FirebaseService firebaseService;
  final UserRepository userRepository;

  const CineMateApp({
    super.key,
    required this.firebaseService,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieBloc(
            MovieRepository(movieService: MovieService()),
          ),
        ),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => UserBloc(firebaseService, userRepository)),
        BlocProvider(
          create: (context) => SettingsBloc(SettingsRepository())..add(LoadSettings()),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          bool isDark = false;
          
          if (state is SettingsUpdated) {
            isDark = state.isDarkTheme;
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CineMate',
            theme: isDark ? ThemeData.dark() : ThemeData.light(),
            initialRoute: '/',
            routes: {
              '/': (context) => const HomeScreen(),
              '/fakeUser': (context) => const FakeUserScreen(),
            },
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const SearchScreen(),
    const PostScreen(),
    const FeedScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Кино"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Лента"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Настройки"),
        ],
      ),
    );
  }
}