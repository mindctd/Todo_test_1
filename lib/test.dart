import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<String> _item = [];
  final List<bool> _checked = [];
  final TextEditingController _controller = TextEditingController();

  void addItem() {
    setState(() {
      if (_controller.text.trim().isNotEmpty) {
        _item.add(_controller.text.trim());
        _checked.add(false);
        _controller.clear();
      }
    });
  }

  void deleteItem(int index) {
    setState(() {
      _item.removeAt(index);
      _checked.removeAt(index);
    });
  }

  void toggleCheck(int index, bool? value) {
    setState(() {
      _checked[index] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.list),
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            const Text(
              "Todoey",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Enter the List",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _item.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Checkbox(
                            value: _checked[index],
                            onChanged: (value) => toggleCheck(index, value),
                          ),
                          title: Text(_item[index]),
                          trailing: IconButton(
                            onPressed: () => deleteItem(index),
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
