#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define IOjob 20
#define CPUjob 100000


int fib(int param){
	if(param <= 0){
		return 0;
	}
	else if(param == 1){
		return 1;
	}
	else{
		return fib(param-1) + fib(param-2);
	}
}

int
main(int argc, char *argv[]){

	int pid = fork();
	if(pid > 0 ){

		fork();
		fork();
		fork();

		for(int i=0;i<400;i++){
			for (int j = 0; j < 3; ++j){
				int fd=open("testIO.txt", O_RDONLY);
				char buf[20];
				read(fd,buf,sizeof buf);
			}
			sleep(1);
		}

		printf(1,"%d\n",fib(30));

		printf(1," ");
		wait();
		wait();
		wait();

	}
	else {
		int x = 999999999;
    for (double z = 0; z < CPUjob; z += 1) {
        x = x / 3.14;
        x=x*3.14+444; // Some random calculation
				x = fib(7);
    }
	}
	wait();
	getpinfo(getpid());

	exit();

}
