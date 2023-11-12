import 'package:flutter/material.dart';
import 'package:quip_sync/core/constants/const_colors.dart';
import 'package:quip_sync/core/constants/const_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'animated_scale.dart' as animation_scale;

class DefaultButton extends StatefulWidget {
  static const double pressedScale = 0.90;
  static const double unPressedScale = 1.0;
  final Function() onPressed;
  final double scale;
  final String txt;

  const DefaultButton({super.key, required this.onPressed, this.scale = 1, required this.txt});

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  double oldScale = 1;
  bool hasFinishedAnimationDown = false;
  bool hasTapUp = false;

  late double depth;
  bool pressed = false; //overwrite widget.pressed when click for animation

  @override
  void dispose() {
    hasDisposed = true;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(DefaultButton oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  double _getScale() {
    if (pressed) {
      //defined by the widget that use it
      return pressed
          ? DefaultButton.pressedScale
          : DefaultButton.unPressedScale;
    } else {
      return pressed
          ? DefaultButton.pressedScale
          : DefaultButton.unPressedScale;
    }
  }

  Future<void> _handlePress() async {
    hasFinishedAnimationDown = false;
    setState(() {
      pressed = true;
      depth = 3;
    });

    await Future.delayed(
        const Duration(milliseconds: 10)); //wait until animation finished
    hasFinishedAnimationDown = true;

    _resetIfTapUp();
  }

  bool hasDisposed = false;

  //used to stay pressed if no tap up
  void _resetIfTapUp() {
    if (hasFinishedAnimationDown == true && hasTapUp == true && !hasDisposed) {
      setState(() {
        pressed = false;
        depth = 3;

        hasFinishedAnimationDown = false;
        hasTapUp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) {
        hasTapUp = false;
        if (!pressed) {
          _handlePress();
        }
      },
      onTapUp: (details) {
        widget.onPressed();

        hasTapUp = true;
        _resetIfTapUp();
      },
      onTapCancel: () {
        hasTapUp = true;
        _resetIfTapUp();
      },
      child: animation_scale.AnimatedScale(
        scale: _getScale(),
        alignment: Alignment.center,
        child:  Container(

          margin: EdgeInsets.all(15.sp),
          height: 5.h,
          width: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: ConstColors.kWidgetBGColor,
            gradient:  LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                ConstColors.kTextSecColor.withOpacity(.5),
                ConstColors.kWidgetBGColor.withOpacity(.5),
              ],
              stops: const[
                0,
                0.75, //was 1 but set to 0.75 to be less dark
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500, // Shadow color
                offset:
                    const Offset(4.0, 4.0),
                blurRadius: 8.0,
                spreadRadius: 2.0,
              ),
              const    BoxShadow(
                color: Colors.white, // Highlight color
                offset:   Offset(-4.0, -4.0),
                blurRadius: 8.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.txt,
              style: ConstStyles.mainTextStyle.copyWith(
                letterSpacing: 5.0,
                  color: ConstColors.kPrimaryColor,
                  fontWeight: FontWeight.bold,fontSize: (ConstStyles.mainTextStyle.fontSize! + 3.sp)),
            ),
          ),
        )



      ),
    );
  }
}
