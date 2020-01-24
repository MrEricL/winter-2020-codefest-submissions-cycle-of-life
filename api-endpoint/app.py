from flask import Flask, render_template, url_for, request, redirect, session

app = Flask(__name__)


@app.route("/")
def index():
    # return render_template("index.html")
    return "hello"



if __name__ == "__main__":
   app.debug = True
   app.run(host="0.0.0.0", port=5000)
