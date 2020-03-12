import 'package:flutter/widgets.dart';

import 'req_state.dart';
import 'req_state_statuses.dart';

typedef Tlistener<T extends ReqStateStatus> = Widget Function(
  BuildContext context, {
  @required T status,
});

class ReqStateSwitcher extends StatelessWidget {
  final Widget _defaultWidget;
  final ReqState _reqState;

  final Tlistener<ReqStateStatusIDLE> onIDLE;
  final Tlistener<ReqStateStatusPending> onPending;
  final Tlistener<ReqStateStatusSucceeded> onSucceeded;
  final Tlistener<ReqStateStatusFailed> onFailed;

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
          return _runListener<ReqStateStatusIDLE>(
            context: context,
            listener: onIDLE,
          );
        }

        if (snapshot.data is ReqStateStatusPending) {
          return _runListener<ReqStateStatusPending>(
            context: context,
            listener: onPending,
          );
        }

        if (snapshot.data is ReqStateStatusSucceeded) {
          return _runListener<ReqStateStatusSucceeded>(
            context: context,
            listener: onSucceeded,
          );
        }

        if (snapshot.data is ReqStateStatusFailed) {
          return _runListener<ReqStateStatusFailed>(
            context: context,
            listener: onFailed,
          );
        }

        return _defaultWidget;
      },
    );
  }

  Widget _runListener<TL extends ReqStateStatus>({
    BuildContext context,
    Tlistener<TL> listener,
  }) {
    return listener != null ? listener(context, status: _reqState.status) : _defaultWidget;
  }
}
