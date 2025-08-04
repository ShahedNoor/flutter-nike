import 'package:flutter/material.dart';

class InfoAlertDialog extends StatelessWidget {
  final String message;
  final double? messageHeight;
  const InfoAlertDialog({super.key, required this.message, required this.messageHeight});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: messageHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 2,
            ),
            Text(message),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      5.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              ],
            )
          ],
        ),
      ),
    );

  }
}