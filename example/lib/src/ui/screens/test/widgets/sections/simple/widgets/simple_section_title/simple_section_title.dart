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
    //   onTrue: _buildIfSucceeded,
    //   onFalse: _buildElse,
    // );

    return ReqStateSwitcher(
      context.provide<TestScreenController>().simpleReqState,
      onSucceeded: _buildIfSucceeded,
      onPending: _buildElse,
      // onFailed: _buildOnElseIdle,
      // onSucceeded: _buildOnElseIdle,
      onOther: _buildElse,
    );
  }

  Widget _buildIfSucceeded(BuildContext context, {ReqStateStatusSucceeded status}) {
    return Text(
      context.provide<TestScreenController>().simpleReqState.status.toString() +
          context.provide<TestScreenController>().simpleReqState.status.toString(),
    );
  }

  Widget _buildElse(BuildContext context, {ReqStateStatus status}) {
    return Text("${status.toString()}" + "${status.toString()}" + "${status.toString()}");
  }
}
