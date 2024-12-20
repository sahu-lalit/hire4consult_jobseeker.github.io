import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hire4consult/controller/auth_controller/auth_controller_concrete.dart';
import 'package:hire4consult/view/main_view/main_view.dart';
import 'package:hire4consult/view/signup_view/signup_view.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthControllerConcrete>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  height: 500,
                  width: 800,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/main_image.jpg"),
                        fit: BoxFit.contain),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 50, 50, 0),
                    child: Column(
                      children: [
                        const Text(
                          "Login to your account.",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              errorBorder: const OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.redAccent),
                              ),
                              hintText: "Email"),
                        ),
                        const SizedBox(
                            height: 20), // Using SizedBox for spacing
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                              ),
                              errorBorder: const OutlineInputBorder(
                                //<-- SEE HERE
                                borderSide: BorderSide(color: Colors.redAccent),
                              ),
                              hintText: "Password"),
                          obscureText: true, // To hide the password text
                        ),
                        const SizedBox(
                            height: 20), // Another SizedBox for spacing

                        Consumer<AuthControllerConcrete>(
                            builder: (context, loginController, child) {
                          return loginController.isLoading
                              ? const SpinKitWave(
                                  color: Colors
                                      .orangeAccent, // Set the color of your choice
                                  size: 50.0, // Set the size of the animation
                                )
                              : ElevatedButton(
                                  onPressed: () async {
                                    final message =
                                        await loginController.loginController(
                                            email: _emailController.text,
                                            password: _passwordController.text);
                                    if (message!.contains('Success')) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()));
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(message)));
                                  },
                                  child: const Text("Login"),
                                );
                        }),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignupPage();
                                  }));
                                },
                                child: const Text("Signup")),
                          ],
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Login with"),
                            const SizedBox(
                              width: 14,
                            ),
                            Image.asset("assets/images/google.png"),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text("OR"),
                            const SizedBox(
                              width: 8,
                            ),
                            Image.asset("assets/images/apple.png"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Text("Copyright © 2024 Hire4Consult. All rights reserved.")
          ],
        ),
      ),
    );
  }
}
