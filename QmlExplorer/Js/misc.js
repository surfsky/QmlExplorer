// factorial序列递归示例
function factorial(a) {
    a = parseInt(a);
    if(a <= 0)
        return 1;
    else
        return a*factorial(a-1);
}
