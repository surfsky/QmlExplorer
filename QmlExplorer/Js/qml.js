/**
QML 相关辅助函数
*/

Qt.include("string.js");



//---------------------------------------------
//---------------------------------------------
/*
弹出阻断式告警窗口
Common.alert('title', 'information information', parent, function(){
    console.log('accepted');
});
*/
function alert(title, info, parent, onAccepted){
    var txt   = "import QtQuick 2.2;"
              + "import QtQuick.Dialogs 1.1;"
              + "MessageDialog {"
              + "      title: '" + title + "';"
              + "      text: '" + info + "';"
              + "      icon: StandardIcon.Information;"
              + "      standardButtons:StandardButton.Ok"
              + "}";
    var obj = Qt.createQmlObject(txt, parent, 'qml');
    obj.accepted.connect(onAccepted);
    obj.visible = true;
}
function question(title, info, parent, onYes, onNo){
    var txt   = "import QtQuick 2.2;"
              + "import QtQuick.Dialogs 1.1;"
              + "MessageDialog {"
              + "      title: '" + title + "';"
              + "      text: '" + info + "';"
              + "      icon: StandardIcon.Question;"
              + "      standardButtons:StandardButton.Yes|StandardButton.No"
              + "}";
    var obj = Qt.createQmlObject(txt, parent, 'qml');
    obj.yes.connect(onYes);
    obj.no.connect(onNo);
    obj.visible = true;
}


//---------------------------------------------
// qml model相关
//---------------------------------------------
// 将json转化为listmodel
function getListModelFromJson(json, parent){
    var model = Qt.createQmlObject('import QtQuick 2.2; ListModel{}', parent);
    model.append(json);
    return model;
}



//---------------------------------------------
// qml遍历辅助方法
//---------------------------------------------
// 获取item信息
function getString(item)
{
    var info = '{0}, ({1}, {2}, {3}, {4}, {5})'.format(
                item.toString(),
                (item.x!=null) ? item.x : 0,
                (item.y!=null) ? item.y : 0,
                (item.width!=null) ? item.width : 0,
                (item.height!=null) ? item.height : 0,
                (item.children!=null) ? item.children.length : 0
                );
    return info;
}

// 遍历子元素（仅UI元素）
function getChildrenString(item, lvl)
{
    var str = '';
    var children = item.children;
    var info = '  '.repeat(lvl) + getString(item);
    str += info + '\r\n';
    for (var i = 0; i < children.length; i++)
        str += getChildrenString(children[i], lvl+1);
    return str;
}

// 打印子节点
function printChildren(item){
    var str = getChildrenString(item, 0);
    console.log(str);
}


// 遍历子元素（包括不可视元素）
// 有问题，不可视元素的data无length属性
function printItem(item){
    printItemData(item, 0);
}
function printItemData(item, lvl)
{
    var info = '  '.repeat(lvl) + item.toString();
    console.log(info);

    var children = item.data;
    //if ('length' in children){
    if (children != null && children.length != null){
        for (var i = 0; i < children.length; i++)
        {
            printItemData(children[i], lvl+1);
        }
    }
}


// 获取qml根元素
function getRoot(item)
{
    return (item.parent !== null) ? getRoot(item.parent) : item;
}


// 删除子节点
function clearChildren(item)
{
    var childrens = item.children;
    for (var i = 0; i < children.length; i++){
        try{children[i].destory(0);}
        catch (e){}
    }
    item.children = [];//// 彻底清空
}
