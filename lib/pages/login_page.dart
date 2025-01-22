import 'package:bus_reservation_udemy/drawer/main_drawer.dart';
import 'package:bus_reservation_udemy/models/app_user.dart';
import 'package:bus_reservation_udemy/pages/widget/text_field_custom.dart';
import 'package:bus_reservation_udemy/provider/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/app_decoration_style.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObsecure = true;

  final _formKeyLogin = GlobalKey<FormState>();

  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKeyLogin,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFieldCustom(
                      controller: usernameController,
                      hint: "Username",
                      onChanged: (val) {},
                      textInputType: TextInputType.text,
                      focusNode: usernameFocus,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: AppDecorationStyle.inputDecoration(
                          hint: "Password",
                          iconVisibility: Icons.visibility,
                          iconVisibilityOff: Icons.visibility_off,
                          isObsecure: isObsecure,
                          onPress: () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          }),
                      controller: passwordController,
                      obscureText: isObsecure,
                      focusNode: passwordFocus,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _login,
                            child: const Text("Login"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    if (_formKeyLogin.currentState!.validate()) {
      String userName = usernameController.text;
      String password = passwordController.text;

      final response = await Provider.of<AppDataProvider>(context, listen: false)
          .login(AppUser(userName: userName, password: password));

      if (response != null) {
        showMsg(context, response.message);
      } else {
        showMsg(context, "Login failed!");
      }
    }
  }
}
