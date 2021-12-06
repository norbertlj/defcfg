#!/bin/bash
if [ $# -eq 0 ] ; then
  echo <<__EOF
  Usage: $0 filename [filename2] [filename3]
__EOF
fi
DAY_DIFFERENCE=1
HOUR_DIFFERENCE=2
_files=$@

for _file in $_files ; do
  _fulldate=$(stat -c '%y' $_file)
  _date=$(echo $_fulldate |awk '{print $1}')
  _time=$(echo $_fulldate |awk '{print $2}')
  _year=$(echo $_date | cut -f1 -d-)
  _month=$(echo $_date | cut -f2 -d-)
  _tmpday=$(echo $_date | cut -f3 -d-)
  _hour=$(echo $_time | cut -f1 -d:)
  _min=$(echo $_time | cut -f2 -d:)
  _sec=$(echo $_time | cut -f3 -d: |cut -f1 -d.)
  _ext=$(echo ${_file##*.}|tr '[A-Z]' '[a-z]')
  # Decrease day by 1 - camera has wrong date
  if [[ $_tmpday -le $DAY_DIFFERENCE ]]; then
    case "$_month" in
      # New year so decrease also year!
      01) _day="31"
        _month="12"
        _year=$(expr $_year - 1 |xargs printf "%02d")
      ;;
      # 31 days months before this one
      02|04|06|08|09|11) _day="31"
        _month=$(expr $_month - 1 |xargs printf "%02d")
      ;;
      # 30 days months before this one
      05|07|10|12) _day="30"
        _month=$(expr $_month - 1 |xargs printf "%02d")
      ;;
      # February before this one
      03) if [ $(expr $_year % 4) -eq 0 ]; then
          _day="29"
        else
          _day="28"
        fi
        _month="02"
      ;;
      *) echo "ERROR: 2"
        exit 2
      ;;
    esac
  else
    _day=$(expr $_tmpday - $DAY_DIFFERENCE |xargs printf "%02d")
  fi
  if [[ $_hour -lt $HOUR_DIFFERENCE ]]; then
    _hour=$(expr 24 + $_hour - $HOUR_DIFFERENCE |xargs printf "02d")
    if [[ $_day == "01" ]]; then
      case "$_month" in
        # New year so decrease also year!
        01) _day="31"
          _month="12"
          _year=$(expr $_year - 1 |xargs printf "%02d")
        ;;
        # 31 days months before this one
        02|04|06|08|09|11) _day="31"
          _month=$(expr $_month - 1 |xargs printf "%02d")
        ;;
        # 30 days months before this one
        05|07|10|12) _day="30"
          _month=$(expr $_month - 1 |xargs printf "%02d")
        ;;
        # February before this one
        03) if [ $(expr $_year % 4) -eq 0 ]; then
            _day="29"
          else
            _day="28"
          fi
          _month="02"
        ;;
        *) echo "ERROR: 2"
          exit 2
        ;;
      esac
    else
      _day=$(expr $_day - 1 |xargs printf "%02d")
    fi
  else
    _hour=$(expr $_hour - $HOUR_DIFFERENCE |xargs printf "%02d")
  fi
  #_newfilename=$(printf "%04d%02d%02d_%02d%02d%02d.%s" $_year $_month $_day $_hour $_min $_sec $_ext)
  _newfilename="${_year}${_month}${_day}_${_hour}${_min}${_sec}.${_ext}"
  echo $_file $_newfilename
  mv -i $_file $_newfilename
done
