#!/bin/bash

set -eo pipefail

xcodebuild -workspace Marvel.xcworkspace \
            -scheme Marvel \
            -destination platform=iOS\ Simulator,OS=14.2,name=iPhone\ 11 \
            clean test | xcpretty
