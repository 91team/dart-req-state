import 'package:flutter/widgets.dart';

import 'widgets/simple_section_header/simple_section_header.dart';
import 'widgets/simple_section_switcher/simple_section_switcher.dart';
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
            SimpleSectionSwitcher(),
          ],
        ),
      ],
    );
  }
}
