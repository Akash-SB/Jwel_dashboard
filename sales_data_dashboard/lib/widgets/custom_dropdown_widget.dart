import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class CustomDropdownWidget<T> extends StatefulWidget {
  final String iconPath;
  final String label;
  final List<T> items;
  final void Function(T) onSelected;
  final T? initialValue;
  final Size buttonSize;
  final String? tooltip;
  final double dropdownWidth;

  const CustomDropdownWidget({
    super.key,
    required this.iconPath,
    required this.label,
    required this.items,
    required this.onSelected,
    required this.buttonSize,
    required this.dropdownWidth,
    this.initialValue,
    this.tooltip,
  });

  @override
  State<CustomDropdownWidget<T>> createState() =>
      _CustomDropdownWidgetState<T>();
}

class _CustomDropdownWidgetState<T> extends State<CustomDropdownWidget<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ??
        (widget.items.isNotEmpty ? widget.items[0] : null);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.buttonSize.width,
      height: widget.buttonSize.height,
      child: PopupMenuButton<T>(
        onSelected: (value) {
          setState(() => selectedValue = value);
          widget.onSelected(value);
        },
        padding: EdgeInsets.zero,
        tooltip: widget.tooltip,
        offset: Offset(
          (widget.buttonSize.width - widget.dropdownWidth) / 2,
          widget.buttonSize.height,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.dp,
          ),
        ),
        itemBuilder: (context) {
          return widget.items.map((item) {
            return PopupMenuItem<T>(
              value: item,
              padding: EdgeInsets.zero,
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  color: item == selectedValue ? Colors.blue[50] : Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.dp,
                    vertical: 10.dp,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    item.toString(),
                    style: TextStyle(
                      fontSize: 5,
                    ),
                  ),
                ),
              ),
            );
          }).toList();
        },
        child: Container(
          width: widget.buttonSize.width,
          padding: EdgeInsets.symmetric(horizontal: 12.dp),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.dp),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                widget.iconPath,
                height: 16.dp,
                color: Colors.black87,
              ),
              SizedBox(
                width: 2.dp,
              ),
              Flexible(
                child: Text(
                  selectedValue?.toString() ?? widget.label,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 5,
                    color: Colors.black,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
