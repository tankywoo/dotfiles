# Quick jump to Python package directory
pycd(){ cd $(dirname $(python -c "print __import__('$1').__file__")); }

# Simplify ntpdate command
ntpupdate(){ sudo ntpdate cn.pool.ntp.org; }
#ntpupdate(){ sudo ntpdate jp.pool.ntp.org; }

i(){ curl ip.cn/$i; }
