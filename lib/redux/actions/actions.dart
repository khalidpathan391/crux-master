import 'package:crux/redux/middleware/toast_middleware.dart';
import 'package:crux/redux/models/loading_state.dart';

abstract class AppAction {}

class InitAppAction extends AppAction {
  InitAppAction();
  @override
  String toString() {
    return "InitAppAction";
  }
}

class LoadingStateAction extends AppAction {
  final LoadingState loadingState;

  LoadingStateAction(this.loadingState);

  @override
  String toString() => "LoadingStateAction{$loadingState}";
}

class ClearStateAction extends AppAction {}

class ToastAction extends AppAction {
  // final LoadingState loadingState;
  final String message;
  final ToastCode toastCode;
  ToastAction(this.message, this.toastCode);

  @override
  String toString() => "ToastAction{$toastCode, $message}";
}

// RegistrationCompleteAction
class RegistrationCompleteAction extends AppAction {}
