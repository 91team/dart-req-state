import 'package:dart_req_state/dart_req_state.dart';
import 'package:dart_req_state_example/src/ui/screens/test/controller/controller.dart';
import 'package:dart_req_state_example/src/ui/widgets/provider/provider.dart';
import 'package:flutter/cupertino.dart' show CupertinoSwitch;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleSectionSwitcher extends StatelessWidget {
  const SimpleSectionSwitcher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReqStateSwitcher(
      context.provide<TestScreenController>().simpleReqState,
      onIDLE: _buildOnNotPending,
      onPending: _buildOnPending,
      onSucceeded: _buildOnNotPending,
      onFailed: _buildOnNotPending,
    );
  }

  Widget _buildOnNotPending(BuildContext context, {ReqStateStatus status}) {
    return CupertinoSwitch(
      value: context.provide<TestScreenController>().simpleIsSwitcherEnabled,
      onChanged: context.provide<TestScreenController>().simpleSetIsSwitcherEnabled,
    );
  }

  Widget _buildOnPending(BuildContext _, {ReqStateStatus status}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
