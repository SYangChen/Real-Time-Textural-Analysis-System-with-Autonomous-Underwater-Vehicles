import numpy as np
import matplotlib.pyplot as plt
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation, LeakyReLU
from keras.utils import np_utils
from keras import optimizers
#%%
xTrain = np.load('tr_x.npy')
yTrain = np.load('tr_y.npy')
xTest = np.load('te_x.npy')
yTest = np.load('te_y.npy')

xTrain *= 1000
xTest *= 1000

ylabel = yTest
yTrain = np_utils.to_categorical(yTrain)
yTest = np_utils.to_categorical(yTest)\
#%%
model = Sequential()
#model.add(Dense(units=1, input_dim=xTrain.shape[1], kernel_initializer='normal', activation='linear'))
model.add(Dense(units=2, input_dim=xTrain.shape[1], kernel_initializer='normal', activation='softmax'))

model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['accuracy'])
model.fit(x=xTrain, y=yTrain, epochs=50, batch_size=16, validation_split=0.2, verbose=2)

loss, acc = model.evaluate(xTest, yTest)

print("\n\t[Info] The accuracy of testing data: {:.2f}%".format(acc*100))
print("\t[Info] The loss of testing data: {:f}".format(loss))
'''
weights = np.array(model.get_weights())
mid_layer_weights = weights[0]
mid_layer_bias = weights[1]
output_layer_weights = weights[2]
output_layer_bias = weights[3]

np.savetxt("mid_layer_weights.txt",mid_layer_weights)
np.savetxt("mid_layer_bias.txt",mid_layer_bias)
np.savetxt("output_layer_weights.txt",output_layer_weights)
np.savetxt("output_layer_bias.txt",output_layer_bias)
'''

print(model.summary())

predictions = model.predict_classes(xTest)
label = [0,1]
print_ytest = []
print_ypred = []
for i in range(len(label)):
    for j in range(len(ylabel)):
        if ylabel[j] == label[i]:
            print_ytest.append(ylabel[j])
            print_ypred.append(predictions[j])


x = list(x for x in range(len(print_ytest)))
plt.scatter(x,print_ytest,c='r',label='Answer')
plt.scatter(x,print_ypred,c='b',label='Prediction')
plt.legend()
plt.show()
