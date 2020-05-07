import 'package:dart_req_state_example/src/ui/screens/test/controller/controller.dart';
import 'package:dart_req_state_example/src/ui/widgets/provider/provider.dart';
import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/widgets.dart';

class SimpleSectionSwitcher extends StatelessWidget {
  const SimpleSectionSwitcher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: context.provide<TestScreenController>().simpleIsSwitcherEnabled,
      onChanged: context.provide<TestScreenController>().simpleSetIsSwitcherEnabled,
    );
  }
}