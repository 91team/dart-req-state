import 'package:dart_req_state/dart_req_state.dart';
import 'package:mobx/mobx.dart';

part 'controller.g.dart';

class TestScreenController = TestScreenControllerBase with _$TestScreenController;

abstract class TestScreenControllerBase with Store {
  final metaReqState = ReqState();
  final simpleReqState = ReqState();

  @observable
  bool metaIsSwitcherEnabled = false;

  @observable
  bool mobxSimpleIsSwitcherEnabled = false;
  bool simpleIsSwitcherEnabled = false;

  TestScreenControllerBase() : metaIsSwitcherEnabled = false;

  metaSetIsSwitcherEnabled(bool next) {
    metaPullItems();
  }

  simpleSetIsSwitcherEnabled(bool next) {
    simplePullItems();
  }

  @action
  metaPullItems() async {
    await metaReqState.executeWithMeta<int>(
      (setPendingMeta) async {
        try {
          for (var i = 1; i < 11; i++) {
            await Future.delayed(Duration(milliseconds: 500));
            setPendingMeta(i);

            if (i == 6) {
              throw Exception("¯\_(ツ)_/¯");
            }
          }
          await Future.delayed(Duration(milliseconds: 1000));

          _metaSetIsSwitcherEnabled();
          return 'Ok';
        } catch (e) {
          throw "¯\_(ツ)_/¯ ¯\_(ツ)_/¯";
        }
      },
      withInitialPendingMeta: 0,
    );
  }

  @action
  simplePullItems() async {
    await simpleReqState.executeWithCallbackOnFail(() async {
      await Future.delayed(Duration(milliseconds: 1000));
      simpleIsSwitcherEnabled = !simpleIsSwitcherEnabled;
      // runInAction(() {
      //   mobxSimpleIsSwitcherEnabled = !mobxSimpleIsSwitcherEnabled;
      // });
    });
  }

  @action
  _metaSetIsSwitcherEnabled() {
    metaIsSwitcherEnabled = !metaIsSwitcherEnabled;
  }

  @action
  _simpleSetIsSwitcherEnabled() {
    mobxSimpleIsSwitcherEnabled = !mobxSimpleIsSwitcherEnabled;
  }

  void init() {}
}
