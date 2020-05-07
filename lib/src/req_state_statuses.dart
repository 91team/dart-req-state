import 'package:meta/meta.dart';

enum ReqStateStatusKey {
  IDLE,
  PENDING,
  SUCCEEDED,
  FAILED,
  CANCELLED,
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

class ReqStateStatusIDLE<TMeta> extends ReqStateStatus {
  ReqStateStatusIDLE({TMeta meta})
      : super(
          key: ReqStateStatusKey.IDLE,
          meta: meta,
        );
}

class ReqStateStatusPending<TMeta> extends ReqStateStatus {
  ReqStateStatusPending({TMeta meta})
      : super(
          key: ReqStateStatusKey.PENDING,
          meta: meta,
        );
}

class ReqStateStatusSucceeded<TMeta> extends ReqStateStatus {
  ReqStateStatusSucceeded({TMeta meta})
      : super(
          key: ReqStateStatusKey.SUCCEEDED,
          meta: meta,
        );
}

class ReqStateStatusFailed<TMeta> extends ReqStateStatus {
  ReqStateStatusFailed({TMeta meta})
      : super(
          key: ReqStateStatusKey.FAILED,
          meta: meta,
        );
}

class ReqStateStatusCancelled<TMeta> extends ReqStateStatus {
  ReqStateStatusCancelled({TMeta meta})
      : super(
          key: ReqStateStatusKey.CANCELLED,
          meta: meta,
        );
}
