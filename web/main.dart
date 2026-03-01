import 'package:web/web.dart' as web;
import 'exemple_components.dart';
import 'component.dart';

class MainComponent extends StatelessComponent {
  @override
  void build() {
    final now = DateTime.now();
    element.textContent =
        'The time is ${now.hour}:${now.minute} '
        'and your Dart web app is running!';

    addChild(MyStatefullComponent());
    addChild(MyStatefullComponent());
    addChild(BasicText(text: " I'm just a paragraph"));
  }
}

void main() {
  final element = web.document.querySelector('#output') as web.HTMLDivElement;
  element.addComponent(MainComponent());
}
