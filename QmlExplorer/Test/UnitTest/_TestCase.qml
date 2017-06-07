import QtQuick 2.0
import QtTest 1.0


/**
测试用例
- TestCase
- SignalSpy
- Data driven test
- QTest compatible APIs
*/
TestCase{
    name: "basicTest"
    function testPass(){
        compare(2+2, 4, "2+2");
    }
}
