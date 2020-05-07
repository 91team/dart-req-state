import 'package:dart_req_state_example/src/ui/screens/test/controller/controller.dart';
import 'package:dart_req_state_example/src/ui/screens/test/widgets/meta.dart';
import 'package:dart_req_state_example/src/ui/screens/test/widgets/simple.dart';
import 'package:dart_req_state_example/src/ui/widgets/screen_wrapper/screen_wrapper.dart';
import 'package:flutter/material.dart' hide Switch;
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TestScreen extends StatelessWidget {
  final Animation<double> animationAppearance;

  const TestScreen({Key key, this.animationAppearance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      creator: () => TestScreenController()..init(),
      child: Observer(
        builder: (context) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Divider(),
                Meta(),
                Divider(),
                SizedBox(
                  height: 100,
                ),
                Divider(),
                Simple(),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
