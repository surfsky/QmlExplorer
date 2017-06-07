android-no-sdk {
    target.path = /data/user/qt
    export(target.path)
    INSTALLS += target
} else:android {
    x86 {
        target.path = /libs/x86
    } else: armeabi-v7a {
        target.path = /libs/armeabi-v7a
    } else {
        target.path = /libs/armeabi
    }
    export(target.path)
    INSTALLS += target
} else:unix {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/bin
        } else {
            target.path = /opt/$${TARGET}/bin
        }
        export(target.path)
    }
    INSTALLS += target
}

export(INSTALLS)



#############################################
# qmake 辅助类库
# surfsky 2014-09
#############################################




#############################################
# 当前编译环境是否是windows
# isWinOS() : message(yes)
# 注： win32 范围变量只是判断目标程序的类别，不是os
#############################################
defineTest(isWinOS){
    equals(QMAKE_HOST.os, Windows): return(true)
    else: return(false)
}


#############################################
# Copy one folder recursively
# surfsky 2014-09
# parameters
#    folderFrom       : source folder
#    folderTo         : target folder
#    autoCreateFolder : determinate whether auto create folder accoding by source folder
# eg
#    !build_pass:copyFolder(qml, $$DESTDIR, true)
#    !build_pass:copyFolder($$PWD/qml, $$DESTDIR/qml, false)
#############################################
defineTest(copyFolder) {
    folderFrom = $$1
    folderTo = $$2
    $$3: folderTo = $$2/$$folderFrom
    isWinOS() {
        folderFrom ~= s,/,\\,g
        folderTo ~= s,/,\\,g
        copyCmd = $$quote(xcopy /S /I /Y /E $$folderFrom $$folderTo)
    }else{
        copyCmd = $$quote(cp -r $$folderFrom $$folderTo)
    }
    message($$copyCmd)
    system($$copyCmd)
}

#############################################
# copy files, and auto create folders
# parameter
#    files:  要拷贝的文件列表，请用相对路径，如qml
#    folder: 目标文件夹。将会根据源文件路径,自动创建匹配的文件夹
# eg
#    !build_pass:copyFiles(OTHER_FILES, $$DESTDIR)
#############################################
defineTest(copyFiles) {
    folderTo = $$2
    for(fileSource, $$1){
        # Get filename & filder
        file = $$folderTo/$$fileSource              #TARGET FILE PATH
        folder = $$dirname(file)                    #TARGET FILE FOLDER
        fileSource = $$PWD/$$fileSource             #SOURCE FILE PATH

        # build command
        isWinOS() {
            fileSource = $$replace(fileSource, /, \\)
            file = $$replace(file, /, \\)
            folder = $$replace(folder, /, \\)
            cmdMKDIR = mkdir $$quote($$folder)
            cmdCOPY  = copy /Y $$quote($$fileSource) $$quote($$file)
        }
        else{
            cmdMKDIR = mkdir -p $$quote($$folder)
            cmdCOPY  = cp $$quote($$fileSource) $$quote($$file)
        }
        message($$cmdCOPY)

        # Run command
        !exists($$folder):system($$cmdMKDIR)
        system($$cmdCOPY)
    }
}


#############################################
# 获取windows路径
#############################################
defineReplace(getWinPath) {
    win32:1 ~= s|\\\\|/|g    #用/替换掉\
    contains(1, ^/.*):pfx = / #前缀是/的，在最后要加上/
    else:pfx =
    segs = $$split(1, /)#根据/分开参数1
    out =
    #去除segs中..和.
    for(seg, segs) {
        equals(seg, ..):out = $$member(out, 0, -2) #这个-2不清楚是做什么的
        else:!equals(seg, .):out += $$seg
    }
    return($$join(out, /, $$pfx)) ##用/将列表链接起来，并用pfx作为结果的前缀
}

