import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crux/redux/actions/navigator_action.dart';
import 'package:crux/redux/models/app_state.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class RouteAwareWidget extends StatefulWidget {
  final Widget child;
  RouteAwareWidget({this.child});

  State<RouteAwareWidget> createState() => _RouteAwareWidgetState();
}

class _RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // log(StoreProvider.of<AppState>(context).state.routes.toString());
    // 'moved to ' +
    String event = StoreProvider.of<AppState>(context)
            .state
            .routes
            .last
            .replaceAll('/', '')
            .replaceAll('_', ' ') +
        ' screen visible';
    // StoreProvider.of<AppState>(context).dispatch(AmplitudeAction(event:event,eventProperties: {}));
  }

  @override
  void didPopNext() {
    StoreProvider.of<AppState>(context).dispatch(NavigatorPopAction());
  }

  // onWillpop

  @override
  Widget build(BuildContext context) => Container(child: widget.child);
}

class MainRoute<T> extends MaterialPageRoute<T> {
  MainRoute(Widget widget, {RouteSettings settings})
      : super(
            builder: (_) => RouteAwareWidget(child: widget),
            settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget widget) {
    // print('test : ' + settings.name);
    if (settings.name == '/') return widget;

    return FadeTransition(opacity: animation, child: widget);
  }
}

class FabRoute<T> extends MaterialPageRoute<T> {
  final Widget widget;
  final RouteSettings settings;
  int duration;
  String direction;

  FabRoute(this.widget, {this.settings, this.duration, this.direction})
      : super(
          builder: (_) => RouteAwareWidget(child: widget),
          settings: settings,
        );

  // PAGE TRANSITION DURATION
  @override
  Duration get transitionDuration {
    if (this.duration != null) {
      return Duration(milliseconds: duration);
    } else
      return Duration(milliseconds: 200);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget widget) {
    // if(settings.name == '/') return widget;

    Offset offset;
    switch (direction) {
      case 'top':
        offset = Offset(0, -1);
        break;
      case 'right':
        offset = Offset(1, 0);
        break;
      case 'left':
        offset = Offset(-1, 0);
        break;
      default:
        offset = Offset(0, 1);
        break;
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: offset,
        end: Offset.zero,
      ).animate(animation),
      child: widget,
      // child is the value returned by pageBuilder
    );
  }
}

class AppRoutes {
  static const String home = "/home";
  static const String splash = "/splash"; //"/home";
  static const String login = "/login";
  static const String verify = "/verify";
  static const String registerProfile = "/registerProfile";
  // static const String completeCaseStudy = "/completeCaseStudy";
  // static const String checkCaseStudy = "/checkCaseStudy";
  // static const String writeCaseStudy = "/writeCaseStudy";
  // static const String evaluateCaseStudy = "/evaluateCaseStudy";
  // static const String createCaseStudy = "/createCaseStudy";
  // static const String createBusinessIdea = "/createBusinessIdea";
}
