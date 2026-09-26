import 'package:flutter/material.dart';

class RadioGroup<T> extends StatelessWidget {
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Widget child;

  const RadioGroup({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _RadioGroupScope<T>(
      groupValue: groupValue,
      onChanged: onChanged,
      child: child,
    );
  }

  static _RadioGroupScope<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_RadioGroupScope<T>>();
  }
}

class _RadioGroupScope<T> extends InheritedWidget {
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const _RadioGroupScope({
    required this.groupValue,
    required this.onChanged,
    required super.child,
  });

  @override
  bool updateShouldNotify(_RadioGroupScope<T> oldWidget) {
    return groupValue != oldWidget.groupValue || onChanged != oldWidget.onChanged;
  }
}

extension RadioGroupContextExtension on BuildContext {
  T? getRadioGroupValue<T>() {
    return RadioGroup.of<T>(this)?.groupValue;
  }

  void setRadioGroupValue<T>(T? value) {
    RadioGroup.of<T>(this)?.onChanged(value);
  }
}
