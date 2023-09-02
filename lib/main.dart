import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo_model.dart';
import 'todo_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: todoProvider.todos.length,
              itemBuilder: (context, index) {
                final todo = todoProvider.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Checkbox(
                        value: todo.isDone,
                        onChanged: (_) {
                          todoProvider.toggleTodoStatus(index);
                        },
                      ),
                      Visibility(
                        visible: todo.isDone,
                        // Показывать только, если задача выполнена
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            todoProvider.removeTodo(index);
                          },
                        ),
                      ),
                    ],
                  ),
                  onLongPress: () {
                    todoProvider.removeTodo(index);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Введите задачу',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final newTodoTitle = _textEditingController.text;
                    if (newTodoTitle.isNotEmpty) {
                      todoProvider.addTodo(newTodoTitle);
                      _textEditingController.clear();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
