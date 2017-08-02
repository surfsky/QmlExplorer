QmlExplorer
===========

A Qt QML running environment and examples explorer app.



Features
===========

Controls:
- Popup
- PageView
- TabView
- ListViewEx: drop down to reflesh, drag up to load more
- ParallaxView
- SliderView
- TreeView
- Shader
- SwipeMouseArea
- ImageMouseArea
- JsonListModel
- ...

Apps:
- Clock
- Dial
- Docker
- ImageCropper
- LiveTile
- NodePad
- RoundMenu
- ....


Help!
===========
After restart this project, I move all qml files into .qrc files. 
I can run qml file by QmlScene, it's ok. However, when I build and run it, It cannot run correctly. 
Often meet error: failed to create object, xxx is not a type.
It may be some IO problem when dynamic creating qml object from .qrc.
Need I change all  "import SomeQmlComponent"  to "import qrc:\xxxxx"? It's a horrible work. 
Anyone can help me? 

