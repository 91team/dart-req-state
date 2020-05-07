import 'package:meta/meta.dart';

enum ReqStateStatusKey {
  IDLE,
  PENDING,
  SUCCEEDED,
  FAILED,
  NOT_IDLE,
  NOT_PENDING,
  NOT_SUCCEEDED,
  NOT_FAILED,
}

extension SerializableStatus on ReqStateStatusKey {
  String get valueString {
    return toString().split('.')[1];
  }
}

abstract class ReqStateStatus {
  final ReqStateStatusKey key;
  dynamic _meta;

  ReqStateStatus({
    @required this.key,
    dynamic meta,
  }) : _meta = meta;

  @override
  String toString() => key.valueString;

  TRetrieveMeta retrieveMeta<TRetrieveMeta>() {
    return _meta as TRetrieveMeta;
  }

  void retainMeta(dynamic nextMeta) {
    _meta = nextMeta;
  }

  bool checkMetaTypeIs<TCheck>() => _meta is TCheck;
}

// IDLE
class ReqStateStatusIDLE<TMeta> extends ReqStateStatus {
  ReqStateStatusIDLE({TMeta meta})
      : super(
          key: ReqStateStatusKey.IDLE,
          meta: meta,
        );
}

class ReqStateStatusNotIDLE<TMeta> extends ReqStateStatus {
  ReqStateStatusNotIDLE({TMeta meta})
      : super(
          key: ReqStateStatusKey.IDLE,
          meta: meta,
        );
}

// PENDING
class ReqStateStatusPending<TMeta> extends ReqStateStatus {
  ReqStateStatusPending({TMeta meta})
      : super(
          key: ReqStateStatusKey.PENDING,
          meta: meta,
        );
}

class ReqStateStatusNotPending<TMeta> extends ReqStateStatus {
  ReqStateStatusNotPending({TMeta meta})
      : super(
          key: ReqStateStatusKey.PENDING,
          meta: meta,
        );
}

// SUCCEEDED
class ReqStateStatusSucceeded<TMeta> extends ReqStateStatus {
  ReqStateStatusSucceeded({TMeta meta})
      : super(
          key: ReqStateStatusKey.SUCCEEDED,
          meta: meta,
        );
}

class ReqStateStatusNotSucceeded<TMeta> extends ReqStateStatus {
  ReqStateStatusNotSucceeded({TMeta meta})
      : super(
          key: ReqStateStatusKey.SUCCEEDED,
          meta: meta,
        );
}

// FAILED
class ReqStateStatusFailed<TMeta> extends ReqStateStatus {
  ReqStateStatusFailed({TMeta meta})
      : super(
          key: ReqStateStatusKey.FAILED,
          meta: meta,
        );
}

class ReqStateStatusNotFailed<TMeta> extends ReqStateStatus {
  ReqStateStatusNotFailed({TMeta meta})
      : super(
          key: ReqStateStatusKey.FAILED,
          meta: meta,
        );
}
