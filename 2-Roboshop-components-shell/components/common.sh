HEAD() {
    #echo -e "\e[32mdone\e[0m"
    echo -n -e "\e[32m$1\e[0m \t\t ...."

}

STAT() {
    #first argument of function is =0
    if [ $1 -eq 0 ]; then
      echo -e "\e[1;31m done\e[0m"
    else
      echo -e "\e[1;31m fail\e[0m"

    fi
}
