
## environment
setenv LANG fi_FI.UTF-8
setenv LC_ALL fi_FI.UTF-8
setenv EDITOR vim
setenv FTP_PASSIVE_MODE true
setenv MYVIMRC ~/.vimrc
setenv G_FILENAME_ENCODING @locale
set catalog=ja.ayanami.cat
if ( -d ~/.tcsh.d ) then
setenv NLSPATH ~/.tcsh.d/%N
endif
setenv RLWRAP_HOME ~/.rlwrap

## java
#setenv CLASSPATH /usr/local/share/java/rhino
setenv _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=on'

# for shellar
setenv CURRENT_SHELL tcsh



if ( -X lv) then
setenv PAGER 'lv -c'
else if ( -X most) then
setenv PAGER most
endif
