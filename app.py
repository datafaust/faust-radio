import os
from flask import Flask, flash, request, redirect, url_for, session, jsonify, make_response
from werkzeug.utils import secure_filename
from flask_cors import CORS, cross_origin
import logging
from flask_restful import Resource, Api
import subprocess
from subprocess import Popen
import string

#logging information
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger('LOG INFO: ')

#app prep
app = Flask(__name__)
api = Api(app)
CORS(app)

@app.route('/recognize', methods=['POST', 'GET'])
def recognize_song():
    stream = os.popen("cd /audio-fingerprint-identifying-python && make recognize-listen seconds=5")
    text = stream.read()
    logger.info(text)
    data = {'message': 'Successfully loaded', 'text': text} #response="Whatever you wish too return"
    return make_response(jsonify(data), 201)

if __name__ == "__main__":
    app.secret_key = os.urandom(24)
    app.run(debug=True,host="0.0.0.0",use_reloader=False)

flask_cors.CORS(app, expose_headers='Authorization')