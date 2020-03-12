import 'dart:async';

import 'package:dart_req_state/dart_req_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ReqState reqState;

  setUp(() {
    reqState = ReqState();
  });

  group('Init', () {
    test('IDLE state', () {
      expect(reqState.status, isA<ReqStateStatusIDLE>());
    });
  });

  group('DeInit', () {
    test('.dispose', () {
      expect(reqState.isClosed, isFalse);
      reqState.dispose();
      expect(reqState.isClosed, isTrue);
    });
  });

  group('Switch status', () {
    test('.switchStatusTo', () {
      reqState.switchStatusToPending();
      expect(reqState.status, isA<ReqStateStatusPending>());

      reqState.switchStatusToFailed();
      expect(reqState.status, isA<ReqStateStatusFailed>());

      reqState.switchStatusToSucceeded();
      expect(reqState.status, isA<ReqStateStatusSucceeded>());

      reqState.switchStatusToIDLE();
      expect(reqState.status, isA<ReqStateStatusIDLE>());
    });

    test('.switchStatusByKey', () {
      reqState.switchStatusByKey(to: ReqStateStatusKey.PENDING);
      expect(reqState.status, isA<ReqStateStatusPending>());

      reqState.switchStatusByKey(to: ReqStateStatusKey.FAILED);
      expect(reqState.status, isA<ReqStateStatusFailed>());

      reqState.switchStatusByKey(to: ReqStateStatusKey.SUCCEEDED);
      expect(reqState.status, isA<ReqStateStatusSucceeded>());

      reqState.switchStatusByKey(to: ReqStateStatusKey.IDLE);
      expect(reqState.status, isA<ReqStateStatusIDLE>());
    });

    test('.resetStatus', () {
      reqState.switchStatusByKey(to: ReqStateStatusKey.PENDING);
      expect(reqState.status, isA<ReqStateStatusPending>());
      reqState.resetStatus();
      expect(reqState.status, isA<ReqStateStatusIDLE>());
    });
  });

  group('Switch status with meta', () {
    test('.swithStatusTo', () {
      reqState.switchStatusToPending<int>(withMeta: 1);
      expect(reqState.status, isA<ReqStateStatusPending>());
      expect(reqState.status.retrieveMeta<int>(), 1);

      reqState.switchStatusToSucceeded<String>(withMeta: '1');
      expect(reqState.status, isA<ReqStateStatusSucceeded>());
      expect(reqState.status.retrieveMeta<String>(), '1');

      reqState.switchStatusToFailed<ReqState>(withMeta: ReqState());
      expect(reqState.status, isA<ReqStateStatusFailed>());
      expect(reqState.status.retrieveMeta<ReqState>(), isA<ReqState>());
    });

    test('.switchStatusByKey', () {
      reqState.switchStatusByKey<int>(to: ReqStateStatusKey.PENDING, withMeta: 1);
      expect(reqState.status, isA<ReqStateStatusPending>());
      expect(reqState.status.retrieveMeta<int>(), 1);

      reqState.switchStatusByKey<String>(
        to: ReqStateStatusKey.SUCCEEDED,
        withMeta: '1',
      );
      expect(reqState.status, isA<ReqStateStatusSucceeded>());
      expect(reqState.status.retrieveMeta<String>(), '1');

      reqState.switchStatusByKey<ReqState>(
        to: ReqStateStatusKey.FAILED,
        withMeta: ReqState(),
      );
      expect(reqState.status, isA<ReqStateStatusFailed>());
      expect(reqState.status.retrieveMeta<ReqState>(), isA<ReqState>());
    });

    test('.resetStatus', () {
      reqState.switchStatusByKey<int>(to: ReqStateStatusKey.PENDING, withMeta: 1);
      expect(reqState.status, isA<ReqStateStatusPending>());
      expect(reqState.status.retrieveMeta<int>(), equals(1));

      reqState.resetStatus();
      expect(reqState.status, isA<ReqStateStatusIDLE>());
      expect(reqState.status.retrieveMeta<Null>(), equals(null));
    });
  });

  group('execute', () {
    test('.executeWithCallbackOnFail', () async {
      expect(
        reqState.stream,
        emitsInOrder([
          isA<ReqStateStatusPending>(),
          isA<ReqStateStatusSucceeded>(),
          isA<ReqStateStatusPending>(),
          isA<ReqStateStatusFailed>(),
        ]),
      );

      await reqState.executeWithCallbackOnFail(() async {
        // some payload
      });

      await reqState.executeWithCallbackOnFail(() async {
        throw new Exception("¯\_(ツ)_/¯");
      });

      reqState.dispose();
    });

    test('.executeWithRethrowOnFail', () async {
      expect(
        reqState.stream,
        emitsInOrder([
          isA<ReqStateStatusPending>(),
          isA<ReqStateStatusSucceeded>(),
          isA<ReqStateStatusPending>(),
          isA<ReqStateStatusFailed>(),
        ]),
      );

      await reqState.executeWithRethrowOnFail(() async {
        // some payload
      });

      try {
        await reqState.executeWithRethrowOnFail(() async {
          throw new Exception("¯\_(ツ)_/¯");
        });
      } catch (e) {
        expect(e, isA<Exception>());
        expect(e.message, equals('¯\_(ツ)_/¯'));
      }

      reqState.dispose();
    });
  });

  group('execute with meta', () {
    test('.executeWithMeta::success', () {
      final completer = Completer();

      reqState.executeWithMeta<int>(
        (retainMetaToPending) async {
          for (var i = 0; i < 10; i++) {
            retainMetaToPending(i);
            try {
              expect(reqState.status.retrieveMeta<int>(), equals(i));
            } catch (error) {
              completer.completeError(error);
            }
          }
          return '¯\_(ツ)_/¯';
        },
      ).then(
        (value) {
          expect(reqState.status, isA<ReqStateStatusSucceeded>());
          expect(reqState.status.retrieveMeta<String>(), equals('¯\_(ツ)_/¯'));
          completer.complete([value]);
        },
      ).catchError(
        (error) {
          completer.completeError(error);
        },
      );

      return completer.future;
    });

    test('.executeWithMeta::failed', () {
      final completer = Completer();

      reqState.executeWithMeta<int>(
        (retainMetaToPending) async {
          for (var i = 0; i < 10; i++) {
            retainMetaToPending(i);
            try {
              expect(reqState.status.retrieveMeta<int>(), equals(i));
            } catch (error) {
              completer.completeError(error);
            }

            if (i == 4) {
              throw '¯\_(ツ)_/¯';
            }
          }
          return 'Ok';
        },
      ).then(
        (value) {
          expect(reqState.status, isA<ReqStateStatusFailed>());
          expect(reqState.status.retrieveMeta<String>(), equals('¯\_(ツ)_/¯'));
          completer.complete([value]);
        },
      ).catchError(
        (error) {
          completer.completeError(error);
        },
      );

      return completer.future;
    });
  });
}
