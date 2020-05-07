import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'widgets/meta_section_header/meta_section_header.dart';
import 'widgets/meta_section_switcher/meta_section_switcher.dart';
import 'widgets/meta_section_title/meta_section_title.dart';

class Meta extends StatelessWidget {
  const Meta({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        MetaHeader(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MetaSectionTitle(),
            MetaSectionSwitcher(),
          ],
        ),
      ],
    );
  }
}
