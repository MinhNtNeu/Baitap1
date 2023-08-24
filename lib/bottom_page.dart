import 'package:besoul/account_page.dart';
import 'package:besoul/brand_page.dart';
import 'package:besoul/discover_page.dart';
import 'package:besoul/home_page.dart';
import 'package:besoul/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'model/images.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}
class _BottomPageState extends State<BottomPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DiscoverPage(),
    AccountPage(),
    NotifocationPage(),
    BrandPage(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _widgetOptions[_selectedIndex],
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Union.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: const TextStyle(color: Colors.grey),
              items: [
                const BottomNavigationBarItem(
                  icon: _IconWidget(icon: icHome),
                  activeIcon: _IconWidget(icon: icDHome),
                  label: 'Trang chủ',
                ),
                const BottomNavigationBarItem(
                  activeIcon: _IconWidget(icon: icDiscover),
                  icon: _IconWidget(icon: icDiscover),
                  label: 'Khám phá',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(30), // Image radius
                          child: Image.asset(avatar, width: 5, height: 5),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      SvgPicture.asset(icEllipse),
                    ],
                  ),
                  label: 'Tài khoản',
                ),
                const BottomNavigationBarItem(
                  activeIcon: _IconWidget(icon: icDTag),
                  icon: _IconWidget(icon: icTag),
                  label: 'Brand',
                ),
                const BottomNavigationBarItem(
                  activeIcon: _IconWidget(icon: icDBell),
                  icon: _IconWidget(icon: icBell),
                  label: 'Thông báo',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xFF12A9CA),
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
class _IconWidget extends StatelessWidget {
  const _IconWidget({Key? key, required this.icon}) : super(key: key);
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
        ),
        const SizedBox(height: 20,),
        SvgPicture.asset(icon,width: 22,height: 22,),
      ],
    );
  }
}
