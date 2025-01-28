import 'package:flutter/material.dart';
import 'dart:io' as io;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskManager(),
    );
  }
}

class TaskManager extends StatefulWidget {
  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  List<String> tasks = []; // Список для хранения задач
  TextEditingController controller = TextEditingController();

  // Функция для добавления задачи
  void addTask() {
    setState(() {
      tasks.add(controller.text);
    });
    controller.clear(); // Очищаем поле ввода
  }

  // Функция для редактирования задачи
  void editTask(int index) {
    controller.text = tasks[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Task"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Enter new task"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                tasks[index] = controller.text;
              });
              controller.clear();
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  // Функция для удаления задачи
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Текстовое поле для ввода задачи
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Enter Task",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Кнопка для добавления задачи
            ElevatedButton(
              onPressed: addTask,
              child: Text("Add Task"),
            ),
            SizedBox(height: 20),
            // Список задач
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Кнопка редактирования задачи
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => editTask(index),
                        ),
                        // Кнопка удаления задачи
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTask(index),
                        ),
                      ],
                    ),
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
