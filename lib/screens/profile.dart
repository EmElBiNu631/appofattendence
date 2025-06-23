  import 'package:flutter/material.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:provider/provider.dart';

  import '../viewmodel/ProfilepageModel.dart';
  import '../viewmodel/homepageviewmodels.dart';
import '../wigets/puchedin.dart';
  import '../wigets/dashboard button.dart';
  import '../wigets/ongoingtask.dart';
  import '../wigets/overviewcard.dart';
  import '../wigets/punchedout.dart';
  import '../wigets/taskcard.dart';
  import '../wigets/tasktracker.dart';
  import 'faceverification.dart';
import 'leavedashboardview.dart';

  class DashboardView extends StatelessWidget {

    final String? checkinMessage;
    final String? checkoutMessage;

    const DashboardView({
      Key? key,
      this.checkinMessage,
      this.checkoutMessage,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      final homepageVm = Provider.of<HomepageViewModel>(context, listen: false);
      homepageVm.updatePunchOutTime(DateTime.now());
      return ChangeNotifierProvider(
        create: (_) => DashboardViewModel(),
        child: Consumer<DashboardViewModel>(
          builder: (context, vm, child) {
            return Scaffold(
              backgroundColor: Colors.grey.shade100,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: 0,
                onTap: vm.setTab,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
                  BottomNavigationBarItem(icon: Icon(Icons.arrow_forward), label: 'Leave'),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0F9D58), Color(0xFF1E88E5)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 26,
                              backgroundImage: AssetImage('assets/images/profile1.jpg'),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    vm.userName,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Full-stack Developer",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/images/companylogo.png',
                              height: 36,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),


                      if (vm.isCheckedIn)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5FAFF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                checkinMessage ?? '"You are Checked-In 09:00 AM"',
                                style: GoogleFonts.poppins(
                                  color: Colors.green.shade800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.5,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, color: Colors.orange, size: 20),
                                  const SizedBox(width: 6),
                                  Text(
                                    '09:20 am, 11-06-2025',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, color: Colors.redAccent, size: 20),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Location/IP (for remote attendance)',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade300,
                                        foregroundColor: Colors.black54,
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'Punched-In',
                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Show location selector dialog first
                                        showDialog(
                                          context: context,
                                          builder: (_) => PunchOutDialog(
                                            onSelect: (location) {
                                              Navigator.pop(context);
                                              vm.punchOutWithLocation(location);

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>  FaceVerificationView(isPunchingIn: false),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },

                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.logout, size: 18),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Punched-Out',
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),

                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          OverviewCard(title: "Presence", count: 20, color: Colors.green),
                          OverviewCard(title: "Absence", count: 3, color: Colors.red),
                          OverviewCard(title: "Leaves", count: 2, color: Colors.orange),
                        ],
                      ),

                      const SizedBox(height: 24),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ToggleButtons(
                          isSelected: vm.taskTabs,
                          onPressed: vm.setTaskTab,
                          borderRadius: BorderRadius.circular(12),
                          selectedColor: Colors.white,
                          fillColor: Colors.blue,
                          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text("My Tasks"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text("Task Tracker"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text("Ongoing & Upcoming"),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Text("Sort by:", style: GoogleFonts.poppins()),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Radio<int>(
                                value: 0,
                                groupValue: vm.sortOption,
                                onChanged: vm.setSortOption,
                              ),
                              Text("Deadline", style: GoogleFonts.poppins()),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<int>(
                                value: 1,
                                groupValue: vm.sortOption,
                                onChanged: vm.setSortOption,
                              ),
                              Text("Project", style: GoogleFonts.poppins()),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.filter_alt_outlined),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Column(
                        children: vm.filteredTasks.map((task) {
                          if (vm.taskTabs[0]) {
                            return MyTaskCard(task: task);
                          } else if (vm.taskTabs[1]) {
                            return TaskTrackerCard(task: task);
                          } else {
                            return OngoingTaskCard(task: task);
                          }
                        }).toList(),
                      ),

                      const SizedBox(height: 24),

                      Text("Dashboard",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),
                      const SizedBox(height: 10),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          DashboardButton(icon: Icons.calendar_month, label: "Attendance", onTap: () {  },),
                          DashboardButton(
                            icon: Icons.logout,
                            label: "Leaves",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LeaveDashboardView(cameFromDashboard: true),
                                ),
                              );
                            },
                          ),
                          DashboardButton(icon: Icons.pie_chart, label: "Leave Status", onTap: () {  },),
                          DashboardButton(icon: Icons.list, label: "Holiday List", onTap: () {  },),
                          DashboardButton(icon: Icons.receipt, label: "Payslip", onTap: () {  },),
                          DashboardButton(icon: Icons.bar_chart, label: "Reports", onTap: () {  },),
                        ],

                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
