import 'package:contacts_manager/config/app_keys.dart';
import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';

enum CustomSnackbarStatus {
  info,
  success,
  error,
  warning,
}

class CustomSnackbar {
  static bool isSnackbarActive = false;

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) {
    hideSnackBar();

    final currentState = AppKeys.scaffoldMessengerKey.currentState;

    return currentState!.showSnackBar(snackBar);
  }

  static void hideSnackBar() {
    final currentState = AppKeys.scaffoldMessengerKey.currentState;

    if (currentState == null) return;

    currentState.hideCurrentSnackBar();
  }

  static void success({
    required String text,
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = false,
    Widget? content,
    Widget? icon,
    Duration? duration,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    void Function()? onTap,
  }) {
    show(
      text: text,
      status: CustomSnackbarStatus.success,
      showIcon: showIcon,
      showCloseButton: showCloseButton,
      content: content,
      icon: icon,
      duration: duration,
      textStyle: textStyle,
      padding: padding,
      contentPadding: contentPadding,
      boxShadow: boxShadow,
      borderRadius: borderRadius,
      onTap: onTap,
    );
  }

  static void info({
    required String text,
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = false,
    Widget? content,
    Widget? icon,
    Duration? duration,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    void Function()? onTap,
  }) {
    show(
      text: text,
      status: CustomSnackbarStatus.info,
      showIcon: showIcon,
      showCloseButton: showCloseButton,
      content: content,
      icon: icon,
      duration: duration,
      textStyle: textStyle,
      padding: padding,
      contentPadding: contentPadding,
      boxShadow: boxShadow,
      borderRadius: borderRadius,
      onTap: onTap,
    );
  }

  static void error({
    required String text,
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = false,
    Widget? content,
    Widget? icon,
    Duration? duration,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    void Function()? onTap,
  }) {
    show(
      text: text,
      status: CustomSnackbarStatus.error,
      showIcon: showIcon,
      showCloseButton: showCloseButton,
      content: content,
      icon: icon,
      duration: duration,
      textStyle: textStyle,
      padding: padding,
      contentPadding: contentPadding,
      boxShadow: boxShadow,
      borderRadius: borderRadius,
      onTap: onTap,
    );
  }

  static void warning({
    required String text,
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = false,
    Widget? content,
    Widget? icon,
    Duration? duration,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    void Function()? onTap,
  }) {
    show(
      text: text,
      status: CustomSnackbarStatus.warning,
      showIcon: showIcon,
      showCloseButton: showCloseButton,
      content: content,
      icon: icon,
      duration: duration,
      textStyle: textStyle,
      padding: padding,
      contentPadding: contentPadding,
      boxShadow: boxShadow,
      borderRadius: borderRadius,
      onTap: onTap,
    );
  }

  static void show({
    required String text,
    required CustomSnackbarStatus status,
    bool showIcon = true,
    bool showCloseButton = true,
    bool force = false,
    Widget? content,
    Widget? icon,
    Duration? duration,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    void Function()? onTap,
  }) {
    if (!force) {
      if (isSnackbarActive) return;
    }

    isSnackbarActive = true;

    Color backgroundColor = Colors.deepPurple.shade200;

    if (status == CustomSnackbarStatus.error) {
      backgroundColor = UIColors.error;
    }

    if (status == CustomSnackbarStatus.warning) {
      backgroundColor = UIColors.warning;
    }

    if (status == CustomSnackbarStatus.info) {
      backgroundColor = UIColors.info;
    }

    showSnackBar(
      SnackBar(
        backgroundColor: UIColors.transparent,
        elevation: UISpacing.zero,
        padding: EdgeInsets.zero,
        duration: duration ?? const Duration(seconds: 5),
        content: GestureDetector(
          onTap: onTap,
          child: content ??
              Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(
                      horizontal: UISpacing.space4x,
                      vertical: UISpacing.space4x,
                    ),
                child: Container(
                  padding: contentPadding ??
                      const EdgeInsets.only(
                        left: UISpacing.space4x,
                        right: UISpacing.space4x,
                        top: UISpacing.space4x,
                        bottom: UISpacing.space4x,
                      ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: borderRadius ??
                        BorderRadius.circular(
                          UISpacing.space1x,
                        ),
                    boxShadow: boxShadow ??
                        [
                          BoxShadow(
                            color: UIColors.black.withOpacity(.3),
                            spreadRadius: UISpacing.px1,
                            blurRadius: UISpacing.space1x,
                            offset: const Offset(0, 2),
                          ),
                        ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          style: textStyle ??
                              UITextStyle.bodySmall.copyWith(
                                color: UIColors.black,
                              ),
                        ),
                      ),
                      if (showCloseButton)
                        const SizedBox(
                          width: UISpacing.space5x,
                          height: UISpacing.space5x,
                          child: IconButton(
                            onPressed: hideSnackBar,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(
                              Icons.close,
                              color: UIColors.black,
                              size: UISpacing.space2x + UISpacing.px2,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
        ),
      ),
    ).closed.then((SnackBarClosedReason reason) {
      isSnackbarActive = false;
    });
  }
}
