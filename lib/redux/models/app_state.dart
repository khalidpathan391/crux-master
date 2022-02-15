import 'package:firebase_auth/firebase_auth.dart';
import 'package:crux/redux/models/case_study_ans.dart';
import 'package:crux/redux/routes/routes.dart';

import 'firestoreUser.dart';
import 'loading_state.dart';

class AppState {
  CaseStudyAns caseStudyAns;
  User currentUser;
  MyAuth myAuth;
  final LoadingState loadingState;
  final List<String> routes;
  final FireStroreUser fireStroreUser;
  AppState(
    this.currentUser, {
    this.caseStudyAns,
    this.myAuth,
    this.loadingState,
    this.routes,
    this.fireStroreUser,
  });
  factory AppState.initial() {
    return AppState(null,
        caseStudyAns: CaseStudyAns([], [], [], [], [], [], [], [], [], [], []),
        loadingState: LoadingState(
            isLoading: false, msg: 'Fetching data... \nplease wait...'),
        routes: [AppRoutes.login],
        fireStroreUser: FireStroreUser(id: '', img: '', name: "", mobile: ''),
        myAuth: MyAuth(otpSent: false, verficationID: ""));
  }
  AppState copyWith({
    LoadingState newLoadingState,
    User newCurrentUser,
    List<String> newRoutes,
    MyAuth newMyAuth,
    CaseStudyAns newCaseStudyAns,
    // String? error,
    FireStroreUser newfireStroreUser,
  }) {
    return AppState(
      newCurrentUser ?? currentUser,
      caseStudyAns: newCaseStudyAns ?? caseStudyAns,
      routes: newRoutes ?? routes,
      fireStroreUser: newfireStroreUser ?? fireStroreUser,
      loadingState: newLoadingState ?? loadingState,
      myAuth: newMyAuth ?? myAuth,
    );
  }
}

class MyAuth {
  final bool otpSent;
  final String verficationID;

  MyAuth({
    this.otpSent,
    this.verficationID,
  });
}
