import 'package:flutter/material.dart';
import 'auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? password;

  final double inputHeight = 50;
  final double inputWidthFactor = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF1A1B1F),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -20, // geser ke bawah untuk overlap
                      child: Image.asset(
                        'images/hiasan_login.png',
                        width: 120,
                        height: 120,
                      ),
                    ),
                    Image.asset('images/shadow.png', width: 140, height: 140),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Color(0xFFF295A5),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "username",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              height: inputHeight,
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFECEF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (val) => email = val,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "password",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              height: inputHeight,
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFECEF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: TextField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (val) => password = val,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: inputHeight,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF295A5),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              if (email != null && password != null) {
                                await AuthService.signInWithEmail(
                                  email!,
                                  password!,
                                );
                              }
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            "Or login with",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: InkWell(
                                onTap: () async {
                                  await AuthService.signInWithApple();
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Image.asset('images/apple.png'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: InkWell(
                                onTap: () async {
                                  await AuthService.signInWithGoogle();
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(14),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Image.asset('images/google.png'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(fontSize: 13),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
