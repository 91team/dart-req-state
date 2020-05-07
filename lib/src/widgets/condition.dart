import 'package:flutter/widgets.dart';

import '../req_state.dart';
import '../req_state_statuses.dart';

typedef _THandler<T extends ReqStateStatus> = Widget Function(
  BuildContext context, {
  @required T status,
});

class ReqStateCondition<TOnTrue extends ReqStateStatus> extends StatelessWidget {
  final Widget _defaultWidget;
  final ReqState _reqState;

  final _THandler<TOnTrue> onTrue;
  final _THandler onFalse;

  const ReqStateCondition(
    ReqState reqState, {
    Key key,
    this.onTrue,
    this.onFalse,
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
        if (snapshot.data is TOnTrue && onTrue != null) {
          return _execHandler<TOnTrue>(
            context: context,
            handler: onTrue,
          );
        }

        if (onFalse != null) {
          return _execHandler(
            context: context,
            handler: onFalse,
          );
        }

        return _defaultWidget;
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
