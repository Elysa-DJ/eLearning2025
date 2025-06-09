import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_page_controller.dart';
import '../../../data/models/category.dart';
import '../../widget/category_chip.dart';
import '../../widget/course_card.dart';
import '../../widget/custom_drawer.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Accueil"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Action de recherche
            },
          ),
        ],
      ),
      drawer: CustomDrawer(controller: controller),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return RefreshIndicator(
          onRefresh: controller.fetchCourses,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AspectRatio(
                        aspectRatio: 16 / 9, // format standard
                        child: Image.asset(
                          'assets/student.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                
                const Text(
                  "Des cours accessibles sur cette plateforme",
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold
                    ),
                ),
                  
                  const SizedBox(height: 20),
                  
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Que souhaitez-vous apprendre",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  const Text(
                    "Catégories",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: CategoryList().categoriesList.length,
                      itemBuilder: (context, index) {
                        final category = CategoryList().categoriesList[index];
                        return CategoryChip(
                          label: category["label"],
                          color: category["color"],
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  const Text(
                    "Les derniers cours",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.latestCourses.length,
                      itemBuilder: (context, index) {
                        final course = controller.latestCourses[index];
                        return CourseCard(
                          title: course.titre,
                          imageUrl: course.imageUrl ?? "",
                          rating: course.rating ?? 0.0,
                          courseId: course.idCours,
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  const Text(
                    "Cours populaires",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.popularCourses.length,
                      itemBuilder: (context, index) {
                        final course = controller.popularCourses[index];
                        return CourseCard(
                          title: course.titre,
                          imageUrl: course.imageUrl ?? "",
                          rating: course.rating ?? 0.0,
                          courseId: course.idCours,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}