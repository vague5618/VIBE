import numpy as np
import pickle
import sys
import math

def sigmoid(x):
    return 1.0/(1.0 + np.exp(-x))

def sigmoid_prime(x):
    return sigmoid(x)*(1.0-sigmoid(x))

def tanh(x):
    return np.tanh(x)

def tanh_prime(x):
    return 1.0 - x**2

class NeuralNetwork:

    def __init__(self, layers, activation='sigmoid'):
        if activation == 'sigmoid':
            self.activation = sigmoid
            self.activation_prime = sigmoid_prime
        elif activation == 'tanh':
            self.activation = tanh
            self.activation_prime = tanh_prime

        # Set weights
        self.weights = []

        for i in range(1, len(layers) - 1):
            r = 2* np.random.random((layers[i-1] + 1, layers[i] + 1)) -1
            self.weights.append(r)
        # output layer - random((2+1, 1)) : 3 x 1
        r = 2*np.random.random((layers[i] + 1, layers[i+1])) - 1
        self.weights.append(r)

    def fit(self, X, y, learning_rate=0.5, epochs=100000):
        # Add column of ones to X
        # This is to add the bias unit to the input layer
        ones = np.atleast_2d(np.ones(X.shape[0]))
        X = np.concatenate((ones.T, X), axis=1)

        for k in range(epochs):
            i = np.random.randint(X.shape[0])
            a = [X[i]]

            for l in range(len(self.weights)):
                    dot_value = np.dot(a[l], self.weights[l])
                    activation = self.activation(dot_value)
                    a.append(activation)
            # output layer
            error = y[i] - a[-1]
            deltas = [error * self.activation_prime(a[-1])]

            # we need to begin at the second to last layer
            # (a layer before the output layer)
            for l in range(len(a) - 2, 0, -1):
                deltas.append(deltas[-1].dot(self.weights[l].T)*self.activation_prime(a[l]))

            # reverse
            # [level3(output)->level2(hidden)]  => [level2(hidden)->level3(output)]
            deltas.reverse()

            # backpropagation
            # 1. Multiply its output delta and input activation
            #    to get the gradient of the weight.
            # 2. Subtract a ratio (percentage) of the gradient from the weight.
            for i in range(len(self.weights)):
                layer = np.atleast_2d(a[i])
                delta = np.atleast_2d(deltas[i])
                self.weights[i] += learning_rate * layer.T.dot(delta)

            if k % 10000 == 0: print 'epochs:', k

    def pickle(self):
        f = file("test_file", "wb")
        pickle.dump(self, f, pickle.HIGHEST_PROTOCOL)
        f.close()

    @staticmethod
    def unpickle():
        with file('/Users/JAY/Desktop/MachineLearning/python/test_file', 'rb') as f:
            return pickle.load(f)

    def predict(self, x):
        a = np.concatenate((np.ones(1).T, np.array(x)), axis=1)
        for l in range(0, len(self.weights)):
            a = self.activation(np.dot(a, self.weights[l]))
        return a


if __name__ == '__main__':

    index_pat = [
        [0,0,0,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0,0],
        [1,0,0,0,0,0,0,0,0],
        [0,0,0,1,0,0,0,0,0],
        [0,0,0,0,1,0,0,0,0],
        [0,0,0,0,0,1,0,0,0],
        [0,0,0,0,0,0,0,0,1],
        [0,0,0,0,0,0,0,1,0],
        [0,0,1,0,0,0,0,0,0]
        ]

    pattern_info = [[]]
    pattern_info.append([[]])
    pattern_info[0].append([])

    pattern_list = []
    target_list = []

    input_info = []

    directory = 0
    file_index = 0
    temp = 0;
    dap = -1;

    while directory < 9:
     directory+=1
     pattern_info.append([[]])
     file_index = 0
     temp +=2
     dap +=1;

     while file_index < 20:
        file_index+=1
        pattern_info[directory].append([])
        with open('./DataSet/Pattern'+str(directory)+'/number'+str(directory)+'_'+str(file_index)+'.txt') as f:
             for line in f:
                for n in line.split(','):
                    pattern_info[directory][file_index].append(int(n))

                pattern_list.append(pattern_info[directory][file_index])
                target_list.append(index_pat[dap])


    with open('data.txt') as f:
        for line in f:
            for n in line.split(','):
                input_info.append(int(n))

    x = np.asarray(pattern_list)
    y = np.asarray(target_list)

    print target_list

    nn = NeuralNetwork([34969,11,9])

    nn.fit(x, y)

    nn.pickle()

    #print(nn.predict(input_info))

    ####################  Predict #########################
    # data = NeuralNetwork.unpickle()
    #
    # predict_data = (sys.argv[1].split(','))
    # predict_data = [int(i) for i in predict_data]
    # result = (data.predict(predict_data)).tolist()
    # print result.index(max(result))+1
    # print(round(data.predict(predict_data),2))