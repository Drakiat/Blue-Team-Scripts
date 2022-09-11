import csv
from flask import Flask, render_template

app=Flask(__name__)
headings =("Host","Current King")
headingsScore =("User","Current Score")
def updateData():
    data =()
    with open('output.csv', newline='') as file:
        content = csv.reader(file)
        data = [tuple(row) for row in content]
        return data
def updateDataScore():
    data =()
    with open('score.csv', newline='') as file:
        content = csv.reader(file)
        data = [tuple(row) for row in content]
        return data
@app.route('/')
def table():
    updateData()
    return render_template("index.html",headings=headings, data=updateData())
@app.route('/score')
def score():
    updateDataScore()
    return render_template("index.html",headings=headingsScore, data=updateDataScore())
if __name__ == '__main__':
    app.run()
