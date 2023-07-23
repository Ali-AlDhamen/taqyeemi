import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../../theme/pallete.dart';
import '../../controller/auth_controller.dart';

class AuthButton extends ConsumerWidget {
  final void Function(BuildContext) onPressed;
  final String text;
  const AuthButton({
    required this.onPressed,
    required this.text,
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: Pallete.purpleColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () => onPressed(context),
        child: isLoading
            ? const Loader()
            : Text(
                text,
                style: const TextStyle(
                  color: Pallete.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
