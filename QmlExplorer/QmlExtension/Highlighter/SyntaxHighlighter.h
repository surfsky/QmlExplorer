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

#ifndef SYNTAXHIGHLIGHTER_H
#define SYNTAXHIGHLIGHTER_H

#include <QObject>
#include <QQuickTextDocument>
#include "QMLHighlighter.h"

class SyntaxHighlighter : public QObject
{
    Q_OBJECT

public:
    explicit SyntaxHighlighter(QObject *parent = 0) {
        Q_UNUSED(parent)
    }

    Q_INVOKABLE void setHighlighter(QObject *textArea) {
        QQuickTextDocument *quickTextDocument = qvariant_cast<QQuickTextDocument*>(textArea->property("textDocument"));
        QTextDocument *document = quickTextDocument->textDocument();
        QMLHighlighter *highlighter = new QMLHighlighter(document);
        Q_UNUSED(highlighter)
    }
};


#endif // SYNTAXHIGHLIGHTER_H
