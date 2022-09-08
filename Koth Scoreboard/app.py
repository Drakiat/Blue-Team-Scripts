from flask import Flask, render_template

app=Flask(__name__)

headings =("Host","Current King","Score")
data =(
    ("localhost","Felipe","10000"),
    ("8.8.8.8","Anna","20000")
)


@app.route('/')
def table():
    return render_template("index.html",headings=headings, data=data)
if __name__ == '__main__':
   app.run()
