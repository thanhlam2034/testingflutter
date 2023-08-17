// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:testingflutter/main.dart';

void main() {
  testWidgets('Add and remote a todo', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoList());

    await tester.enterText(find.byType(TextField), 'hi');

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pump();

    expect(find.text('hi'), findsOneWidget);

    await tester.drag(find.byType(Dismissible), const Offset(500, 0));

    await tester.pumpAndSettle();

    expect(find.text('hi'), findsNothing);
  });
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'TodoList';
  final todos = <String>[];
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _appTitle,
        home: Scaffold(
            appBar: AppBar(title: const Text(_appTitle)),
            body: Column(children: [
              TextField(
                controller: controller,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return Dismissible(
                      key: Key('$todo$index'),
                      onDismissed: (direction) => todos.removeAt(index),
                      background: Container(color: Colors.red),
                      child: ListTile(title: Text(todo)),
                    );
                  },
                ),
              ),
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  todos.add(controller.text);
                  controller.clear();
                });
              },
              child: const Icon(Icons.add),
            )));
  }
}
