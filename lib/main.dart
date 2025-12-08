import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rootments/EmployeeDetailsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = "";
  Future<void> loginEmployee() async {
    if (employeeIdController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      setState(() {
        errorMessage = "ID and Password are required";
      });
      return;
    }
    setState(() {
      isLoading = true;
      errorMessage = "";
    });
    try {
      final response = await http.post(
        Uri.parse("https://rootments.in/api/verify_employee"),

        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer RootX-production-9d17d9485eb772e79df8564004d4a4d4",
        },
        body: jsonEncode({
          "employeeId": employeeIdController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == "success") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EmployeeDetailsScreen(employeeData: data["data"]),
          ),
        );
      } else {
        setState(() {
          errorMessage = "Employee Not Found";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Network Error";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 110),
              Text(
                "RootMents",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Welcome to your workspace",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Employee ID"),
                      TextField(
                        controller: employeeIdController,
                        decoration: InputDecoration(
                          hintText: "Enter Employee ID",
                          prefixIcon: Icon(Icons.perm_identity),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Text("Employee Password"),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Enter Employee Password",
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(height: 150),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : loginEmployee,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text("Need Help? Contact your Admin"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
