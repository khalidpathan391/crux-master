import 'package:crux/redux/services/local_storage.dart';

import 'actions.dart';

class SaveLocalStorageAction extends AppAction {
  final LocalStorageService localStorageService;

  SaveLocalStorageAction(this.localStorageService);
}
