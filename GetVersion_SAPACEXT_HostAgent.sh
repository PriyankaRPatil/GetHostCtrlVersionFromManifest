#!/bin/bash
# This script is created to check version of SAPACEXT and hostagent
# date - 6th Feb 2020, author - priyanka patil

host_list= <path>/HOSTS.txt
pwd=<path>/pwd.txt

for host in `cat ${host_list}`
do
        echo -ne "$host \t" >> <path>/op1.txt
        cat $pwd| ssh $host "sudo -u daaadm cat /usr/sap/hostctrl/exe/hostagent.mf" | grep -i "hostagent patch" |tr -d '\n'>> <path>/op1.txt
        echo -e "" >> <path>/op1.txt
        ssh $host "cat /usr/sap/hostctrl/exe/sapacext.mf" | grep -i patch >> <path>/op2.txt
done

paste <path>/op1.txt <path>/op2.txt > <path>/opfin.txt
rm -rf <path>/op1.txt <path>/op2.txt