#/bin/csh -f

#csup /etc/supfile
cd /usr/src
make cleandir
make cleandir
if ( -e /usr/obj ) then
rm -rfv /usr/obj
endif

cd /usr/src

make -j4 buildworld && make -j4 buildkernel

