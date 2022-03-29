import 'package:flutter/material.dart';

class DialogAction {
  final String titleText;
  final VoidCallback onPressed;

  DialogAction({required this.titleText, required this.onPressed});
}

class CustomDialog extends StatelessWidget {
  final String headerText;
  final String text;
  final List<DialogAction> actions;

  const CustomDialog(
      {Key? key,
      required this.headerText,
      required this.text,
      required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(headerText, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actions
                  .map((e) => TextButton(
                      onPressed: e.onPressed,
                      child: Text(
                        e.titleText,
                        style: const TextStyle(fontSize: 16),
                      )))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
