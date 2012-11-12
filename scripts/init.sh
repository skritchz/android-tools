CONFIG_FILE=config.sh

echo "Please enter Creator Name" 
read str
echo "CREATOR"=$str > $CONFIG_FILE

echo "Please provide Brading Name"
read str
echo "BRANDING_NAME="$str >> $CONFIG_FILE


echo "Please provide starting version"
read str 
echo "VERSION="$str >> $CONFIG_FILE
