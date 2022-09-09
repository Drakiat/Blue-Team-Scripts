import requests
import time
import csv
import os
def getBoxesIP():
    IPs = []
    file = open('IPs.txt','r')
    Lines = file.readlines()
    count = 0
    for line in Lines:
        IPs.append(line.strip())
    return IPs
def checkBoxes(IPs):
    CurrentKing = {}
    for ip in IPs:
        #print('trying '+'http://'+ip.strip()+':9999/')
        try:
            r=requests.get('http://'+ip.strip()+':9999/',timeout=3)
            #print(r.text)
            CurrentKing.update({ip.strip():r.text.strip()})
        except requests.exceptions.HTTPError as e:
            print("error")
        except requests.exceptions.RequestException as e:
            print("error")
        time.sleep(5)
    return CurrentKing
def main():
    IPs=getBoxesIP()
    CurrentKing = {}
    Score={}
    dataToSend =()
    while(True):
        CurrentKing=checkBoxes(IPs)
        print(CurrentKing)
        for kings in CurrentKing.values():
            if kings in Score:
                Score.update({kings:Score[kings]+1})
            else:
                Score.update({kings:0})
        w = csv.writer(open("output.csv", "w"))
        for key, val in CurrentKing.items():
            w.writerow([key, val])
        print(Score)
try:
    main()
except KeyboardInterrupt:
    print('ctrl-c button. Saving output as ouput.csv.old')
    os.rename("output.csv", "output.csv.old")
else:
    print('Hello user there is some format error')
    os.rename("output.csv", "output.csv.old")
