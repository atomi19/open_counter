import 'package:flutter/material.dart';

Widget buildIconButton(Widget child) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(26, 0, 0, 0),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ]
    ),
    child: child,
  );
}

Widget buildTextButton({
  required BuildContext context,
  required VoidCallback onPressed,
  required Widget child,
  }) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(26, 0, 0, 0),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ]
    ),
    child: TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if(states.contains(WidgetState.hovered)) {
              return Theme.of(context).hoverColor;
            }
            if(states.contains(WidgetState.pressed)) {
              return Theme.of(context).highlightColor;
            }
            return null;
          },
        ),
      ),
      onPressed: onPressed, 
      child: child
    )
  );
}