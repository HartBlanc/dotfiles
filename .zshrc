# The clang python binding searches for header files in /usr/include by default
# MacOS System Integrity Protection prevents the cration of /usr/include (even by root)
# updating CPATH tells the clang python binding where to find the C headers
export CPATH=`xcrun --show-sdk-path`/usr/include

# add the user base's binary directory to the path to allow binaries to be installed
# using `pip3 --user` (reduces risk of breaking system-wide packages)
export PATH=$PATH:$(python3 -m site --user-base)/bin

