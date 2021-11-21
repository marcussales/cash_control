import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mobx/mobx.dart';
part 'connectivity_controller.g.dart';

class ConnectivityController = _ConnectivityController
    with _$ConnectivityController;

abstract class _ConnectivityController with Store {
  _ConnectivityController() {
    _setupListener();
  }

  void _setupListener() {
    DataConnectionChecker().checkInterval = Duration(seconds: 1);
    DataConnectionChecker().onStatusChange.listen((event) {
      setConnected(event == DataConnectionStatus.connected);
    });
  }

  @observable
  bool connected = true;

  @action
  void setConnected(bool value) => connected = value;
}
