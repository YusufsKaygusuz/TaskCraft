import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../widgets/todo_item.dart';
import '../constants/colors.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: toDoBackGround,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                searchBox(),
                SizedBox(height: 20),
                Text(
                  'Bütün Yapılacaklar',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (ToDo todo in _foundToDo.reversed)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                      child: ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeletedItem: _deleteToDoItem,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Yeni bir görev ekle',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: toDoBlue,
                    minimumSize: const Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id)
  {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo)
  {
    setState(() {
      todoList.add(
        ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(),
        todoText: toDo)
      );
      _todoController.clear();
    });
  }

void _runFilter(String enteredKeyword)
{
  List<ToDo> results = [];
  if(enteredKeyword.isEmpty)
  {
    results = todoList;
  }
  else{
    results = todoList
    .where((item) => item.todoText!
    .toLowerCase()
    .contains(enteredKeyword.toLowerCase()))
    .toList();
  }

  setState(() {
    _foundToDo = results;
  });
}


  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: toDoBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 30,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: toDoGtey)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: toDoBackGround,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: toDoBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.JPG'),
            ),
          )
        ],
      ),
    );
  }
}
