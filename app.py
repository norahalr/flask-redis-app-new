from flask import Flask
import redis
import os

app = Flask(__name__)
r = redis.Redis(host=os.getenv('REDIS_HOST', 'redis'), port=6379)

@app.route('/')
def visits():
    visits = r.incr('visits')
    return f"Total visits: {visits}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)