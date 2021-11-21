import 'package:cash_control/controllers/card_controller.dart';
import 'package:cash_control/controllers/category_controller.dart';
import 'package:cash_control/controllers/connectivity_controller.dart';
import 'package:cash_control/controllers/loading.controller.dart';
import 'package:cash_control/controllers/spent_controller.dart';
import 'package:cash_control/controllers/user_controller.dart';
import 'package:cash_control/controllers/page_controller.dart';
import 'package:cash_control/shared/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

final getIt = GetIt.instance;
final UserController auth = getIt<UserController>();
final LoadingController loading = getIt<LoadingController>();
final PagesController pagesStore = getIt<PagesController>();
final CategoryController categoryController = getIt<CategoryController>();
final SpentController spentController = getIt<SpentController>();
final CardController cardController = getIt<CardController>();
final ConnectivityController connectivityController =
    getIt<ConnectivityController>();
