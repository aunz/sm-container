import flask 
from predictor import main

app = flask.Flask(__name__)

@app.route('/ping', methods=['GET'])
def ping():
    return flask.Response(response='\n', status=200, mimetype='application/json')

@app.route('/invocations', methods=['POST'])
def invocations():
    return main(flask.request.get_data(cache=False))

if __name__ == '__main__':  app.run(host='0.0.0.0', port=8080)


