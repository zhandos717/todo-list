class Todo {
  final String title;
  late bool isDone; // Обратите внимание на ключевое слово late

  Todo({
    required this.title,
    bool isDone = false, // Можно передавать значение по умолчанию
  }) {
    this.isDone = isDone; // Инициализируем поле isDone в конструкторе
  }
}
