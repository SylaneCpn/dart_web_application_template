
import 'dart:js_interop';
import 'component.dart';
import 'package:web/web.dart';

//Statefull Component
class MyStatefullComponent extends Component<MyStatefullComponentState> {

   MyStatefullComponent({MyStatefullComponentState? state}) : super(state : state ?? MyStatefullComponentState());

   @override
   void build() {
    element.appendChild(HTMLParagraphElement()..innerText = "My count is ${state.count}");
    final button = HTMLButtonElement()..innerText = "Click Me";
    button.addEventListener("click", state.incrementCount.toJS);
    element.appendChild(button); 
   }

   @override
   void rebuild() {
    final button = element.querySelector("p") as HTMLParagraphElement?;
    button?.innerText = "My count is ${state.count}";
   }

}


// Associated State 
class MyStatefullComponentState extends ComponentState {
  int count = 0;

  void incrementCount() {
    count++;
    notify();
  }
}



// StateLess Component
class BasicText extends Component{
  final String text;
  BasicText({this.text = "Some Text"}) : super(state : null);
  
  @override
  void build() {
    element.appendChild(HTMLParagraphElement()..innerText = text);
  }

}


