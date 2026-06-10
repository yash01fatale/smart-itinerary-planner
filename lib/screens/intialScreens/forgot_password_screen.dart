import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../config/app_routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    Future<void> resetPassword(BuildContext context) async {
      if (emailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Plz Enter your email"),
        ));
      }
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email Sent Sucessfully"),
        ));
      } on FirebaseAuthException catch (e) {
        String message;

    switch (e.code) {
      case 'user-not-found':
        message = 'No account found with this email';
        break;

      case 'invalid-email':
        message = 'Invalid email address';
        break;

      default:
        message = e.message ?? 'Something went wrong';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          SizedBox.expand(
            child: Image.network(
              "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
              fit: BoxFit.cover,
            ),
          ),

          /// Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.75),
                  Colors.black.withOpacity(.45),
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  /// Logo
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xffFBBF24),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.travel_explore,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "TravelWise AI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Recover your account and continue your journey",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 50),

                  /// Glass Card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 20,
                        sigmaY: 20,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.12),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.lock_reset,
                              color: Color(0xffFBBF24),
                              size: 70,
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Enter your registered email address and we'll send you a password reset link.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              controller: emailController,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Enter Email Address",
                                hintStyle: const TextStyle(
                                  color: Colors.white60,
                                ),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Color(0xffFBBF24),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(.10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 58,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFBBF24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: () async {
  await resetPassword(context);
},
                                child: const Text(
                                  "Send Reset Link",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextButton.icon(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xffFBBF24),
                                size: 18,
                              ),
                              label: const Text(
                                "Back to Login",
                                style: TextStyle(
                                  color: Color(0xffFBBF24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
