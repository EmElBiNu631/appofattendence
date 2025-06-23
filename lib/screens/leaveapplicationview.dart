
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodel/leaveviewmodel.dart';

class LeaveFormView extends StatelessWidget {
  const LeaveFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeaveFormViewModel(),
      child: const LeaveFormContent(),
    );
  }
}

class LeaveFormContent extends StatelessWidget {
  const LeaveFormContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LeaveFormViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 20),
              Text(
                "Apply for Leave",
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),

              buildFieldCard(
                icon: Icons.person_outline,
                child: buildTextField(
                  label: "Employee Name - auto-filled",
                  controller: vm.nameController,
                  enabled: false,
                ),
              ),
              const SizedBox(height: 20),

              buildFieldCard(
                icon: Icons.badge_outlined,
                child: buildTextField(
                  label: "Employee ID - auto-filled",
                  controller: vm.idController,
                  enabled: false,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: buildFieldCard(
                      icon: Icons.calendar_today_outlined,
                      child: buildDateField(
                        context: context,
                        label: "From Date",
                        date: vm.fromDate,
                        onTap: () => pickDate(context, true),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildFieldCard(
                      icon: Icons.calendar_today_outlined,
                      child: buildDateField(
                        context: context,
                        label: "To Date",
                        date: vm.toDate,
                        onTap: () => pickDate(context, false),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              buildFieldCard(
                icon: Icons.airplane_ticket_outlined,
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration.collapsed(hintText: ''),
                  value: vm.leaveType.isNotEmpty ? vm.leaveType : null,
                  hint: Text('Choose Type', style: GoogleFonts.poppins()),
                  items: ['Sick Leave', 'Casual Leave', 'Earned Leave']
                      .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type, style: GoogleFonts.poppins()),
                  ))
                      .toList(),
                  onChanged: vm.setLeaveType,
                ),
              ),
              const SizedBox(height: 20),
              buildFieldCard(
                icon: Icons.edit_note_outlined,
                child: TextField(
                  controller: vm.reasonController,
                  maxLines: 4,
                  style: GoogleFonts.poppins(),
                  decoration: InputDecoration.collapsed(
                    hintText: "Reason",
                    hintStyle: GoogleFonts.poppins(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildFieldCard(
                icon: Icons.attach_file_outlined,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    vm.attachmentPath ?? "Attachment (Optional)",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.upload_file),
                    onPressed: () {
                      vm.pickAttachment();
                    },
                  ),

                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: vm.submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06A8F2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildFieldCard({required IconData icon, required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration.collapsed(
        hintText: label,
        hintStyle: GoogleFonts.poppins(),
      ),
    );
  }

  Widget buildDateField({
    required BuildContext context,
    required String label,
    DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: IgnorePointer(
        child: TextField(
          controller: TextEditingController(
            text: date != null ? date.toString().split(" ")[0] : "",
          ),
          style: GoogleFonts.poppins(),
          decoration: InputDecoration.collapsed(
            hintText: label,
            hintStyle: GoogleFonts.poppins(),
          ),
        ),
      ),
    );
  }

  void pickDate(BuildContext context, bool isFrom) async {
    final vm = Provider.of<LeaveFormViewModel>(context, listen: false);
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      isFrom ? vm.setFromDate(picked) : vm.setToDate(picked);
    }
  }
}
