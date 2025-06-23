import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniproject/models/taskmodel.dart';

class TaskTrackerCard extends StatelessWidget {
  final TaskModel task;

  const TaskTrackerCard({Key? key, required this.task}) : super(key: key);

  String formatEnum(Object e) {
    final name = e.toString().split('.').last;
    return name[0].toUpperCase() + name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final dueDateStr =
        "${task.dueDate.day.toString().padLeft(2, '0')}-${task.dueDate.month.toString().padLeft(2, '0')}-${task.dueDate.year}";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Due: $dueDateStr",
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              Text("Status:", style: GoogleFonts.poppins(fontSize: 12)),
              ...TaskStatus.values.map(
                    (s) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle,
                        size: 10,
                        color: s == task.status ? Colors.green : Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      formatEnum(s),
                      style: GoogleFonts.poppins(fontSize: 11),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          value: task.progress / 100,
                          strokeWidth: 4,
                          color: Colors.green,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                      Text(
                        "${task.progress.toInt()}%",
                        style: GoogleFonts.poppins(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    "2 days remaining",
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: Colors.orange),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.edit, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    "Assigned By (optional)",
                    style: GoogleFonts.poppins(fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            children: [
              Text("Priority:", style: GoogleFonts.poppins(fontSize: 12)),
              ...TaskPriority.values.map(
                    (p) => Text(
                  formatEnum(p),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: p == task.priority
                        ? (p == TaskPriority.low
                        ? Colors.green
                        : p == TaskPriority.medium
                        ? Colors.orange
                        : Colors.red)
                        : Colors.grey,
                    fontWeight: p == task.priority
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),

          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 8,
            spacing: 16,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.circle, size: 10, color: Colors.green),
                  const SizedBox(width: 6),
                  Text("Start", style: GoogleFonts.poppins(fontSize: 12)),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.circle, size: 10, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text("Update", style: GoogleFonts.poppins(fontSize: 12)),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.circle, size: 10, color: Colors.teal),
                  const SizedBox(width: 6),
                  Text("Complete", style: GoogleFonts.poppins(fontSize: 12)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(thickness: 0.6),
        ],
      ),
    );
  }
}
