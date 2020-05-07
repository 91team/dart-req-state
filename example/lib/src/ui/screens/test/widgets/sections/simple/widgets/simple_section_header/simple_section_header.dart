import 'package:flutter/widgets.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'example/lib/src/ui/steens/test/widgets/simple.dart',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Самый распространенный случай использования',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
