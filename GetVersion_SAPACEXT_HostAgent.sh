#!/bin/bash
# Checks the version of SAPACEXT and Host agent on multiple hosts if you do not have root access and access to SAP LAMA, or any centralized monitoring tool
# Prerequisite - 
# 1. Ensure you have SSH enabled and have proper authorizations.
# 2. Add hostnames in HOSTS.txt, ensure each entry is on a new line.
# 3. pwd.txt contains your password. Please note that after deploying keys, modify the snippet as SSH command will not ask for your password.

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
