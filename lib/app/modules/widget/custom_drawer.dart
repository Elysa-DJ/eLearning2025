import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  const CustomDrawer({
    required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/3769021/pexels-photo-3769021.jpeg',
              ),
            ),
            accountName: Text(
              controller.currentUser?.name ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              controller.currentUser?.email ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Accueil'),
                  onTap: () => Get.toNamed('/home-page'),
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Mes cours'),
                  onTap: () => Get.toNamed('/course'),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Mon profil'),
                  onTap: () => Get.toNamed('/profile'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Paramètres'),
                  onTap: () => Get.toNamed('/settings'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: const Text(
                    'Déconnexion',
                    style: TextStyle(
                      color: Colors.red,
            
                    ),
                  ),
                  onTap: () {
                    // Handle logout
                    controller.logout();
                    print('logout');

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}