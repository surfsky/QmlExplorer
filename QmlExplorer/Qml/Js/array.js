//--------------------------------
// js数组操作
// a = ['1','2','3','4','5'];
// 成员只能是简单的数据类型，不能是QtObject
// QtObject可用list<xxx> 来容纳，但增删方法未知
//--------------------------------
/*
QML并不提供堆栈相关的类，可用js的Array来模拟
使用
    import "common.js" as Common
    Common.array.push("a");
    Common.array.push("b");
    Common.array.push("c");
    console.log(Common.array.pop());
    console.log(Common.array.pop());
    console.log(Common.array.pop());
*/
var array = new Array();


/*清空数组*/
Array.prototype.clear = function()
{
    this.length = 0;
}

/*
删除数组元素
示例
    a = ['1','2','3','4','5'];
    console.log(a);
    a.remove(1);
    console.log(a);
*/
Array.prototype.remove = function(n)
{
    if(isNaN(n) || n>this.length) return false;
    for(var i=0,j=0; i<this.length; i++)
    {
        if(this[i] != this[n])
            this[j++]=this[i];
    }
    this.length -= 1;
}

/*
删除数组元素，并返回新数组
参数
    n表示第几项，从0开始算起。
示例
    var test=new Array(0,1,2,3,4,5);
    test=test.del(3);
    alert(test);
*/
/*
Array.prototype.del = function(n) {
    if(n<0) return this;
    else    return this.slice(0,n).concat(this.slice(n+1,this.length));
}
*/
