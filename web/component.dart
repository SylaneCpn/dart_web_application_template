import 'dart:js_interop';
import 'package:web/web.dart';

void runAppInElement(Component component, HTMLElement element) {
  element.append(component.element);
}

extension AddComponent on HTMLElement {
  void addComponent(Component component) {
    appendChild(component.element);
  }
}

abstract class Component {
  final HTMLDivElement element = HTMLDivElement();
  void build();
  void addChild(Component component) {
    element.addComponent(component);
  }
  void addChidren(List<Component> components) {
    for (final component in components) {
      addChild(component);
    }
  }
  
}

abstract class StatelessComponent extends Component {
  StatelessComponent() {
    build();
  }
}

abstract class StateFullComponent<T extends ComponentState> extends Component {
  StateFullComponent({required this.state}) {
    build();
    state.addListener(this);
  }

  final T state;

  @override
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

  void addListener(StateFullComponent component) {
    _listerners.add(component.rebuild);
  }

  void removeListener(StateFullComponent component) {
    _listerners.remove(component.rebuild);
  }
}
