#include "wave_to_FFT.h"
#include "dec_to_bin.h"
#include <cstdlib>
#include <iostream>
#include <sys/mman.h>   //mmap
#include <sys/ioctl.h>  //ioctl
#include <sys/time.h>	//gettimeofday
#include <fcntl.h>      //open
#include <unistd.h>		// usleep
using namespace std ;

#define WRITE_RESET 0
#define WRITE_INSIGN 1
#define WRITE_INDATA 2
#define READ_CATEGORY 3

void Inject_Data( int my_intr_fd, int inject_case, unsigned long data ) {
	
	int temp ;
	switch( inject_case ) {
		case WRITE_RESET :
			temp = ioctl( my_intr_fd, WRITE_RESET, data ) ;
			break ;
		case WRITE_INSIGN :
			temp = ioctl( my_intr_fd, WRITE_INSIGN, data ) ;
			break ;
		case WRITE_INDATA :
			temp = ioctl( my_intr_fd, WRITE_INDATA, data ) ;
			break ;
		default :
			cout << "There is an error with case injecting" << endl ;
			break ;
	}
	
}

int Eject_Data( int my_intr_fd ) {
	
	return ioctl( my_intr_fd, READ_CATEGORY, 0 ) ;
	
}

int main( int argc, char *argv[] ){

	int my_intr_fd = 0, i, j ;
	//Open Char Device
	my_intr_fd = open( "/dev/ann32", O_RDWR ) ;
	//Check if char device is opened successfully
	if ( my_intr_fd < 1 ){
		printf( "\t\t[error] Unable to open my_intr device file" ) ;
		exit( EXIT_FAILURE ) ;
	}
	
	//Using ioctl as example
	printf( "\t\t [info] ANN32 hardware start\n" ) ;
	
	// reset
	Inject_Data( my_intr_fd, WRITE_RESET, 0 ) ; // rst = 0;
	usleep( 5 ) ;
	Inject_Data( my_intr_fd, WRITE_RESET, 1 ) ; // rst = 1;
	usleep( 5 ) ;
	Inject_Data( my_intr_fd, WRITE_RESET, 0 ) ; // rst = 0;
	Inject_Data( my_intr_fd, WRITE_INSIGN, 0 ) ;
	// reset
	
    double result[1000] ;
    int bit32[32] ;
	char hex[8] ;
	unsigned long inData ;
	int cat = 0 ;

    WAV2FFT( argv[1], result ) ;
    for( int i = 0 ; i < 1000 ; ++i ){
		Inject_Data( my_intr_fd, WRITE_INSIGN, 0 ) ;
        Double2Bin( result[i], 31, bit32 ) ;
        ShowHex( bit32, hex ) ;
		inData = strtoul( hex, NULL, 16 ) ;
		Inject_Data( my_intr_fd, WRITE_INDATA, inData ) ;
		Inject_Data( my_intr_fd, WRITE_INSIGN, 1 ) ;
		usleep( 10 ) ;
		// cout << inData[i] << endl ;
    }
	sleep( 1 ) ; 
	cat = Eject_Data( my_intr_fd ) ;
	cout << cat << endl ;
    return 0 ;
}
