# A simple way to make web apps with dart

Using vanilla Javascrpt to manage your web page/app can be complicated.
That's why JavaScrpt frameworks are so popular. But they are often an overkill for most of projects.

This is meant to be a lightweight alternative to building "Native" web apps from a higher level.

I wanted a staticly typed way of building web apps, but i'm more comfortable whit dart than TypeScript. And since dart also compiles to JavaScript, it is my go to  when building "vanilla" apps.

The project is a single file you can add to your project. It provides two classes to help you manage the DOM.


## Creating a custom component

To create a component create a class that inherits from `Component` :

```dart

class MyComponent extends Component {

}

```

A `Component` is a generic class that can be either Stateless or Statefull. We will start with a Stateless `Component`.

### Create a Stateless Component

Complete `MyComponent` with a constructor :

```dart

class MyComponent extends Component {

    MyComponent() : super(state : null);
}

```

The constructor has to call the super constructor in order to work properly. For a Stateless `Component`, there is no state, that's why we provide the `state` parameter with `null`.


In order to represent the `Component` to the DOM, you'll need to override the abstract `build` method.

`Component` provide an `element` getter to an initialy empty `div`.

The `build` method role is the compete the `element` with wathever you want your `element` to look the same way you would do in JavaScript.

for exemple : 

```dart

@override
  void build() {
    element.appendChild(HTMLParagraphElement()..innerText = " Hello World !");
  }

```

The equivalent HTML of `element` would be : 

```html

<div>
    <p>Hello Word</p>
</div>

```

The `build` method is automatically called by the super constructor, so you just need to define it to complete the `element`.

Once the class is instanciated you can just call the `element` getter an add it to the DOM.

for exemple : 

```dart
void main() {

  final output = document.querySelector('#output') as HTMLDivElement;
  output.appendChild(MyComponent().element);

}
```

Your text now appears to the DOM.


### Create a Stateless Component

If we want to create a Statefull `Component`, we need to first define it's state.

To define a Component state, create a class that inherits from `ComponentState`.


```dart
class MyStatefullComponentState extends ComponentState {

    int count = 0;

}
```

Here `MyStatefullComponentState` will simply store an `int`.

`ComponentState` is a special class that tracks what it need to update in the ui when it change. 

It provides two usefull methods : `notify` and `addListener`.

`notify` will mostly be used by `ComponentState` own methods. When called it will rebuild the ui of it's listeners.

`addListener` adds a listener what will be trigger by `notify`.

We will complete our `MyStatefullComponentState` class.

```dart

class MyStatefullComponentState extends ComponentState {

    int count = 0;

    void incrementCount() {
        count++;
        notify();
    }

}

```

`increment` will add one to the count as well as telling the part of the ui that depends on it to rebuild.


Now, we will implements our `Component` for this state.



```dart

class MyStatefullComponent extends Component<MyStatefullComponentState> {

   MyStatefullComponent({MyStatefullComponentState? state}) : super(state : state ?? MyStatefullComponentState());

}

```


This time we need to provide a state to the super constructor.

We will override the `build` method. 

```dart
class MyStatefullComponent extends Component<MyStatefullComponentState> {

   MyStatefullComponent({MyStatefullComponentState? state}) : super(state : state ?? MyStatefullComponentState());

   @override
   void build() {
    element.appendChild(HTMLParagraphElement()..innerText = "My count is ${state.count}");
    final button = HTMLButtonElement()..innerText = "Click Me";
    button.addEventListener("click", state.increment.toJS);
    element.appendChild(button); 
   }

}


```

We should have a text thats updated with a button.
But how does the how th update the UI ?

We passed the `state.increment` which call `notify` to the button callback. Because `notify` is called ui is completely rebuilt.

This behavior is defined by the `rebuild` method of `Component`, by default it discards everything in `element` and call `build` again :

```dart

void rebuild() {
    element.innerHTML = "".toJS;
    build();
  }

```


This mean any local state will be discarded. We can override this method to only make the change we want.

```dart

class MyStatefullComponent extends Component<MyStatefullComponentState> {

   MyStatefullComponent({MyStatefullComponentState? state}) : super(state : state ?? MyStatefullComponentState());

   @override
   void build() {
    element.appendChild(HTMLParagraphElement()..innerText = "My count is ${state.count}");
    final button = HTMLButtonElement()..innerText = "Click Me";
    button.addEventListener("click", state.increment.toJS);
    element.appendChild(button); 
   }

   @override
   void rebuild() {
    final button = element.querySelector("p") as HTMLParagraphElement?;
    button?.innerText = "My count is ${state.count}";
   }

}

```

Here we just change the text that use the updated text.


### Update UI from extenal state

To make part of the ui update from state that is not it's own, just add a listerner for that state in the constructor.


```dart 

class ParentComponentState extends ComponentState {
    ...
}

class LocalComponentState extends ComponentState {
    ...
}


class StatefullComponent extends Component<LocalComponentState> {

    final ParentComponentState parentState;

    StatefullComponent({LocalComponentState? state , required this.parentState }) : super(state : state ?? LocalComponentState()) {
        parentState.addListener(this);
    }

    @override
    void build() {
        ...
    }

    @override
    void rebuild() {
        ...
    }
}


```









## Running and building

To run the app,
activate and use [`package:webdev`](https://dart.dev/tools/webdev):

```
dart pub global activate webdev
webdev serve
```

To build a production version ready for deployment,
use the `webdev build` command:

```
webdev build
```

To learn how to interop with web APIs and other JS libraries,
check out https://dart.dev/interop/js-interop.
