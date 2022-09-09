import csv
from flask import Flask, render_template

app=Flask(__name__)
headings =("Host","Current King")
def updateData():
    data =()
    with open('output.csv', newline='') as file:
        content = csv.reader(file)
        data = [tuple(row) for row in content]
        return data
@app.route('/')
def table():
    updateData()
    return render_template("index.html",headings=headings, data=updateData())
if __name__ == '__main__':
    app.run()
