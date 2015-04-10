/****************************************************************************
**
** Copyright (C) 2013-2014 Oleg Yadrov.
** Contact: wearyinside@gmail.com
**
** This file is part of QML Creator.
**
** QML Creator is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** QML Creator is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with QML Creator. If not, see http://www.gnu.org/licenses/.
**
****************************************************************************/

#ifndef QMLHIGHLIGHTER_H
#define QMLHIGHLIGHTER_H

#include <QtWidgets/QtWidgets>
#include <QtCore/QtCore>

class QMLHighlighter : public QSyntaxHighlighter
{
public:
    typedef enum {
        Background,
        Normal,
        Comment,
        Number,
        String,
        Operator,
        Keyword,
        BuiltIn,
        Sidebar,
        LineNumber,
        Cursor,
        Marker,
        BracketMatch,
        BracketError,
        FoldIndicator,
        Item,
        Property
    } ColorComponent;

    QMLHighlighter(QTextDocument *parent = 0);
    void setColor(ColorComponent component, const QColor &color);
    void mark(const QString &str, Qt::CaseSensitivity caseSensitivity);

protected:
    void highlightBlock(const QString &text);

private:
    QSet<QString> m_keywords;
    QSet<QString> m_jsIds;
    QSet<QString> m_qmlIds;
    QSet<QString> m_properties;
    QHash<ColorComponent, QColor> m_colors;
    QString m_markString;
    Qt::CaseSensitivity m_markCaseSensitivity;
};

#endif // QMLHIGHLIGHTER_H
