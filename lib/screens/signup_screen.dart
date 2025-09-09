import 'package:flutter/material.dart';
import 'profile_setup_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'We have sent an OTP to your phone number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30.0),
            CustomTextField(
              controller: _otpController,
              hintText: 'Enter OTP',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.lock,
            ),
            const SizedBox(height: 20.0),
            CustomButton(
              text: 'Verify OTP',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileSetupScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                // Resend OTP logic
              },
              child: const Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}