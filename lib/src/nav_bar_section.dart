import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'nav_bar_item.dart';

// ignore: must_be_immutable
class TitledBottomNavBar extends StatefulWidget {
  final bool reverse;
  final Curve curve;
  final Color activeColor;
  final Color inactiveColor;
  final Color inactiveStripColor;
  final Color indicatorColor;
  final bool enableShadow;
  int currentIndex;
  final ValueChanged<int> onTap;
  final List<TitledNavBarItem> items;

  TitledBottomNavBar({
    Key key,
    this.reverse = false,
    this.curve = Curves.linear,
    @required this.onTap,
    @required this.items,
    this.activeColor,
    this.inactiveColor,
    this.inactiveStripColor,
    this.indicatorColor,
    this.enableShadow = true,
    this.currentIndex = 0,
  })  : assert(items != null),
        assert(items.length >= 2 && items.length <= 5),
        assert(onTap != null),
        assert(currentIndex != null),
        assert(enableShadow != null),
        super(key: key);

  @override
  State createState() => _TitledBottomNavBarState();
}

class _TitledBottomNavBarState extends State<TitledBottomNavBar> {
  static const double BAR_HEIGHT = 60;
  static const double INDICATOR_HEIGHT = 2;

  bool get reverse => widget.reverse;

  Curve get curve => widget.curve;

  List<TitledNavBarItem> get items => widget.items;

  double width = 0;
  Color activeColor;
  Duration duration = Duration(milliseconds: 270);

  double _getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr)
      return lerpDouble(-1.0, 1.0, index / (items.length - 1));
    else
      return lerpDouble(1.0, -1.0, index / (items.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    activeColor = widget.activeColor ?? Theme.of(context).indicatorColor;

    return Container(
      decoration: BoxDecoration(
        color: widget.inactiveStripColor,
        boxShadow: widget.enableShadow
            ? [
                BoxShadow(color: Colors.black12, blurRadius: 10),
              ]
            : null,
      ),
      child: Container(
        height: BAR_HEIGHT,
        width: width,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              top: INDICATOR_HEIGHT,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: items.map((item) {
                  var index = items.indexOf(item);
                  return GestureDetector(
                    onTap: () => _select(index),
                    child: _buildItemWidget(item, index == widget.currentIndex),
                  );
                }).toList(),
              ),
            ),
            Positioned(
              top: 0,
              width: width,
              child: AnimatedAlign(
                alignment:
                    Alignment(_getIndicatorPosition(widget.currentIndex), 0),
                curve: curve,
                duration: duration,
                child: Container(
                  color: widget.indicatorColor ?? activeColor,
                  width: width / items.length,
                  height: INDICATOR_HEIGHT,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _select(int index) {
    widget.currentIndex = index;
    widget.onTap(widget.currentIndex);

    setState(() {});
  }

  Widget _buildLogo(TitledNavBarItem item) {
    return item.logo;
  }

  Widget _buildText(TitledNavBarItem item) {
    return DefaultTextStyle.merge(
      child: item.title,
      style: TextStyle(color: reverse ? activeColor : widget.inactiveColor),
    );
  }

  Widget _buildItemWidget(TitledNavBarItem item, bool isSelected) {
    return Container(
      color: item.backgroundColor,
      height: BAR_HEIGHT,
      width: width / items.length,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: isSelected ? 0.0 : 1.0,
            duration: duration,
            curve: curve,
            child: reverse ? _buildLogo(item) : _buildText(item),
          ),
          AnimatedAlign(
            duration: duration,
            alignment: isSelected ? Alignment.center : Alignment(0, 5.2),
            child: reverse ? _buildText(item) : _buildLogo(item),
          ),
        ],
      ),
    );
  }
}
