import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject/constants/appcolor.dart';
import '../models/taskmodel.dart';

class OngoingTaskCard extends StatelessWidget {
  final TaskModel task;

  const OngoingTaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPending = task.status == TaskStatus.notStarted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.title,
          style: GoogleFonts.poppins(
            color: AppColors.success,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            '${(task.progress * 100).toInt()}% Done',
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Text('Status: ', style: TextStyle(fontWeight: FontWeight.w500)),
            Text(
              isPending ? 'Pending Task' : 'Ongoing Task',
              style: TextStyle(
                color: isPending ? AppColors.warning :AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(isPending ? 'Assigned date: ' : 'Start date: ',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            Text(
              _formatDate(task.dueDate.subtract(const Duration(days: 30))),
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
        Row(
          children: [
            Text(isPending ? 'Due date: ' : 'Expected completion: ',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
            Text(_formatDate(task.dueDate), style: GoogleFonts.poppins()),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Text('Priority: ', style: TextStyle(fontWeight: FontWeight.w500)),
            Text(
              task.priority.name[0].toUpperCase() + task.priority.name.substring(1),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: task.priority == TaskPriority.high
                    ? AppColors.warning
                    : task.priority == TaskPriority.medium
                    ? AppColors.warning
                    :AppColors.success
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                // handle action
              },
              child: Text(
                isPending ? 'Start task' : 'Make as Done',
                style: GoogleFonts.poppins(color: AppColors.white),
              ),
            ),
          ],
        ),
        const Divider(thickness: 0.7, height: 28),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }
}
