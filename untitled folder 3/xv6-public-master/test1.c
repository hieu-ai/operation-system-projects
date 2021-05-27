#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define IOjob 200
#define CPUjob 1000000


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

int main(int argc, char *argv[])
{
		int x = 999999999;
    int pid = fork();
    if (pid > 0){ //parent

		// Do I/O intensive jo
		for(int i=0;i<IOjob;i++){
			int fd=open("testIO.txt", O_RDONLY);
			write(fd, "A", 1);
			char buf[15];
			read(fd,buf,sizeof buf);
			printf(1, " ");
			x++;
		}

    wait();

    } else {
      int x = 999999999;
	    for (double z = 0; z < CPUjob; z += 1){
	        x = x / 3.14;
	        x=x*3.14+444; // Some random calculation
					x = fib(7);
	    }
    }
    getpinfo(getpid());
    exit();
}
