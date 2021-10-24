import 'package:mobx/mobx.dart';
part 'loading.controller.g.dart';

class LoadingController = _LoadingController with _$LoadingController;

abstract class _LoadingController with Store {
  @observable
  bool isLoading = true;

  @action
  bool updateLoading(bool value) => isLoading = value;
}
