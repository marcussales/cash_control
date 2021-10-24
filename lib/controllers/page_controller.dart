import 'package:mobx/mobx.dart';

part 'page_controller.g.dart';

class PagesController = _PagesController with _$PagesController;
enum Pages { HOME, MY_SPENTS, NEW_SPENT, MY_CARDS, PERFIL }

abstract class _PagesController with Store {
  @observable
  int page = 0;

  @action
  void setPage(int value) => page = value;

  int getPage() => page;
}
