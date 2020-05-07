import 'package:flutter/widgets.dart';

import '../req_state.dart';
import '../req_state_statuses.dart';

typedef _THandler = Widget Function(
  BuildContext context, {
  @required ReqStateStatus status,
});

class ReqStateCondition<TIF> extends StatelessWidget {
  final Widget _defaultWidget;
  final ReqState _reqState;

  final _THandler onIf;
  final _THandler onElse;

  const ReqStateCondition(
    ReqState reqState, {
    Key key,
    this.onIf,
    this.onElse,
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
        if (snapshot.data is TIF && onIf != null) {
          return _execHandler(
            context: context,
            handler: onIf,
          );
        }

        if (onElse != null) {
          return _execHandler(
            context: context,
            handler: onIf,
          );
        }

        return _defaultWidget;
      },
    );
  }

  Widget _execHandler({
    BuildContext context,
    _THandler handler,
  }) {
    return handler != null ? handler(context, status: _reqState.status) : _defaultWidget;
  }
}
