import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sgela_services/sgela_util/dark_light_control.dart';
import 'package:sgela_services/sgela_util/sponsor_prefs.dart';
import 'package:sgela_services/sgela_util/functions.dart';
import 'package:sgela_shared_widgets/util/widget_prefs.dart';

import '../util/gaps.dart';
import '../util/styles.dart';


class ColorGallery extends StatefulWidget {
  const ColorGallery(
      {super.key, required this.prefs, required this.colorWatcher});

  final WidgetPrefs prefs;
  final ColorWatcher colorWatcher;

  @override
  ColorGalleryState createState() => ColorGalleryState();
}

class ColorGalleryState extends State<ColorGallery> {
  Color? selectedColor;
  List<Color> colors = [];
  DarkLightControl darkLightControl = GetIt.instance<DarkLightControl>();
  SponsorPrefs prefs = GetIt.instance<SponsorPrefs>();

  @override
  void initState() {
    super.initState();
    colors = getColors();
    pp('colors available: ${colors.length}');
    _getMode();
  }

  _getMode() {
    mode = prefs.getMode();
    colorIndex = prefs.getColorIndex();
  }
  void _setColorIndex(int index) {
    widget.prefs.saveColorIndex(index);
    widget.colorWatcher.setColor(index);
    prefs.saveColorIndex(index);

    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pop(index);
    });
  }

  int mode = 0;
  int colorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Primary Colour',
              style: mode == LIGHT? myTextStyle(
                  context, Theme.of(context).primaryColor, 18, FontWeight.bold): myTextStyleMedium(context),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      gapH16,
                      Text(
                        'Tap to select your app\'s colour',
                        style: mode == LIGHT? myTextStyle(
                            context,
                            Theme.of(context).primaryColor,
                            16,
                            FontWeight.bold) : myTextStyleMedium(context),
                      ),
                      gapH16,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount: colors.length,
                              itemBuilder: (_, index) {
                                var color = colors.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = color;
                                      _setColorIndex(index);
                                    });
                                  },
                                  child: Container(
                                    color: color,
                                    margin: const EdgeInsets.all(8),
                                    child: selectedColor == color
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                );
                              }),
                        ),
                      ),
                      Card(
                        elevation: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RadioMenuButton(
                                value: 0,
                                groupValue: groupValue,
                                onChanged: (c) {
                                  pp('on DARK radio changed c:$c');
                                  _setMode(c!);
                                },
                                child: const Text('Dark Mode')),
                            RadioMenuButton(
                                value: 1,
                                groupValue: groupValue,
                                onChanged: (c) {
                                  pp('on LIGHT radio changed c:$c');
                                  _setMode(c!);
                                },
                                child: const Text('Light Mode')),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  int groupValue = -1;

  void _setMode(int c) {
    pp('...mode is $c');
    if (c == 0) {
      darkLightControl.setDarkMode();
    } else {
      darkLightControl.setLightMode();
    }
    prefs.saveMode(c);
    setState(() {
      groupValue = c;
      mode = c;
    });
  }
}


final List<Color> _colors = [
  Colors.red[200]!,
  Colors.green[200]!,
  Colors.blue[200]!,
  Colors.yellow[200]!,
  Colors.pink[200]!,
  Colors.teal[200]!,
  Colors.indigo[200]!,
  Colors.brown[200]!,
  Colors.deepPurple[200]!,
  Colors.amber[200]!,
  Colors.lightGreen[200]!,
  Colors.orange[200]!,
  Colors.cyan[200]!,
  Colors.red[300]!,
  Colors.green[300]!,
  Colors.blue[300]!,
  Colors.yellow[300]!,
  Colors.pink[300]!,
  Colors.teal[300]!,
  Colors.indigo[300]!,
  Colors.brown[300]!,
  Colors.deepPurple[300]!,
  Colors.amber[300]!,
  Colors.lightGreen[300]!,
  Colors.orange[300]!,
  Colors.cyan[300]!,
  Colors.red[400]!,
  Colors.green[400]!,
  Colors.blue[400]!,
  Colors.yellow[400]!,
  Colors.pink[400]!,
  Colors.teal[400]!,
  Colors.indigo[400]!,
  Colors.brown[400]!,
  Colors.deepPurple[400]!,
  Colors.amber[400]!,
  Colors.lightGreen[400]!,
  Colors.orange[400]!,
  Colors.cyan[400]!,
  Colors.grey[600]!,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.pink,
  Colors.teal,
  Colors.indigo,
  Colors.brown,
  Colors.deepPurple,
  Colors.amber,
  Colors.lightGreen,
  Colors.orange,
  Colors.cyan,
  Colors.red[700]!,
  Colors.green[700]!,
  Colors.blue[700]!,
  Colors.yellow[700]!,
  Colors.pink[700]!,
  Colors.teal[700]!,
  Colors.indigo[700]!,
  Colors.brown[700]!,
  Colors.deepPurple[700]!,
  Colors.amber[700]!,
  Colors.lightGreen[700]!,
  Colors.orange[700]!,
  Colors.cyan[700]!,
];

List<Color> getColors() {
  return _colors;
}
