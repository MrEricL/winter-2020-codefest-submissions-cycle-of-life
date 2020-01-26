from flask import Flask, render_template, url_for, request, redirect, session
from fastai.vision import *


app = Flask(__name__)

# load the model here
learn = load_learner("data")

# format: localhost:5000/?path=data%2Fglass422%2Ejpg

@app.route('/', methods = ['POST','GET'])
def root():
	path = request.args['path']
	waste_types = ['cardboard','glass','metal','paper','plastic','trash']

	img = open_image(path)
	result = learn.predict(img)
	prob = [round(x.item()*100,2) for x in result[2]]
	prob = sorted(zip(prob,waste_types), reverse=True) #list of likeliest material

	return str(prob)



if __name__=='__main__':
	app.run(debug=True)




