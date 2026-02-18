import 'package:flutter/material.dart';
import 'package:mahalaxmi_coolers/features/widgetTree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final plotController = TextEditingController();
  final laneController = TextEditingController();
  final pinController = TextEditingController();

  String selectedCity = "Yavatmal";
  String selectedState = "Maharashtra";

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    plotController.dispose();
    laneController.dispose();
    pinController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("User not logged in")));
          return;
        }

        AuthCredential credential = EmailAuthProvider.credential(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        await user.linkWithCredential(credential);

        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "username": usernameController.text.trim(),
          "email": emailController.text.trim(),
          "phone": user.phoneNumber,
          "plot": plotController.text.trim(),
          "lane": laneController.text.trim(),
          "city": selectedCity,
          "state": selectedState,
          "pin": pinController.text.trim(),
          "createdAt": FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account Created Successfully")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WidgetTree(title: 'Mahalaxmi Rentals'),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'credential-already-in-use') {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Email already in use")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? "Error occurred")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Create Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: BackButton(color: Theme.of(context).colorScheme.surface),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!value.contains("@")) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Set Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                Text(
                  "Address Details",
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: plotController,
                  decoration: const InputDecoration(
                    labelText: "Plot No",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: laneController,
                  decoration: const InputDecoration(
                    labelText: "Lane / Area",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: selectedCity,
                  decoration: const InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Yavatmal",
                      child: Text("Yavatmal"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: selectedState,
                  decoration: const InputDecoration(
                    labelText: "State",
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Maharashtra",
                      child: Text("Maharashtra"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedState = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: pinController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "PIN Code",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length != 6) {
                      return "Enter valid 6-digit PIN";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      submitForm();
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
