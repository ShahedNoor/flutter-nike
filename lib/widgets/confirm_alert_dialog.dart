import 'package:flutter/material.dart';

class ConfirmAlertDialog extends StatelessWidget {
  final void Function()? onTap;
  const ConfirmAlertDialog({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 2),
            const Text('Do you want to add this item to your cart?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: () {
                    if (onTap != null) onTap!();
                  },
                  child: const Text('Ok'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
