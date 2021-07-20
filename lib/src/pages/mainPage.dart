import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/src/app/controllers/AuthController.dart';
import 'package:flutter_ecommerce/src/pages/auth/signIn.dart';
import 'package:flutter_ecommerce/src/pages/categories/index.dart';
import 'package:flutter_ecommerce/src/pages/home_page.dart';
import 'package:flutter_ecommerce/src/pages/products/index.dart';
import 'package:flutter_ecommerce/src/pages/shopping_cart_page.dart';
import 'package:flutter_ecommerce/src/pages/users/index.dart';
import 'package:flutter_ecommerce/src/themes/light_color.dart';
import 'package:flutter_ecommerce/src/themes/theme.dart';
import 'package:flutter_ecommerce/src/widgets/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:flutter_ecommerce/src/widgets/title_text.dart';
import 'package:flutter_ecommerce/src/widgets/extentions.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isHomePageSelected = true;
  Widget _appBar(GlobalKey<ScaffoldState> curentKey) {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print('Some message');
              curentKey.currentState!.openDrawer();
            },
            // onTap: () => _scaffoldKey.currentState!.openDrawer(),
            child: _icon(Icons.sort, color: Colors.black54),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn())); 
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Color(0xfff8f8f8),
                        blurRadius: 10,
                        spreadRadius: 10),
                  ],
                ),
                child: Image.asset("assets/user.png"),
              ),
            ),
          ),GestureDetector(
            onTap:(){
              AuthController().signOut();
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
            },
            child:Icon(Icons.logout)
          )
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: isHomePageSelected ? 'Our' : 'Shopping',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text: isHomePageSelected ? 'Products' : 'Cart',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            Spacer(),
            !isHomePageSelected
                ? Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.delete_outline,
                      color: LightColor.orange,
                    ),
                  ).ripple(() {},
                    borderRadius: BorderRadius.all(Radius.circular(13)))
                : SizedBox()
          ],
        ));
  }

  void onBottomIconPressed(int index) {
    if (index == 0 || index == 1) {
      setState(() {
        isHomePageSelected = true;
      });
    } else {
      setState(() {
        isHomePageSelected = false;
      });
    }
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: Text('Users'),
            leading: Icon(Icons.supervised_user_circle_sharp),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserIndex()));
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categories'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryIndex()));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_sharp),
            title: Text('Products'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductIndex()));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      key: _scaffoldKey,
      drawer: _drawer(),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _appBar(_scaffoldKey),
                    // _appBar(),
                    _title(),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInToLinear,
                        switchOutCurve: Curves.easeOutBack,
                        child: isHomePageSelected
                            ? MyHomePage(
                                title: 'Some',
                              )
                            : Align(
                                alignment: Alignment.topCenter,
                                child: ShoppingCartPage(),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                onIconPresedCallback: onBottomIconPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
