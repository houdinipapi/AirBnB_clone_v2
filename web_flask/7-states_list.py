#!/usr/bin/python3

"""
Starts a Flask web application
"""

from flask import Flask, render_template
from models import *
from models import storage

app = Flask(__name__)


@app.route("/states_list", strict_slashes=False)
def states_list():
    """
    Display a HTML page with the list of all
    State objects present in DBStorage.
    """
    states = storage.all(State).values()
    sorted_states = sorted(states, key=get_state_name)

    return render_template("7-states_list.html", states=states)


def get_state_name(state):
    """
    Custom function to return state name for sorting.
    """
    return state.name


@app.teardown_appcontext
def teardown_db(exception):
    """
    Remove the current SQLAlchemy Session after each request.
    """
    storage.close()


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
