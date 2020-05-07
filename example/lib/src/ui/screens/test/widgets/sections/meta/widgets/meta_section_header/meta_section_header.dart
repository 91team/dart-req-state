import 'package:flutter/widgets.dart';

class MetaHeader extends StatelessWidget {
  const MetaHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'example/lib/src/ui/steens/test/widgets/meta.dart',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Получение мета инфы в виджете\nв данном случае после PENDING будет FAILED',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
