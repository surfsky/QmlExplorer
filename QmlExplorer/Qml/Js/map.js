/*
http://blog.csdn.net/kevin_luan/article/details/33726115#
var map = new Map();
map.put("a","A");
map.put("b","B");
map.put("c","C");
var v = map.get("a"); //返回：A
var s = map.entrySet(); // 返回Entity[{key,value},{key,value}]
var b = map.containsKey('kevin'); //返回:false
*/
function Map() {
    this.keys = new Array();
    this.data = new Object();

    /**
     * 放入一个键值对
     * @param {String} key
     * @param {Object} value
     */
    this.put = function(key, value) {
        if(this.data[key] == null){
            this.keys.push(key);
            this.data[key] = value;
        }else{
            this.data[key]=this.data[key];
        }
        return true;
    };

    /**
     * 获取某键对应的值
     * @param {String} key
     * @return {Object} value
     */
    this.get = function(key) {
        return this.data[key];
    };

    /**
     * 删除一个键值对
     * @param {String} key
     */
    this.remove = function(key) {
        for(var i=0;i<this.keys.length;i++){
            if(key===this.keys[i]){
                var del_keys= this.keys.splice(i,1);
                for(k in del_keys){
                    this.data[k] = null;
                }
                return true;
            }
        }
        return false;
    };

    /**
     * 遍历Map,执行处理函数
     *
     * @param {Function} 回调函数 function(key,value,index){..}
     */
    this.each = function(fn){
        if(typeof fn != 'function'){
            return;
        }
        var len = this.keys.length;
        for(var i=0;i<len;i++){
            var k = this.keys[i];
            fn(k,this.data[k],i);
        }
    };

    /**
     * 获取键值数组
     * @return entity[{key,value},{key,value}]
     */
    this.entrySet = function() {
        var len = this.keys.length;
        var entrys = new Array(len);
        for (var i = 0; i < len; i++) {
            entrys[i] = {
                key : this.keys[i],
                value : this.data[this.keys[i]]
            };
        }
        return entrys;
    };

    /**
     * 判断Map是否为空
     */
    this.isEmpty = function() {
        return this.keys.length == 0;
    };

    /**
     * 获取键值对数量
     */
    this.size = function(){
        return this.keys.length;
    };

    this.containsKey=function(key){
        return this.keys.filter(function(v){
           if(v===key){
               return key;
           }
        }).length>0;
    };
    /**
     * 重写toString
     */
    this.toString = function(){
        var s = "{";
        for(var i=0;i<this.keys.length;i++){
            var k = this.keys[i];
            s += k+"="+this.data[k];
            if(this.keys.length>i+1){
                s+=','
            }
        }
        s+="}";
        return s;
    };
    /**
     * 解析字符串到Map
     * {a=A,b=B,c=B,}
     */
    this.parserStringAndAddMap=function(str){
        var count=0;
        if(str && str.length>0){
            str=str.trim();
            var startIndex=str.indexOf("{"),endIndex=str.lastIndexOf("}");
            if(startIndex!==-1 && endIndex!==-1){
                str=str.substring(startIndex+1,endIndex);
                var arrs= str.split(",");
                for(var i=0;i<arrs.length;i++){
                    var kv=arrs[i].trim();
                    if(kv.length>0 && kv.indexOf("=")!==-1){
                        var kv_arr=kv.split("=");
                        if(kv_arr.length==2){
                            if(this.put(kv_arr[0].trim(),kv_arr[1].trim())){
                                count++;
                            }else{
                                console.error('error: kv:'+kv);
                            }

                        }
                    }
                }
            }else{
                console.log("data error:"+str);
            }
        }else{
            console.log('data is not empty');
        }
        return count;
    };
}
