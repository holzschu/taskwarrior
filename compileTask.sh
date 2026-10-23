#!/bin/bash
set -euo pipefail

mkdir -p .build/deps
curl --fail --location --retry 3 https://github.com/holzschu/ios_system/releases/download/v3.0.5/ios_error.h -o .build/deps/ios_error.h
curl --fail --location --retry 3 https://github.com/holzschu/ios_system/releases/download/v3.0.5/ios_system.xcframework.zip -o .build/deps/ios_system.xcframework.zip
shasum -a 256 -c - <<'CHECKSUMS'
51d46b912eb30399cbb5c36c8c8f15eb1a44adcfc9ee581304ac9d3739a84716  .build/deps/ios_error.h
d429e68102926f58bedd8e8b7105dcd169478cd6da1cef494a5f468482d1c8f5  .build/deps/ios_system.xcframework.zip
CHECKSUMS
unzip -oq .build/deps/ios_system.xcframework.zip -d .build/deps
git submodule update --init --depth 1

for platform in iphoneos iphonesimulator; do
	if [ "$platform" = iphoneos ]; then
		arch=arm64
		triple=arm64-apple-ios14.0
		slice=ios-arm64
		plist=basic_Info.plist
	else
		arch="arm64;x86_64"
		triple=
		slice=ios-arm64_x86_64-simulator
		plist=basic_Info_Simulator.plist
	fi
	frameworks="$PWD/.build/deps/ios_system.xcframework/$slice"
	cmake -S . -B ".build/$platform" \
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DENABLE_SYNC=OFF \
		-DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT="$(xcrun --sdk "$platform" --show-sdk-path)" \
		-DCMAKE_OSX_ARCHITECTURES="$arch" -DCMAKE_OSX_DEPLOYMENT_TARGET=14.0 \
		-DCMAKE_BUILD_TYPE=Release -DCMAKE_MACOSX_BUNDLE=OFF \
		-DCMAKE_CXX_FLAGS="${triple:+-target $triple} -I$PWD/.build/deps" \
		-DCMAKE_EXE_LINKER_FLAGS="-dynamiclib -F$frameworks -framework ios_system"
	cmake --build ".build/$platform" --target task_executable calc_executable lex_executable --parallel 3

	for binary in task calc lex; do
		framework_dir=".build/Release-$platform/$binary.framework"
		rm -rf "$framework_dir"
		mkdir -p "$framework_dir"
		cp ".build/$platform/src/$binary" "$framework_dir/$binary"
		cp "$plist" "$framework_dir/Info.plist"
		plutil -replace CFBundleExecutable -string "$binary" "$framework_dir/Info.plist"
		plutil -replace CFBundleName -string "$binary" "$framework_dir/Info.plist"
		plutil -replace CFBundleIdentifier -string "Nicolas-Holzschuch.$binary" "$framework_dir/Info.plist"
		install_name_tool -id "@rpath/$binary.framework/$binary" "$framework_dir/$binary"
	done
done

for framework in task lex calc; do
	rm -rf ".build/$framework.xcframework"
	xcodebuild -create-xcframework -framework ".build/Release-iphoneos/$framework.framework" \
		-framework ".build/Release-iphonesimulator/$framework.framework" -output ".build/$framework.xcframework"
	rm -f ".build/$framework.xcframework.zip"
	(cd .build && zip -rq "$framework.xcframework.zip" "$framework.xcframework")
	swift package compute-checksum ".build/$framework.xcframework.zip"
done
