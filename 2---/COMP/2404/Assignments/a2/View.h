#ifndef VIEW_H
#define VIEW_H

/*
	Purpose: A boundary class responsible for interacting with the user during the program
*/

#include <iostream>
#include <string>
using namespace std;


class View
{
  public:
    void showMenu(int&);
    void printStr(string);
    void readInt(int&);
    void readStr(string&);
};

#endif
