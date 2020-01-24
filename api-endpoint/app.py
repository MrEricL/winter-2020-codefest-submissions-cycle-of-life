from flask import Flask, render_template, url_for, request, redirect, session
import os
import subprocess

app = Flask(__name__)

DIRNAME = os.path.dirname(__file__)
PROCESSNAME = os.path.join(DIRNAME, '..', 'mock-process', 'hello.py')

@app.route("/")
def index():
    p = subprocess.Popen('python ' + PROCESSNAME, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    output = []
    for line in p.stdout.readlines():
        output.append(line.decode().strip())
    retval = p.wait()
    return "".join(output)



if __name__ == "__main__":
   app.debug = True
   app.run(host="0.0.0.0", port=5000)
