#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

#include "Call.h"

Call::Call(string s, string dst, int y, int m, int d, int h, int min, int dur)
	: src(s), dest(dst), duration(dur), date(new Date(d, m, y)), time(new Time(h, min))
{

}

Call::~Call(){
	delete date;
	delete time;
}

bool Call::greaterThan(Call *c){
	if(date->greaterThan(c->date)){
		return true;
	} else if(date->equals(c->date) && time->greaterThan(c->time)){
		return true;
	} else{
		return false;
	}
}

void Call::print(){
	date->print();
	cout<<", ";
	time->print();

	cout<<"; Lasted: "<<duration<<" minute(s)."<<endl;
	cout<<"From: "<<src<<" To: "<<dest<<endl<<endl;
}