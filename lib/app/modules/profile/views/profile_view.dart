import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});
 @override
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Obx(() => ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildSection(
                    icon: FeatherIcons.book,
                    title: 'My Courses',
                    color: const Color(0xFF3B82F6),
                    child: _buildCourses(),
                  ),
                  _buildSection(
                    icon: FeatherIcons.award,
                    title: 'Achievements',
                    color: const Color(0xFF8B5CF6),
                    child: _buildMessage('Complete courses to earn achievements'),
                  ),
                  _buildSection(
                    icon: FeatherIcons.clock,
                    title: 'Learning Activity',
                    color: const Color(0xFF10B981),
                    child: _buildMessage('Your learning statistics will appear here'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(FeatherIcons.settings, color: Color(0xFF6B7280)),
                      label: const Text(
                        'Settings',
                        style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
          ),
          const Text(
            'john.doe@example.com',
            style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 16),
          Obx(() {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat('Courses', controller.enrollments.length.toString()),
                  Container(width: 1, height: 40, color: const Color(0xFFD1D5DB)),
                  _buildStat('Completed', '8'),
                  Container(width: 1, height: 40, color: const Color(0xFFD1D5DB)),
                  _buildStat('Average', '92%'),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required Color color,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildMessage(String message, {bool isError = false}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: isError ? const Color(0xFFEF4444) : const Color(0xFF6B7280),
        ),
      ),
    );
  }

  Widget _buildCourses() {
    if (controller.loading.value) {
      return _buildMessage('Loading your courses...');
    } else if (controller.error.isNotEmpty) {
      return _buildMessage(controller.error.value, isError: true);
    } else if (controller.enrollments.isEmpty) {
      return _buildMessage('You are not enrolled in any courses yet.');
    } else {
      return Column(
        children: controller.enrollments
            .map((e) => _buildEnrollmentCard(e['title']))
            .toList(),
      );
    }
  }

  Widget _buildEnrollmentCard(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Color(0xFF1F2937), fontWeight: FontWeight.w500),
      ),
    );
  }
}
