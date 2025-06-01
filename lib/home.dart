import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterapp/form_course.dart';
import 'package:flutterapp/models/course_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CourseModel> courses = [
    CourseModel(
      id: '1',
      name: 'Curso 1',
      description: 'curso de ads',
      startAt: '01/01/2025',
    ),
    CourseModel(
      id: '2',
      name: 'Curso 2',
      description: 'curso de cc',
      startAt: '01/01/2025',
    ),
    CourseModel(
      id: '3',
      name: 'Curso 3',
      description: 'curso de eng compt',
      startAt: '01/01/2025',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de cursos")),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {},
                    icon: Icons.edit,
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.black,
                    label: "Editar",
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    label: "Excluir",
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(child: Text("CC")),
                title: Text(courses[index].name ?? ''),
                subtitle: Text(courses[index].description ?? ''),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormCourse()),
          );
        },
      ),
    );
  }
}
