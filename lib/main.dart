import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo Manager',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todos = [];
  String newTodo = '';

  void addTodo() {
    if (newTodo.length > 0) {
      setState(() {
        todos.add(newTodo);
        newTodo = '';
      });
    }
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void markComplete(int index) {
    setState(() {
      // Toggle completion status of todo at given index
      if (todos[index].startsWith('✓ ')) {
        todos[index] = todos[index].substring(2);
      } else {
        todos[index] = '✓ ' + todos[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Add a new todo...'),
                    onChanged: (value) {
                      setState(() {
                        newTodo = value;
                      });
                    },
                    onSubmitted: (value) {
                      addTodo();
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  child: Text('Add'),
                  onPressed: () {
                    addTodo();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(todos[index]),
                  onDismissed: (direction) {
                    deleteTodo(index);
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: todos[index].startsWith('✓ '),
                      onChanged: (value) {
                        markComplete(index);
                      },
                    ),
                    title: Text(todos[index]),
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
