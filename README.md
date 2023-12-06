# TaskCraft
<img src="https://github.com/YusufsKaygusuz/TaskCraft/assets/86704802/8fdde664-cd74-4dc1-91cb-016e7103320c" alt="TaskCraft" width="250"/>

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











