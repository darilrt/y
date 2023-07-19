import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key, required this.icons, required this.onChange})
      : super(key: key);

  final List<IconData> icons;

  final void Function(int) onChange;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    widget.onChange(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            widget.icons.length,
            (i) {
              return Flexible(
                child: IconButton(
                  icon: Icon(
                    widget.icons[i],
                    color: _selectedIndex == i
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSecondary,
                    size: 24,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  onPressed: () => _onItemTapped(i),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
