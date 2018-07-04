/**
ajax 辅助函数
注意：qml提供的ajax方法并不支持cookie qt5.8
*/

// AJAX
function ajax(url, method, arg, success, failure)
{
    if (method == 'GET') get(url, success, failure);
    if (method == 'POST') post(url, arg, success, failure);
}


// GET
function get(url, success, failure)
{
    var xhr = new XMLHttpRequest;
    xhr.open("GET", url);
    xhr.onreadystatechange = function() {
        handleResponse(xhr, success, failure);
    }
    xhr.send();
}

// POST
function post(url, arg, success, failure)
{
    var xhr = new XMLHttpRequest;
    xhr.open("POST", url);
    //xhr.setRequestHeader("Content-Length", arg.length);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");  //用POST的时候一定要有这句
    xhr.onreadystatechange = function() {
        handleResponse(xhr, success, failure);
    }
    xhr.send(arg);
}



// 处理返回值
function handleResponse(xhr, success, failure){
    if (xhr.readyState == XMLHttpRequest.DONE) {
        if (xhr.status ==  200){
            if (success != null && success != undefined)
            {
                var result = xhr.responseText;
                try{
                    success(result, JSON.parse(result));
                }catch(e){
                    success(result, {});
                }
            }
        }
        else{
            if (failure != null && failure != undefined)
                failure(xhr.responseText, xhr.status);
        }
    }
}


// pastebin post demo
function demo(){
    var url = "http://pastebin.com/api/api_post.php";
    var name = 'project1';
    var code = 'hello world';
    var params = "api_option=paste" + "&" +
            "api_dev_key=7ffdaa2800e8c5da75589596f405d739" + "&" +
            "api_paste_format=javascript" + "&" +
            "api_paste_expire_date=1M" + "&" +
            "api_paste_private=1" + "&" +
            "api_paste_name=" + name + "&" +
            "api_paste_code=" + code;
    post(url, params, function(result, json){
       console.log(result);
    });
}
