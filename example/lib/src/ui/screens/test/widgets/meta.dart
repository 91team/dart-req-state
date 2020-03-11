import 'package:dart_req_state/dart_req_state.dart';
import 'package:dart_req_state_example/src/ui/screens/test/controller/controller.dart';
import 'package:dart_req_state_example/src/ui/widgets/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Meta extends StatelessWidget {
  const Meta({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ReqStateSwitcher(
              context.provide<TestScreenController>().metaReqState,
              onIDLE: (context, {status}) => Text(
                context
                    .provide<TestScreenController>()
                    .metaReqState
                    .status
                    .toString(),
              ),
              onPending: (context, {status}) {
                return Text(
                  "${status.toString()}::${status.retrieveMeta()}",
                );
              },
              onFailed: (context, {status}) {
                return Text(
                  "${status.toString()}::${status.retrieveMeta()}",
                );
              },
              onSucceeded: (context, {status}) {
                return Text(
                  "${status.toString()}::${status.retrieveMeta()}",
                );
              },
            ),
            CupertinoSwitch(
              value:
                  context.provide<TestScreenController>().metaIsSwitcherEnabled,
              onChanged: context
                  .provide<TestScreenController>()
                  .metaSetIsSwitcherEnabled,
            ),
          ],
        ),
      ],
    );
  }
}
