# SPMPlugin

[![swift-version](https://img.shields.io/badge/swift-5.6-brightgreen.svg)](https://github.com/apple/swift)
[![xcode-version](https://img.shields.io/badge/xcode-14%20beta4-brightgreen)](https://developer.apple.com/xcode/)

Contains a plugin conveniently called `Plug` that can be used on both Swift Package Manager targets as on
xcode project targets.

This project was made because there where several issues for me to actually get it to run with visual output on SPM and Xcode targets.
This was due to:

- plugins do not provide breakpoints when run
- both input and output files need to exist or they will not run
- plugins that run in the build system of Xcode and/or SPM have to be executables that Xcode/SPM will run on your behave, command tools not necessarily
- output should be located into the `pluginWorkingDirectory` which is not your sources folder but in the dreaded `DerivedData` folder
- If output needs to be compiled than all output generated by your tool should be listed in the output files, or they will just be generated but not compiled

For this project output will be

- `~/DerivedData/SPMPluginXcode-<#uuid#>/SourcePackages/plugins/SPMPluginXcode.output/SPMPluginXcode/Plug/Output.swift`
- `~/DerivedData/SPMPlugin-<#uuid#>/SourcePackages/plugins/SPMPluginXcode.output/SPMPluginXcode/Plug/Output.swift`

## Found issues in xcode 14 Beta4

- The pre build command can work when you use a tool that is not build by xcode itself. When you do it like in code now with a tool that you get an error like below

```
/usr/bin/sandbox-exec -p "(version 1)
(deny default)
(import \"system.sb\")
(allow file-read*)
(allow process*)
(allow file-write*
    (subpath \"/private/tmp\")
    (subpath \"/private/var/folders/y4/c8rp4svn2xb2v780p6tmwvx80000gn/T\")
)
(deny file-write*
    (subpath \"<#root#>/SPMPlugin/ExampleXcode/SPMPluginXcode\")
)
(allow file-write*
    (subpath \"<#user#>/Library/Developer/Xcode/DerivedData/SPMPluginXcode-gekgfcqooheywrbyvaoyqkubzduv/SourcePackages/plugins/SPMPluginXcode.output/SPMPluginXcode/Plug\")
)
" "/${BUILD_DIR}/${CONFIGURATION}/PluginMain" <#user#>/Library/Developer/Xcode/DerivedData/SPMPluginXcode-gekgfcqooheywrbyvaoyqkubzduv/SourcePackages/plugins/SPMPluginXcode.output/SPMPluginXcode/Plug <#user#>/Developer/Mediahuis/DesignSystem/SPMPlugin/ExampleXcode/SPMPluginXcode/SPMPluginXcode/Input.swift <#user#>/Library/Developer/Xcode/DerivedData/SPMPluginXcode-gekgfcqooheywrbyvaoyqkubzduv/SourcePackages/plugins/SPMPluginXcode.output/SPMPluginXcode/Plug/Output.swift

The file “PluginMain” doesn’t exist.
```

## Setup

This is tested with [![xcode-version](https://img.shields.io/badge/xcode-14%20beta3-brightgreen)](https://developer.apple.com/xcode/) and might work better with 
future versions of xcode

## Potential

- [swiftgen](https://github.com/SwiftGen/SwiftGen/blob/develop/Documentation/Articles/SwiftGen-Build-Tool-Package-Plugins.md) can be used to have type safe asset accessors in swift and you do not have to worry about them being up to date or have to commit them
- [sourcery](https://github.com/krzysztofzablocki/Sourcery/issues/1023) would be awesome for custom code generation but at present no artefact is ready to be used as input
