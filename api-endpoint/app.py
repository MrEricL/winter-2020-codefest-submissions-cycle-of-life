from flask import Flask, render_template, url_for, request, redirect, session
from fastai.vision import *
import os
import requests


app = Flask(__name__)

# name of where we are
DIRNAME = os.path.dirname(__file__)
# name of directory with user uploaded images
IMG_DIR = os.path.join(DIRNAME, 'imgs')

# load the model here
learn = load_learner("data")

# format: localhost:5000/?img=URL

@app.route('/', methods = ['POST','GET'])
def root():
        img_url = request.args['img']
        img_name = img_url.split("/")[-1]
        new_img = os.path.join(IMG_DIR, img_name)

        img_data = requests.get(img_url).content
        with open(new_img, 'wb') as handle:
                handle.write(img_data)

        waste_types = ['cardboard','glass','metal','paper','plastic','trash']

        img = open_image(new_img)
        result = learn.predict(img)
        prob = [round(x.item()*100,2) for x in result[2]]
        prob = sorted(zip(prob,waste_types), reverse=True) #list of likeliest material

        return str(prob)



if __name__=='__main__':
	app.run(debug=True)
