#ifndef DEC_TO_BIN
#define DEC_TO_BIN
#include <iostream>
using namespace std;

struct NUM{
    int x;
    double y;
};

NUM DecimalConverter(double d){
    int x;
    NUM value;
    d *= 2;
    if(d<1)
        x = 0;
    else
        x = 1;
    d -= x;
    
    value.x = x;
    value.y = d;

    return value;
}

void Show16bits(int *bit32){
    for(int i=0;i<32;i++)
        cout << bit32[i];
    cout << endl;
}

void ShowHex(int *bit32, char *hex){
    char list[16]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
    for(int i=0;i<8;i++){
        int value=0,rate=8;
        for(int j=i*4;j<(i+1)*4;j++){
            value += rate*bit32[j];
            rate /= 2;
        }
        hex[i] = list[value];
    }
    
    // cout << "0x";
    // for(int i=0;i<8;i++)
    //     cout << hex[i];
    // cout << endl;
}

void ShowDecimal(int *bit32){
    int sign=0;
    double rate=1,value=0;
    if(bit32[0]==1)
        sign = 1;
    if(sign==1){
        int c[32], carry=1;
        for(int i=0;i<32;i++)
            c[i] = !bit32[i];
        for(int i=31;i>=0;i--){
            c[i] += carry;
            if(c[i]>1){
                c[i]=0;
                carry=1;
            }
            else{
                carry=0;
                break;
            }
        }
        for(int i=0;i<32;i++)
            bit32[i] = c[i];
    }
    
    for(int i=0;i<32;i++){
        value += bit32[i]*rate;
        rate /= 2;
    }

    if(sign==1)
        value *= -1;

    cout << value << endl;
}

void Double2Bin(double num,int places,int *bit32){
    int sign = 0;
    if(num<0){
        sign = 1;
        num *= -1;
    }
    if(num>=1)
        bit32[0] = 1;
    else
        bit32[0] = 0;

    for(int i=1;i<=places;i++){
        NUM temp = DecimalConverter(num);
        bit32[i] = temp.x;
        num = temp.y;
    }
    if(sign==1){
        int c[32], carry=1;
        for(int i=0;i<32;i++)
            c[i] = !bit32[i];
        for(int i=31;i>=0;i--){
            c[i] += carry;
            if(c[i]>1){
                c[i]=0;
                carry=1;
            }
            else{
                carry=0;
                break;
            }
        }
        for(int i=0;i<32;i++)
            bit32[i] = c[i];
    }
}

/*
int main(){
    int bit32[32];
    Double2Bin(0.3141592628,31,bit32);
    Show16bits(bit32);
    ShowHex(bit32);
    ShowDecimal(bit32);
    
    return 0;
}
*/
#endif
