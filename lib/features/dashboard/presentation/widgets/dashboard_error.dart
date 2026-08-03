import 'package:flutter/material.dart';

class DashboardError extends StatelessWidget {
  const DashboardError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .25,
        ),
        Icon(
          Icons.cloud_off_rounded,
          size: 72,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Refresh',
              ),
            )),
      ],
    );
  }
}
