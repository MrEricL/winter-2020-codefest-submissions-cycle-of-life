from flask import Flask, render_template, url_for, request, redirect, session
from fastai.vision import *
import os
import requests
import urllib.request
import base64


app = Flask(__name__)

# name of where we are
DIRNAME = os.path.dirname(__file__)
# name of directory with user uploaded images
IMG_DIR = os.path.join(DIRNAME, 'imgs')

# load the model here
learn = load_learner("data")

# format: localhost:5000/?img=URL

def decode_img(encoded):
        encoded = "+".join(encoded.split(" "))
        img_bytes = io.BytesIO(base64.b64decode(encoded))
        return img_bytes

def decode_url(encoded):
        encoded = "+".join(encoded.split(" "))
        link = base64.b64decode(encoded).decode("utf-8")
        return str(link)

def download_url(url, name="imgs/test.jpg"):
        urllib.request.urlretrieve(url, "imgs/test.jpg")


@app.route('/', methods = ['POST','GET'])
def root():
        # if base 64 image
        #img_url = request.args['img']
        #img = open_image(decode_img(img_url))

        # if base 64 link
        #img_url = request.args['img']
        #download_url(decode_url(img_url))
        #img = open_image("imgs/test.jpg")


        waste_types = ['cardboard','glass','metal','paper','plastic','trash']

        
        #img = open_image("../test.jpg")
        result = learn.predict(img)
        prob = [round(x.item()*100,2) for x in result[2]]
        prob = sorted(zip(prob,waste_types), reverse=True) #list of likeliest material

        return str(prob)



if __name__=='__main__':
	app.run(debug=True)
