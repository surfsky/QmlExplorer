import QtQuick 2.0
import QtQml 2.2


/**
测试console对象
- 标准的js的console.log可输出格式化文本
    %s:字符串
    %i，%d：整数
    %f：浮点数
    %o：小o，DOM方式输出对象
    %O：大O，输出对象
- 但经过测试，qml的console没有这个功能
*/
QtObject {

    Component.onCompleted: {
        console.profile();

        // 脚本开始时间
        console.time('timer1');

        // 打印输出相关方法
        print('print: %d.....', 112);   // 同样无效，无法format
        console.log('log: %d.....', 112)   // 这条语句无效，无法使用format方式
        console.debug('debug');
        console.info('info');
        console.warn('warn')
        console.error('error');

        // 断点异常等调试辅助方法
        console.assert('a' != 'a', 'assert error')
        console.exception('exception');  // 输出错误信息以及JavaScript执行的堆栈跟踪。
        console.trace();      // 输出在调用点的JavaScript执行的堆栈跟踪。
        console.count();      // 附在用户提供的信息之后输出当前函数被调用的次数。


        // 脚本结束耗时
        console.timeEnd('timer1');
    }
    Component.onDestruction: {
        console.profileEnd();
    }
}
