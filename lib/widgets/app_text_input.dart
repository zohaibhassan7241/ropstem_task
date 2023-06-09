import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? leading;
  final Widget? trailing;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? errorText;
  final int? maxLines;
  final bool? autofocus;

  const AppTextInput({
    Key? key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.leading,
    this.trailing,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.errorText,
    this.maxLines = 1,
    this.autofocus = false,
  }) : super(key: key);

  Widget _buildErrorLabel(BuildContext context) {
    if (errorText == null) {
      return Container();
    }
    if (leading != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                errorText!,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Theme.of(context).errorColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(errorText!,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Theme.of(context).errorColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget leadingWidget = const SizedBox(width: 16);
    if (leading != null) {
      leadingWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          leading!,
          const SizedBox(width: 8),
        ],
      );
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor.withOpacity(.07),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              leadingWidget,
              Expanded(
                child: TextField(
                  onTap: onTap,
                  textAlignVertical: TextAlignVertical.center,
                  onSubmitted: onSubmitted,
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: onChanged,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    hintText: hintText,
                    suffixIcon: trailing,
                    border: InputBorder.none,
                  ),
                  autofocus: autofocus ?? false,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5,),
        _buildErrorLabel(context)
      ],
    );
  }
}
