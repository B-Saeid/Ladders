import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInputField extends StatelessWidget {
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final String? label;
  final TextStyle? labelTextStyle;
  final String? hint;
  final bool? filled;
  final Color? fillColor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool hideCharacterCounter;

  /// Not to be assigned along side with the controller
  final String? initialValue;
  final String? prefixText;
  final String? obscuringCharacter;
  final InputBorder inputBorder;
  final InputBorder? disabledInputBorder;
  final InputBorder? errorInputBorder;
  final TextInputAction? textInputAction;
  final EdgeInsetsDirectional? contentPadding;
  final bool isPass;
  final bool? showCursor;
  final bool autocorrect;
  final bool autofocus;
  final bool? enableInteractiveSelection;
  final bool? enabled;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final void Function(String)? onChange;
  final void Function(String)? onSubmit;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final void Function(PointerDownEvent?)? onTapOutside;
  final bool unfocusWhenTapOutside;
  final String? autofillHints;
  final bool readOnly;
  final TextDirection? textDirection;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  const FormInputField(
      {super.key,
      this.controller,
      this.textStyle,
      this.label,
      this.labelTextStyle,
      this.hint,
      this.filled,
      this.fillColor,
      this.maxLength,
      this.maxLengthEnforcement,
      this.hideCharacterCounter = true,
      this.initialValue,
      this.prefixText,
      this.obscuringCharacter,
      this.inputBorder = const OutlineInputBorder(),
      this.disabledInputBorder,
      this.errorInputBorder,
      this.textInputAction,
      this.contentPadding,
      this.isPass = false,
      this.showCursor,
      this.autocorrect = false,
      this.autofocus = false,
      this.enableInteractiveSelection,
      this.enabled,
      this.keyboardType,
      this.prefixIcon,
      this.suffixIcon,
      this.focusNode,
      this.onChange,
      this.onSubmit,
      this.onTap,
      this.onEditingComplete,
      this.validator,
      this.onTapOutside,
      this.unfocusWhenTapOutside = false,
      this.autofillHints,
      this.readOnly = false,
      this.textDirection,
      this.inputFormatters,
      this.textCapitalization = TextCapitalization.none});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onTap: onTap,
      style: textStyle,
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      key: key,
      focusNode: focusNode,
      cursorRadius: const Radius.circular(60),
      initialValue: initialValue,
      textCapitalization: textCapitalization,

      /// TODO :
      /*

        package:flutter/src/material/text_field.dart Iterable<String>? autofillHints  Containing class: TextField  Type: Iterable<String>?
        A list of strings that helps the autofill service identify the type of this text input.
        When set to null, this text input will not send its autofill information to the platform, preventing it from participating in autofills triggered by a different AutofillClient, even if they're in the same AutofillScope. Additionally, on Android and web, setting this to null will disable autofill for this text field.
        The minimum platform SDK version that supports Autofill is API level 26 for Android, and iOS 10.0 for iOS.
        Defaults to an empty list.
        Setting up iOS autofill:
        To provide the best user experience and ensure your app fully supports password autofill on iOS, follow these steps:
        Set up your iOS app's associated domains .
        Some autofill hints only work with specific keyboardTypes. For example, AutofillHints.name requires TextInputType.name and AutofillHints.email works only with TextInputType.emailAddress. Make sure the input field has a compatible keyboardType. Empirically, TextInputType.name works well with many autofill hints that are predefined on iOS.
        Troubleshooting Autofill
        Autofill service providers rely heavily on autofillHints. Make sure the entries in autofillHints are supported by the autofill service currently in use (the name of the service can typically be found in your mobile device's system settings).
        Autofill UI refuses to show up when I tap on the text field
        Check the device's system settings and make sure autofill is turned on, and there are available credentials stored in the autofill service.
        iOS password autofill: Go to Settings -> Password, turn on "Autofill Passwords", and add new passwords for testing by pressing the top right "+" button. Use an arbitrary "website" if you don't have associated domains set up for your app. As long as there's at least one password stored, you should be able to see a key-shaped icon in the quick type bar on the software keyboard, when a password related field is focused.
        iOS contact information autofill: iOS seems to pull contact info from the Apple ID currently associated with the device. Go to Settings -> Apple ID (usually the first entry, or "Sign in to your iPhone" if you haven't set up one on the device), and fill out the relevant fields. If you wish to test more contact info types, try adding them in Contacts -> My Card.
        Android autofill: Go to Settings -> System -> Languages & input -> Autofill service. Enable the autofill service of your choice, and make sure there are available credentials associated with your app.
        I called TextInput.finishAutofillContext but the autofill save
        prompt isn't showing
        iOS: iOS may not show a prompt or any other visual indication when it saves user password. Go to Settings -> Password and check if your new password is saved. Neither saving password nor auto-generating strong password works without properly setting up associated domains in your app. To set up associated domains, follow the instructions in https://developer.apple.com/documentation/safariservices/supporting_associated_domains_in_your_app . For the best results, hint strings need to be understood by the platform's autofill service. The common values of hint strings can be found in AutofillHints, as well as their availability on different platforms.
        If an autofillable input field needs to use a custom hint that translates to different strings on different platforms, the easiest way to achieve that is to return different hint strings based on the value of defaultTargetPlatform.
        Each hint in the list, if not ignored, will be translated to the platform's autofill hint type understood by its autofill services:
        On iOS, only the first hint in the list is accounted for. The hint will be translated to a UITextContentType .
        On Android, all hints in the list are translated to Android hint strings.
        On web, only the first hint is accounted for and will be translated to an "autocomplete" string.
        Providing an autofill hint that is predefined on the platform does not automatically grant the input field eligibility for autofill. Ultimately, it comes down to the autofill service currently in charge to determine whether an input field is suitable for autofill and what the autofill candidates are.
        See also:
        AutofillHints, a list of autofill hint strings that is predefined on at least one platform.
        UITextContentType , the iOS equivalent.
        Android autofillHints , the Android equivalent.
        The autocomplete  attribute, the web equivalent.
       */
      autofillHints: autofillHints != null ? [autofillHints!] : null,
      readOnly: readOnly,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      obscuringCharacter: obscuringCharacter ?? '•',
      selectionControls: isPass ? EmptyTextSelectionControls() : null,
      // pretty nice
      controller: controller,
      obscureText: isPass,
      keyboardType: keyboardType,
      showCursor: showCursor,
      autofocus: autofocus,
      autocorrect: autocorrect,
      enableInteractiveSelection: enableInteractiveSelection,
      decoration: InputDecoration(
        border: inputBorder,
        disabledBorder: disabledInputBorder,
        errorBorder: errorInputBorder,
        contentPadding: contentPadding,
        // focusedBorder: inputBorder,
        // enabledBorder: inputBorder,
        labelStyle: labelTextStyle,
        filled: filled,
        fillColor: fillColor,
        prefixText: prefixText,
        hintText: hint,
        labelText: label,
        counterText: hideCharacterCounter ? '' : null,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validator,
      onTapOutside: getOnTapOutside(context),
      textDirection: textDirection,
      inputFormatters: inputFormatters,
    );
  }

  TapRegionCallback? getOnTapOutside(BuildContext context) {
    return onTapOutside == null
        ? (unfocusWhenTapOutside ? (_) => FocusScope.of(context).unfocus() : null)
        : (PointerDownEvent event) {
            if (unfocusWhenTapOutside) FocusScope.of(context).unfocus();
            onTapOutside!(event);
          };
  }
}
