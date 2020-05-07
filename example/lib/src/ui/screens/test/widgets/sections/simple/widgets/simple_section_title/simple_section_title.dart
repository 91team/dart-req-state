import 'package:dart_req_state/dart_req_state.dart';
import 'package:dart_req_state_example/src/ui/screens/test/controller/controller.dart';
import 'package:dart_req_state_example/src/ui/widgets/provider/provider.dart';
import 'package:flutter/widgets.dart';

class SimpleSectionTitle extends StatelessWidget {
  const SimpleSectionTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ReqStateCondition<ReqStateStatusSucceeded>(
    //   context.provide<TestScreenController>().simpleReqState,
    //   onIf: _buildOnIfSucceeded,
    //   onElse: _buildOnElseSucceeded,
    // );

    return ReqStateSwitcher(
      context.provide<TestScreenController>().simpleReqState,
      onSucceeded: _buildOnIfSucceeded,
      onPending: _buildOnElseSucceeded,
      // onFailed: _buildOnElseIdle,
      // onSucceeded: _buildOnElseIdle,
      onOther: _buildOnElseSucceeded,
    );
  }

  Widget _buildOnIfSucceeded(BuildContext context, {ReqStateStatus status}) {
    return Text(
      context.provide<TestScreenController>().simpleReqState.status.toString(),
    );
  }

  Widget _buildOnElseSucceeded(BuildContext context, {ReqStateStatus status}) {
    return Text("${status.toString()}");
  }
}
