from flask import Flask
from redis import Redis
import os

app = Flask(__name__)
redis = Redis(host=os.getenv('REDIS_PORT_6379_TCP_ADDR', 'localhost'), port=int(os.getenv('REDIS_PORT_6379_TCP_PORT', 6379)))

@app.route('/')
def hello():
    redis.incr('hits')
    return 'Hello World! I have been seen %s times.' % redis.get('hits')

if __name__ == "__main__":
	app.run(host="0.0.0.0", port=80, debug=True)

