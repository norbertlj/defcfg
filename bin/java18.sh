OLD_PATH=$PATH
NEW_PATH=`echo $PATH |tr ':' '\n' | grep -vi java | tr '\n' ':'`
NEW_PATH=`echo "${NEW_PATH%%:}"`
export PATH="~/java/java-1.8.0-ibm-1.8.0.3.0-1jpp.1.el7.x86_64/bin:${NEW_PATH}"
echo $PATH
