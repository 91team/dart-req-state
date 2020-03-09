import 'package:dart_req_state/dart_req_state.dart';
import 'package:dart_req_state_example/src/ui/screens/test/controller/controller.dart';
import 'package:dart_req_state_example/src/ui/widgets/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Simple extends StatelessWidget {
  const Simple({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ReqStateSwitcher(
              context.provide<TestScreenController>().simpleReqState,
              onIDLE: (context, {status}) => Text(
                context
                    .provide<TestScreenController>()
                    .simpleReqState
                    .status
                    .toString(),
              ),
              onPending: (context, {status}) {
                return Text("${status.toString()}");
              },
              onFailed: (context, {status}) {
                return Text("${status.toString()}");
              },
              onSucceeded: (context, {status}) {
                return Text("${status.toString()}");
              },
            ),
            CupertinoSwitch(
              value: context
                  .provide<TestScreenController>()
                  .simpleIsSwitcherEnabled,
              onChanged: context
                  .provide<TestScreenController>()
                  .simpleSetIsSwitcherEnabled,
            ),
          ],
        ),
      ],
    );
  }
}
