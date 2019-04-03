# Inheritance

## Table of contents
1. [Basics](#basics)


## Basics
Reference 1: Jumping into C++, Chapter 26  
Reference 2: [C++11 Syntax and Feature](http://ezoeryou.github.io/cpp-book/C++11-Syntax-and-Feature.xhtml#class.virtual)

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
    void say_virtual(); // hiding
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
  child3.say_virtual();

  return 0;
}
```
