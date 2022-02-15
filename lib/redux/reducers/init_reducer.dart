import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:crux/redux/actions/actions.dart';
import 'package:crux/redux/actions/auth_actions.dart';
import 'package:crux/redux/actions/local_actions.dart';
import 'package:crux/redux/models/app_state.dart';
import 'package:crux/redux/models/loading_state.dart';
import 'package:crux/redux/services/local_storage.dart';

final loadingStateReducer = combineReducers<LoadingState>([
  TypedReducer<LoadingState, LoadingStateAction>(_isloaded),
  TypedReducer<LoadingState, ClearStateAction>(_clearIsLoaded),
]);
LoadingState _isloaded(LoadingState isloaded, LoadingStateAction action) =>
    action.loadingState;
LoadingState _clearIsLoaded(LoadingState isloaded, ClearStateAction action) =>
    LoadingState(isLoading: true, msg: 'Fetching Data...');

final currentUserReducer = combineReducers<User>([
  TypedReducer<User, SaveCurrentUserAction>(_currentUser),
  TypedReducer<User, ClearStateAction>(_clearCurrentUser),
]);

User _currentUser(User isloaded, SaveCurrentUserAction action) => action.user;
User _clearCurrentUser(User isloaded, ClearStateAction action) => null;

final localStorageReducer = combineReducers<LocalStorageService>(
    [TypedReducer<LocalStorageService, SaveLocalStorageAction>(_saveLocal)]);
LocalStorageService _saveLocal(LocalStorageService localStorageService,
        SaveLocalStorageAction action) =>
    action.localStorageService;
final otpSentReducer = combineReducers<MyAuth>([
  TypedReducer<MyAuth, OTPSentAction>(_otpSent),
]);

MyAuth _otpSent(MyAuth isloaded, OTPSentAction action) => action.myAuth;
