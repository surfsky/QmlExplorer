# QChart.js

*QML bindings for Charts.js, a simple HTML5 Charts javascript library
 using the canvas element* -
 [chartjs.org](http://www.chartjs.org).

To give QChart.js a try, just clone this repository and use qmlscene.

```Shell
$ qmlscene QChartGallery.qml
```

![Screenshot](http://jwintz.me/images/qchart.png)

## Dependencies

Qt >= 5.0.

## Setup

This shows how to integrate QChart.js as a ``jbQuick.Charts`` submodule into your git project.

```Shell
$ cd /path/to/project/root/
$ mkdir -p qml/jbQuick
$ git submodule add git://github.com/jwintz/qchart.js.git qml/jbQuick/Charts
$ git commit -a -m "Added QChart.js as a submodule."
```

When cloning a repository with submodules, use:

```Shell
$ git clone git://your/project/repository.git
$ git submodule init
$ git submodule update
```

To update your local submodule, use:

```Shell
$ git submodule update
```

## Usage

Assuming ``jbQuick`` is in your qml import path:

```QML
import jbQuick.Charts 1.0
```

QChart.js qmldir provides:
* ``Chart`` QML item inheriting ``Canvas``
* ``Charts`` Javascript library

In addition, ``Chart`` provides the following properties:
* ``chartAnimated``: whether chart data should be animated on initialization
* ``chartAnimationEasing``: an easing type enumeration provided to a PropertyAnimation
* ``chartAnimationDuration``: the length (ms) of the animation
* ``chartData``: a javascript construct of the data set, see Chart.js documentation
* ``chartType``: a value amongst:
  * ``Charts.chartType.BAR`` for a bar chart
  * ``Charts.chartType.DOUGHNUT`` for a doughnut chart
  * ``Charts.chartType.LINE`` for a line chart
  * ``Charts.chartType.PIE`` for a pie chart
  * ``Charts.chartType.POLAR`` for a polar chart
  * ``Charts.chartType.RADAR`` for a radar chart

The following snippet creates a line chart.

```QML
Chart {
  id: chart_line;
  width: 400;
  height: 400;
  chartAnimated: true;
  chartAnimationEasing: Easing.InOutElastic;
  chartAnimationDuration: 2000;
  chartType: Charts.ChartType.LINE;
  Component.onCompleted: {
      chartData = ...;
  }
}
```

## Documentation

You can find Charts.js documentation at
[chartjs.org/docs](http://www.chartjs.org/docs).

## License

QChart.js, just as Charts.js, is available under the [MIT license]
(http://opensource.org/licenses/MIT).
