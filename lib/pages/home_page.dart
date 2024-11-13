import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/history_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);

  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 4;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const ProductsPage(),
    const CartPage(),
    const HistoryPage(),
    // const UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              removeMargins: true,
              durationInMilliSeconds: 150,
              shadowElevation: 5,
              textOverflow: TextOverflow.visible,
              notchBottomBarController: _controller,
              bottomBarHeight: 40,
              bottomBarItems: const [
                BottomBarItem(
                    inActiveItem: Icon(Icons.search),
                    activeItem: Icon(Icons.search,
                        color: Color.fromRGBO(67, 176, 42, 1)),
                    itemLabel: 'Каталог'),
                BottomBarItem(
                    inActiveItem: Icon(Icons.shopping_basket),
                    activeItem: Icon(Icons.shopping_basket,
                        color: Color.fromRGBO(67, 176, 42, 1)),
                    itemLabel: 'Кошик'),
                BottomBarItem(
                    inActiveItem: Icon(Icons.history),
                    activeItem: Icon(Icons.history,
                        color: Color.fromRGBO(67, 176, 42, 1)),
                    itemLabel: 'Історія'),
                BottomBarItem(
                    inActiveItem: Icon(Icons.person),
                    activeItem: Icon(Icons.person,
                        color: Color.fromRGBO(67, 176, 42, 1)),
                    itemLabel: 'Профіль'),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
              kBottomRadius: 16)
          : null,
    );
  }
}
