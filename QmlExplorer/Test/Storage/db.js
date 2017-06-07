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

.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var db = Sql.LocalStorage.openDatabaseSync(
    "QML Creator",
    "1.0",
    "QML Creator (C) 2013-2014, Oleg Yadrov",
    100000
    );

function init() {
    db.transaction(
        function(tx) {
            tx.executeSql('drop table Projects;');
            tx.executeSql('CREATE TABLE IF NOT EXISTS Projects(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, code TEXT);');
        }
    );
}

function getProjects() {
    var projects = new Array(0)
    db.transaction(
        function(tx) {
            var rs = tx.executeSql('SELECT * FROM Projects;');
            for (var i = 0; i < rs.rows.length; i++) {
                var project = new Object
                project.id = rs.rows.item(i).id
                project.name = rs.rows.item(i).name
                projects.push(project)
            }
        }
    );
    return projects
}

function getProjectCode(id) {
    var answer = ""
    db.transaction(
        function(tx) {
            var rs = tx.executeSql('SELECT * FROM Projects WHERE id=?;', [ id ]);
            answer = rs.rows.item(0).code;
        }
    );
    return answer
}

// 到底插进去了没有？
function addProject(name, code) {
    db.transaction(
        function(tx) {
            tx.executeSql('INSERT INTO Projects(name, code) VALUES(?, ?);', [name, code ]);
        }
    );
}

function saveProject(id, name, code) {
    db.transaction(
        function(tx) {
            var rs = tx.executeSql('SELECT * FROM Projects WHERE id=?;', [ id ]);
            if (rs.rows.length === 1) {
                tx.executeSql('UPDATE Projects SET name=?, code=? WHERE id=?;', [ name, code, id ]);
            }
        }
    );
}


function removeProject(id) {
    db.transaction(
        function(tx) {
            tx.executeSql('DELETE FROM Projects WHERE id=?;', [ id ]);
        }
    );
}
