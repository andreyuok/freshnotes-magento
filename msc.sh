#!/bin/bash
BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`
RESET=`tput sgr0`

echo "${YELLOW} --------------------------------------- ${RESET}"
echo "${YELLOW} --== START MAGENTO SERVICES CHAIN! ==-- ${RESET}"
echo "${YELLOW} --------------------------------------- ${RESET}"
echo " "
sleep 1

echo "${GREEN} Cleanup filesystem... ${RESET}"
echo "---------------------"
rm -rf generated/code
rm -rf generated/metadata
rm -rf pub/static/adminhtml
rm -rf pub/static/frontend
rm -rf var/
rm pub/static/deployed_version.txt
echo " "

echo "${GREEN} Run bin/magento setup:upgrade... ${RESET}"
echo "--------------------------------"
bin/magento setup:upgrade
echo " "

echo "${GREEN} Run bin/magento setup:di:compile... ${RESET}"
echo "-----------------------------------"
bin/magento setup:di:compile
echo " "

echo "${GREEN} Run bin/magento setup:static-content:deploy... ${RESET}"
echo "----------------------------------------------"
bin/magento setup:static-content:deploy -f -s standard
echo " "

echo "${GREEN} Run bin/magento cache:flush ${RESET}"
echo "---------------------------"
bin/magento cache:flush
echo " "

echo "${GREEN} Run bin/magento indexer:reindex ${RESET}"
echo "---------------------------"
bin/magento indexer:reindex
echo " "

echo "${YELLOW} -------------------------------------- ${RESET}"
echo "${YELLOW} --== FINISHED MAGENTO SERVICES CHAIN! ==-- ${RESET}"
echo "${YELLOW} -------------------------------------- ${RESET}"
echo " "
