import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String text;
  final PageController _pageController;
  final int page;

  // ignore: use_key_in_widget_constructors
  const DrawerTile(this.iconData, this.text, this._pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          _pageController.jumpToPage(page);
        },
        child: Container(
          color: Colors.transparent,
          height: 60,
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              Icon(
                iconData,
                color: _pageController.page!.round() == page
                    ? Theme.of(context).primaryColor
                    : Colors.grey[600],
                size: 28,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: _pageController.page!.round() == page
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
