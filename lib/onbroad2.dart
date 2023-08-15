import 'package:besoul/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardPage2 extends StatefulWidget {
  const OnboardPage2({Key? key}) : super(key: key);

  @override
  State<OnboardPage2> createState() => _OnboardPage2State();
}

class _OnboardPage2State extends State<OnboardPage2> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _PictureWidget(),
              SizedBox(
                height: 26,
              ),
              _StartWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PictureWidget extends StatelessWidget {
  const _PictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SvgPicture.asset('assets/Group.svg'),
          const SizedBox(
            height: 26,
          ),
          const SizedBox(
            child: Text(
              'Tìm Kiếm Sản Phẩm Theo KOL Bạn Yêu Thích',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF112835),
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          const Text(
            ' Thường xuyên theo dõi KOL bạn đã follow để xem những sản phẩm mới nhất nhé..!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF797E7E),
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class _StartWidget extends StatefulWidget {
  const _StartWidget({Key? key}) : super(key: key);

  @override
  State<_StartWidget> createState() => _StartWidgetState();
}

class _StartWidgetState extends State<_StartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFE9E9E9),
              ),
              height: 6,
              width: 25,
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFF9BE6CF),
              ),
              height: 6,
              width: 25,
            ),
            const SizedBox(
              width: 4,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFE9E9E9),
              ),
              height: 6,
              width: 25,
            ),
          ],
        ),
        const SizedBox(height: 40),
        Ink(
          child: InkWell(
            onTap: () {
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const LoginPage(),
                  ),
                );
              }
            },
            child: const Text(
              'Bỏ qua',
              style: TextStyle(
                color: Color(0xFF5F6D70),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        )
      ],
    );
  }
}
