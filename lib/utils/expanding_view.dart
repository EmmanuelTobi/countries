import 'package:countries/utils/colors.dart';
import 'package:flutter/material.dart';

class ExpandingContainer extends StatefulWidget {

  ExpandingContainer({
    super.key,
    this.context,
    this.title,
    this.actualHeight,
    this.expandedHeight,
    this.expand = false,
    this.body
  });

  final BuildContext? context;
  final Widget? title;
  final Widget? body;
  final bool? expand;
  double? actualHeight = 20;
  final double? expandedHeight;

  @override
  State<ExpandingContainer> createState() => _ExpandingContainerState();
}

class _ExpandingContainerState extends State<ExpandingContainer> {

  ValueNotifier<bool>? containerExpandedState;

  @override
  void initState() {
    containerExpandedState = ValueNotifier(widget.expand!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: containerExpandedState!,
        builder: (context, dynamic value, child) {
          return AnimatedContainer(
            color: XColors.white(),
            height: widget.actualHeight,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 1),
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  if(value == true) {
                    containerExpandedState!.value = false;
                    widget.actualHeight = 50;
                  } else {
                    containerExpandedState!.value = true;
                    widget.actualHeight = widget.expandedHeight;
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: widget.title!,
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 26, color: XColors.textColor(),),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              containerExpandedState!.value != false ? Flexible(child: widget.body!) : Container(),
            ],),
          );
        }
    );
  }
}