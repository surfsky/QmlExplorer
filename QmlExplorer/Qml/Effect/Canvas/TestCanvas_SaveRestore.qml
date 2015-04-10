import QtQuick 2.0

/**
Canvas 变形绘制以及上下文保存测试
canvas可用的变形方法
  translate(dx, dy)
  rotate()
  scale(x,y)
  setTransform(m11, m12, m21, m22, dx, dy)
  resetTransform()
关于save、restore可参考：http://www.cnblogs.com/xirihanlin/archive/2009/07/24/1530246.html
*/
Canvas {
    id: canvas
    width: 300; height: 300
    onPaint: {
        var ctx = getContext("2d")
        ctx.lineWidth = 4
        ctx.fillStyle = 'green'

        // 保存上下文环境
        // 先做坐标系操作（平移旋转放缩）
        // 再绘制图形
        // 恢复上下文环境
        // 问题：觉得放缩和旋转的操作时颠倒的
        ctx.save();                   // 保存之前的上下文
        ctx.translate(100, 100);      // 平移
        ctx.rotate(Math.PI/4);        // 旋转
        ctx.scale(2.0, 1.0);          // 放缩
        ctx.fillStyle = 'yellow';     // 填充色为黄色
        ctx.fillRect(10, 10, 40, 40); // 绘制
        ctx.restore();                // 恢复之前的上下文

        // 以正常上下文绘制
        ctx.fillRect(10, 10, 40, 40);
    }
}
