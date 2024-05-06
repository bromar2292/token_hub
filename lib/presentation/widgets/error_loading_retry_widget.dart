import 'package:flutter/material.dart';

class ErrorLoadingRetry extends StatelessWidget {
  const ErrorLoadingRetry({
    super.key,
    required this.retryMethod,
  });

  final Function() retryMethod;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text('Error Loading Data'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: retryMethod,
            child: const Text('Try Again'),
          )
        ],
      ),
    );
  }
}
