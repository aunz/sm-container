import os
import io
import pickle
import time

model_path = '/opt/ml/model'

print(11112211)
print(os.environ)

def main(data):
    print(12345)
    print('the data', data, '\n')
    for i in range(15):
        print('sleep', i)
        time.sleep(60)
    # print(io.StringIO(data))
    # return '1233\n'
    return os.urandom(10)