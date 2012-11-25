# -*- coding: utf-8 -*-
import json

from collections import defaultdict
from flask import Flask, session, redirect, url_for, escape, request, abort, make_response

app = Flask('provider')

levels = {'optymo': {'nombre_km': [100, 200, 500, 1000],
    'fillots': [1, 2, 3, 5, 10, 20]}}

users = {
    'lothiraldan': {'optymo': {'nombre_km': 0, 'fillots': 0}},
    'cake': {'optymo': {'fillots': 5}},
    'ludo': {'optymo': {'fillots': 3}},
    'vid': {'optymo': {'fillots': 10}}
}

def any_response(data):
    response = make_response(data)
    origin = request.headers['Origin']
    response.headers['Access-Control-Allow-Origin'] = origin
    return response

@app.route('/level/<project_slug>/<achievement_slug>')
def level(project_slug, achievement_slug):
    if not 'username' in request.args:
        return any_response(('Not authorized', 401))
    try:
        value = users[request.args['username']][project_slug][achievement_slug]
        if value == 0:
            return json.dumps((value, 0))
        step = len([x for x in levels[project_slug][achievement_slug] if x <= value])
        return json.dumps((value, step))
    except KeyError as e:
        return any_response(('Not authorized', 401))

@app.route('/add/<project_slug>/<achievement_slug>')
def add(project_slug, achievement_slug):
    if not 'username' in request.args:
        return any_response(('Not authorized', 401))
    add = request.args.get('quantity', None)
    if add is None:
        add = 1

    users[request.args['username']][project_slug][achievement_slug] += 1
    return json.dumps('OK')

@app.route('/achievement_info/<project_slug>/<achievement_slug>')
def achievement_info(project_slug, achievement_slug):
    try:
        return json.dumps(levels[project_slug][achievement_slug])
    except KeyError:
        return any_response(('Not authorized', 401))

@app.route('/leaderboard/<project_slug>/<achievement_slug>')
def leaderboard(project_slug, achievement_slug):
    results = []
    for user_name, user_data in users.items():
        try:
            results.append((user_name, user_data[project_slug][achievement_slug]))
        except KeyError:
            continue
    results.sort(key=lambda x: x[1], reverse=True)
    return json.dumps(results)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        redirect_url = request.args.get('redirect_url')
        redirect_url += '?username='+request.form['username']
        return redirect(redirect_url)
    return '''
        <html>
        <head>
            <link href="http://gameup.co/css/bootstrap.min.css" rel="stylesheet">
        </head>
        <body style="padding: 40px;">
        <form action="" method="post">
            <span class="help-block">Login</span>
            <input type=text name=username>
            <label class="checkbox">
                <input type="checkbox" required='required'>Autoriser Sample à accéder à mes données
            </label>
            <input type=submit value=Login class="btn">
        </form>
        </body>
    '''

@app.route('/logout')
def logout():
    # remove the username from the session if it's there
    session.pop('username', None)
    return 'Logout'

# set the secret key.  keep this really secret:
app.secret_key = 'A0Zr98j/3yXBR~XHH!jmN]LWX/,?RT'

if __name__ == '__main__':
    app.debug = True
    app.config.update(SESSION_COOKIE_DOMAIN='gameup.co')
    app.run(host='0.0.0.0', port=5000)