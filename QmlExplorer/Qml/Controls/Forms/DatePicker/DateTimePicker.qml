import QtQuick 2.0
import "../Spinner/"


/**
日期时间选择控件
    /用滚轴方式显示日期时间
    可只显示日期（未完成）

bug:
    setValue()日期不准确。如2014-12-03显示为2014-12-01
*/
Rectangle
{
    id: root
    width: 800
    height: 200
    border.color: '#808080'
    border.width: 2

    property bool showTime : true;
    onShowTimeChanged: {
        spinnerYear.width = showTime ? root.width/5 : root.width/3;
        spinnerMonth.width = showTime ? root.width/5 : root.width/3;
        spinnerDay.width = showTime ? root.width/5 : root.width/3;
        spinnerHour.width = showTime ? root.width/5 : 0;
        spinnerMinute.width = showTime ? root.width/5 : 0;
        if (!showTime){
            spinnerHour.currentIndex = 0;
            spinnerMinute.currentIndex = 0;
        }
    }

    //-----------------------------------------------------------
    // 公共属性和方法
    //-----------------------------------------------------------
    property int rowHeight: 30
    function getValue(){
        return new Date(getYear(), getMonth()-1, getDay(), getHour(), getMinute(), 0);
    }
    function setValue(dt){
        var year = dt.getFullYear();
        var month = dt.getMonth()+1;
        setYear(year);
        setMonth(month);
        setHour(dt.getHours());
        setMinute(dt.getMinutes());

        setMonthDays();
        setDay(dt.getDate());
    }


    //-----------------------------------------------------------
    // 私有方法
    //-----------------------------------------------------------
    function getYear()    {return spinnerYear.currentIndex + 1950;}
    function getMonth()   {return spinnerMonth.currentIndex + 1;}
    function getDay()     {return spinnerDay.currentIndex + 1;}
    function getHour()    {return spinnerHour.currentIndex;}
    function getMinute()  {return spinnerMinute.currentIndex;}
    //-----------------------------------------------------------
    function setYear(d)   {spinnerYear.currentIndex = d - 1950;}
    function setMonth(d)  {spinnerMonth.currentIndex = d - 1;}
    function setDay(d)    {spinnerDay.currentIndex = d - 1;}
    function setHour(d)   {spinnerHour.currentIndex = d;}
    function setMinute(d) {spinnerMinute.currentIndex = d;}
    //-----------------------------------------------------------
    function getMonthDays(year, month){
        var dt = new Date(year, month+1, 0);
        return dt.getDate();
    }
    function setMonthDays(){
        spinnerDay.model = getMonthDays(getYear(), getMonth());
    }


    //-----------------------------------------------------------
    //
    //-----------------------------------------------------------
    Component.onCompleted: setValue(new Date());



    //-----------------------------------------------------------
    // 年月日时分
    //-----------------------------------------------------------
    Row {
        anchors.fill: parent

        // 年(1950-2050)
        Spinner {
            id: spinnerYear
            width: root.width/5;
            height: root.height
            focus: true
            model: 100
            itemHeight: 30
            delegate: Text { font.pixelSize: 25; text: index+1950; height: 30 }
            onCurrentIndexChanged: setMonthDays();
        }

        // 月(1-12)
        Spinner {
            id: spinnerMonth
            width: root.width/5;
            height: root.height
            focus: true
            model: 12
            itemHeight: 30
            delegate: Text { font.pixelSize: 25; text: index+1; height: 30 }
            onCurrentIndexChanged: setMonthDays();
        }

        // 日(1-31)
        Spinner {
            id: spinnerDay
            width: root.width/5;
            height: root.height
            focus: true
            model: 30
            itemHeight: 30
            delegate: Text { font.pixelSize: 25; text: index+1; height: 30 }
        }

        // 时(0-23)
        Spinner {
            id: spinnerHour
            width: root.width/5;
            height: root.height
            focus: true
            model: 24
            itemHeight: 30
            delegate: Text { font.pixelSize: 25; text: index; height: 30 }
        }

        // 分(0-59)
        Spinner {
            id: spinnerMinute
            width: root.width/5;
            height: root.height
            focus: true
            model: 60
            itemHeight: 30
            delegate: Text { font.pixelSize: 25; text: index; height: 30 }
        }
    }
}

