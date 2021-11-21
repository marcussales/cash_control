import 'package:cash_control/api/icons_api.dart';
import 'package:cash_control/models/IconsModel.dart';
import 'package:mobx/mobx.dart';
part 'icons_controller.g.dart';

class IconsController = _IconsController with _$IconsController;

abstract class _IconsController with Store {
  IconsApi _api = IconsApi();

  ObservableList<IconModel> iconsList = ObservableList<IconModel>();

  @observable
  int selectedItem = -1;

  List<IconModel> currentList = [];

  @action
  setSelectedItem(value) async {
    _refreshList();
    value != selectedItem ? selectedItem = value : selectedItem = -1;
  }

  @action
  Future<void> getIconsList() async {
    List<IconModel> listFromApi = await _api.getList();
    iconsList.addAll(listFromApi);
    currentList.addAll(listFromApi);
  }

  @action
  void _refreshList() {
    iconsList.clear();
    iconsList.addAll(currentList);
  }

  String getSelectedItem() => iconsList[selectedItem].icon;

  @action
  setCategoryIcon(String iconUrl) {
    int categoryIconIdx =
        iconsList.indexWhere((IconModel icon) => icon.icon == iconUrl);
    setSelectedItem(categoryIconIdx);
  }
}
