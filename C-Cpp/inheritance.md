# Inheritance

## Table of contents
1. [Basics](#basics)
2. [Virtual Function](#virtual-function)

## Basics
Reference 1: Jumping into C++, Chapter 26  
Reference 2: [C++11 Syntax and Feature](http://ezoeryou.github.io/cpp-book/C++11-Syntax-and-Feature.xhtml#class.virtual)

### Sample Code
```cpp
#include<iostream>
#include<string>
using namespace std;

class Parent
{
  public:
    void say(string &text){
      cout << text << endl;
    }

    virtual void say_virtual(string &text){
      cout << text << endl;
    }

    int a;
    virtual void show_a(){
      cout << a << endl;
    }

};

class Child1 : public Parent
{
  public:
    int a = 5;
  
};

class Child2 : public Parent
{
  public:
    void say_virtual(string &text); // override
};

void Child2::say_virtual(string &text){
  cout << text.substr (3,5) << endl;
}

class Child3 : public Parent
{
  public:
    void say(string &text){
      cout << "I say: " << text.substr (1,2) << endl;
    }

    void say_virtual(); // hiding -> Don't use it
};

void Child3::say_virtual(){
  cout << "Don't use hiding" << endl;
}

int main()
{
  // Inherit class and a virtual function
  Child1 child1;
  string saythis = "Hello";
  child1.say(saythis);  // > "Hello"
  child1.say_virtual(saythis); // > "Hello"

  child1.show_a();

  // Override virtual class
  Child2 child2;
  child2.say_virtual(saythis); // Different message from above

  // Don't use hiding
  // cf. https://cpplover.blogspot.com/2010/08/overloadoverridehiding.html
  Child3 child3;
  child3.say(saythis);
  child3.say_virtual();

  return 0;
}
```

## Virtual Function

### Basics
[Reference](https://stackoverflow.com/a/391492/4357279)

> An abstract function cannot have functionality. You're basically saying, any child class MUST give their own version of this method, however it's too general to even try to implement in the parent class.
An abstract function might be related to a pure virtual function ([Reference](https://stackoverflow.com/a/1306837/4357279)). 
> When a pure virtual method exists, the class is "abstract" and can not be instantiated on its own. Instead, a derived class that implements the pure-virtual method(s) must be used. A pure-virtual isn't defined in the base-class at all, so a derived class must define it, or that derived class is also abstract, and can not be instantiated. Only a class that has no abstract methods can be instantiated.

> A virtual function, is basically saying look, here's the functionality that may or may not be good enough for the child class. So if it is good enough, use this method, if not, then override me, and provide your own functionality.

> What virtual does is to give you polymorphism (only virtual method gives it), that is, the ability to select at run-time the most-derived override of a method.

We should use a virtual function if there is any chance that the function will be overriden in subclass ([Reference](https://stackoverflow.com/q/2391679/4357279) has nice examples).

### Pointer
[Reference](https://stackoverflow.com/a/1307867/4357279) shows how `virtual` functions can be overriden.

```cpp
#include <iostream>
using namespace std;

class Base {
public:
    void NonVirtual() {
        cout << "Base NonVirtual called.\n";
    }
    virtual void Virtual() {
        cout << "Base Virtual called.\n";
    }
};
class Derived : public Base {
public:
    void NonVirtual() {
        cout << "Derived NonVirtual called.\n";
    }
    void Virtual() {
        cout << "Derived Virtual called.\n";
    }
};

int main() {
    // Ex.1
    Base* bBase = new Base();
    Base* bDerived = new Derived(); // Pointer is `Base`

    bBase->NonVirtual(); // Base NonVirtual called.
    bBase->Virtual(); // Base Virtual called.
    bDerived->NonVirtual(); // Base NonVirtual called.
    bDerived->Virtual(); // Derived Virtual called.

    // Ex.2
    Base* derived2 = new Derived(); // Pointer is `Base`
    derived2 -> NonVirtual(); // Base NonVirtual called.
    Derived* derived3 = new Derived(); // Pointer is `Derived`
    derived3 -> NonVirtual(); // Derived NonVirtual called.
}
```

In Ex.1, the compiler sees that `bDerived` is a `Base*`. Since `NonVirtual` is not virtual, it does the resolution on class `Base`.

When we call `Virtual()` in `Derived` class, he selecction of method happens at run-time, not compile-time. What happens at compile-time is that the compiler sees that this is a `Base*`, and that it's calling a virtual method, so it insert a call to the virtual method table (vtable) instead of class `Base`. This vtable is instantiated at run-time.

