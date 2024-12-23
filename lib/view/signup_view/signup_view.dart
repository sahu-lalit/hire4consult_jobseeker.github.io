import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hire4consult/controller/auth_controller/auth_controller_concrete.dart';
import 'package:hire4consult/view/main_view/main_view.dart';
import 'package:hire4consult/view/login_view/login_view.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _resumeLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          "Create your account today.",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          controller: _userNameController,
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
                              hintText: "Full Name"),
                        ),

                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // TextField(
                        //   controller: _resumeLinkController,
                        //   decoration: InputDecoration(
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: const BorderSide(), //<-- SEE HERE
                        //         borderRadius: BorderRadius.circular(10.0),
                        //       ),
                        //       focusedBorder: const OutlineInputBorder(
                        //         //<-- SEE HERE
                        //         borderSide:
                        //             BorderSide(color: Colors.blueAccent),
                        //       ),
                        //       errorBorder: const OutlineInputBorder(
                        //         //<-- SEE HERE
                        //         borderSide: BorderSide(color: Colors.redAccent),
                        //       ),
                        //       hintText: "Resume Link"),
                        // ),

                        const SizedBox(
                          height: 20,
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
                          builder: (context, signupController, child) {
                            return signupController.isLoading
                                ? const SpinKitWave(
                                    color: Colors
                                        .orangeAccent, // Set the color of your choice
                                    size: 50.0, // Set the size of the animation
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      final message = await signupController
                                          .signUpController(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                              username:
                                                  _userNameController.text,
                                              resumeLink:
                                                  _resumeLinkController.text);
                                      if (message!.contains('Success')) {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()));
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(message)));
                                    },
                                    child: const Text("Signup"),
                                  );
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  }));
                                },
                                child: const Text("Login")),
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
