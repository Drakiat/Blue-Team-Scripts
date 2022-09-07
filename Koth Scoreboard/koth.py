import requests
import time
def getBoxesIP():
    IPs = []
    file = open('IPs.txt','r')
    Lines = file.readlines()
    count = 0
    for line in Lines:
        IPs.append(line.strip())
    return IPs
def checkBoxes(IPs):
    for ip in IPs:
        print('trying '+'http://'+ip.strip()+':9999/')
        try:
            r=requests.get('http://'+ip.strip()+':9999/')
            print(r.text)
        except requests.exceptions.HTTPError as e:
            print(e)
        except requests.exceptions.RequestException as e:
            print(e)
        time.sleep(1)
def main():
    IPs=getBoxesIP()
    while(True):
        checkBoxes(IPs)
main()
