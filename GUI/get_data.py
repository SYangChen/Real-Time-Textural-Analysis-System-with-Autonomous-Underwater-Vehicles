import serial
import numpy as np
from matplotlib import pyplot as plt

PORT = '/dev/ttyUSB1'
BPS = 115200
TIME = 2

save_data = 0
def SaveData( value ):
    value = int(value.decode())+1
    np.save('data',np.array(value))
    return value

def Terminal(ser,cmd=False):
    def Show(x,flag=False):
        try:
            if( flag ):
                print(x.decode())
            else:
                print(x.decode(),end='')
            return 1
        except:
            return 0

    line=b''
    while(1):
        global save_data
        x=ser.read()
        line += x
        if( x==b'\n' ):
            if( cmd ):
                cmd = False
                line = b''
                continue
            Show(line)
            if( save_data ):
                value = SaveData( line )
                #print('store: ',value)
            line = b''
        elif( x==b'' ):
            Show(line)
            line = b''
            save_data = 0
            break
def CMD_line(ser):
    global save_data
    shutdown = 0
    while(1):
        cmd = input()
        if cmd == 'exit':
            cmd = 'shutdown -h now'
            shutdown = 1
        if( cmd == './a.out' ):
            save_data = 1
        ser.write(str(cmd+'\n').encode("gbk"))
        Terminal( ser, cmd=True )
        if( shutdown ): break
if __name__ == '__main__':
    try:
        portx=PORT
        timex=TIME
        bps=BPS
        ser=serial.Serial(portx,bps,timeout=timex)
        Terminal( ser )
        user = input()
        ser.write(str(user+'\n').encode("gbk"))
        Terminal( ser, cmd=True )
        password = input()
        ser.write(str(password+'\n').encode("gbk"))
        Terminal( ser )
        
        CMD_line(ser)
        
        ser.close()
    except Exception as e:
        print("---異常---：",e)
        ser.close()
