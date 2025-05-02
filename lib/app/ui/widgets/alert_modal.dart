import 'package:flutter/material.dart';

class AlertModal extends StatefulWidget {
  const AlertModal({super.key, required this.width});
  final double width;
  @override
  State<AlertModal> createState() => _AlertModalState();
}

class _AlertModalState extends State<AlertModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Column(
          children: [
            Container(
              width: widget.width * .2,
              padding: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              child: Icon(
                Icons.check,
                size: widget.width * .05,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'E-mail de confirmação enviado\n confirme o e-mail',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "OK",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          )
        ]);
  }
}
