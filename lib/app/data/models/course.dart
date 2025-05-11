class Course {
  final String idCours;
  final String titre;
  final String? imageUrl;
  final double? rating;
  final String? description;
  final String? instructor;
  final List<String> categories;
  final int? students;
  final double? price;
  final List<Chapter>? chapters;

  // Calculate total course duration based on chapters' learning time
  int get duration {
    if (chapters == null) return 0;
    return chapters!.fold(0, (sum, chapter) => sum + chapter.learningTime);
  }

  Course({
    required this.idCours,
    required this.titre,
    this.imageUrl,
    this.rating,
    this.description,
    this.instructor,
    this.categories = const [],
    this.students,
    this.price,
    this.chapters,
  });
}

class Chapter {
  final String title;
  final String description;
  final List<Section> sections;
  final int learningTime; // in minutes

  Chapter({
    required this.title,
    required this.description,
    this.sections = const [],
    required this.learningTime,
  });
}

class Section {
  final String title;
  final String description;
  final String? videoUrl;
  final String? pdfUrl;

  Section({
    required this.title,
    required this.description,
    this.videoUrl,
    this.pdfUrl,
  });
}