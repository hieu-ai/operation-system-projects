#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"


#define IOjob 500
#define CPUjob 1000000

int
main(int argc, char *argv[]){
	int pid=fork();
	if(pid >0){};
	for(int i=0;i<IOjob;i++){
		sleep(1);
	}
	wait();
	getpinfo(getpid());
	exit();
}