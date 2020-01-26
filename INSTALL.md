# Cycle of Life

## General Project
1. You will have to go through each section in this document to properly install and use the application as we have not released it online ( *yet* )
2. You will need to clone this repository, which you can do `git clone git@github.com:hunter-classes/winter-2020-codefest-submissions-cycle-of-life.git`
   - Any way to get it locally should be sufficient
3. Past this, we have only tested on *nix environments, but it may work on Windows  ¯\_(ツ)_/¯

## Frontend

### Flutter app (allows for iOS and Android)
1. Install flutter from [official flutter website](https://flutter.dev/docs/get-started/install).
2.

## Backend

### Flask endpoint
1. Install `python` (preferabbly 3.7.3)
2. We recommend making a virtual environment with `pyenv` or `virtualenv`
3. Once the environment is active:
```bash
pip install -r api-endpoint/requirements.txt
```
   - NOTES: 
     - `bottleneck`, a dependency for `fastai` isn't fully compatible with python 3.8 yet
       - This means it's possible it may or may not work on your machine
       - Using `pyenv`, you can create a python 3.7.3 environment, refer to its [docs](https://github.com/pyenv/pyenv)
     - If you wish, you can run:
```bash
pip install flask 
pip install requests
pip install fastai
```
4. After steps 1 and 2, you can activate the sever:
```bash
cd api-endpoint
python app.py
```
