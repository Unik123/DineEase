import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/style/components/snackbar.dart';
import 'package:dineease/utils/validator.dart';
import 'package:dineease/view/auth/register_screen.dart';
import 'package:dineease/view/main_screen.dart';
import 'package:dineease/view_model/auth/auth_vm.dart';
import 'package:dineease/view_model/hive_vm.dart';
import 'package:dineease/view_model/password_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final hiveVM = Provider.of<HiveViewModel>(context, listen: false);
      final user = hiveVM.getCurrentUser();

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MainScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final authVM = Provider.of<AuthViewModel>(context, listen: false);

    Future<String> login() async {
      String message = '';
      LoginScreen.formKey.currentState!.save();
      if (LoginScreen.formKey.currentState!.validate()) {
        final status = await authVM.login(
          emailController.text,
          passwordController.text,
        );
        if (status) {
          message = 'Logged in Succesfully';
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const MainScreen(),
            ),
          );
        } else {
          message = authVM.errorMessage!;
        }
      }
      return message;
    }

    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.screenPadding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * 0.08),
              Image.asset(
                'assets/images/dine.jpeg',
                width: screenSize.width * 0.89,
                height: screenSize.width * 0.4,
              ),
              SizedBox(height: screenSize.height * 0.02),
              const Text('Welcome Back', style: MyTextStyle.body),
              Text('Dine Ease',
                  style: MyTextStyle.title.copyWith(fontSize: 40)),
              SizedBox(height: screenSize.height * 0.01),
              SizedBox(height: screenSize.height * 0.02),
              Form(
                key: LoginScreen.formKey,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 8.0,
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 20,
                          ),
                        ),
                        Text(
                          'Username',
                          style: MyTextStyle.body,
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: emailController,
                      style: MyTextStyle.body,
                      decoration: InputDecoration(
                        hintText: 'Username or Email',
                        errorStyle: MyTextStyle.thin,
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: validateEmail,
                    ),
                    SizedBox(height: screenSize.height * 0.01),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 8.0,
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Icon(
                            Icons.lock,
                            size: 20,
                          ),
                        ),
                        Text(
                          'Password',
                          style: MyTextStyle.body,
                        ),
                      ],
                    ),
                    Consumer<ShowPasswordProvider>(
                      builder: (context, showPasswordProvider, _) =>
                          TextFormField(
                        controller: passwordController,
                        obscureText: !showPasswordProvider.isPasswordVisible,
                        validator: validatePassword,
                        style: MyTextStyle.body,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          errorStyle: MyTextStyle.thin,
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(showPasswordProvider.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              showPasswordProvider.togglePasswordVisibility();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: MyTextStyle.body,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      " SignUp",
                      style: MyTextStyle.body.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.035),
              SizedBox(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.056,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  onPressed: () async {
                    String message = await login();
                    message != ""
                        ? MySnackBar.showSnackBar(context, message)
                        : () {};
                  },
                  child: Text(
                    'Login',
                    style: MyTextStyle.body.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
