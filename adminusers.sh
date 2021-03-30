if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi
while read p; do
  echo "$p"
  usermod -aG sudo $p
done <adminusers.txt
