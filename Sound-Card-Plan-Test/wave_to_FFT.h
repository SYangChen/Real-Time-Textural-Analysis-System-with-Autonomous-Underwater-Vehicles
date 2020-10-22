#ifndef WAV_TO_FFT
#define WAV_TO_FFT
#include <iostream>
#include <fstream>
#include <string.h>
#include <vector>
#include <cmath>
#include <complex>
using namespace std;

const double pi = acos(-1);
const complex<double> j(0, 1);

class CN {
  public:
    double x;
    double y;
    CN(double X, double Y): x(X), y(Y) {}
    CN(double X): x(X), y(0) {}
    CN operator +(CN& obj){
        return CN(this->x + obj.x, this->y + obj.y);
    }
    CN operator -(CN& obj){
        return CN(this->x - obj.x, this->y - obj.y);
    }
};

ostream& operator<<(ostream& output, const CN& num)
{
    if(num.y>=0)
    	output << num.x << " + " << num.y << "i";
    else
        output << num.x << " - " << num.y*-1 << "i";
    return output;
}

void FFT(vector<CN>& v) {
    int N = int(v.size());
    if (N <= 1) return;

    vector<CN> even, odd;
    for (int i = 0; i < N; i += 2) {
        even.push_back(v[i]);
    }
    FFT(even);
    for (int i = 1; i < N; i += 2) {
        odd.push_back(v[i]);
    }
    FFT(odd);

    vector<CN> T;
    for (int k = 0; k < N / 2; k++) {
        complex<double> a( -2, 0 ), b( double(k), 0 ), c( double(N), 0 ), d( odd[k].x, odd[k].y );
        complex<double> temp = exp(a * j * pi * b / c) * d; // exp(-2j*pi*k/N)*odd[k]
        CN num(temp.real(), temp.imag());
        T.push_back(num);
    }

    vector<CN> result;
    for (int k = 0; k < N / 2; k++)
        result.push_back(even[k] + T[k]);
    for (int k = 0; k < N / 2; k++)
        result.push_back(even[k] - T[k]);
    for (int k = 0; k < N; k++)
        v[k] = result[k];
}

struct wav_info{
    uint32_t file_size;
    uint32_t subchunk2size;
    vector<short> data;
};

wav_info ReadWav(char *filename){
    fstream fs;
    wav_info WAV;
    uint32_t reader;

    fs.open(filename, ios::binary | ios::in);

    fs.seekg(0, ios::end);
    WAV.file_size = fs.tellg();

    fs.seekg(0x28);
    fs.read((char*)&reader, 4);
    WAV.subchunk2size = reader;

    fs.seekg(0x2C);
    for(int i=0;i<int(WAV.subchunk2size)/2;i++){
        fs.seekg(0x2C+i*2);
        fs.read((char*)&reader, 2);
        WAV.data.push_back(reader);
    }

    fs.close();

    return WAV;
}

void WAV2FFT(char *filename, double* result){
    /*  read wav  */
    wav_info wav;
    wav = ReadWav(filename);
    vector<CN> v;

    // wav file information
    /*
    cout << "File Size: " << wav.file_size << " bits" << endl;
    cout << "Data Size: " << wav.subchunk2size << endl;
    cout << "Data: " << endl;
    for(int i=0;i<int(wav.data.size());i++)
        if(wav.data[i]!=0)
            cout << wav.data[i] << ' ';
    cout << endl;
    */

    /*   turn to CN type  */
    for(int i=0;i<int(wav.data.size());i++){
        CN temp(double(wav.data[i]));
        v.push_back(temp);
    }
    
    /*  FFT  */
    FFT(v);

    /*  11000-18000  */
    vector<CN> Select_period;
    float max_in_period = 0.0;
    for(int i=11000;i<18000;i++){
        float distance;
        float temp;
        temp = v[i].x * v[i].x + v[i].y * v[i].y;
        distance = sqrt(temp);
        if (max_in_period < distance) 
        {
            max_in_period = distance;
        }
        Select_period.push_back(distance);
    }

    /*  select 1000  */
    vector<CN> sonar_feature;
    for(int i=0;i<int(Select_period.size());i=i+7){
        float max_feature = 0;
        for(int j=0;j<7;j=j+1){
            if (j % 7 == 0)
                max_feature = 0;
            if (max_feature < Select_period[i+j].x)
                max_feature = Select_period[i+j].x;
        }
        sonar_feature.push_back(max_feature);
    }

    /*   normalize   */
    for(int i=0;i<int(sonar_feature.size());i++){
        double feature = 0;
        feature = sonar_feature[i].x;
        feature = feature / (max_in_period*1000);
        result[i] = feature;
    }
}

/*
int main(){
    double result[1000];

    WAV2FFT("chirp-10-20k-50ms-am08_fs44100.wav",result);
    for(int i=0;i<1000;i++)
        cout << result[i] << endl;

    return 0;
}
*/
#endif
