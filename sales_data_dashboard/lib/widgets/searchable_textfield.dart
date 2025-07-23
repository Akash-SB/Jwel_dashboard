// searchable_textfield.dart
import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class SearchableTextField<T> extends StatefulWidget {
  final String label;
  final List<T> options;
  final String Function(T) displayString;
  final void Function(T) onSelect;

  const SearchableTextField({
    super.key,
    required this.label,
    required this.options,
    required this.displayString,
    required this.onSelect,
  });

  @override
  State<SearchableTextField<T>> createState() => _SearchableTextFieldState<T>();
}

class _SearchableTextFieldState<T> extends State<SearchableTextField<T>> {
  final TextEditingController _controller = TextEditingController();
  List<T> filteredOptions = [];
  bool showOptions = false;

  void _onChanged(String value) {
    setState(() {
      filteredOptions = widget.options
          .where((e) => widget
              .displayString(e)
              .toLowerCase()
              .contains(value.toLowerCase()))
          .take(5)
          .toList();
      showOptions = true;
    });
  }

  void _selectItem(T item) {
    _controller.text = widget.displayString(item);
    widget.onSelect(item);
    setState(() => showOptions = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: _controller,
            onChanged: _onChanged,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF9CA3AF),
              ),
              labelText: widget.label,
              labelStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xFF9CA3AF),
              ),
              filled: true,
              fillColor: Colors.white,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.dp),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.dp),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.dp),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
            ),
          ),
        ),
        if (showOptions && filteredOptions.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8.dp),
              color: Colors.white,
            ),
            constraints: BoxConstraints(maxHeight: 180.dp),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredOptions.length,
              itemBuilder: (context, index) {
                final item = filteredOptions[index];
                return InkWell(
                  onTap: () => _selectItem(item),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Color(0xFFE5E7EB),
                        width: 0.5,
                      )),
                    ),
                    child: Text(
                      widget.displayString(item),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
