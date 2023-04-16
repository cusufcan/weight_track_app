import 'package:flutter/material.dart';
import 'package:weight_track_app/constants/project_paddings.dart';
import 'package:weight_track_app/constants/project_strings.dart';

import '../../../core/error/shake_error.dart';
import '../button/elevated_button.dart';
import '../text/title_text.dart';
import '../textField/text_field.dart';

class DataBottomSheetContent extends StatefulWidget {
  const DataBottomSheetContent({
    super.key,
    required this.languageIndex,
    required this.setState,
    this.onChanged,
    required this.weightFormFieldController,
    required this.weightSemiFormFieldController,
    required this.animationController,
    required this.isOkBtnActive,
    this.onPressed,
    this.customDatePicker,
  });
  final int? languageIndex;
  final StateSetter setState;
  final Function(String)? onChanged;
  final TextEditingController weightFormFieldController;
  final TextEditingController weightSemiFormFieldController;
  final AnimationController animationController;
  final bool isOkBtnActive;
  final void Function()? onPressed;
  final Widget? customDatePicker;

  @override
  State<DataBottomSheetContent> createState() => _DataBottomSheetContentState();
}

class _DataBottomSheetContentState extends State<DataBottomSheetContent> with ProjectPaddings, ProjectStrings {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: paddingHorizontalVeryHigh + EdgeInsets.only(bottom: paddingHigh),
          child: CustomTitleText(text: findString(widget.languageIndex ?? 0, LanguagesEnum.addRecord))),
      Padding(
        padding: paddingHorizontalVeryHigh + EdgeInsets.only(bottom: paddingMed),
        child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
              flex: 10,
              child: CustomFormField(
                  controller: widget.weightFormFieldController,
                  onChanged: widget.onChanged,
                  maxLength: 3,
                  autoFocus: true,
                  textInputAction: TextInputAction.next)),
          const Expanded(flex: 1, child: CustomTitleText(text: '.', textAlign: TextAlign.center)),
          Expanded(
              flex: 3,
              child: CustomFormField(
                  controller: widget.weightSemiFormFieldController,
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.done,
                  isZeroIn: true,
                  labelText: '0'))
        ]),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: paddingMed),
        child: ShakeError(
            animationController: widget.animationController,
            shakeOffset: 5,
            shakeCount: 10,
            child: SizedBox(height: 100, child: widget.customDatePicker)),
      ),
      Padding(
        padding: paddingHorizontalVeryHigh + EdgeInsets.only(bottom: paddingMed),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              flex: 3,
              child: CustomElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  text: findString(widget.languageIndex ?? 0, LanguagesEnum.cancelUpper))),
          const Spacer(),
          Expanded(
              flex: 3,
              child: CustomElevatedButton(
                  onPressed: widget.onPressed,
                  text: widget.isOkBtnActive
                      ? findString(widget.languageIndex ?? 0, LanguagesEnum.okUpper)
                      : findString(widget.languageIndex ?? 0, LanguagesEnum.disable))),
        ]),
      )
    ]);
  }
}
