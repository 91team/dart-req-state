import 'package:dart_req_state/dart_req_state.dart';
import 'package:dart_req_state_example/src/ui/screens/test/controller/controller.dart';
import 'package:dart_req_state_example/src/ui/widgets/provider/provider.dart';
import 'package:flutter/widgets.dart';

class SimpleSectionTitle extends StatelessWidget {
  const SimpleSectionTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ReqStateCondition<ReqStateStatusIDLE>(
    //   context.provide<TestScreenController>().simpleReqState,
    //   onIf: _buildOnIfIdle,
    //   onElse: _buildOnElseIdle,
    // );

    return ReqStateSwitcher(
      context.provide<TestScreenController>().simpleReqState,
      onIDLE: _buildOnIfIdle,
      onPending: _buildOnElseIdle,
      // onFailed: _buildOnElseIdle,
      // onSucceeded: _buildOnElseIdle,
      onOther: _buildOnElseIdle,
    );
  }

  Widget _buildOnIfIdle(BuildContext context, {ReqStateStatus status}) {
    return Text(
      context.provide<TestScreenController>().simpleReqState.status.toString(),
    );
  }

  Widget _buildOnElseIdle(BuildContext context, {ReqStateStatus status}) {
    return Text("${status.toString()}");
  }
}
