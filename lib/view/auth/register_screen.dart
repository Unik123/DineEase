import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/style/components/snackbar.dart';
import 'package:dineease/utils/validator.dart';
import 'package:dineease/view/auth/login_screen.dart';
import 'package:dineease/view_model/auth/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

String selectedRole = 'waiter';

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final TextEditingController firstnameController = TextEditingController();
    final TextEditingController lastnameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController passwordcontroller = TextEditingController();
    final TextEditingController password2controller = TextEditingController();

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    Future<String> register() async {
      String message = '';

      RegisterScreen.formKey.currentState!.save();

      if (RegisterScreen.formKey.currentState!.validate()) {
        final status = await authViewModel.register(
          firstnameController.text,
          lastnameController.text,
          selectedRole,
          emailController.text,
          int.parse(phoneController.text),
          addressController.text,
          passwordcontroller.text,
          password2controller.text,
        );
        if (status) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
          );
        } else {
          message = 'Register Failed';
        }
      }
      return message;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.screenPadding),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.08),
              Image.asset(
                'assets/images/dine.jpeg',
                width: screenWidth * 1.1,
                height: screenHeight * 0.14,
              ),
              Text('Dine Ease',
                  style: MyTextStyle.title.copyWith(fontSize: 35)),
              SizedBox(
                height: screenHeight * 0.018,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
                    child: Icon(
                      Icons.redeem_outlined,
                      size: 20,
                    ),
                  ),
                  Text('Your Role', style: MyTextStyle.body),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: SizedBox(
                    height: screenHeight * 0.055,
                    child: DropdownButton<String>(
                      value: selectedRole,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (newValue) {
                        setState(() {
                          selectedRole = newValue!;
                        });
                      },
                      dropdownColor: Colors.white,
                      items: <String>['waiter', 'cook', 'cashier']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: MyTextStyle.body.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.017),
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
                      Icons.format_align_justify,
                      size: 20,
                    ),
                  ),
                  Text(
                    'Fill the form',
                    style: MyTextStyle.body,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Form(
                key: RegisterScreen.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: firstnameController,
                            style: MyTextStyle.body,
                            decoration: InputDecoration(
                              hintText: 'First name',
                              errorStyle: MyTextStyle.thin,
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: TextFormField(
                            controller: lastnameController,
                            style: MyTextStyle.body,
                            decoration: InputDecoration(
                              hintText: 'Last name',
                              errorStyle: MyTextStyle.thin,
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: emailController,
                      style: MyTextStyle.body,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        errorStyle: MyTextStyle.thin,
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: phoneController,
                      style: MyTextStyle.body,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        errorStyle: MyTextStyle.thin,
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: addressController,
                      style: MyTextStyle.body,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        errorStyle: MyTextStyle.thin,
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: passwordcontroller,
                      style: MyTextStyle.body,
                      validator: validatePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        errorStyle: MyTextStyle.thin,
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: password2controller,
                      style: MyTextStyle.body,
                      validator: (value) => validatePasswordConfirmation(
                        value,
                        passwordcontroller.text,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        fillColor: Colors.white,
                        errorStyle: MyTextStyle.thin,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: MyTextStyle.body,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            " LogIn",
                            style: MyTextStyle.body.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.035),
                    SizedBox(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.056,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        onPressed: () async {
                          String message = await register();
                          message != ""
                              ? MySnackBar.showSnackBar(context, message)
                              : () {};
                        },
                        child: Text(
                          'SignUp',
                          style: MyTextStyle.body.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
