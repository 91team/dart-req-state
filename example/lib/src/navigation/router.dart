import 'package:auto_route/auto_route_annotations.dart';
import 'package:dart_req_state_example/src/ui/screens/test/test.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  TestScreen test;
}
