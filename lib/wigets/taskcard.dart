import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject/constants/appcolor.dart';
import '../models/taskmodel.dart';

class MyTaskCard extends StatelessWidget {
  final TaskModel task;

  const MyTaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> descriptionPoints = _getDescriptions(task.title);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: 4),

          ...descriptionPoints.map(
                (desc) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• ", style: TextStyle(fontSize: 16, height: 1.6)),
                Expanded(
                  child: Text(
                    desc,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.greyshade700,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Start task logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Start',
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  color:AppColors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),
          const Divider(thickness: 0.7, color: Colors.grey),
        ],
      ),
    );
  }

  List<String> _getDescriptions(String title) {
    switch (title.toLowerCase()) {
      case 'ui/ux design implementation':
        return [
          'Translating wireframes into responsive designs.',
          'Using HTML, CSS, and JavaScript effectively.',
          'Ensuring brand consistency in UI components.',
          'Collaborating with designers for feedback.',
        ];
      case 'responsive design':
        return [
          'Optimizing layout for all screen sizes.',
          'Using media queries and flex layouts.',
          'Maintaining a seamless user experience.',
          'Testing on multiple devices and browsers.',
        ];
      case 'back-end development':
        return [
          'Building robust RESTful APIs.',
          'Managing authentication and data access.',
          'Structuring relational databases effectively.',
          'Integrating backend with frontend systems.',
        ];
      case 'server-side logic':
        return [
          'Writing logic for processing requests.',
          'Handling user sessions and tokens.',
          'Ensuring scalability and security.',
          'Logging and error handling best practices.',
        ];
      default:
        return [
          'Task detail point one.',
          'Task detail point two.',
          'Task detail point three.',
          'Task detail point four.',
        ];
    }
  }
}
