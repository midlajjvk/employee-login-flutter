import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final Map employeeData;

  const EmployeeDetailsScreen({super.key, required this.employeeData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee Details"), centerTitle: true),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              detailRow(
                "Employee ID",
                employeeData["employeeId"]?.toString() ?? "nil",
              ),
              detailRow("Name", employeeData["name"]?.toString() ?? "nil"),
              detailRow("Role", employeeData["role"]?.toString() ?? "nil"),
              detailRow(
                "Store",
                (employeeData["Store"]?.toString().trim().isNotEmpty ?? false)
                    ? employeeData["Store"].toString()
                    : "nil",
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [Text("$title:"), Text(value)]),
    );
  }
}
