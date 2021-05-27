#include "types.h"
#include "user.h"
#include "date.h"
#include "printf.h"

const char * months[13] = {"NA","January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};

int
main(int argc, char *argv[])
{

 struct rtcdate r;
 if (date(&r)) {
   printf(2, "date failed\n");
   exit();
 }
 //Print time and add 0's where appropriate for readability
 if(r.hour <= 9){ //WRITTEN BY MARCHANT AND NGUYENHI
 	if(r.minute <= 9){  //CASE
 		printf(1, " 0%d:0%d UTC %s %d, %d\n", r.hour, r.minute, months[r.month] ,r.day, r.year);
 	}
 	else{
 		printf(1, " 0%d:%d UTC %s %d, %d\n", r.hour, r.minute, months[r.month] ,r.day, r.year);
 	}

 }
 else{
   printf(1, " %d:%d UTC %s %d, %d\n", r.hour, r.minute, months[r.month] ,r.day, r.year);

 }
 exit();
}
