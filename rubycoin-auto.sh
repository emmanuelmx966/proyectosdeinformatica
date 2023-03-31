#!/bin/bash
wget "https://dl.walletbuilders.com/download?customer=760f41152e5366943704eab617db0aa26e716fe06df83d523f&filename=rubycoin-qt-linux.tar.gz" -O rubycoin-qt-linux.tar.gz

mkdir $HOME/Desktop/Rubycoin

tar -xzvf rubycoin-qt-linux.tar.gz --directory $HOME/Desktop/Rubycoin

mkdir $HOME/.rubycoin

cat << EOF > $HOME/.rubycoin/rubycoin.conf
rpcuser=rpc_rubycoin
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node2.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/Rubycoin/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./rubycoin-qt
EOF

chmod +x $HOME/Desktop/Rubycoin/start_wallet.sh

cat << EOF > $HOME/Desktop/Rubycoin/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
echo Press [CTRL+C] to stop mining.
while :
do
./rubycoin-cli generatetoaddress 1 \$(./rubycoin-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/Rubycoin/mine.sh

exec $HOME/Desktop/Rubycoin/rubycoin-qt &

sleep 15

cd $HOME/Desktop/Rubycoin/

clear

exec $HOME/Desktop/Rubycoin/mine.sh