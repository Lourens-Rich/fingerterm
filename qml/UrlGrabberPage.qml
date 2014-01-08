/*
    Copyright 2011-2012 Heikki Holstila <heikki.holstila@gmail.com>

    This file is part of FingerTerm.

    FingerTerm is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    FingerTerm is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with FingerTerm.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    SilicaListView {
        id: urlView

        anchors.fill: parent

        header: PageHeader {
            title: 'Open URL'
        }

        ViewPlaceholder {
            enabled: urlView.count == 0
            text: 'No URLs'
        }

        delegate: ListItem {
            menu: contextMenu

            Label {
                text: modelData
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: Theme.paddingMedium
                }
            }

            onClicked: {
                Qt.openUrlExternally(modelData)
                pageStack.pop()
            }

            Component {
                id: contextMenu
                ContextMenu {
                    MenuItem {
                        text: 'Copy to clipboard'
                        onClicked: util.copyTextToClipboard(modelData)
                    }
                }
            }
        }

        model: term.grabURLsFromBuffer()
    }
}
