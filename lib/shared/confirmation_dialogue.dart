import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends StatelessWidget {
  final Future<void> Function() onConfirm;

  const ConfirmationDialog({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm Deletion"),
      content: Text("Are you sure you want to delete this vehicle?"),
      actions: <Widget>[
        FilledButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        FilledButton(
          child: Text("Delete"),
          onPressed: () async {
            await onConfirm(); // Call the onConfirm callback and wait for it to complete
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Vehicle deleted successfully!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'OK',
                  textColor: Colors.white,
                  onPressed: () {},
                ),
              ),
            );
            context.go('/home'); // Close the dialog
          },
        ),
      ],
    );
  }
}
