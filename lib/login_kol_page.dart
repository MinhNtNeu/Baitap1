import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginKOLPage extends StatefulWidget {
  const LoginKOLPage({Key? key}) : super(key: key);

  @override
  State<LoginKOLPage> createState() => _LoginKOLPageState();
}

class _LoginKOLPageState extends State<LoginKOLPage> {
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
                const Positioned(
                  top: 335,
                  left: 105,
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                        color: Color(0xFF606265),
                        fontSize: 32,
                        fontWeight: FontWeight.w800),
                  ),
                )
              ],
            ),
            const _LoginWidget(),
            const SizedBox(
              height: 127,
            ),
            const _BottomBarWidget(),
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _inputField('Email', emailController),
        const SizedBox(
          height: 20,
        ),
        _inputField('Mật khẩu', passwordController, isPassword: true),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 298,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            color: const Color(0xFF60D7B2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'ĐĂNG NHẬP',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Quên mật khẩu',
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
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
              : null,
        ),
        obscureText: isPassword ? obscurePassword : false,
      ),
    );
  }
}

class _BottomBarWidget extends StatelessWidget {
  const _BottomBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
          text: TextSpan(
              text: "Chưa có Tài khoản?",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400),
              children: const <TextSpan>[
            TextSpan(
                text: '  Đăng ký ngay',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500))
          ])),
    );
  }
}