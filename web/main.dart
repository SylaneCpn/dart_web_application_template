import 'package:web/web.dart' as web;
import 'exemple_components.dart';

void main() {
  final now = DateTime.now();
  final element = web.document.querySelector('#output') as web.HTMLDivElement;
  element.textContent =
      'The time is ${now.hour}:${now.minute} '
      'and your Dart web app is running!';
  element.appendChild(MyStatefullComponent().element);
  element.appendChild(MyStatefullComponent().element);
  element.appendChild(BasicText(text: " I'm just a paragraph").element);

  
}
