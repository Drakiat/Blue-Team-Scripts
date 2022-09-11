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
def updateScoreFile(Score_Dict):
    #with open('scores.csv', mode='r') as infile:
    #    reader =  csv.DictReader(infile,delimiter=',')
    #    Score_File = dict(reader)
        #Score_File = pd.read_csv('scores.csv', header=None, index_col=0, squeeze=True).to_dict()
        #print("here comes the score file")
        #print(Score_Dict)
        #outfile.close()
        w = csv.writer(open("score.csv", "w"))
        for key, val in Score_Dict.items():
            w.writerow([key, val])
def checkBoxes(IPs):
    CurrentKing = {}
    for ip in IPs:
        #print('trying '+'http://'+ip.strip()+':9999/')
        try:
            r=requests.get('http://'+ip.strip()+':9999/',timeout=3)
            #print(r.text)
            CurrentKing.update({ip.strip():r.text.strip()})
        except requests.exceptions.HTTPError as e:
            print("HTTP error on ip: "+ip)
        except requests.exceptions.RequestException as e:
            print("Request error on ip: "+ip)
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
                Score.update({kings:int(1)})
        w = csv.writer(open("output.csv", "w"))
        for key, val in CurrentKing.items():
            w.writerow([key, val])
        updateScoreFile(Score)
        print(Score)
try:
    main()
except KeyboardInterrupt:
    print('ctrl-c button. Saving output as ouput.csv.old')
    os.rename("output.csv", "output.csv.old")
else:
    print('Hello user there is some format error')
    os.rename("output.csv", "output.csv.old")
