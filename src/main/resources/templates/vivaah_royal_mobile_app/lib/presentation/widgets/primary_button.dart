import 'package:flutter/material.dart';

/// Primary call-to-action button with a built-in loading state.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: Colors.white,
                ),
              )
            : Icon(icon ?? Icons.arrow_forward_rounded, size: 20),
        label: Text(label),
      ),
    );
  }
}
