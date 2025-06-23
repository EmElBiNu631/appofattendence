
import 'package:flutter/material.dart';

Widget userNameFutureBuilder({required Widget Function(String) builder}) {
  return FutureBuilder<String>(
    future: Future.value("Emel Binu"),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return builder(snapshot.data ?? "");
      }
      return const CircularProgressIndicator();
    },
  );
}

Widget userNameonlyFutureBuilder() {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text("Good Morning, Emel Binu", style: TextStyle(fontSize: 18)),
  );
}

Widget boxwithnameandrole(String userName, String role) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(role, style: const TextStyle(color: Colors.grey)),
      ],
    ),
  );
}

Widget checkinandoutwidget(String inMsg, String outMsg, String time, String location, BuildContext context, String punchInText, String punchOutText) {
  return Card(
    margin: const EdgeInsets.all(12),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Check-in: $inMsg"),
          Text("Check-out: $outMsg"),
          Text("Time: $time"),
          Text("Location: $location"),
        ],
      ),
    ),
  );
}

Widget leaveDetails(String label1, String val1, String label2, String val2, String label3, String val3) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(children: [Text(label1), Text(val1)]),
      Column(children: [Text(label2), Text(val2)]),
      Column(children: [Text(label3), Text(val3)]),
    ],
  );
}

Widget customscrollingbuttons({required List<String> titles, required int? selectedIndex, required Function(int) onButtonTap}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: List.generate(titles.length, (index) {
        final selected = selectedIndex == index;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: selected ? Colors.blue : Colors.grey[300],
              foregroundColor: selected ? Colors.white : Colors.black,
            ),
            onPressed: () => onButtonTap(index),
            child: Text(titles[index]),
          ),
        );
      }),
    ),
  );
}

Widget customRadioButtons({required String title, required String title1, required String title2, required String selectedButton, required ValueChanged<String?> onChanged}) {
  return Row(
    children: [
      const SizedBox(width: 16),
      Text(title),
      const SizedBox(width: 16),
      ChoiceChip(label: Text(title1), selected: selectedButton == title1, onSelected: (_) => onChanged(title1)),
      const SizedBox(width: 8),
      ChoiceChip(label: Text(title2), selected: selectedButton == title2, onSelected: (_) => onChanged(title2)),
    ],
  );
}

Widget custommytasks(String title, String description) {
  return Card(
    child: ListTile(
      title: Text(title),
      subtitle: Text(description),
    ),
  );
}

Widget trackerItem({required String title, required String dueDate, required int progress, required String remaining, required String priority, required String status, required Function(String?) onSelectionChanged}) {
  return Card(
    child: ListTile(
      title: Text(title),
      subtitle: Text("Due: $dueDate\nPriority: $priority\nStatus: $status"),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$progress%"),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: progress / 100),
        ],
      ),
    ),
  );
}

Widget ongoingItemSimple({required String startDate, required String title, required String status, required String completion, required String completionDate, required String priority}) {
  return Card(
    margin: const EdgeInsets.all(8),
    child: ListTile(
      title: Text(title),
      subtitle: Text("Status: $status\nCompletion: $completion\nPriority: $priority"),
    ),
  );
}

Widget metricGrid(List<Map<String, String>> metrics) {
  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(8),
    children: metrics.map((metric) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart),
              const SizedBox(height: 8),
              Text(metric['label'] ?? '', textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text(metric['value'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget dashboard(String title1, String img1, VoidCallback onTap1, String title2, String img2, VoidCallback onTap2, String title3, String img3, VoidCallback onTap3) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      GestureDetector(onTap: onTap1, child: Column(children: [Image.asset(img1, width: 60), Text(title1)])),
      GestureDetector(onTap: onTap2, child: Column(children: [Image.asset(img2, width: 60), Text(title2)])),
      GestureDetector(onTap: onTap3, child: Column(children: [Image.asset(img3, width: 60), Text(title3)])),
    ],
  );
}

Widget custombottomnavigation(String label1, String label2, String label3, String label4, int selectedIndex, ValueChanged<int> onTap) {
  return BottomNavigationBar(
    currentIndex: selectedIndex,
    onTap: onTap,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: label1),
      BottomNavigationBarItem(icon: Icon(Icons.history), label: label2),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: label3),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: label4),
    ],
  );
}