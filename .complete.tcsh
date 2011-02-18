

complete cd 'p/1/d/'  \
            'n/-*/d/'

complete echo 'p/1/s/'

complete make     'p/1/(all clean distclean depend  install install.man Makefiles buildworld installworld config-recursive)/'
complete sudo     'p/1/(make vim portsnap)/'


complete unzip  'p/*/f:*.{ZIP,zip}/'
complete tar	'c/-[Acru]*/(b B C f F g G h i l L M N o P \
                           R S T v V w W X z Z)/' \
        			'c/-[dtx]*/(B C f F g G i k K m M O p P \
        			            R s S T v w x X z Z)/' \
        			'p/1/(A c d r t u x -A -c -d -r -t -u -x \
        			--catenate --concatenate --create --diff --compare \
        			--delete --append --list --update --extract --get \
        			--help --version)/' \
        			'c/--/(catenate concatenate create diff compare \
                     delete append list update extract get atime-preserve \
        			       block-size read-full-blocks directory checkpoint file \
        			       force-local info-script new-volume-script incremental \
        			       listed-incremental dereference ignore-zeros \
        			       ignore-failed-read keep-old-files starting-file \
        			       one-file-system tape-length modification-time \
        			       multi-volume after-date newer old-archive portability \
        			       to-stdout same-permissions preserve-permissions \
        			       absolute-paths preserve record-number remove-files \
        			       same-order preserve-order same-owner sparse \
        			       files-from null totals verbose label version \
        			       interactive confirmation verify exclude exclude-from \
        			       compress uncompress gzip ungzip use-compress-program \
        			       block-compress help version)/' \
        			'c/-/(b B C f F g G h i k K l L m M N o O p P R s S \
        			      T v V w W X z Z 0 1 2 3 4 5 6 7 -)/' \
        			'C@/dev@f@' \
        			'n/-c*f/x:<new_tar_file, device_file, or "-">/' \
        			'n/{-[Adrtux]j*f,--file}/f:*.{tar.bz2,tbz}/' \
        			'n/{-[Adrtux]z*f,--file}/f:*.{tar.gz,tgz}/' \
        			'n/{-[Adrtux]Z*f,--file}/f:*.{tar.Z,taz}/' \
        			'n/{-[Adrtux]*f,--file}/f:*.tar/' \
        			'N/{-xj*f,--file}/`tar -tjf $:-1`/' \
        			'N/{-xz*f,--file}/`tar -tzf $:-1`/' \
        			'N/{-xZ*f,--file}/`tar -tZf $:-1`/' \
        			'N/{-x*f,--file}/`tar -tf $:-1`/' \
        			'n/--use-compress-program/c/' \
        			'n/{-b,--block-size}/x:<block_size>/' \
        			'n/{-V,--label}/x:<volume_label>/' \
        			'n/{-N,--{after-date,newer}}/x:<date>/' \
        			'n/{-L,--tape-length}/x:<tape_length_in_kB>/' \
        			'n/{-C,--directory}/d/' \
        			'N/{-C,--directory}/`\ls $:-1`/' \
        			'n/-[0-7]/"(l m h)"/'

complete pkg_info         'n@-[cdorLR]*@` \ls -1 /var/db/pkg | sed "s%/var/db/pkg/%%"`@'
complete pkg_delete       'n@*@` \ls -1 /var/db/pkg | sed "s%/var/db/pkg/%%"`@'

complete ps               'n/-*U/u/'

complete {which,where}    'p/1/c/'
complete {,j}{man,whatis} 'n/-M/d/' \
                          'n/*/c/'
complete alias            'p/1/a/'
complete unalias          'n/*/a/'
complete set              'p/1/s/'
complete unset            'n/*/s/'
complete {set,print}env   'p/1/e/'
complete unsetenv         'n/*/e/'

complete {cc,gcc,g++}     'c/-[IL]/d/' \
                          'n/-c/f:*.c/' \
                          'n/*/f:*.[fco]/'


complete find 	'n/-fstype/"(nfs 4.2)"/'  \
                'n/-name/f/' \
		  	        'n/-type/"(c b d f p l s)"/'  \
                'n/-user/u/ n/-group/g/' \
          			'n/-exec/c/'  \
                'n/-ok/c/'  \
                'n/-cpio/f/'  \
                'n/-ncpio/f/' \
                'n/-newer/f/' \
		  	        'c/-/(fstype name perm prune type user nouser \
		  	              group nogroup size inum atime mtime ctime exec \
			                ok print ls cpio ncpio newer xdev depth \
			                daystart follow maxdepth mindepth noleaf version \
			                anewer cnewer amin cmin mmin true false uid gid \
			                ilname iname ipath iregex links lname empty path \
			                regex used xtype fprint fprint0 fprintf \
			                print0 printf not a and o or)/' \
			          'n/*/d/'

complete ln    'c/-/(b d F f i n S s V v -)/' \
               'n/{-S,--suffix}/x:<suffix>/' \
               'n/{-V,--version-control}/"(t numbered nil existing \
                                           never simple"/' \
               'n/-/f/' \
               'N/-/x:<link_name>/' \
               'p/1/f/' \
               'p/2/x:<link_name>/'

complete kill  'p/*/`ps ax| awk \{print\ \$1\}`/'
complete pkill 'p/*/`ps c | awk \{print\ \$5\} | sort |uniq | tr -d COMMAND`/'

 
complete ./configure 'c/-[IL]/d/' \
                     'c/--*=/f/' \
                     'c/--{cache-file,prefix,exec-prefix,\
                           bindir,sbindir,libexecdir,datadir,\
                           sysconfdir,sharedstatedir,localstatedir,\
                           libdir,includedir,oldincludedir,infodir,\
                           mandir,srcdir}/(=)//' \
                     'c/--/(cache-file verbose prefix exec-prefix bindir \
                            sbindir libexecdir datadir sysconfdir \
                            sharedstatedir localstatedir libdir \
                            includedir oldincludedir infodir mandir \
                            srcdir)//'
 
#from 2ch FreeBSD thread
complete sysctl 'c/-/(b d e h N n o x a)/' \
                'C@?*.?*.?*.?*.@`\/sbin\/sysctl -Noa `@@' \
                'C@?*.?*.?*.@`\/sbin\/sysctl -Noa | awk -F . '"'"'{if(NF>4) print $1"."$2"."$3"."$4"."; else print $1"."$2"."$3"."$4}'"'"' | sort | uniq`@@' \
                'C@?*.?*.@`\/sbin\/sysctl -Noa | awk -F . '"'"'{if(NF>3) print $1"."$2"."$3"."; else print $1"."$2"."$3}'"'"' | sort | uniq`@@' \
                'C@?*.@`\/sbin\/sysctl -Noa | awk -F . '"'"'{if(NF>2) print $1"."$2"."; else print $1"."$2}'"'"' | sort | uniq`@@' \
                'C@*@`\/sbin\/sysctl -Noa | awk -F . '"'"'{if(NF>1) print $1"."; else print $1}'"'"' | sort | uniq`@@' 


