import 'package:flutter/material.dart';
import 'package:mahalaxmi_coolers/features/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyMobileScreen extends StatefulWidget {
  const VerifyMobileScreen({super.key});

  @override
  State<VerifyMobileScreen> createState() => _VerifyMobileScreenState();
}

class _VerifyMobileScreenState extends State<VerifyMobileScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";

  bool showOtpField = false;
  bool showVerifyButton = false;

  @override
  void dispose() {
    mobileController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void submitMobile() async {
    if (mobileController.text.length == 10) {
      String phone = "+91${mobileController.text.trim()}";

      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: ${e.message}")));
        },
        codeSent: (String verId, int? resendToken) {
          setState(() {
            verificationId = verId;
            showOtpField = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("OTP Sent Successfully")),
          );
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      );
    }
  }

  void verifyOtp() {
    print("OTP Verified: ${otpController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Login with Mobile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: BackButton(color: Theme.of(context).colorScheme.surface),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 50),

            TextField(
              controller: mobileController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: "Enter Mobile Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (!showOtpField)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: submitMobile,
                  child: const Text("Send OTP"),
                ),
              ),

            const SizedBox(height: 30),

            if (showOtpField) ...[
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  if (value.length == 6) {
                    setState(() {
                      showVerifyButton = true;
                    });
                  } else {
                    setState(() {
                      showVerifyButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter OTP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],

            if (showVerifyButton)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: otpController.text.trim(),
                          );

                      await _auth.signInWithCredential(credential);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Mobile Verified Successfully"),
                        ),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid OTP")),
                      );
                    }
                  },
                  child: const Text("Verify"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
