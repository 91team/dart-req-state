import 'package:meta/meta.dart';

enum ReqStateStatusKey {
  IDLE,
  PENDING,
  SUCCEEDED,
  FAILED,
}

extension SerializableStatus on ReqStateStatusKey {
  String get valueString {
    return toString().split('.')[1];
  }
}

abstract class ReqStateStatus<TMeta> {
  final ReqStateStatusKey key;
  TMeta _meta;

  ReqStateStatus({@required this.key, TMeta meta}) : _meta = meta;

  @override
  String toString() => key.valueString;

  TRetrieveMeta retrieveMeta<TRetrieveMeta>() {
    return _meta as TRetrieveMeta;
  }

  void retainMeta(TMeta nextMeta) {
    _meta = nextMeta;
  }

  bool checkMetaTypeIs<TCheck>() => _meta is TCheck;
}

class ReqStateStatusIDLE<TMeta> extends ReqStateStatus<TMeta> {
  ReqStateStatusIDLE({TMeta meta})
      : super(
          key: ReqStateStatusKey.IDLE,
          meta: meta,
        );
}

class ReqStateStatusPending<TMeta> extends ReqStateStatus<TMeta> {
  ReqStateStatusPending({TMeta meta})
      : super(
          key: ReqStateStatusKey.PENDING,
          meta: meta,
        );
}

class ReqStateStatusSucceeded<TMeta> extends ReqStateStatus<TMeta> {
  ReqStateStatusSucceeded({TMeta meta})
      : super(
          key: ReqStateStatusKey.SUCCEEDED,
          meta: meta,
        );
}

class ReqStateStatusFailed<TMeta> extends ReqStateStatus<TMeta> {
  ReqStateStatusFailed({TMeta meta})
      : super(
          key: ReqStateStatusKey.FAILED,
          meta: meta,
        );
}
