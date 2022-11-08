import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/user_dao.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Create a text controller for the email field.
  final _emailController = TextEditingController();
  // Create a text controller for the password field.
  final _passwordController = TextEditingController();
  // Create a key needed for a form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Dispose of the editing controllers
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

// TODO: Add build
  @override
  Widget build(BuildContext context) {
    // Use Provider to get an instance of the UserDao.
    final userDao = Provider.of<UserDao>(context, listen: false);
    return Scaffold(
      // Create an AppBar with the name of your app.
      appBar: AppBar(
        title: const Text('RayChat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        // Create the Form with the global key.
        child: Form(
          key: _formKey,
          // TODO: Add Column & Email
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(height: 80),
                  Expanded(
                    // Create the field for the email address.
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Email Address',
                      ),
                      autofocus: false,
                      // Use an email address keyboard type.
                      keyboardType: TextInputType.emailAddress,
                      // Turn off auto-correction and capitalization.
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      // Set the editing controller.
                      controller: _emailController,
                      // Define a validator to check for empty strings.
                      // You can use regular expressions
                      // or any other type of validation.
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Email Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              // TODO: Add Password
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(), hintText: 'Password'),
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      controller: _passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // TODO: Add Buttons
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ElevatedButton(
                      // Set the first button to call the login() method
                      // and show any error messages.
                      onPressed: () async {
                        final errorMessage = await userDao.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                        // If there is an error message, first check to see
                        // if the state object is “mounted” (still showing),
                        // then show a snackbar.
                        if (errorMessage != null) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              duration: const Duration(milliseconds: 700),
                            ),
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ElevatedButton(
                      // Set the second button to call the signup() method
                      // and show any error messages.
                      onPressed: () async {
                        final errorMessage = await userDao.signup(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (errorMessage != null) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              duration: const Duration(milliseconds: 700),
                            ),
                          );
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
              // TODO: Add parentheses
            ],
          ),
        ),
      ),
    );
  }
}
