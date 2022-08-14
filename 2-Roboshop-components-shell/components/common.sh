HEAD() {
    #echo -e "\e[32mdone\e[0m"
    #funtion argument passed in double quotes ex: Installing nginx
    echo -n -e "\e[32m$1\e[0m \t\t ...."

}

STAT() {
    #first argument of function is =0
    if [ $1 -eq 0 ]; then
      echo -e "\e[1;31m done\e[0m"
    else
      echo -e "\e[1;31m fail\e[0m"
      #if it is failed telling logs to check
      echo -e "\t \e[1;33m Check logs for more detail.... Logfile: /tmp/roboshop\e[0m"
      #stopping when failed.
      exit 1

    fi
}
