import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/reducers/navigator_reducer.dart';

import 'init_reducer.dart';

AppState baseReducer(AppState oldState, dynamic action) {
  return oldState.copyWith(
    newRoutes: navigationReducer(oldState.routes, action),
    newLoadingState: loadingStateReducer(oldState.loadingState, action),
    newCurrentUser: currentUserReducer(oldState.currentUser, action),
    // newFireStoreUser: fireStoreUserReducer(oldState.fireStoreUser, action),
    newMyAuth: otpSentReducer(oldState.myAuth, action),
    // newAppData: appDataReducer(oldState.appData, action),
    // newPackages: savePackagesReducer(oldState.packages, action),
    // newRevFetching: saveRevFetchedReducer(oldState.revFetching, action),
    // newLocalContactName: contactStateReducer(oldState.localContactName, action),
    // newPosition: updatePositionReducer(oldState.position, action),
    // newSelectedPackage: saveSelectedPackageReducer(oldState.selectedPackage, action)
  );
}
