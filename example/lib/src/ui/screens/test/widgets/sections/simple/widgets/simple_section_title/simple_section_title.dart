import 'package:dart_req_state/dart_req_state.dart';
import 'package:dart_req_state_example/src/ui/screens/test/controller/controller.dart';
import 'package:dart_req_state_example/src/ui/widgets/provider/provider.dart';
import 'package:flutter/widgets.dart';

class SimpleSectionTitle extends StatelessWidget {
  const SimpleSectionTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReqStateSwitcher(
      context.provide<TestScreenController>().simpleReqState,
      onIDLE: (context, {status}) => Text(
        context.provide<TestScreenController>().simpleReqState.status.toString(),
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
    );
  }
}
