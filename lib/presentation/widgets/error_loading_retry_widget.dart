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
        // Wrap in Column for better layout
        mainAxisSize: MainAxisSize.min, // Shrink the content
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
