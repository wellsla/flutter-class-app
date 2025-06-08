import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterapp/form_course.dart';
import 'package:flutterapp/models/course_model.dart';
import 'package:flutterapp/repository/course_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = CourseRepository();
  late Future<List<CourseModel>> futureCourseList;

  Future<List<CourseModel>> getCourses() async {
    return await repository.getAll();
  }

  @override
  void initState() {
    futureCourseList = getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Cursos'),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu de Navegação',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Novo Curso'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormCourse()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Feriados'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/feriados');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: futureCourseList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum curso encontrado."));
          }

          final courses = snapshot.data!;
          return buildCourseList(courses);
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

  Widget buildCourseList(List<CourseModel> courses) {
    return ListView.builder(
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
    );
  }
}
