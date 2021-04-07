getcap -r / 2>/dev/null > cap.txt
while read p; do
  echo "$p" | awk '{print $1;}' >capbin.txt
done <cap.txt

while read b; do
  echo "$b"
  setcap -r $b
done <capbin.txt
