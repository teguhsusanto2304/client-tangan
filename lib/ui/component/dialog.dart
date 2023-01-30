import 'package:flutter/material.dart';

enum ViewDialogsAction { yes, no }

class ViewDialogs {
  static Future<ViewDialogsAction> yesOrNoDialog(
      BuildContext context,
      String title,
      String body,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(ViewDialogsAction.no),
              child: const Text('Not Necessary'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ViewDialogsAction.yes),
              child: const Text(
                'Want to be Notified',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : ViewDialogsAction.no;
  }
}

/**
    floatingActionButton: FloatingActionButton.extended(
    onPressed: () async {
    final action = await ViewDialogs.yesOrNoDialog(
    context,
    'Subscription',
    'Waant to be notified about the '
    'upcoming events and shows? Please subscribe to '
    'our News Channel.',
    );
    if (action == ViewDialogsAction.yes) {
    setState(() => tappedYes = true);
    } else {
    setState(() => tappedYes = false);
    }
    },
    label: const Text('Show me Notification'),
    ),
 */