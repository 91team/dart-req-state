import 'package:dart_req_state/dart_req_state.dart';
import 'package:dart_req_state_example/src/ui/screens/test/controller/controller.dart';
import 'package:dart_req_state_example/src/ui/widgets/provider/provider.dart';
import 'package:flutter/widgets.dart';

class MetaSectionTitle extends StatelessWidget {
  const MetaSectionTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReqStateSwitcher(
      context.provide<TestScreenController>().metaReqState,
      onIDLE: _buildOnEvery,
      onPending: _buildOnEvery,
      onFailed: _buildOnEvery,
      onSucceeded: _buildOnEvery,
    );
  }

  Widget _buildOnEvery(BuildContext context, {ReqStateStatus status}) {
    return Text(
      "${status.toString()}::${status.retrieveMeta()}",
    );
  }
}
