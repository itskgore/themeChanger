import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themeswitch/provider/theme_provider.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;

  AnimatedToggle({Key key, this.values, this.onToggleCallback})
      : super(key: key);

  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final theme = Provider.of<ThemeProvider>(context);
    return Container(
      width: width * .7,
      height: width * .13,
      child: Stack(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                widget.onToggleCallback(1);
              },
              child: Container(
                width: width * .7,
                height: width * .13,
                decoration: ShapeDecoration(
                    color: theme.themeMode().toggleBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * .1))),
                child: Row(
                  children: List.generate(
                      widget.values.length,
                      (index) => Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * .1),
                            child: Text(
                              widget.values[index],
                              style: TextStyle(
                                  fontSize: width * .05,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF918f95)),
                            ),
                          )),
                ),
              )),
          AnimatedAlign(
            alignment: theme.isLightTheme
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
            child: Container(
              alignment: Alignment.center,
              width: width * .35,
              height: width * .13,
              decoration: ShapeDecoration(
                  color: theme.themeMode().toggleBackgroundColor,
                  shadows: theme.themeMode().shadow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * .1))),
              child: Text(
                theme.isLightTheme ? widget.values[0] : widget.values[1],
                style: TextStyle(
                    fontSize: width * .045, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
