import 'dart:async';

import 'package:meta/meta.dart';

import 'req_state_statuses.dart';

typedef ExecFn = Future<void> Function();
typedef ExecFnWithMeta<Meta> = Future<dynamic> Function(void Function(Meta m));

class ReqState {
  final _controller = StreamController<ReqStateStatus>.broadcast();
  ReqStateStatus _currentStatus = ReqStateStatusIDLE();

  ReqStateStatus get status => _currentStatus;
  Stream<ReqStateStatus> get stream => _controller.stream;
  bool get isClosed => _controller.isClosed;

  void dispose() {
    _controller.close();
  }

  void resetStatus() {
    _switchToStatus(status: ReqStateStatusIDLE());
  }

  Future<void> executeWithRethrowOnFail(ExecFn execFn) async {
    try {
      swithStatusToPending();
      await execFn();
      swithStatusToSucceesed();
    } catch (e) {
      swithStatusToFailed();
      rethrow;
    }
  }

  Future<void> executeWithCallbackOnFail(
    ExecFn execFn, {
    Function(Exception) onFailed,
  }) async {
    try {
      swithStatusToPending();
      await execFn();
      swithStatusToSucceesed();
    } catch (e) {
      swithStatusToFailed();

      if (onFailed != null) {
        onFailed(e);
      }
    }
  }

  Future<void> executeWithMeta<TMeta>(
    ExecFnWithMeta<TMeta> execFn, {
    TMeta withInitialPendingMeta,
  }) async {
    try {
      swithStatusToPending(withMeta: withInitialPendingMeta);
      var successMeta = await execFn((TMeta meta) {
        swithStatusToPending(withMeta: meta);
      });
      swithStatusToSucceesed(withMeta: successMeta);
    } catch (e) {
      swithStatusToFailed(withMeta: e);
    }
  }

  void switchStatusByKey<TMeta>({
    @required ReqStateStatusKey to,
    TMeta withMeta,
  }) {
    switch (to) {
      case ReqStateStatusKey.PENDING:
        swithStatusToPending<TMeta>(withMeta: withMeta);
        break;
      case ReqStateStatusKey.SUCCEEDED:
        swithStatusToSucceesed<TMeta>(withMeta: withMeta);
        break;
      case ReqStateStatusKey.FAILED:
        swithStatusToFailed<TMeta>(withMeta: withMeta);
        break;
      case ReqStateStatusKey.IDLE:
        swithStatusToIDLE<TMeta>(withMeta: withMeta);
        break;
      default:
        throw Exception('Got unexpected status $to');
    }
  }

  void swithStatusToIDLE<TMeta>({TMeta withMeta}) {
    _switchToStatus(status: ReqStateStatusIDLE(meta: withMeta));
  }

  void swithStatusToPending<TMeta>({TMeta withMeta}) {
    _switchToStatus(status: ReqStateStatusPending<TMeta>(meta: withMeta));
  }

  void swithStatusToSucceesed<TMeta>({TMeta withMeta}) {
    _switchToStatus(status: ReqStateStatusSucceeded(meta: withMeta));
  }

  void swithStatusToFailed<TMeta>({TMeta withMeta}) {
    _switchToStatus(status: ReqStateStatusFailed(meta: withMeta));
  }

  void _switchToStatus<TMeta>({ReqStateStatus<TMeta> status}) {
    _currentStatus = status;
    _controller.add(_currentStatus);
  }
}
