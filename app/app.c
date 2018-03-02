#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>

/*Array size to write and read*/
#define MAX_SIZE		1024

/*Operator code for ioctl*/
#define SET_REGMASK		0
#define GET_START		1
#define IS_READY		2

void GetOr(int* DataIn, int OrKey, int* DataOut) 
{
	char k;
	int temp[MAX_SIZE];
	int dev = open("/dev/de2i150_altera", O_RDWR);
	int i;
	
	//Write to RAM source
	write(dev, DataIn, MAX_SIZE*sizeof(int));
	
	//Write to RegMask
	ioctl(dev, SET_REGMASK, &OrKey);
	
	//Start processing
	k = 1;
	ioctl(dev, GET_START, &k);
	
	//Blocking, until OrAtom is ready 
	while(1)
	{
		ioctl(dev, IS_READY, &k);
		if(k == 0) break;
	}
	
	//Read the result from RAM destination
	read(dev, temp, MAX_SIZE*sizeof(int));
	
	for(i = 0; i < MAX_SIZE; i++)
		DataOut[i] = temp[i];
	
	//The end
	close(dev);
}

int main() {
	
	int a[MAX_SIZE], b[MAX_SIZE];
	int i;
	char k;
	
	//Initialize array a
	for (i = 0; i < MAX_SIZE; i++)
		a[i] = i;
	
	/* Call GetOr 
	*  array a will be written to RAM source 
	*  RegMask = 1 to calculate or operator (or each memory cell with 0x0000_0001)
	*  array b will get the results after calculation
	*/
	GetOr(a, 1, b);
	
	for(i = 0; i < MAX_SIZE; i++)
		printf("%d\n", b[i]);
	
	return 0;
}

