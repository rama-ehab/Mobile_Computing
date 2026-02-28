import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primaryColor: Colors.lightBlue[300],
        scaffoldBackgroundColor: Colors.grey[100],
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlueAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: const TodoPage(),
    );
  }
}

class Todo {
  String title;
  bool isDone;

  Todo({required this.title, this.isDone = false});
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Todo> todos = [];
  final TextEditingController controller = TextEditingController();

  void addTodo() {
    if (controller.text.isEmpty) return;

    setState(() {
      todos.add(Todo(title: controller.text));
      controller.clear();
    });
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.lightBlue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input field
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter a new task',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: addTodo, child: const Text('Add')),
              ],
            ),
            const SizedBox(height: 20),

            // Task count
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tasks: ${todos.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Todo list
            Expanded(
              child: todos.isEmpty
                  ? const Center(
                      child: Text(
                        'No tasks yet',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return Dismissible(
                          key: Key(todo.title + index.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: const EdgeInsets.only(right: 20),
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) => deleteTodo(index),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: todo.isDone,
                                onChanged: (_) => toggleTodo(index),
                                activeColor: Colors.lightBlue[300],
                              ),
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                  decoration: todo.isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: todo.isDone
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                            ),
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

// import 'package:flutter/material.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Todo App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const TodoPage(),
//     );
//   }
// }

// class Todo {
//   String title;
//   bool isDone;

//   Todo({required this.title, this.isDone = false});
// }

// class TodoPage extends StatefulWidget {
//   const TodoPage({super.key});

//   @override
//   State<TodoPage> createState() => _TodoPageState();
// }

// class _TodoPageState extends State<TodoPage> {
//   final List<Todo> todos = [];
//   final TextEditingController controller = TextEditingController();

//   void addTodo() {
//     if (controller.text.isEmpty) return;

//     setState(() {
//       todos.add(Todo(title: controller.text));
//       controller.clear();
//     });
//   }

//   void toggleTodo(int index) {
//     setState(() {
//       todos[index].isDone = !todos[index].isDone;
//     });
//   }

//   void deleteTodo(int index) {
//     setState(() {
//       todos.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todo App'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: controller,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter a new task',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: addTodo,
//                   child: const Text('Add'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: todos.isEmpty
//                 ? const Center(
//                     child: Text(
//                       'No tasks yet',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: todos.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         leading: Checkbox(
//                           value: todos[index].isDone,
//                           onChanged: (_) => toggleTodo(index),
//                         ),
//                         title: Text(
//                           todos[index].title,
//                           style: TextStyle(
//                             decoration: todos[index].isDone
//                                 ? TextDecoration.lineThrough
//                                 : TextDecoration.none,
//                           ),
//                         ),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => deleteTodo(index),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
