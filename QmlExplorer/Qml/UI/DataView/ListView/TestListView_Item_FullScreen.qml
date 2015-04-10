import QtQuick 2.0
import "../../../Controls/Button"


/**
ListView点击行全屏显示示例
改自官方listview示例
*/
Rectangle {
    id: page
    width: 400; height: 240
    color: "black"


    //----------------------------------------------------
    // listview
    //----------------------------------------------------
    ListView {
        id: listView
        anchors.fill: parent
        model: recipes
        delegate: recipeDelegate
    }


    //----------------------------------------------------
    // 菜单代理。该代理有两种模式：
    // 1. 列表模式(默认), 只显示图片和标题(image, title)
    // 2. 详情模式，还显示营养和食用方式（ingredients, method）
    //----------------------------------------------------
    Component {
        id: recipeDelegate
        Item {
            id: recipe

            // Create a property to contain the visibility of the details.
            // We can bind multiple element's opacity to this one property,
            // rather than having a "PropertyChanges" line for each element we
            // want to fade.
            property real detailsOpacity : 0
            width: listView.width
            height: 70

            // 背景色
            Rectangle {
                id: background
                x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
                color: "ivory"
                border.color: "orange"
                radius: 5
            }

            // 点击切换到 'Details' 状态
            MouseArea {
                anchors.fill: parent
                onClicked: recipe.state = 'Details';
            }

            // 列表模式UI
            Row {
                id: topLayout
                x: 10; y: 10; height: recipeImage.height; width: parent.width
                spacing: 10
                Image {
                    id: recipeImage
                    width: 50; height: 50
                    source: picture
                }
                Column {
                    width: background.width - recipeImage.width - 20; height: recipeImage.height
                    spacing: 5
                    Text {
                        text: title
                        font.bold: true; font.pointSize: 16
                    }
                    Text {
                        text: "Ingredients"
                        font.bold: true
                        opacity: recipe.detailsOpacity
                    }
                    Text {
                        text: ingredients
                        wrapMode: Text.WordWrap
                        width: parent.width
                        opacity: recipe.detailsOpacity
                    }
                }
            }

            // 详情UI
            Item {
                id: details
                x: 10; width: parent.width - 20
                anchors { top: topLayout.bottom; topMargin: 10; bottom: parent.bottom; bottomMargin: 10 }
                opacity: recipe.detailsOpacity
                Text {
                    id: methodTitle
                    anchors.top: parent.top
                    text: "Method"
                    font.pointSize: 12; font.bold: true
                }
                Flickable {
                    id: flick
                    width: parent.width
                    anchors { top: methodTitle.bottom; bottom: parent.bottom }
                    contentHeight: methodText.height
                    clip: true
                    Text { id: methodText; text: method; wrapMode: Text.WordWrap; width: details.width }
                }
                Image {
                    anchors { right: flick.right; top: flick.top }
                    source: "content/pics/moreUp.png"
                    opacity: flick.atYBeginning ? 0 : 1
                }
                Image {
                    anchors { right: flick.right; bottom: flick.bottom }
                    source: "content/pics/moreDown.png"
                    opacity: flick.atYEnd ? 0 : 1
                }
            }

            // 点击恢复为普通状态
            TextButton {
                y: 10
                anchors { right: background.right; rightMargin: 10 }
                opacity: recipe.detailsOpacity
                text: "Close"
                onClicked: recipe.state = '';
            }

            // 状态及状态变更动画
            states: State {
                name: "Details"
                PropertyChanges { target: background; color: "white" }
                PropertyChanges { target: recipeImage; width: 130; height: 130 } // Make picture bigger
                PropertyChanges { target: recipe; detailsOpacity: 1; x: 0 } // Make details visible
                PropertyChanges { target: recipe; height: listView.height } // Fill the entire list area with the detailed view

                // Move the list so that this item is at the top.
                PropertyChanges { target: recipe.ListView.view; explicit: true; contentY: recipe.y }

                // Disallow flicking while we're in detailed view
                PropertyChanges { target: recipe.ListView.view; interactive: false }
            }
            transitions: Transition {
                ParallelAnimation {
                    ColorAnimation { property: "color"; duration: 500 }
                    NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
                }
            }
        }
    }


    //----------------------------------------------------
    // model
    //----------------------------------------------------
    ListModel {
        id: recipes
        ListElement {
            title: "Pancakes"
            picture: "pics/pancakes.jpg"
            ingredients: "<html>
                           <ul>
                            <li> 1 cup (150g) self-raising flour
                            <li> 1 tbs caster sugar
                            <li> 3/4 cup (185ml) milk
                            <li> 1 egg
                           </ul>
                          </html>"
            method: "<html>
                      <ol>
                       <li> Sift flour and sugar together into a bowl. Add a pinch of salt.
                       <li> Beat milk and egg together, then add to dry ingredients. Beat until smooth.
                       <li> Pour mixture into a pan on medium heat and cook until bubbles appear on the surface.
                       <li> Turn over and cook other side until golden.
                      </ol>
                     </html>"
        }
        ListElement {
            title: "Fruit Salad"
            picture: "pics/fruit-salad.jpg"
            ingredients: "* Seasonal Fruit"
            method: "* Chop fruit and place in a bowl."
        }
        ListElement {
            title: "Vegetable Soup"
            picture: "pics/vegetable-soup.jpg"
            ingredients: "<html>
                           <ul>
                            <li> 1 onion
                            <li> 1 turnip
                            <li> 1 potato
                            <li> 1 carrot
                            <li> 1 head of celery
                            <li> 1 1/2 litres of water
                           </ul>
                          </html>"
            method: "<html>
                      <ol>
                       <li> Chop vegetables.
                       <li> Boil in water until vegetables soften.
                       <li> Season with salt and pepper to taste.
                      </ol>
                     </html>"
        }
        ListElement {
            title: "Hamburger"
            picture: "pics/hamburger.jpg"
            ingredients: "<html>
                           <ul>
                            <li> 500g minced beef
                            <li> Seasoning
                            <li> lettuce, tomato, onion, cheese
                            <li> 1 hamburger bun for each burger
                           </ul>
                          </html>"
            method: "<html>
                      <ol>
                       <li> Mix the beef, together with seasoning, in a food processor.
                       <li> Shape the beef into burgers.
                       <li> Grill the burgers for about 5 mins on each side (until cooked through)
                       <li> Serve each burger on a bun with ketchup, cheese, lettuce, tomato and onion.
                      </ol>
                     </html>"
        }
        ListElement {
            title: "Lemonade"
            picture: "pics/lemonade.jpg"
            ingredients: "<html>
                           <ul>
                            <li> 1 cup Lemon Juice
                            <li> 1 cup Sugar
                            <li> 6 Cups of Water (2 cups warm water, 4 cups cold water)
                           </ul>
                          </html>"
            method: "<html>
                      <ol>
                       <li> Pour 2 cups of warm water into a pitcher and stir in sugar until it dissolves.
                       <li> Pour in lemon juice, stir again, and add 4 cups of cold water.
                       <li> Chill or serve over ice cubes.
                      </ol>
                     </html>"
        }
    }

}
