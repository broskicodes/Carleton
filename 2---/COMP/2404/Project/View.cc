#include <iostream>
using namespace std;
#include <string>

#include "View.h"

void View::showMenu(int& choice)
{
  int numOptions = 3;

  cout << endl;
  cout << "What would you like to do:"<< endl;
  cout << "  (1) Percentage distribution of farms, by province (2016)" << endl;
  cout << "  (2) Percentage change of animals, by province (2011-2016)" << endl;
  cout << "  (3) Sub-region with highest number of horses, by province (2016)" << endl;
  cout << "  (0) Exit" << endl<<endl;

  cout << "Enter your selection: ";
  cin >> choice;

  while (choice < 0 || choice > numOptions) {
		if (choice == 0)
    	return;

    cout << "Enter your selection: ";
    cin >> choice;
  }
}

void View::printStr(string str)
{
  cout << str;
}

void View::readInt(int& n)
{
  cin >> n;
}

void View::readStr(string& str)
{
  cin >> str;
}



