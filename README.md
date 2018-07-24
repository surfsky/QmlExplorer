QmlExplorer
===========

A Qt QML running environment and examples explorer app.



Features
===========
Test:
- Common (DynamicalCreate, Font, Image, Singleton, Syntax, Thread, Tool)
- Effect (Animation, Canvas, GraphicalEffect, Particles, Shader)
- KeyMouseTouch
- MultiDensity
- Multimedia (Sound, video)
- Network ( Ajax, XmlListModel, WebSocket)
- Qt3D
- Storage
- Styles
- UI (Basic, Dataview, Layout, Pages, WindowsDialog)
- UnitTest


Controls:
- Charts
- Effectors
- Gauges
- Views
- Components
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
- NotePad
- Painter
- RoundMenu
- ....


Help!
===========
When I restarted this project several months ago, I moved all qml files into .qrc files. 
I can run qml file by QmlScene, it's ok. However, when I build and run it, It cannot run normally. 
It often meet error: failed to create object, xxx is not a type.
It may be some IO limit when dynamic creating qml object from .qrc.
Should I change all  "import SomeQmlComponent"  code to "import qrc:\xxxxx"? It's a horrible work. 
Anyone can help me? 

Snapshots
===========

![](https://github.com/surfsky/QmlExplorer/blob/master/Images/App_Clock.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/App_Dial.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/App_ImageCrop.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/App_Metro.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/App_Notepad.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/App_Painter.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/App_RoundMenu.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/Effect_genie.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/Effect_Reflect.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/Effect_RoundCorner.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/Effect_Shine.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/Effect.gif)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/Form_AnglePicker.gif)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/Form_Charts.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/Form_ColorPicker.png)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/Form_DatePicker.gif)
![](https://github.com/surfsky/QmlExplorer/blob/master/Images/Gauge_Dial.png)


