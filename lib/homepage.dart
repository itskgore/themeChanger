import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themeswitch/animatedToggle.dart';
import 'package:themeswitch/provider/theme_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  changeThemeMode(bool theme) {
    if (!theme) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('HomePage'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: height * 0.1),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: themeProvider.isLightTheme ? 1 : 0,
                  child: Text(
                    'Light Mode',
                    style: TextStyle(
                        fontSize: width * .06, fontWeight: FontWeight.bold),
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: themeProvider.isLightTheme ? 0 : 1,
                  child: Text(
                    'Dark Mode',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: width * .06,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Stack(
              children: <Widget>[
                Container(
                  width: width * 0.35,
                  height: width * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: themeProvider.themeMode().gradient,
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                  ),
                ),
                Transform.translate(
                  offset: Offset(40, 0),
                  child: ScaleTransition(
                    scale: _animationController.drive(
                        Tween<double>(begin: 0.0, end: 1.0)
                            .chain(CurveTween(curve: Curves.decelerate))),
                    child: Container(
                      width: width * .26,
                      height: width * .26,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeProvider.isLightTheme
                              ? Colors.white
                              : Color(0xFF26242e)),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              'Choose a style',
              style:
                  TextStyle(fontSize: width * .06, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Container(
              width: width * .6,
              child: Text(
                  'Tap the below button to switch between \nLight & Dark mode',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      wordSpacing: 3,
                      fontSize: width * .06,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: height * .1,
            ),
            AnimatedToggle(
              values: ['Light', 'Dark'],
              onToggleCallback: (v) async {
                await themeProvider.toggleThemeData();
                setState(() {});
                changeThemeMode(themeProvider.isLightTheme);
              },
            )
          ],
        ),
      )),
    );
  }
}
