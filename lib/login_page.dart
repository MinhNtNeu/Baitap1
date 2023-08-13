import 'package:besoul/login_kol_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [_AppBarWidget(),
            SizedBox(height: 44,),
            _LogoWidget(),
            SizedBox(height: 64,),
            _SignInWidget()],
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
      child: Row(
        children: [
          InkResponse(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset('assets/chevronleft.svg')),
          const SizedBox(width: 8,),
          InkResponse(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text('Quay lại',style: TextStyle(color: Color(0xFF727F89),fontWeight: FontWeight.w500,fontSize: 14),)),
        ],
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: SizedBox.fromSize(
              size: const Size.fromRadius(48), // Image radius
              child: Container(
                color: const Color(0xFF60D7B2),
              )),
        ),
        const Text(
          'Besoul',
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w500, color: Color(0xFF595D5F)),
        ),
      ],
    );
  }
}

class _SignIn1Widget extends StatelessWidget {
  const _SignIn1Widget(
      {Key? key,
      required this.text,
      required this.images,
      required this.color,
      this.font})
      : super(key: key);
  final String images;
  final String text;
  final color;
  final font;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353,
      height: 40,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(images,width: 20,height: 20,),
          const SizedBox(width: 8,),
          Text(
            text,
            style: TextStyle(color: font,fontSize: 14,fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _SignIn2Widget extends StatelessWidget {
  const _SignIn2Widget({Key? key, required this.title, required this.svg})
      : super(key: key);
  final String svg;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(
        width: 1,
            color: const Color(0xFFC6CFD2)
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(svg,width: 20,height: 20,),
          const SizedBox(width: 8,),
          Text(title,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
        ],
      ),
    );
  }
}

class _SignInWidget extends StatelessWidget {
  const _SignInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SignIn1Widget(
            text: 'Đăng nhập với Kakaotalk',
            images: 'assets/talk.svg',
            color: Color(0xFFF9E200)),
        const SizedBox(height: 10),
        const _SignIn1Widget(
          text: 'Đăng nhập với Facebook',
          images: 'assets/fb.svg',
          color: Color(0xFF1878F3),
          font: Colors.white,
        ),
        const SizedBox(height:10),
        const _SignIn1Widget(
            text: 'Đăng nhập với Apple',
            images: 'assets/apple.svg',
            color: Colors.black,
            font: Colors.white),
        const SizedBox(height:10),
        const _SignIn2Widget(title: 'Đăng nhập với Tiktok', svg: 'assets/toptop.svg'),const SizedBox(height:10),
        const _SignIn2Widget(title: 'Đăng nhập với Google', svg: 'assets/gg.svg'),const SizedBox(height:10),
        const _SignIn2Widget(title: 'Đăng nhập với Zalo', svg: 'assets/Zalo.svg'),const SizedBox(height:10),
        SizedBox(height: 44,),
        InkResponse(
            onTap: () {
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const LoginKOLPage(),
                  ),
                );
              }
            },
            child: const Text('Dành cho KOL',style: TextStyle(color: Color(0xFF595D5F),fontWeight: FontWeight.w500,fontSize: 14,decoration: TextDecoration.underline,),)),
      ],
    );
  }
}
