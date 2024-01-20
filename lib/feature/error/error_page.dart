import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("유효하지 않은 페이지입니다."),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text("돌아가기"),
            ),
          ],
        ),
      ),
    );
  }
}
