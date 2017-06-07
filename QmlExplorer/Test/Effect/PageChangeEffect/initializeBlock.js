//![0]
var blockSize = 30;
var maxColumn = 8;
var maxRow = 12;
var maxIndex = maxColumn * maxRow;
var board = new Array(maxIndex);
var component;

//Index function used instead of a 2D array
function index(column, row) {
    return column + (row * maxColumn);
}

function initializeBlock() {
    //Delete blocks from previous game
    for (var i = 0; i < maxIndex; i++) {
        if (board[i] != null)
            board[i].destroy();
    }

    //Calculate board size
    maxColumn = Math.floor(background.width / blockSize);
    maxRow = Math.floor(background.height / blockSize);
    maxIndex = maxRow * maxColumn;

    //Initialize Board
    board = new Array(maxIndex);
    for (var column = 0; column < maxColumn; column++) {
        for (var row = 0; row < maxRow; row++) {

            board[index(column, row)] = null;
            //setTimeout(_createBlock2(column, row),1000);
            //setTimeout(function(){createBlock(column,row)},1000);
            //delay((new Date()).getTime(),1);
            createBlock(column, row);


        }
    }
}

function createBlock(column, row) {
//setTimeout(function(){createBlock(0,0)},1000);
    if (component == null)
        component = Qt.createComponent("BoomBlock.qml");

    // Note that if Block.qml was not a local file, component.status would be
    // Loading and we should wait for the component's statusChanged() signal to
    // know when the file is downloaded and ready before calling createObject().
    if (component.status == Component.Ready) {
        var dynamicObject = component.createObject(background);
        if (dynamicObject == null) {
            console.log("error creating block");
            console.log(component.errorString());
            return false;
        }
        dynamicObject.x = column * blockSize;
        dynamicObject.y = row * blockSize;
        dynamicObject.width = blockSize;
        dynamicObject.height = blockSize;
        dynamicObject.spawned = true;
        board[index(column, row)] = dynamicObject;
    } else {
        console.log("error loading block component");
        console.log(component.errorString());
        return false;
    }
    return true;

}

//![0]

