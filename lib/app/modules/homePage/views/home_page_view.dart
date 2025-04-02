import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/course_card.dart';
import '../controllers/home_page_controller.dart';
import '../../widget/categories.dart';

// Ajout du fichier CustomDrawer
import '../../widget/custom_drawer.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryListInstance = CategoryList();
    final courses = CourseCard.getCourses();

    return Scaffold(
      appBar: AppBar(
        title: Text("Accueil"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu), // Bouton pour ouvrir le Drawer
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Ajouter action de recherche
            },
          ),
        ],
      ),
      drawer: CustomDrawer(), // Appel du Drawer ici
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/student.jpg', // Remplace par ton image
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Des cours accessibles sur cette plateforme",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Que souhaitez-vous apprendre",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Catégories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
                
                child: ListView.builder(
                  
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryListInstance.categoriesList.length,
                  itemBuilder: (context, index) {
                    final category = categoryListInstance.categoriesList[index];
                    return CategoryChip(
                      label: category["label"],
                      color: category["color"],
                    );
                  },
                )

              ),
              
              SizedBox(height: 20),
              Text(
                "Les derniers cours",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return CourseCard(
                      title: course["title"],
                      imageUrl: course["imageUrl"],
                      rating: course["rating"],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
