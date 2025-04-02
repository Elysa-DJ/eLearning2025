import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu Principal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text('Cours'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ExpansionTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Année Scolaire'),
            children: [
              ListTile(title: Text('2023-2024'), onTap: () {}),
              ListTile(title: Text('2022-2023'), onTap: () {}),
              ListTile(title: Text('2021-2022'), onTap: () {}),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.school),
            title: Text('Cycle'),
            children: [
              ListTile(title: Text('Primaire'), onTap: () {}),
              ListTile(title: Text('Collège'), onTap: () {}),
              ListTile(title: Text('Lycée'), onTap: () {}),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.class_),
            title: Text('Classe'),
            children: [
              ListTile(title: Text('1ère Année'), onTap: () {}),
              ListTile(title: Text('2ème Année'), onTap: () {}),
              ListTile(title: Text('3ème Année'), onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
