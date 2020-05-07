import 'dart:async';

import 'package:meta/meta.dart';

import 'req_state_statuses.dart';

typedef _ExecFn = Future<void> Function();
typedef _ExecFnWithMeta<Meta> = Future<dynamic> Function(void Function(Meta m));

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

  Future<void> executeWithRethrowOnFail(_ExecFn execFn) async {
    try {
      switchStatusToPending();
      await execFn();
      switchStatusToSucceeded();
    } catch (e) {
      switchStatusToFailed();
      rethrow;
    }
  }

  Future<void> executeWithCallbackOnFail(
    _ExecFn execFn, {
    Function(Exception) onFailed,
  }) async {
    try {
      switchStatusToPending();
      await execFn();
      switchStatusToSucceeded();
    } catch (e) {
      switchStatusToFailed();

      if (onFailed != null) {
        onFailed(e);
      }
    }
  }

  Future<void> executeWithMeta<TMeta>(
    _ExecFnWithMeta<TMeta> execFn, {
    TMeta withInitialPendingMeta,
  }) async {
    try {
      switchStatusToPending(withMeta: withInitialPendingMeta);
      var successMeta = await execFn((TMeta meta) {
        switchStatusToPending(withMeta: meta);
      });
      switchStatusToSucceeded(withMeta: successMeta);
    } catch (e) {
      switchStatusToFailed(withMeta: e);
    }
  }

  void switchStatusByKey<TMeta>({
    @required ReqStateStatusKey to,
    TMeta withMeta,
  }) {
    switch (to) {
      case ReqStateStatusKey.IDLE:
        switchStatusToIDLE<TMeta>(withMeta: withMeta);
        break;
      case ReqStateStatusKey.PENDING:
        switchStatusToPending<TMeta>(withMeta: withMeta);
        break;
      case ReqStateStatusKey.SUCCEEDED:
        switchStatusToSucceeded<TMeta>(withMeta: withMeta);
        break;
      case ReqStateStatusKey.FAILED:
        switchStatusToFailed<TMeta>(withMeta: withMeta);
        break;
      case ReqStateStatusKey.CANCELLED:
        switchStatusToCancelled<TMeta>(withMeta: withMeta);
        break;
      default:
        throw Exception('Got unexpected status $to');
    }
  }

  void switchStatusToIDLE<TMeta>({TMeta withMeta}) {
    _switchToStatus(status: ReqStateStatusIDLE(meta: withMeta));
  }

  void switchStatusToPending<TMeta>({TMeta withMeta}) {
    _switchToStatus(status: ReqStateStatusPending<TMeta>(meta: withMeta));
  }

  void switchStatusToSucceeded<TMeta>({TMeta withMeta}) {
    _switchToStatus(status: ReqStateStatusSucceeded(meta: withMeta));
  }

  void switchStatusToFailed<TMeta>({TMeta withMeta}) {
    _switchToStatus(status: ReqStateStatusFailed(meta: withMeta));
  }

  void switchStatusToCancelled<TMeta>({TMeta withMeta}) {
    _switchToStatus(status: ReqStateStatusCancelled(meta: withMeta));
  }

  void _switchToStatus({ReqStateStatus status}) {
    _currentStatus = status;
    _controller.add(_currentStatus);
  }
}
