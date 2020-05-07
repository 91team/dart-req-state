import 'package:flutter/widgets.dart';

import '../req_state.dart';
import '../req_state_statuses.dart';

typedef Tlistener = Widget Function(
  BuildContext context, {
  @required ReqStateStatus status,
});

class ReqStateSwitcher extends StatelessWidget {
  final Widget _defaultWidget;
  final ReqState _reqState;

  final Tlistener onIDLE;
  final Tlistener onPending;
  final Tlistener onSucceeded;
  final Tlistener onFailed;
  final Tlistener onCancelled;

  ReqStateSwitcher(
    ReqState reqState, {
    Key key,
    this.onIDLE,
    this.onPending,
    this.onSucceeded,
    this.onFailed,
    this.onCancelled,
  })  : _defaultWidget = const SizedBox.shrink(),
        _reqState = reqState,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ReqStateStatus>(
      stream: _reqState.stream,
      initialData: _reqState.status,
      builder: (
        BuildContext streamBuilderContext,
        AsyncSnapshot<ReqStateStatus> snapshot,
      ) {
        if (snapshot.data is ReqStateStatusCancelled) {
          return _runListener(
            context: context,
            listener: onCancelled,
          );
        }

        if (snapshot.data is ReqStateStatusIDLE) {
          return _runListener(
            context: context,
            listener: onIDLE,
          );
        }

        if (snapshot.data is ReqStateStatusPending) {
          return _runListener(
            context: context,
            listener: onPending,
          );
        }

        if (snapshot.data is ReqStateStatusSucceeded) {
          return _runListener(
            context: context,
            listener: onSucceeded,
          );
        }

        if (snapshot.data is ReqStateStatusFailed) {
          return _runListener(
            context: context,
            listener: onFailed,
          );
        }

        return _defaultWidget;
      },
    );
  }

  Widget _runListener({
    BuildContext context,
    Tlistener listener,
  }) {
    return listener != null ? listener(context, status: _reqState.status) : _defaultWidget;
  }
}
