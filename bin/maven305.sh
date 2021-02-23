OLD_PATH=$PATH
NEW_PATH=`echo $PATH |tr ':' '\n' | grep -vi maven |tr '\n' ':'`
NEW_PATH=`echo "${NEW_PATH%%:}"`
export PATH="~/apache-maven-3.0.5/bin:${NEW_PATH}"
echo $PATH
