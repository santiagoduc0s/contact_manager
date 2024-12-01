import 'package:contacts_manager/config/config.dart';
import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static Future<bool> confirm({
    BuildContext? buildContext,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    EdgeInsets? titlePadding,
    EdgeInsets? contentPadding,
    EdgeInsets? actionsPadding,
    Color? backgroundColor,
    bool barrierDismissible = true,
  }) async {
    final value = await show(
      buildContext: buildContext,
      title: title,
      content: content,
      actions: actions,
      titlePadding: titlePadding,
      contentPadding: contentPadding,
      actionsPadding: actionsPadding,
      backgroundColor: backgroundColor,
      barrierDismissible: barrierDismissible,
    );

    return value != null && value == true;
  }

  static Future<T?> show<T>({
    BuildContext? buildContext,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    EdgeInsets? titlePadding,
    EdgeInsets? contentPadding,
    EdgeInsets? actionsPadding,
    Color? backgroundColor,
    bool barrierDismissible = true,
  }) async {
    final value = await showDialog<T>(
      barrierDismissible: barrierDismissible,
      context: buildContext ?? AppKeys.getRootContext(),
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: title != null
              ? titlePadding ??
                  const EdgeInsets.symmetric(
                    horizontal: UISpacing.space6x,
                    vertical: UISpacing.space5x,
                  )
              : EdgeInsets.zero,
          contentPadding: content != null
              ? contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: UISpacing.space6x,
                  )
              : EdgeInsets.zero,
          actionsPadding: actions != null
              ? actionsPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: UISpacing.space6x,
                    vertical: UISpacing.space5x,
                  )
              : EdgeInsets.zero,
          title: title,
          content: content,
          actions: actions,
          backgroundColor: backgroundColor ?? UIColors.white,
          surfaceTintColor: UIColors.transparent,
        );
      },
    );

    return value;
  }
}
