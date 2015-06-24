@echo off 

REM http://www.azavea.com/blogs/labs/2014/10/running-vagrant-with-ansible-provisioning-on-windows/

REM If you used the stand Cygwin installer this will be C:\cygwin 
set CYGWIN=%USERPROFILE%\.babun\cygwin

REM You can switch this to work with bash with %CYGWIN%\bin\bash.exe 
set SH=%CYGWIN%\bin\zsh.exe

%SH% -c "/bin/ansible-playbook %*"