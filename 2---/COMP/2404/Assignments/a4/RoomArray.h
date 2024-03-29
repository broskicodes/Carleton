#ifndef ROOMARRAY_H
#define ROOMARRAY_H

/*
	Purpose: A collection class that stores room objects
*/

#include "defs.h"
#include "Room.h"


class RoomArray
{
  public:
    RoomArray();
    ~RoomArray();
    void  add(Room*);
    int   getSize();
    Room* get(int);
    void  print();

  private:
    Room* elements[MAX_ARR];
    int   size;
};

#endif

