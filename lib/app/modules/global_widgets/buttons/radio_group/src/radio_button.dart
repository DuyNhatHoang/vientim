// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'radio_button_text_position.dart';

class RadioButton<T> extends StatelessWidget {
  final String description;
  final T value;
  final T groupValue;
  final void Function(T) onChanged;
  final RadioButtonTextPosition textPosition;
  final Color activeColor;
  final TextStyle textStyle;

  const RadioButton({
     this.description,
     this.value,
     this.groupValue,
     this.onChanged,
    this.textPosition = RadioButtonTextPosition.right,
    this.activeColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          if (onChanged != null) {
            onChanged(value);
          }
        },
        child: Row(
          mainAxisAlignment: textPosition == RadioButtonTextPosition.right
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: <Widget>[
            textPosition == RadioButtonTextPosition.left
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      description,
                      style: textStyle,
                      textAlign: TextAlign.left,
                    ),
                  )
                : Container(),
            Radio<T>(
              groupValue: groupValue,
              onChanged: onChanged,
              value: value,
              activeColor: activeColor,
            ),
            textPosition == RadioButtonTextPosition.right
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      description,
                      style: textStyle,
                      textAlign: TextAlign.right,
                    ),
                  )
                : Container(),
          ],
        ),
      );
}
