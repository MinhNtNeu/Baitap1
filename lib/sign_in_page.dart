import 'dart:convert';
import 'package:besoul/bottom_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                    child: SvgPicture.asset(
                  'assets/Frame 3.svg',
                )),
                const Positioned(top: 42, left: 16, child: _AppBarWidget()),
                const Positioned(
                    top: 167,
                    left: 125,
                    child: Text(
                      'Besoul',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            const _LoginWidget(),
            const SizedBox(
              height: 127,
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkResponse(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/chevron-left.svg')),
        InkResponse(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Quay lại',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _LoginWidget extends StatefulWidget {
  const _LoginWidget({Key? key}) : super(key: key);

  @override
  State<_LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<_LoginWidget> {
  bool isLoading = false;
  final dio = Dio();
  Color loginBarColor = Colors.grey;
  bool canNavigate = false;
  String responseData = '';

  void post() async {

    var data = {
      'email': emailController.text,
      'passwords': passwordController.text,
      'username': accountController.text,
      'displayName': nameController.text,
    };
    try {
      var response = await dio.post(
        'https://mobile.gongu365.vn/v5/api/public/customer/account/register',
        data: jsonEncode(data),
        options: Options(
          responseType: ResponseType.json,
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
          },
        ),
      );
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      if (response.statusCode == 200 &&
          (isEmailValid && isPasswordValid && isAccountValid && isNameValid)) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const BottomPage(),
          ),
        );
      } else {
        print(response.statusCode);
        print(response.statusMessage);
      }
    } on DioException catch (e) {
      final response = e.response;
      if (response != null) {
        setState(() {
          responseData = response.data.toString();
        });
        print(response.data);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    } catch (error) {
      print(error);
    }
    setState(() {
      isLoading = false;
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isEmailValid = true;
  bool isPasswordValid = false;
  bool isPassValid = false;
  bool isNameValid = false;
  bool isAccountValid = false;
  bool isPasswordMatch = true;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {
        isEmailValid = emailController.text.isNotEmpty;
      });
    });

    passwordController.addListener(() {
      setState(() {
        isPasswordValid = passwordController.text.isNotEmpty;
      });
    });

    passController.addListener(() {
      setState(() {
        isPassValid = passController.text.isNotEmpty;
      });
    });
    nameController.addListener(() {
      setState(() {
        isNameValid = nameController.text.isNotEmpty;
      });
    });
    accountController.addListener(() {
      setState(() {
        isAccountValid = accountController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    accountController.dispose();
    passController.dispose();
    nameController.dispose();
  }

  bool obscurePassword = true;
  bool obscurePass = true;


  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
            strokeWidth: 4.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _inputField('Tài khoản', accountController),
              const SizedBox(
                height: 20,
              ),
              _inputField('Mật khẩu', passwordController, isPassword: true),
              const SizedBox(
                height: 20,
              ),
              _inputField('Nhập lại mật khẩu', passController, isPass: true),
              const SizedBox(
                height: 20,
              ),
              _inputField('Tên hiển thị ', nameController),
              const SizedBox(
                height: 20,
              ),
              _inputField('Email', emailController,isEmail: true),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                responseData,
                style: const TextStyle(fontSize: 13, color: Color(0xFFE57070)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              checkWidget(),
              const SizedBox(
                height: 20,
              ),
              InkResponse(
                onTap: () {
                  post();
                },
                child: Container(
                  width: 298,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                    color: isEmailValid &&
                            isPasswordValid &&
                            isAccountValid &&
                            isNameValid &&
                            isPassValid &&
                            isChecked
                        ? const Color(0xFF60D7B2)
                        : Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'ĐĂNG KÝ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false, isPass = false, isEmail = false}) {
    return Container(
      width: 298,
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: Color(0xFFCBD5E1),
          width: 1,
        )),
      ),
      child: TextField(
        style: const TextStyle(color: Color(0XFF262626)),
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black12,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                )
              : isPass
                  ? IconButton(
                      icon: Icon(
                        obscurePass ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePass = !obscurePass;
                        });
                      },
                    )
                  : null,
          errorText: isEmail &&  !isEmailValid ? 'Email không hợp lệ' :isPass && !isPasswordMatch ? 'Mật khẩu không khớp' : null,

        ),
        obscureText: isPassword
            ? obscurePassword
            : isPass
                ? obscurePass
                : false,
        onChanged: (value) {
          if (isEmail) {
            setState(() {
              isEmailValid = value.contains('@');
            });
          } else if (isPass) {
            setState(() {
              isPasswordMatch = value == passwordController.text;
            });}
        },

      ),
    );
  }

  Widget checkWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        checkboxWidget(),
        SizedBox(
          height: 50,
          width: 300,
          child: RichText(
              text: TextSpan(
                  text: "Tôi đã đọc và đồng ý với ",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                TextSpan(
                    text: '  Điều khoản sử dụng của công ty',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline))
              ])),
        ),
      ],
    );
  }

  Widget checkboxWidget() {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
