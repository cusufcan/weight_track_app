import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weight_track_app/constants/project_colors.dart';
import 'package:weight_track_app/constants/project_radius.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.controller,
      this.onChanged,
      this.maxLength,
      this.textAlign,
      this.autoFocus,
      this.focusNode,
      this.textInputAction,
      this.isZeroIn,
      this.labelText,
      this.hintText});
  final void Function(String)? onChanged;
  final int? maxLength;
  final bool? autoFocus;
  final bool? isZeroIn;
  final TextAlign? textAlign;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(ProjectRadius().radiusNormal)),
        borderSide: const BorderSide(color: Colors.transparent));
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength ?? 20),
        FilteringTextInputFormatter.digitsOnly,
        !(isZeroIn ?? false)
            ? FilteringTextInputFormatter.deny(RegExp(r'^0+'))
            : FilteringTextInputFormatter.singleLineFormatter
      ],
      controller: controller,
      onChanged: onChanged,
      focusNode: focusNode,
      autofocus: autoFocus ?? false,
      textInputAction: textInputAction,
      textAlign: textAlign ?? TextAlign.left,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder,
        label: Center(child: Text(labelText ?? '')),
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: outlineInputBorder,
        filled: true,
        fillColor: ProjectColors().inputFieldBg,
      ),
    );
  }
}
