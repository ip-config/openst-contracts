#!/bin/bash

echo "\n********* Preparing price oracle deployment *************"
npm install @ostdotcom/ost-price-oracle@1.0.5-beta.4 --save-dev
cd ../../node_modules/@ostdotcom/ost-price-oracle/
echo "\n********* Done *************"

echo "\n********* Deploying PO 1 *************"
node ./tools/deploy/price_oracle.js OST USD 0x12A05F200 '' po1.txt $PRICE_ORACLE_CONFIG_STRATEGY_FILE_NAME
echo "\n********* Done *************"
echo "\n********* Deploying PO 2 *************"
node ./tools/deploy/price_oracle.js OST EUR 0x12A05F200 '' po2.txt $PRICE_ORACLE_CONFIG_STRATEGY_FILE_NAME
echo "\n********* Done *************"
echo "\n********* Deploying PO 3 *************"
node ./tools/deploy/price_oracle.js OST INR 0x12A05F200 '' po3.txt $PRICE_ORACLE_CONFIG_STRATEGY_FILE_NAME
echo "\n********* Done *************"
echo "\n********* Deploying PO 4 *************"
node ./tools/deploy/price_oracle.js ETH USD 0x12A05F200 '' po4.txt $PRICE_ORACLE_CONFIG_STRATEGY_FILE_NAME
echo "\n********* Done *************"

export OST_UTILITY_PRICE_ORACLES="{\"OST\":{\"USD\":\"$(cat ./tools/deploy/po1.txt)\",\"EUR\":\"$(cat ./tools/deploy/po2.txt)\",\"INR\":\"$(cat ./tools/deploy/po3.txt)\"},\"ETH\":{\"USD\":\"$(cat ./tools/deploy/po4.txt)\"}}"
echo '\nexport OST_UTILITY_PRICE_ORACLES='\'$OST_UTILITY_PRICE_ORACLES\'>>../../../mocha_test/scripts/env_vars.sh
echo OST_UTILITY_PRICE_ORACLES=$OST_UTILITY_PRICE_ORACLES

node ./test/scripts/set_price.js OST USD 0.5 0x12A05F200 $PRICE_ORACLE_CONFIG_STRATEGY_FILE_NAME
node ./test/scripts/set_price.js OST EUR 0.2 0x12A05F200 $PRICE_ORACLE_CONFIG_STRATEGY_FILE_NAME
node ./test/scripts/set_price.js ETH USD 20.2 0x12A05F200 $PRICE_ORACLE_CONFIG_STRATEGY_FILE_NAME

rm ./tools/deploy/po1.txt
rm ./tools/deploy/po2.txt
rm ./tools/deploy/po3.txt
rm ./tools/deploy/po4.txt


