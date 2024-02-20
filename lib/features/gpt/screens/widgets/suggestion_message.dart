import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SuggestionMessage extends ConsumerWidget {
  final String message;
  final void Function(String messge) onTap;
  final bool isLoading;

  const SuggestionMessage(this.message, this.onTap, this.isLoading, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: isLoading ? null : () => onTap(message),
      child: Container(
        
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(

          color: isLoading ? Colors.white.withOpacity(0.3) : Colors.white,

          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        )
      ),
    );
  }
}