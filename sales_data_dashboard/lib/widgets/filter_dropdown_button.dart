import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class FilterDropdownButton extends StatelessWidget {
  final String selectedValue;
  final void Function(String?) onChanged;
  final List<String> items;
  final String? imagePath;

  const FilterDropdownButton({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.items,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.dp,
        vertical: 4.dp,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
            onChanged: onChanged,
            icon: const Icon(Icons.keyboard_arrow_down),
            isDense: true,
            dropdownColor: Colors.white,
            style: const TextStyle(color: Colors.black),
            items: items.map((item) {
              final bool isSelected = item == selectedValue;
              return DropdownMenuItem<String>(
                value: item,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFEAF1FF) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    item,
                    style: TextStyle(
                      color:
                          isSelected ? const Color(0xFF1A73E8) : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
            selectedItemBuilder: (context) {
              return items.map((item) {
                return Row(
                  children: [
                    if (imagePath != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Image.asset(
                          imagePath!,
                          height: 18,
                          width: 18,
                          color: Colors.black87,
                        ),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Icon(Icons.filter_alt, size: 18),
                      ),
                    Text(item),
                  ],
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
