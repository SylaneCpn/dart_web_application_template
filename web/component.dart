import 'dart:js_interop';
import 'package:web/web.dart';

abstract class Component<T extends ComponentState?> {
  Component({required this.state}) {
    element = HTMLDivElement();
    build();
    state?.addListener(this);
  }


  final T state;
  late final HTMLDivElement element;

  void build();
  void rebuild() {
    element.innerHTML = "".toJS;
    build();
  }
}

abstract class ComponentState {
  final List<void Function()> _listerners = [];

  void notify() {
    for (final callback in _listerners) {
      callback();
    }
  }

  void addListener(Component component) {
    _listerners.add(component.rebuild);
  }

  void removeListener(Component component) {
    _listerners.remove(component.rebuild);
  }
}
