import 'package:flutter/widgets.dart';

import 'req_state.dart';
import 'req_state_statuses.dart';

typedef Tlistenner<T extends ReqStateStatus> = Widget Function(
  BuildContext context, {
  @required T status,
});

class ReqStateSwitcher extends StatelessWidget {
  final Widget _defaultWidget;
  final ReqState _reqState;

  final Tlistenner<ReqStateStatusIDLE> onIDLE;
  final Tlistenner<ReqStateStatusPending> onPending;
  final Tlistenner<ReqStateStatusSucceeded> onSucceeded;
  final Tlistenner<ReqStateStatusFailed> onFailed;

  const ReqStateSwitcher(
    ReqState reqState, {
    Key key,
    this.onIDLE,
    this.onPending,
    this.onSucceeded,
    this.onFailed,
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
        if (snapshot.data is ReqStateStatusIDLE) {
          return _runListenner<ReqStateStatusIDLE>(
            context: context,
            listenner: onIDLE,
          );
        }

        if (snapshot.data is ReqStateStatusPending) {
          return _runListenner<ReqStateStatusPending>(
            context: context,
            listenner: onPending,
          );
        }

        if (snapshot.data is ReqStateStatusSucceeded) {
          return _runListenner<ReqStateStatusSucceeded>(
            context: context,
            listenner: onSucceeded,
          );
        }

        if (snapshot.data is ReqStateStatusFailed) {
          return _runListenner<ReqStateStatusFailed>(
            context: context,
            listenner: onFailed,
          );
        }

        return _defaultWidget;
      },
    );
  }

  Widget _runListenner<TL extends ReqStateStatus>({
    BuildContext context,
    Tlistenner<TL> listenner,
  }) {
    return listenner != null
        ? listenner(context, status: _reqState.status)
        : _defaultWidget;
  }
}
