import 'package:flutter/widgets.dart';

import '../req_state.dart';
import '../req_state_statuses.dart';

typedef _THandler<T extends ReqStateStatus> = Widget Function(
  BuildContext context, {
  @required T status,
});

class ReqStateSwitcher extends StatelessWidget {
  final Widget _defaultWidget;
  final ReqState _reqState;

  final _THandler<ReqStateStatusIDLE> onIDLE;
  final _THandler<ReqStateStatusPending> onPending;
  final _THandler<ReqStateStatusSucceeded> onSucceeded;
  final _THandler<ReqStateStatusFailed> onFailed;
  final _THandler<ReqStateStatusCancelled> onCancelled;
  final _THandler onOther;

  ReqStateSwitcher(
    ReqState reqState, {
    Key key,
    this.onIDLE,
    this.onPending,
    this.onSucceeded,
    this.onFailed,
    this.onCancelled,
    this.onOther,
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
        if (snapshot.data is ReqStateStatusIDLE && onIDLE != null) {
          return _execHandler<ReqStateStatusIDLE>(
            context: context,
            handler: onIDLE,
          );
        }

        if (snapshot.data is ReqStateStatusPending && onPending != null) {
          return _execHandler<ReqStateStatusPending>(
            context: context,
            handler: onPending,
          );
        }

        if (snapshot.data is ReqStateStatusSucceeded && onSucceeded != null) {
          return _execHandler<ReqStateStatusSucceeded>(
            context: context,
            handler: onSucceeded,
          );
        }

        if (snapshot.data is ReqStateStatusFailed && onFailed != null) {
          return _execHandler<ReqStateStatusFailed>(
            context: context,
            handler: onFailed,
          );
        }

        if (snapshot.data is ReqStateStatusCancelled && onCancelled != null) {
          return _execHandler<ReqStateStatusCancelled>(
            context: context,
            handler: onCancelled,
          );
        }

        return _execHandler(
          context: context,
          handler: onOther,
        );
      },
    );
  }

  Widget _execHandler<T extends ReqStateStatus>({
    BuildContext context,
    _THandler<T> handler,
  }) {
    return handler != null ? handler(context, status: _reqState.status) : _defaultWidget;
  }
}
