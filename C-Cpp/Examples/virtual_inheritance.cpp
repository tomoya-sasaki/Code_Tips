#include <iostream>
using namespace std;

#include <Eigen/Dense>

using namespace std;
using namespace Eigen;


class baseA
{
  public:
    baseA() {};

    void print()
    {
      cout << "Base A" << endl; 
    };

    virtual void print_v()
    {
      cout << "Base A virtual" << endl; 
    }

    virtual void print_v2() = 0;
};


class childA : virtual public baseA
{
  public:
    childA() : baseA() {};

    int val1 = 1;

    virtual void print_v2()
    {
      cout << "child A" << endl; 
    }

    virtual void print_v() = 0;
};



class childB : virtual public baseA
{
  public:
    childB() : baseA() {};

    int val2 = 2;

    void print()
    {
      cout << "print child B" << endl; 
    };

    virtual void print_v2()
    {
      cout << "print_v2 child B" << endl; 
    }

};


class grandchild : public childA, public childB
{
  public:
    grandchild() : baseA(), childA(), childB() {};

    virtual void print_v()
    {
      cout << "print_v grandchild " << val1 << endl; 
    }

    virtual void print_v2()
    {
      cout << "print_v2 grandchild " << val2 << endl; 
    }

};


int main() {
  grandchild obj;
  obj.print();
  obj.print_v();
  obj.print_v2();
}
