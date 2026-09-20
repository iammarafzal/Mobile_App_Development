import 'package:flutter/material.dart';

void main() => runApp(const ProfileScreen());
    
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Screen',
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Profile Screen'),
          ) ,
        ),
        body: Padding(padding: EdgeInsets.all(20),
        child: 
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(150.0),
                  child: Image.asset(
                    'assets/ammar-afzal.jpg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                )
              ]
            ),
            Row(
              children: [
                Text('Name:'),
                SizedBox(width: 16,),
                Text("Ammar Afzal")
              ],
            ),
            Row(
              children: [
                Text('Email:'),
                SizedBox(width: 16,),
                Text("iammarafzal@gmail.com")
              ],
            ),
            Row(
              children: [
                Text('Location:'),
                SizedBox(width: 16,),
                Text("Islamabad")
              ],
            ),
            Row(
              children: [
                Text('Gender:'),
                SizedBox(width: 16,),
                Text("Male")
              ],
            )
          ],
        ),
        )
      )
    );
  }
}


