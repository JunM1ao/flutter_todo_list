import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _todos = [];
  String _input = '';

  // Code Reference: https://flutter.dev/docs/cookbook/persistence/key-value

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _todos = (prefs.getStringList('todo') ?? []);
    });
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList('todo', _todos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),

        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              title: const Text('Add New Todo'),
              content: TextField(
                onChanged: (String value) {
                  _input = value;
                },
              ),

              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      setState(() {
                        _todos.add(_input);
                        _input = '';
                        Navigator.of(context).pop();
                        _saveData();
                      });
                    },
                    child: const Text('Add')
                )
              ],
            );

          });
        },
      ),
      body: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (BuildContext context, int index) {

            return Dismissible(
              background: Container(color: Colors.redAccent),
              key: Key(_todos[index]),

              onDismissed: (direction) {
                setState(() {
                  _todos.removeAt(index);
                  _saveData();
                });
              },

              child: Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 6.0
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                child: ListTile(
                  title: Text(_todos[index]),
                ),
              ),
            );

          }),
    );
  }
}
