import os
import io
import pickle
import time
import subprocess

model_path = '/opt/ml/model'

def main(data):
    return os.urandom(10)