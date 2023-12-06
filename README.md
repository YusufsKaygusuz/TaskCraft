# TaskCraft
<img src="https://github.com/YusufsKaygusuz/TaskCraft/assets/86704802/8fdde664-cd74-4dc1-91cb-016e7103320c" alt="TaskCraft" width="250"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/YusufsKaygusuz/TaskCraft/assets/86704802/89b08d7a-823d-43a3-97be-8fd6cae879e4" alt="TaskCraft" width="250"/>





<p align="center">
    <img src="https://img.shields.io/badge/made%20with-Dart-blue" alt="Made with Dart">
    <img src="https://img.shields.io/badge/made%20with-Flutter-blue" alt="Made with Flutter">
</p>


# TaskCraft ToDo Uygulaması Dizin Yapısı

| Klasör       | Dart Dosyası         |
|--------------|----------------------|
| constants    | colors.dart          |
| model        | todo.dart            |
| screens      | home.dart            |
| widgets      | todo_item.dart       |
| main.dart                           |


<h2>colors.dart</h2>

Bu dosya, TaskCraft ToDo uygulamasında kullanılan renk temalarını içeren Flutter projesindeki bir sabit dosyadır. Renkler genellikle uygulama boyunca kullanılan temel renkleri temsil eder. Aşağıda tanımlanan bazı renkler bulunmaktadır:

 ```dart
  import 'package:flutter/material.dart';
  
  const Color toDoRed = Color(0xFFDA4040);
  const Color toDoBlue = Color(0xFF5F52EE);
  const Color toDoBlack = Color(0xFF3A3A3A);
  const Color toDoGtey = Color(0xFF717171);
  const Color toDoBackGround = Color(0xFFEEEFF5);
 ```

<h2>todo.dart</h2>
ToDo sınıfı, bir görevin temsilini sağlar. Her görev, bir kimlik (id), görev metni (todoText), ve görevin tamamlanıp tamamlanmadığını belirten bir durum (isDone) içerir. Görev oluşturulurken, id ve todoText parametreleri zorunlu (required), isDone parametresi ise varsayılan olarak false olarak ayarlanmıştır.

 ```dart
class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });
}
 ```
Ayrıca, sınıfın içinde bulunan todoList metodu, uygulama başlangıcında kullanılmak üzere önceden tanımlanmış bir görev listesi oluşturur. Bu görev listesi, ToDo sınıfından örnekler içerir ve varsayılan olarak bazı görevleri içerir.

 ```dart
static List<ToDo> todoList() {
  return [
    ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
    ToDo(id: '02', todoText: 'Check Emails', isDone: true),
    ToDo(id: '03', todoText: 'Team Meeting',),
    ToDo(id: '04', todoText: 'Work on Back-End for 2 hours', ),
    ToDo(id: '05', todoText: 'Dinner Plan with best friends', isDone: true),
  ];
}
 ```
 Bu metot, uygulamanın başlangıcında kullanılacak örnek bir görev listesi sağlar. Her bir görev, önceden belirlenmiş bir kimlik, metin ve tamamlanma durumu ile temsil edilir.

<h2>home.dart</h2>
Ana Ekran (Home Widget)
Ana ekran, kullanıcının ToDo listesini görüntüleyebileceği, yeni görevler ekleyebileceği ve mevcut görevleri işaretleyip silebileceği bir arayüz sunar. Ekran, Scaffold widget'ı içinde düzenlenmiştir.

<h3>ToDo Listesi ve Arama:</h3>

ToDo sınıfından oluşturulan todoList değişkeni, varsayılan görev listesini içerir.
_foundToDo değişkeni, kullanıcının arama yapması durumunda gösterilecek görev listesini içerir.
searchBox metodu, kullanıcının görevleri aramasını sağlayan bir arama kutusunu oluşturur.

 ```dart
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
 ```

<h3>Görevleri Gösterme ve Yönetme:</h3>

ListView.builder widget'ı kullanılarak görev listesi ekrana yerleştirilir. Görevler, _foundToDo listesinden alınır.
Her görev, ToDoItem widget'ı içinde gösterilir. Bu widget, bir görevin metni, durumu ve işlem butonları içerir.
_handleToDoChange metodu, bir görevin durumunu değiştirir (tamamlandı ise tamamlanmamış, tamamlanmamış ise tamamlandı yapar).
_deleteToDoItem metodu, bir görevi listeden siler.
Yeni Görev Ekleme:

Bir TextField widget'ı, kullanıcının yeni görev eklemesini sağlar.
+ butonuna basıldığında _addToDoItem metodu çalışır ve yeni görevi listeye ekler.
Arama Yapma:

searchBox içindeki arama kutusuna her yazıldığında _runFilter metodu çağrılır. Bu metot, girilen anahtar kelimeye göre görevleri filtreler.
```dart
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
```

<h3>AppBar ve Tema:</h3>

 ```dart
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
 ```

AppBar, uygulama başlığını ve kullanıcı avatarını içerir.
Uygulama teması, colors.dart dosyasından alınan renk sabitleriyle belirlenir.



👨‍💻 Keyifli Kodlamalar! 👩‍💻

<h3 align="center">Connect with me:</h3>
<p align="center">
<a href="https://www.linkedin.com/in/yusuf-sami-kaygusuz-69b992230" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="yusuf-kaygusuz-69b992230" height="30" width="40" /></a>
<a href="https://instagram.com/yusufskaygusuz" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/instagram.svg" alt="yusufskaygusuz" height="30" width="40" /></a>
<a href="https://medium.com/@yusufskaygusuz" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/medium.svg" alt="@yusufskaygusuz" height="30" width="40" /></a>
</p>
