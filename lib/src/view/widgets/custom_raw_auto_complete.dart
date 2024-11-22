import 'package:bonne_reponse/src/view/widgets/text_input.dart';
import 'package:flutter/material.dart';

class CustomAutocomplete extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _autocompleteKey = GlobalKey();

  final List<String> options;

  CustomAutocomplete(
      {super.key, required this.textEditingController, required this.options});

  void clear() {
    textEditingController.clear();
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Can not be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      key: _autocompleteKey,
      focusNode: _focusNode,
      textEditingController: textEditingController,
      optionsBuilder: (TextEditingValue textEditingValue) {
        return options.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      fieldViewBuilder: (context, textEditingController,
          FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
        return CustomTextInput(
          controller: textEditingController,
          focusNode: fieldFocusNode,
          validator: validateName,
          labelText: "Hello", //TODO: Change this to the actual label
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Material(
          elevation: 4.0,
          child: ListView(
            children: options
                .map((String option) => GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(
                          option,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
