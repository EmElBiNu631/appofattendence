import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:miniproject/constants/appcolor.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../viewmodel/attendenceviewmodel.dart';

class AttendanceCalendarView extends StatelessWidget {
  const AttendanceCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AttendanceCalendarViewModel(),
      child: const AttendanceCalendarContent(),
    );
  }
}

class AttendanceCalendarContent extends StatelessWidget {
  const AttendanceCalendarContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AttendanceCalendarViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColors.black),
        title: Text(
          'Attendance Calendar',
          style: GoogleFonts.poppins(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2025, 1, 1),
                    lastDay: DateTime.utc(2025, 12, 31),
                    focusedDay: viewModel.focusedDay,
                    selectedDayPredicate: (day) =>
                        isSameDay(viewModel.selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      viewModel.onDaySelected(selectedDay, focusedDay);
                      _showAttendancePicker(context, selectedDay);
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppColors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        final status = viewModel.getAttendanceStatus(day);
                        if (status != null) {
                          Color bgColor;
                          switch (status) {
                            case 'Present':
                              bgColor = AppColors.success;
                              break;
                            case 'Absent':
                              bgColor = AppColors.redaccent;
                              break;
                            case 'Leave':
                              bgColor = AppColors.warning;
                              break;
                            case 'Holiday':
                              bgColor = AppColors.purple;
                              break;
                            default:
                              bgColor = AppColors.grey;
                          }
                          return Center(
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: bgColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${day.day}',
                                  style:
                                  const TextStyle(color: AppColors.white),
                                ),
                              ),
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildAttendanceOverview(),
              const SizedBox(height: 16),
              _buildSelectedDateDetails(viewModel),
              const SizedBox(height: 20),
              _buildLegend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceOverview() {
    final int present = 20;
    final int absent = 3;
    final int leaves = 2;
    final int lop = 6;

    final total = present + absent + leaves + lop;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Overview", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text("Total Days: $total", style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: [
                PieChartSectionData(value: present.toDouble(), color:AppColors.success, title: "$present\nDays", radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                PieChartSectionData(value: absent.toDouble(), color: AppColors.redaccent, title: "$absent\nDays", radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                PieChartSectionData(value: leaves.toDouble(), color: AppColors.warning, title: "$leaves\nDays", radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                PieChartSectionData(value: lop.toDouble(), color: AppColors.blue, title: "$lop\nDays", radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedDateDetails(AttendanceCalendarViewModel viewModel) {
    final DateTime selected = viewModel.selectedDay ?? DateTime.now();
    final status = viewModel.getAttendanceStatus(selected) ?? "None";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat('MMMM dd, yyyy').format(selected), style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text("Status:", style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: const TextStyle(color: Colors.green)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.login, color: AppColors.success),
              SizedBox(width: 6),
              Text("Check-in: 09:30 AM"),
              Spacer(),
              Icon(Icons.logout, color: AppColors.redaccent),
              SizedBox(width: 6),
              Text("Check-out: 06:00 PM"),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _infoChip("Work Mode", "Office", AppColors.blue)),
              const SizedBox(width: 12),
              Expanded(child: _infoChip("Verification", "Selfie", AppColors.warning)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.location_pin, size: 18, color: AppColors.danger),
              SizedBox(width: 6),
              Text("Lat: 13.05, Long: 80.24", style: TextStyle(color: AppColors.black54)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.grey50, border: Border.all(color: AppColors.grey300), borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.note_alt_outlined, color: AppColors.black54),
                SizedBox(width: 8),
                Expanded(child: Text("Worked on UI Bug Fixing", style: TextStyle(color: AppColors.black87))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.black54)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Legend", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _legendItem(AppColors.success, "Present"),
            _legendItem(AppColors.redaccent, "Absent"),
            _legendItem(AppColors.warning, "Leave"),
            _legendItem(AppColors.purple, "Holiday"),
          ],
        ),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }

  void _showAttendancePicker(BuildContext context, DateTime date) {
    final viewModel = Provider.of<AttendanceCalendarViewModel>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 16, top: 20, left: 16, right: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Mark Attendance", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    _attendanceOption(context, "Present", AppColors.success, date),
                    _attendanceOption(context, "Absent", AppColors.redaccent, date),
                    _attendanceOption(context, "Leave", AppColors.warning, date),
                    _attendanceOption(context, "Holiday", AppColors.purple, date),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: AppColors.black54)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _attendanceOption(BuildContext context, String label, Color color, DateTime date) {
    final viewModel = Provider.of<AttendanceCalendarViewModel>(context, listen: false);

    return GestureDetector(
      onTap: () {
        viewModel.markAttendance(date, label);
        Navigator.pop(context);
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12), border: Border.all(color: color)),
        child: Column(
          children: [
            Icon(Icons.check_circle, color: color, size: 24),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
