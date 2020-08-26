import matplotlib.pyplot as plt
import numpy as np
import os
import scipy.io as sio
from scipy.fftpack import fft,ifft

#%%
def FindIndex (fft_result):
    fft_result_x = np.arange(fft_result.shape[-1])
    fft_result_x = fft_result_x/(fft_result_x.shape[-1])*12800
    flag3k=0
    index1=0
    flag7k=0
    index2=0
    for i in range(len(fft_result_x)):
        if(flag3k==0 and fft_result_x[i]>=5000):
            flag3k=1
            index1=i
        if(flag7k==0 and fft_result_x[i]>=11000):
            flag7k=1
            index2=i    
            break
    return index1, index2

def FindFeature (first_index, second_index, fftresult):
        index1=first_index
        index2=second_index
        fftresult=fftresult
        max_feature=0
        period =5000
        different = int((index2-index1)/period)
        list1=[]
    
        for j in range(len(fftresult)):
            for k in range (period):
                 for i in range(index1, (index1+different+1), 1):
                     if(i<index1+different):
                         if(float(max_feature)<= fftresult[j:j+1,i:i+1]):
                             max_feature =  fftresult[j:j+1,i:i+1].reshape(-1)    
                     else:
                         list1.append(max_feature)
                         index1=index1+different
                         max_feature=0
                         break   
            index1=first_index
            index2=second_index
        list1 = np.array(list1).reshape(len(fftresult),-1)
        return list1
#%%
if __name__ == '__main__':
    data_list = ['三號砂data','九號砂data']
    for fileName in data_list:
        image_file_path = r'D:\中山大學\資訊工程\專題\project\\' + fileName  
        imagelist = os.listdir(image_file_path)
        
        fft_result=[]
        for i in range (len(imagelist)):
            inputData=sio.loadmat(image_file_path +"\\"+ imagelist[i])
            data = inputData['Ch1']
            data = data.astype('float')
            yf=abs(fft(data))
            
            data_length=data.shape[1]
            yf1=abs(fft(data))/data_length
            yf2 = yf1[0:1,range(int(data_length/2))]
            yf2 = yf2.reshape(-1)
            
            xf = np.arange(data_length/2)
            xf1 = xf/(data_length/2)*12800
           
            plt.plot(xf1,yf2,'b')
            plt.title('FFT of Mixed wave)',fontsize=10,color='#F08080')
                     
            fft_result.append(yf2)
            plt.show()
        file = 'num3' if fileName == data_list[0] else 'num9'
        np.save(file +  "_fft_result.npy",fft_result)
#%%
    num3_fft_result = np.load("num3_fft_result.npy")
    num9_fft_result = np.load("num9_fft_result.npy")
    
    num3_beginIndex, num3_endIndex = FindIndex(num3_fft_result)
    num9_beginIndex, num9_endIndex = FindIndex(num9_fft_result)
    
    num3_feature = FindFeature(num3_beginIndex, num3_endIndex, num3_fft_result)
    num9_feature = FindFeature(num9_beginIndex, num9_endIndex, num9_fft_result)
    
    num3_feature = np.array(num3_feature)
    num9_feature = np.array(num9_feature)
    
    data = np.vstack((num3_feature,num9_feature))
    label = []
    for i in range( len(num3_feature) ):
        label.append(0)
    for i in range( len(num9_feature) ):
        label.append(1)
    label=np.array(label).reshape(-1,1)
    
    data = np.hstack((data,label))
    per = np.random.permutation(data.shape[0])
    random_data = data[per]
#%%    
    tr=random_data[:-40,:]
    tr_x=tr[:,:-1]
    tr_y=tr[:,-1]
    te=random_data[-40:,:]
    te_x=te[:,:-1]
    te_y=te[:,-1]
    
    np.save( "tr_x.npy",tr_x)
    np.save( "tr_y.npy",tr_y)
    np.save( "te_x.npy",te_x)
    np.save( "te_y.npy",te_y)