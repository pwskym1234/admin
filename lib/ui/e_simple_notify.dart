import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:admin/data/extension/build_context_x.dart';
import 'package:admin/data/extension/go_router.dart';
import 'package:admin/route/router_service.dart';

class SimpleNotify {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<void> show(String text) async {
    final completer = Completer();
    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (_) {
        return _SimpleNotifyContainer(
          text: text,
          duration: const Duration(seconds: 2),
          onRemoved: () {
            entry?.remove();
            completer.complete();
          },
        );
      },
    );

    navigatorKey.currentState?.overlay?.insert(entry);
    return completer.future;
  }
}

// 왜 전역 함수로 설정 안하나?
// class SimpleNotify {
//   Future<void> show(WidgetRef ref, String text) async {
//     final completer = Completer();
//     OverlayEntry? entry;
//     entry = OverlayEntry(
//       builder: (_) {
//         return _SimpleNotifyContainer(
//           text: text,
//           duration: const Duration(seconds: 2),
//           onRemoved: () {
//             entry?.remove();
//             completer.complete();
//           },
//         );
//       },
//     );

//     final routerService = ref.read(routerServiceProvider);
//     routerService.goRouter.overlayState?.insert(entry);
//     return completer.future;
//   }
// }

class _SimpleNotifyContainer extends StatefulWidget {
  const _SimpleNotifyContainer({
    required this.text,
    required this.duration,
    required this.onRemoved,
  });

  final String text;
  final Duration duration;
  final VoidCallback? onRemoved;

  @override
  _SimpleNotifyState createState() => _SimpleNotifyState();
}

class _SimpleNotifyState extends State<_SimpleNotifyContainer> {
  final positionKey = GlobalKey();
  bool isVisible = false;
  bool isRemoved = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1), () {
      setState(() => isVisible = true);
    });
    Future.delayed(widget.duration, () {
      setState(() => isVisible = false);
      Future.delayed(const Duration(milliseconds: 300), () {
        widget.onRemoved?.call();
        // if (mounted && isRemoved == false) {
        //   widget.onRemoved?.call();
        // } else {
        //   isRemoved = true;
        // }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = 34 + widget.text.length * 14.0;

    if (width > context.getWidth - 34) {
      width = context.getWidth - 34;
    }
    return Center(
      key: positionKey,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        curve: Curves.easeInOutQuart,
        duration: const Duration(milliseconds: 300),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          child: Wrap(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 17),
                width: width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.text,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
