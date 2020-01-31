from flask import Flask, render_template, url_for, request, redirect, session
from fastai.vision import *
import os
import requests
import urllib.request
import base64
import json
import numpy as np
import cv2 as cv
from matplotlib import pyplot as plt


app = Flask(__name__)

# name of where we are
DIRNAME = os.path.dirname(__file__)
# name of directory with user uploaded images
IMG_DIR = os.path.join(DIRNAME, 'imgs')

# load the model here
learn = load_learner("data")

# format: localhost:5000/?img=URL

def check_exposure(loc):
    img = cv.imread(loc,0)
    hist,bins = np.histogram(img.flatten(),256,[0,256])
    cdf = hist.cumsum()
    cdf_25 = cdf[len(cdf)//4]/cdf[-1] * 100
    cdf_75 = cdf[3*len(cdf)//4]/cdf[-1] * 100
    exposure = None
    if cdf_25 >= 60:
        if cdf_25 >= 80:
            exposure = (1, "very underexposed")
        else:
            exposure = (1, "a little underexposed")
    elif cdf_75 <= 30:
        if cdf_75 <= 20:
            exposure = (2, "very overexposed")
        else:
            exposure = (2, "a little underexposed")
    else:
        exposure = (0, "")
    
    return exposure
        


def decode_img(encoded):
        encoded = "+".join(encoded.split(" "))
        img_bytes = io.BytesIO(base64.b64decode(encoded))
        return img_bytes

def decode_url(encoded):
        encoded = "+".join(encoded.split(" "))
        link = base64.b64decode(encoded).decode("utf-8")
        return str(link)

def download_url(url, name="imgs/test.jpg"):
        print(url, "\n\n\n\n\n")
        urllib.request.urlretrieve(url, "imgs/test.jpg")


@app.route('/', methods = ['POST','GET'])
def root():
        # if base 64 image
        #img_url = request.args['img']
        #img = open_image(decode_img(img_url))

        # if base 64 link
        try:
                img_url = request.args['img']
                download_url(decode_url(img_url))
                img = open_image("imgs/test.jpg")
                exposure = check_exposure("imgs/test.jpg")
        except:
                return "uh oh"


        waste_types = ['cardboard','glass','metal','paper','plastic','trash']

        
        #img = open_image("wine.jpg")
        result = learn.predict(img)
        only_prob = [round(x.item()*100,2) for x in result[2]]
        prob = sorted(zip(only_prob,waste_types), reverse=True) #list of likeliest material


        #CHOOSE WHICH ONE YOU WANT
        a = {"res": prob}
        # return json.dumps(a)

        # b = {waste_types[i]:only_prob[i] for i in range(len(only_prob))}
        # if exposure[0] != 0:
        a["exposure"] = exposure
        return json.dumps(a)

        #return str(prob)



if __name__=='__main__':
	app.run(debug=True)
