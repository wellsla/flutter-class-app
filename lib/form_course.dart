import 'package:flutter/material.dart';

class FormCourse extends StatefulWidget {
  const FormCourse({super.key});

  @override
  State<FormCourse> createState() => _FormCourseState();
}

class _FormCourseState extends State<FormCourse> {
  TextEditingController textNameController = TextEditingController();
  TextEditingController textDescController = TextEditingController();
  TextEditingController textStartAtController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulário")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Preencha o nome do curso"),
                controller: textNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null; //válido!
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Preencha a descrição do curso",
                ),
                controller: textDescController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null; //válido!
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(hintText: "Preencha data do curso"),
                controller: textStartAtController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null; //válido!
                },
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(onPressed: () {
                  if (formKey.currentState!.validate()){
                    //salvar os dados
                    
                  }
                }, child: Text("Salvar")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
