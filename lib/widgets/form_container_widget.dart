import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final IconData? prefixIcon; // New property for prefix icon

  const FormContainerWidget({
    Key? key,
    this.controller,
    this.fieldKey,
    this.isPasswordField,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
    this.prefixIcon, // Initialize prefixIcon
  }) : super(key: key);

  @override
  State<FormContainerWidget> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Set the background color to transparent
          borderRadius: BorderRadius.circular(500),
          border: Border.all(
            color: Colors.blue[900]!,
            width: 0.6, //
            // Adjust the border width as needed
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          // Adjust padding as needed
          child: TextFormField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            controller: widget.controller,
            keyboardType: widget.inputType,
            key: widget.fieldKey,
            obscureText: widget.isPasswordField == true ? _obscureText : false,
            onSaved: widget.onSaved,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.blue[900],
                // Adjust the padding here as needed
              ),
              // suffixIcon: GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       _obscureText = !_obscureText;
              //     });
              //   },
              //   child: widget.isPasswordField == true
              //       ? Icon(
              //           _obscureText ? Icons.visibility_off : Icons.visibility,
              //           color: _obscureText == false
              //               ? Colors.blue[900]
              //               : Colors.blue[900],
              //         )
              //       : const Text(''),
              // ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, color: Colors.blue[900])
                  : null, // Add prefix icon if provided
            ),
          ),
        ),
      ),
    );
  }
}
