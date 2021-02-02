#!/bin/sh

# Do NOT use cmake! It has problems with cross-compiling. 
# compile for iOS:

IOS_SYSTEM_VER="v2.7.0"

HHROOT="https://github.com/holzschu"

echo "Downloading header file:"
curl -OL $HHROOT/ios_system/releases/download/$IOS_SYSTEM_VER/ios_error.h 

echo "Downloading ios_system Framework:"
rm -rf ios_system.xcframework
curl -OL $HHROOT/ios_system/releases/download/$IOS_SYSTEM_VER/ios_system.xcframework.zip
unzip ios_system.xcframework.zip
rm ios_system.xcframework.zip

echo "Compiling for iOS:"
cp iOS_flags/CMakeCache.txt .
make clean
make

# Create iOS frameworks:
mkdir -p Frameworks

for binary in task calc lex 
do
	rm -rf Frameworks/$binary.framework
	mkdir Frameworks/$binary.framework
	cp src/$binary Frameworks/$binary.framework/$binary
	cp basic_Info.plist Frameworks/$binary.framework/Info.plist
	plutil -replace CFBundleExecutable -string $binary Frameworks/$binary.framework/Info.plist
	plutil -replace CFBundleName -string $binary Frameworks/$binary.framework/Info.plist
	plutil -replace CFBundleIdentifier -string Nicolas-Holzschuch.$binary  Frameworks/$binary.framework/Info.plist
	install_name_tool -id @rpath/$binary.framework/$binary   Frameworks/$binary.framework/$binary
done

# compile for simulator:
echo "Compiling for Simulator:"
make clean
cp Simulator_flags/CMakeCache.txt .
make

mkdir -p Frameworks_Simulator
for binary in task calc lex 
do
	rm -rf Frameworks_Simulator/$binary.framework
	mkdir Frameworks_Simulator/$binary.framework
	cp src/$binary Frameworks_Simulator/$binary.framework/$binary
	cp basic_Info_Simulator.plist Frameworks_Simulator/$binary.framework/Info.plist
	plutil -replace CFBundleExecutable -string $binary Frameworks_Simulator/$binary.framework/Info.plist
	plutil -replace CFBundleName -string $binary Frameworks_Simulator/$binary.framework/Info.plist
	plutil -replace CFBundleIdentifier -string Nicolas-Holzschuch.$binary  Frameworks_Simulator/$binary.framework/Info.plist
	install_name_tool -id @rpath/$binary.framework/$binary   Frameworks_Simulator/$binary.framework/$binary
done

# then, merge them into XCframeworks:
echo "Merging into XCFrameworks:"
for framework in task lex calc
do
   rm -rf $framework.xcframework
   xcodebuild -create-xcframework -framework Frameworks/$framework.framework -framework Frameworks_Simulator/$framework.framework -output $framework.xcframework
   # while we're at it, let's compute the checksum:
   rm -f $framework.xcframework.zip
   zip -rq $framework.xcframework.zip $framework.xcframework
   swift package compute-checksum $framework.xcframework.zip
done
