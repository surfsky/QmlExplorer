import QtQuick 2.0

/*
sprite包括
    AnimatedSprite - For playing animations stored as a series of frames
    SpriteSequence - For playing and transitioning between multiple animations stored as a series of frames
    Sprite - Specifies sprite animations for other Items to display
资源来自项目 touchInteraction
*/
Rectangle {
    width: 300
    height: 800
    //spacing: 10

    // 单个精灵（固定动作）
    AnimatedSprite
    {
        y: 20
        id: animatedSprite
        width: 256
        height: 256
        frameCount: 9
        frameWidth: 256
        frameHeight: 256
        frameDuration: 80
        interpolate: false
        source: "Bear1.png"
    }

    // 精灵序列（可容纳若干状态下的精灵）
    SpriteSequence
    {
        y: 250
        id: spriteSequence
        width: 256
        height: 256
        interpolate: false
        running: true
        sprites:
        [
            Sprite{
                name: "floating"
                source: "Bear1.png"
                frameCount: 9
                frameWidth: 256
                frameHeight: 256
                frameDuration: 80
                to: {"still":0, "flailing":0}
            },
            Sprite{
                name: "flailing"
                source: "Bear2.png"
                frameCount: 8
                frameWidth: 256
                frameHeight: 256
                frameDuration: 80
                to: {"falling":1}
            },
            Sprite{
                name: "falling"
                source: "Bear3.png"
                frameCount: 5
                frameWidth: 256
                frameHeight: 256
                frameDuration: 80
                to: {"falling":1}
            }
        ]
    }
    MouseArea{
        anchors.fill: spriteSequence
        onClicked:{
            spriteSequence.jumpTo("flailing");
        }
    }

}
