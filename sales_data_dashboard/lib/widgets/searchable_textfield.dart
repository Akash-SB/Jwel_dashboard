// searchable_textfield.dart
import 'package:flutter/material.dart';

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
              prefixIcon: const Icon(Icons.search),
              labelText: widget.label,
              labelStyle: const TextStyle(fontSize: 14),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
        if (showOptions && filteredOptions.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            constraints: const BoxConstraints(maxHeight: 180),
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
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Text(widget.displayString(item)),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
