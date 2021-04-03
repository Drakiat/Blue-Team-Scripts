getcap -r / 2>/dev/null > cap.txt
while read p; do
  echo "$p" | awk '{print $1;}'
done <cap.txt
