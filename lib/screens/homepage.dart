import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../viewmodel/homepageviewmodels.dart';
import '../wigets/puchedin.dart';
import 'faceverification.dart';
import 'leavedashboardview.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomepageViewModel(),
      child: HomepageContent(checkinMessage: '', checkoutMessage: ''),
    );
  }
}

class HomepageContent extends StatefulWidget {
  final String checkinMessage;
  final String checkoutMessage;

  const HomepageContent({
    super.key,
    required this.checkinMessage,
    required this.checkoutMessage,
  });

  @override
  State<HomepageContent> createState() => _HomepageContentState();
}

class _HomepageContentState extends State<HomepageContent> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomepageViewModel>(context);

    if (vm.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
              _buildTopHeader(vm),
              _buildGreetingCard(vm),
              const SizedBox(height: 20),
              if (!vm.isCheckedIn)
                const Text(
                  "You haven't Punch-in yet",
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
              const SizedBox(height: 16),
              _buildPunchButtons(vm),
              const SizedBox(height: 24),
              _buildOverviewCards(vm),
              const SizedBox(height: 24),
              _buildDashboardGrid(context, vm),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader(HomepageViewModel vm) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F9D58), Color(0xFF1E88E5)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage("assets/images/profile1.jpg"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vm.userName.isEmpty ? 'Loading...' : vm.userName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  vm.role.isEmpty ? 'Loading...' : vm.role,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Image.asset("assets/images/companylogo.png", height: 36),
        ],
      ),
    );
  }

  Widget _buildGreetingCard(HomepageViewModel vm) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "${vm.greeting},\n${vm.userName.isEmpty ? 'User' : vm.userName} 👋",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildPunchButtons(HomepageViewModel vm) {
    return vm.isCheckedIn
        ? Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5FAFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.checkinMessage.isNotEmpty
              ? widget.checkinMessage
              : "Checked in at ${DateFormat('hh:mm a').format(DateTime.now())}"),

          const SizedBox(height: 10),

          if (vm.lastPunchOutTime != null)
            Text(
              "Punched out at ${DateFormat('hh:mm a').format(vm.lastPunchOutTime!)}",
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),

          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.location_on, color: Colors.redAccent, size: 20),
              SizedBox(width: 6),
              Text("Location/IP (for remote attendance)", style: TextStyle(color: Colors.black54)),
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
                  ),
                  child: const Text('Punched-In'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => PunchInDialog(
                        onSelect: (location) {
                          Navigator.pop(context);
                          vm.punchOutWithLocation(location);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FaceVerificationView(isPunchingIn: false),
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
                  ),
                  child: const Text("Punch Out"),
                ),
              ),
            ],
          ),
        ],
      ),
    )
        : Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
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
            },
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

  Widget _buildOverviewCards(HomepageViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Overview", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            _overviewBox("Presence", "${vm.presence}", Colors.green),
            _overviewBox("Absence", "${vm.absence}", Colors.red),
            _overviewBox("Leaves", "${vm.leaves}", Colors.orange),
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
            _dashboardItem(Icons.logout, "Leaves", Colors.orange, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LeaveDashboardView(cameFromDashboard: false),
                ),
              );
            }),
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
