import '../../models/fake_user.dart';

List<FakeUser> fakeUsers = [
  FakeUser(
    name: "Вениамин Ранний",
    city: "Москва",
    avatarPath: "assets/avatar1.png",
    posts: [
      PostWithMovie(
        review: "Пересмотрел классику. Все еще шедевр, спецэффекты до сих пор смотрятся круто!",
        movie: MovieShortData(
          title: "The Matrix",
          year: "1999",
          rating: "8.7",
        ),
      ),
      PostWithMovie(
        review: "Отличный боевик на вечер, Киану Ривз как всегда на высоте.",
        movie: MovieShortData(
          title: "John Wick",
          year: "2014",
          rating: "7.4",
        ),
      ),
    ],
  ),
  FakeUser(
    name: "Филип Рождественский",
    city: "Санкт-Петербург",
    avatarPath: "assets/avatar2.png",
    posts: [
      PostWithMovie(
        review: "Концовка заставила задуматься. Волчок упал или нет?!",
        movie: MovieShortData(
          title: "Inception",
          year: "2010",
          rating: "8.8",
        ),
      ),
    ],
  ),
  FakeUser(
    name: "Всеволод Груздьев",
    city: "Казань",
    avatarPath: "assets/avatar3.png",
    posts: [
      PostWithMovie(
        review: "Картинка красивая, но сюжет немного затянут.",
        movie: MovieShortData(
          title: "Avatar",
          year: "2009",
          rating: "7.9",
        ),
      ),
      PostWithMovie(
        review: "Лучший саундтрек от Ханса Циммера, мурашки по коже.",
        movie: MovieShortData(
          title: "Interstellar",
          year: "2014",
          rating: "8.7",
        ),
      ),
    ],
  ),
  FakeUser(
    name: "Тамара Петровна",
    city: "Новосибирск",
    avatarPath: "assets/avatar4.png",
    posts: [
      PostWithMovie(
        review: "Леджер гениален. Лучший Джокер в истории кино.",
        movie: MovieShortData(
          title: "The Dark Knight",
          year: "2008",
          rating: "9.0",
        ),
      ),
    ],
  ),
];