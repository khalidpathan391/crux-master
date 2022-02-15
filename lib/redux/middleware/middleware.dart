import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:crux/redux/middleware/auth_middleware.dart';
import 'package:crux/redux/middleware/navigator_middleware.dart';
import 'package:crux/redux/middleware/toast_middleware.dart';
import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/services/auth.dart';
import 'package:crux/redux/services/local_storage.dart';

import 'init_middleware.dart';

List<Middleware<AppState>> createMiddleWare(
  GlobalKey<NavigatorState> navigatorKey,
  AuthService authService,
  // FirestoreService firestoreService,
  // StorageService storageService,
  LocalStorageService localStorageService,
  // HttpService httpService,
  // PurchasesService purchasesService
) {
  return [
    ...createInitMiddleware(
        authService,
        //  firestoreService,
        localStorageService),
    ...createAuthMiddleware(
      authService, localStorageService,
      //  firestoreService,amplitudeService
    ), // storageService),
    ...createNavigationMiddleware(navigatorKey),
    // ...createFirestoreUserMiddleware(firestoreService, storageService, amplitudeService),
    // ...createFunctionsMiddleware(httpService,amplitudeService,firestoreService),
    // ...createLocalMiddleware(localStorageService),
    // ...createPurchaseMiddleware(amplitudeService,localStorageService),
    // ...createAmplitudeMiddleware(amplitudeService),
    ...createToastMiddleware()
  ];
}
