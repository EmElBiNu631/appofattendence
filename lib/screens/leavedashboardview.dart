import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miniproject/screens/profile.dart';
import 'package:provider/provider.dart';
import '../viewmodel/LeaveDashboardViewModel.dart';
import 'leaveapplicationview.dart'; // Request Leave Form

class LeaveDashboardView extends StatefulWidget {
  const LeaveDashboardView({super.key});

  @override
  State<LeaveDashboardView> createState() => _LeaveDashboardViewState();
}


class _LeaveDashboardViewState extends State<LeaveDashboardView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late LeaveDashboardViewModel vm;

  late String checkinMessage;
  late String checkoutMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    vm = LeaveDashboardViewModel()..fetchLeaveData();

    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    checkinMessage = "Checked in at $formattedTime";
    checkoutMessage = "Checked out at $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LeaveDashboardViewModel>.value(
      value: vm,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 80,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DashboardView(
                    checkinMessage: checkinMessage,
                    checkoutMessage: checkoutMessage,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset("assets/images/companylogo.png"),
            ),
          ),

          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
            ),
          ],
        ),

        body:
        Column(

          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Dashboard"),
                  Tab(text: "Request Leave"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDashboardTab(),
                  const LeaveFormView(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTab() {
    return Consumer<LeaveDashboardViewModel>(
      builder: (context, vm, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double spacing = 12;
                  double cardWidth = (constraints.maxWidth - spacing) / 2;
                  double cardHeight = 130;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 12,
                    children: [
                      _StatCard(
                        title: "Total Leave Taken",
                        value: "${vm.totalLeaves} days",
                        sub: "29 days remaining this year",
                        width: cardWidth,
                      ),
                      _StatCard(
                        title: "Approval Rate",
                        value: "${vm.approvalRate}%",
                        sub: "28 days remaining this year",
                        width: cardWidth,
                      ),
                      _StatCard(
                        title: "Pending Request",
                        value: "${vm.pendingRequests}",
                        sub: "28 days remaining this year",
                        width: cardWidth,
                      ),
                      _StatCard(
                        title: "Team Member on Leave",
                        value: "${vm.teamOnLeave}",
                        sub: "24 days remaining this year",
                        width: cardWidth,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildLeaveChart(),
              const SizedBox(height: 20),
              _buildUpcomingLeave(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLeaveChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Leave Overview", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _QuarterBar(label: "Q1", height: 80),
            _QuarterBar(label: "Q2", height: 50),
            _QuarterBar(label: "Q3", height: 30),
            _QuarterBar(label: "Q4", height: 10),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("20", style: TextStyle(fontSize: 12)),
            Text("Leave days taken"),
            Text("Remaining 29", style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildUpcomingLeave() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Upcoming Leave", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text("Your scheduled time off..."),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String sub;
  final double width;

  const _StatCard({
    required this.title,
    required this.value,
    required this.sub,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 13, color: Colors.black)),
              const SizedBox(height: 4),
              Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}


class _QuarterBar extends StatelessWidget {
  final String label;
  final double height;

  const _QuarterBar({required this.label, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: 20, height: height, color: Colors.blue),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
