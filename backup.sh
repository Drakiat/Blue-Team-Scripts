#!/bin/bash
cd /root
mkdir thicc
cd /
folders="etc var root home sbin bin"
for dir in $folders
do
	tar czvfp /root/thicc/${dir}.tgz ${dir}
done
