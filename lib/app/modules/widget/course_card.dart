import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double rating;

  const CourseCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.rating = 5.0,
  }) : super(key: key);

  static List<Map<String, dynamic>> getCourses() {
    return [
      {"title": "Cours de physique-Chimie", "imageUrl": "assets/physiquechimie.jpg", "rating": 4.5},
      {"title": "Cours de mathématiques", "imageUrl": "assets/maths1.jpg", "rating": 5.0},
      {"title": "Cours de biologie", "imageUrl": "assets/biologie.jpg", "rating": 4.2},
      {"title": "Cours d'informatique", "imageUrl": "assets/informatique.jpg", "rating": 4.8},
      {"title": "Cours de physique-Chimie", "imageUrl": "assets/physiquechimie.jpg", "rating": 4.5},
      {"title": "Cours de mathématiques", "imageUrl": "assets/maths2.jpg", "rating": 5.0},
      {"title": "Cours de biologie", "imageUrl": "assets/biologie.jpg", "rating": 4.2},
      {"title": "Cours d'informatique", "imageUrl": "assets/informatique.jpg", "rating": 4.8},
    ];
  }

  static Widget buildCourseList() {
    final courses = getCourses();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: courses.map((course) {
            return CourseCard(
              title: course["title"],
              imageUrl: course["imageUrl"],
              rating: course["rating"],
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
       child: SingleChildScrollView(  // Envelopper dans SingleChildScrollView
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              imageUrl,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: index < rating.round() ? Colors.amber : Colors.grey,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
  }
}
