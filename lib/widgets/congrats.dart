// congrats.dart
import 'package:flutter/material.dart';

class CongratulationsDialog extends StatelessWidget {
  final VoidCallback onClose;

  const CongratulationsDialog({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onClose(); // Trigger the onClose callback
        return true; // Allow back navigation
      },
      child: AlertDialog(
        title: Text('Congratulations!', style: TextStyle(color: Colors.green)),
        content: Text('You have selected correct numbers.'),
        actions: [
          TextButton(
            onPressed: () {
              onClose(); // Trigger the onClose callback
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
