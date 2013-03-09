#!/usr/bin/env sh



first()
{
cd /usr/src
make -s cleandir
make -s cleandir
rm -rf /usr/obj
make -s -j 4 buildworld
make -s -j 4 buildkernel
make -s installkernel
echo "REBOOT"

}

second() 
{
echo "-------------------------------------------"
echo ">> mounting disks <<"
echo "-------------------------------------------"
mount -u /
mount -a -t ufs
echo "-------------------------------------------"
echo ">> mergemaster -p <<"
echo "-------------------------------------------"
mergemaster -p
cd /usr/src
echo "-------------------------------------------"
echo ">> make installworld <<"
echo "-------------------------------------------"
make -s installworld
make -DBATCH_DELETE_OLD_FILES delete-old
echo "-------------------------------------------"
echo ">> mergemaster <<"
echo "-------------------------------------------"
mergemaster
echo "-------------------------------------------"
echo ">> please reboot"
echo "-------------------------------------------"
}

third()
{
echo "-------------------------------------------"
echo ">> mounting fs <<"
echo "-------------------------------------------"
mount -u /
mount -a -t ufs

cd /usr/src
echo "-------------------------------------------"
echo ">> delete old libs <<"
echo "-------------------------------------------"
yes y | make delete-old-libs
}

if [ $1 == "first" ]; then
first
elif [ $1 == "second" ]; then
second
elif [ $1 == "third" ]; then
third
fi
