import 'package:flutter/material.dart';

class SolidButton extends StatefulWidget {
  @override
  _SolidButtonState createState() => _SolidButtonState();

  final Widget child;
  final Function onPressed;
  final double height,
      width,
      childHeight,
      childWidth,
      splashOpacity,
      highlightOpacity;
  final Color splashColor, highlightColor, color;
  final EdgeInsets margin, padding, childMargin, childPadding;
  final Alignment alignment;
  final ShapeBorder shape;
  final bool showBorder;

  SolidButton({
    this.child,
    this.shape = const BeveledRectangleBorder(
      side: BorderSide(width: 0.25),
    ),
    this.onPressed,
    this.height,
    this.width,
    this.childHeight,
    this.childWidth,
    this.color,
    this.highlightColor,
    this.splashColor,
    this.highlightOpacity = 0.1,
    this.splashOpacity = 0.2,
    this.margin = const EdgeInsets.all(0.0),
    this.padding = const EdgeInsets.all(0.0),
    this.childMargin = const EdgeInsets.all(0.0),
    this.childPadding = const EdgeInsets.all(0.0),
    this.alignment = Alignment.center,
    this.showBorder = false,
  });
}

class _SolidButtonState extends State<SolidButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: widget.margin,
      padding: widget.padding,
      alignment: widget.alignment,
      child: FlatButton(
        shape: (widget.showBorder)
            ? widget.shape
            : Border.all(style: BorderStyle.none),
        child: Container(
          margin: widget.childMargin,
          padding: widget.childPadding,
          width: widget.childWidth,
          height: widget.childHeight,
          child: widget.child,
        ),
        onPressed: () => widget.onPressed?.call(),
        splashColor: (widget.splashColor == null)
            ? Theme.of(context).primaryColor.withOpacity(
                  widget.splashOpacity,
                )
            : widget.splashColor.withOpacity(
                widget.splashOpacity,
              ),
        highlightColor: (widget.highlightColor == null)
            ? Theme.of(context).primaryColor.withOpacity(
                  widget.highlightOpacity,
                )
            : widget.highlightColor.withOpacity(
                widget.highlightOpacity,
              ),
        color: widget.color,
      ),
    );
  }
}
