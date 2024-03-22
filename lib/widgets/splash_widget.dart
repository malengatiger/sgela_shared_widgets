import 'package:flutter/material.dart';
import 'package:sgela_shared_widgets/util/styles.dart';
class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  static const mm = '💠💠💠💠💠💠💠💠 SplashWidget';

  @override
  void initState() {
    super.initState();
  }

  String? message;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AnimatedContainer(
        // width: 300, height: 300,
        curve: Curves.easeInOutCirc,
        duration: const Duration(milliseconds: 3000),
        child: Card(
          elevation: 16.0,
          // shape: getRoundedBorder(radius: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Image.asset(
                  'assets/sgela_logo2.png',
                  height: 96,
                  width: 96,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const FaIcon(FontAwesomeIcons.anchorCircleCheck),

                  Text(
                    message == null ? 'We help you experience more!' : message!,
                    style: myTextStyleSmall(context),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  const Text('🔷🔷'),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
