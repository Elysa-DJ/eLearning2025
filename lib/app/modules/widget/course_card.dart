import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/course.dart';
import '../course_details/views/course_details_view.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double rating;
  final String courseId;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.courseId,
    this.onTap,
  });

  @override
   Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Create a sample course for demonstration
        final course = Course(
          idCours: courseId,
          titre: title,
          imageUrl: imageUrl,
          rating: rating,
          description: 'Ce cours vous apprendra les bases essentielles pour devenir un développeur compétent.',
          instructor: 'John Doe',
          categories: ['Développement', 'Web'],
          students: 1234,
          price: 49.99,
          chapters: [
            Chapter(
              id: 'chapter1',
              title: 'Introduction aux technologies web',
              description: 'Vue d\'ensemble des technologies web modernes',
              learningTime: 60,
              sections: [
                Section(
                  title: 'HTML5 Fondamentaux',
                  description: 'Les bases de HTML5',
                  videoUrl: 'assets/video/[@AnimesGratuit] The Eminence in Shadow S02EP04 VF.mp4',
                  pdfUrl: 'https://www.tresfacile.net/doc/python/python-tres-facile-preview.pdf', // Chemin d'asset correctement formaté
                ),
                Section(
                  title: 'CSS3 Essentiels',
                  description: 'Introduction à CSS3',
                  videoUrl: 'https://example.com/css3.mp4',
                  pdfUrl: 'https://example.com/css3.pdf',
                ),
              ],
            ),
            Chapter(
              id: 'chapter2',
              title: 'JavaScript Moderne',
              description: 'Les fondamentaux de JavaScript',
              learningTime: 90,
              sections: [
                Section(
                  title: 'Variables et Types',
                  description: 'Comprendre les variables en JavaScript',
                  videoUrl: 'https://example.com/js-basics.mp4',
                  pdfUrl: 'https://example.com/js-basics.pdf',
                ),
              ],
            ),
          ],
        );
        
        Get.to(() => CourseDetailsView(course: course));
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.error_outline, color: Colors.grey),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 120,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / 
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
   
}