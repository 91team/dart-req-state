# dart_req_state

A new Flutter package project.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Методы

#### executeWithRethrowOnFail

##### Сигнатура

```dart
    typedef ExecFn = Future<void> Function();

    Future<void> executeWithRethrowOnFail(ExecFn execFn)
```

##### Описание

Если где-то произошла ошибка, то этот метод выкинет ее наружу через `rethrow`

##### Код метода

```dart
  Future<void> executeWithRethrowOnFail(ExecFn execFn) async {
    try {
      switchStatusToPending();
      await execFn();
      switchStatusToSucceeded();
    } catch (e) {
      switchStatusToFailed();
      rethrow;
    }
  }
```

#### executeWithCallbackOnFail

##### Сигнатура

```dart
    typedef ExecFn = Future<void> Function();

    Future<void> executeWithCallbackOnFail(
        ExecFn execFn, {
        Function(Exception) onFailed,
    })
```

##### Описание

В отличие от `executeWithRethrowOnFail` этот метод не выкидывает ошибки через `rethrow`

Через именованный параметр `onFailed` можно передать обработчик ошибки, если не передать `onFailed`, то ошибка будет заглушена внутри этого метода.

##### Код метода

```dart
  Future<void> executeWithCallbackOnFail(
    ExecFn execFn, {
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
```

#### executeWithMeta

##### Сигнатура

```dart
    typedef ExecFnWithMeta<Meta> = Future<dynamic> Function(void Function(Meta m));

    Future<void> executeWithMeta<TMeta>(
        ExecFnWithMeta<TMeta> execFn, {
        TMeta withInitialPendingMeta,
    })
```

##### Описание

Использовать только если в статусе запроса нужна какая-то дополнительная `meta` информация.

Если внутри `execFn` поизошла ошибка, то эта ошибка улетит как мета информация в статус `FAILED` (1)

Результат `execFn` тоже отправится как мета, но в статус в статус `SUCCEEDED` (2)

Параметром `withInitialPendingMeta` задается начальная мета для статуса `PENDING` (3)

Для изменения мета инфы статуса `PENDING` самое правильное это юзать функцию, которая приходит в `execFn` первым пареметров (4)

##### Код метода

```dart
  Future<void> executeWithMeta<TMeta>(
    ExecFnWithMeta<TMeta> execFn, {
    TMeta withInitialPendingMeta, // (3)
  }) async {
    try {
      // (3)
      switchStatusToPending(withMeta: withInitialPendingMeta);

      var successMeta = await execFn(/*(4)*/(TMeta meta) {
        // (4)
        switchStatusToPending(withMeta: meta);
      });

      // Результат функции execFn отправляется в статус (2)
      switchStatusToSucceeded(withMeta: successMeta);
    } catch (e) {
      // Ошибка отправляется как мета инфа в статус (1)
      switchStatusToFailed(withMeta: e);
    }
  }
```

### Roadmap

- Дописать доку
- Widget тесты
- Добавить примеры использования
- Добавить расширения для `mobx`
