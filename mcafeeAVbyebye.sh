# 2018-10-04 script that automatically disables McAfee on Windows from a linux liveCD, renames the files/folders required for McAfee antivir/DLP to run 
# change destdir to path where C drive is mounted
destdir='CHANGEME'

function disableav(){
  # remove McAfee
mv "$destdir/Program Files (x86)/McAfee" "$destdir/Program Files (x86)/notMcAfee"
mv "$destdir/Program Files/McAfee" "$destdir/Program Files/notMcAfee"
mv "$destdir/Program Files/Common Files/McAfee" "$destdir/Program Files/Common Files/notMcAfee"
mv "$destdir/Windows/System32/mfevtps.exe" "$destdir/Windows/System32/notmfevtps.exe"
}

function revert(){
  # Reverting changes
mv "$destdir/Program Files (x86)/notMcAfee" "$destdir/Program Files (x86)/McAfee"
mv "$destdir/Program Files/notMcAfee" "$destdir/Program Files/McAfee"
mv "$destdir/Program Files/Common Files/notMcAfee" "$destdir/Program Files/Common Files/McAfee"
mv "$destdir/Windows/System32/notmfevtps.exe" "$destdir/Windows/System32/mfevtps.exe"
}


echo "Make sure to modify destdir value first. Right now it is set to: $destdir"
echo "Choose method:"
echo "1: Disable McAfee)"
echo "2: Revert changes)"
echo "Hit CTRL-C to exit"

read input;
if [ $input -eq "1" ]
then
	disableav
	echo -e "\e[105mDisabled\e[00m"
else
	revert
	echo -e "\e[105mDisable Reverted\e[00m"
fi
