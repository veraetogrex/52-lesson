import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/main.dart'; // Путь к твоему основному файлу

void main() {
  testWidgets('Test task manager app', (WidgetTester tester) async {
    // Строим виджет приложения
    await tester.pumpWidget(MyApp());

    // Проверяем, что текстовое поле для ввода задачи есть на экране
    expect(find.byType(TextField), findsOneWidget);

    // Проверяем, что кнопка "Add Task" есть на экране
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Вводим задачу в текстовое поле
    await tester.enterText(find.byType(TextField), 'Test Task 1');
    
    // Нажимаем кнопку для добавления задачи
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Обновляем виджет

    // Проверяем, что задача добавлена в список
    expect(find.text('Test Task 1'), findsOneWidget);

    // Нажимаем на кнопку редактирования
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump(); // Обновляем виджет

    // Проверяем, что текстовое поле в диалоге содержит текущий текст задачи
    expect(find.byType(TextField), findsOneWidget);

    // Вносим изменения в задачу и сохраняем
    await tester.enterText(find.byType(TextField), 'Updated Test Task 1');
    await tester.tap(find.text('Save'));
    await tester.pump();

    // Проверяем, что задача обновилась
    expect(find.text('Updated Test Task 1'), findsOneWidget);

    // Нажимаем на кнопку удаления задачи
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Проверяем, что задача была удалена из списка
    expect(find.text('Updated Test Task 1'), findsNothing);
  });
}
