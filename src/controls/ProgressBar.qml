/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Private 1.0
import "Styles/Settings.js" as Settings

/*!
    \qmltype ProgressBar
    \inqmlmodule QtQuick.Controls 1.0
    \ingroup indicators
    \brief A progress bar

    The ProgressBar is used to give an indication of the progress of an operation.
    \l value is updated regularly and must be between \l minimumValue and \l maximumValue.

*/

Control {
    id: progressbar

    /*! This property holds the progress bar's current value.
        Attempting to change the current value to one outside the minimum-maximum
        range has no effect on the current value.
        The default value is \c 0
    */
    property real value: 0

    /*! This property is the progress bar's minimum value
        The \l value is clamped to this value.
        The default value is \c 0
    */
    property real minimumValue: 0

    /*! This property is the progress bar's maximum value
        The \l value is clamped to this value.
        If maximumValue is smaller than \l minimumValue, \l minimumValue will be enforced.
        The default value is \c 1
    */
    property real maximumValue: 1

    /*! This property toggles indeterminate mode.
        When the actual progress is unknown, use this option.
        The progress bar will be animated as a busy indicator instead.
        The default value is \c false
    */
    property bool indeterminate: false

    /*! \qmlproperty enum orientation

        This property holds the orientation of the progress bar.

        \list
        \li Qt.Horizontal - Horizontal orientation. (Default)
        \li Qt.Vertical - Vertical orientation.
        \endlist
    */
    property int orientation: Qt.Horizontal

    /*! \internal */
    style: Qt.createComponent(Settings.THEME_PATH + "/ProgressBarStyle.qml", progressbar)

    /*! \internal */
    onMaximumValueChanged: setValue(value)
    /*! \internal */
    onMinimumValueChanged: setValue(value)
    /*! \internal */
    Component.onCompleted: setValue(value)
    /*! \internal */
    onValueChanged: setValue(value)

    Accessible.role: Accessible.ProgressBar
    Accessible.name: value

    implicitWidth: orientation === Qt.Horizontal ? 200 : (__panel ? __panel.implicitHeight : 0)
    implicitHeight: orientation === Qt.Horizontal ? (__panel ? __panel.implicitHeight : 0) : 200

    /* \internal */
    function setValue(v) {
        var newval = parseFloat(v)
        if (!isNaN(newval)) {
            // we give minimumValue priority over maximum if they are inconsistent
            if (newval > maximumValue) {
                if (maximumValue >= minimumValue)
                    newval = maximumValue;
                else
                    newval = minimumValue
            } else if (v < minimumValue) {
                newval = minimumValue
            }
            value = newval
        }
    }
}