#!/bin/bash
#developed in ParrotOS 4.10 by RedGrappe
clear
echo "Dependencies:\ncurl, jq and git \nif you don't have the required dependencies run: \nsudo apt update && sudo apt install curl jq git "
sleep 5
clear
echo "Enter the USERNAME of the account you want to clone *EXAMPLE:leyvatheam*"
read user
cdr=`pwd`
mkdir $user
cd $user
echo "*/*/*/*/*/*/*/ GETTING LINKS FOR ALL REPOs FROM THE USER "$user" /*/*/*/*/*/*/*"
curl "https://api.github.com/users/$user/repos?per\_page=100"  | jq '.[].clone_url'  > urls.txt
echo "DONE"
sleep 1
echo "STARTIG CLONING PROCESS"
sed  's/"//gp' urls.txt > clone.urls
for repos in $(cat clone.urls); do
    git clone --recursive $repos
done
rm clone.urls

EXIT=0
while [ $EXIT -lt 1 ]; do
    echo "Do you want to SAVE the text file that contains the URLS? y/n:"
    read save
    if [ "$save" = 'y' ]; then
        echo "File Saved on: $cdr/$user/urls.txt"
        EXIT=1
    elif [ "$save" = 'n' ]; then
        rm urls.txt
        echo "File Deleted"
        EXIT=1
    fi
done
echo "All Done"

