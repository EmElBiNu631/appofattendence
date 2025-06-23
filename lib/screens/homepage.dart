import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../viewmodel/homepageviewmodels.dart';
import '../wigets/commonwidgets.dart';
import 'faceverification.dart';
import 'leaveapplicationview.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomepageViewModel(),
      child: const HomepageContent(),
    );
  }
}

class HomepageContent extends StatefulWidget {
  const HomepageContent({super.key});

  @override
  State<HomepageContent> createState() => _HomepageContentState();
}

class _HomepageContentState extends State<HomepageContent> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomepageViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Leave'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopHeader(),
              const SizedBox(height: 20),
              const Text(
                "Good Morning,\nEmel Binu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Text(
                vm.isCheckedIn ? "" : "You haven't Punch-in yet",
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              _buildPunchButtons(vm),
              const SizedBox(height: 24),
              _buildOverviewCards(),
              const SizedBox(height: 12),
              _buildDashboardGrid(context, vm),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.green.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage("assets/images/profile1.jpg"),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Emel Binu", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Full-stack Developer", style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        Image.asset("assets/images/companylogo.png", height: 40),
        const SizedBox(width: 10),
        const Icon(Icons.notifications_none, color: Colors.blueAccent, size: 30),
      ],
    );
  }

  Widget _buildPunchButtons(HomepageViewModel vm) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: !vm.isCheckedIn
                ? () {
              showDialog(
                context: context,
                builder: (_) => PunchInDialog(
                  onSelect: (location) {
                    Navigator.pop(context);
                    vm.punchInWithLocation(location);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FaceVerificationView(isPunchingIn: true),
                      ),
                    );
                  },
                ),
              );
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text("Punch In", style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text("Punch Out", style: TextStyle(color: Colors.black54)),
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            _overviewBox("Presence", "20", Colors.green),
            _overviewBox("Absence", "03", Colors.red),
            _overviewBox("Leaves", "02", Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _overviewBox(String title, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 6),
            Text(title, style: TextStyle(color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardGrid(BuildContext context, HomepageViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Dashboard", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _dashboardItem(Icons.calendar_month, "Attendance", Colors.green, () {}),
            _dashboardItem(Icons.logout, "Leaves", Colors.orange, () => vm.navigateToLeaves(context)),
            _dashboardItem(Icons.info_outline, "Leave Status", Colors.purple, () {}),
            _dashboardItem(Icons.event_note, "Holiday List", Colors.indigo, () {}),
            _dashboardItem(Icons.receipt_long, "Payslip", Colors.teal, () {}),
            _dashboardItem(Icons.bar_chart, "Reports", Colors.redAccent, () {}),
          ],
        ),
      ],
    );
  }

  Widget _dashboardItem(IconData icon, String title, Color iconColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: iconColor),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 13), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
