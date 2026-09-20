import 'package:flutter/material.dart';

void main() => runApp(const FormExample());

class FormExample extends StatelessWidget {
  const FormExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Form and Navigation Example",
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Form and Navigation Example"),),
        ),
        body: Center(child: FormWidget(),),
      ),
    );
  }
}


class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => FormWidgetState();
}

class FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: "Ammar Afzal",
                labelText: "Full Name",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter full name";
                }
                return null;
              },
              onSaved: (value) => value != null ? _name = value : null
              ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                hintText: "xyz@gmail.com",
                labelText: "Email Address",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter email";
                }
                final regexEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);
                if (!regexEmail.hasMatch(value)){
                  return "Please enter correct email address";
                }
                return null;
              },
              onSaved: (value) => value != null ? _email = value : null
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Form submitted successfully."),
                        duration: const Duration(seconds: 3),)
                    );
                  }
                }, 
                child: Text("Submit"))
            ],
          )
        ),
      );
  }


}