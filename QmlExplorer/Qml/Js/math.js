// 四舍五入到小数点某个位数
function roundx(x, num){
    return Math.round(x * Math.pow(10, num)) / Math.pow(10, num) ;
}
