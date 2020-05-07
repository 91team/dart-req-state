import 'package:dart_req_state_example/src/ui/screens/test/controller/controller.dart';
import 'package:dart_req_state_example/src/ui/widgets/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'widgets/simple_section_header/simple_section_header.dart';
import 'widgets/simple_section_title/simple_section_title.dart';

class Simple extends StatelessWidget {
  const Simple({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SectionHeader(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SimpleSectionTitle(),
            CupertinoSwitch(
              value: context.provide<TestScreenController>().simpleIsSwitcherEnabled,
              onChanged: context.provide<TestScreenController>().simpleSetIsSwitcherEnabled,
            ),
          ],
        ),
      ],
    );
  }
}
