import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
import "components"

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.qqworini.utest0"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    width: units.gu(100)
    height: units.gu(75)

    function randomNumber(top, bottom) {
        var tmpt = Number(top)
        var tmpb = Number(bottom)
        var gap = tmpt - tmpb
        var ran = Math.round(Math.random() * 10000)
        var result = ran % gap
        console.log("gap, ran, %:" ,gap, ran, result)
        var isExist = false
        for (var i=0; i<lotteryModel.count; i++){
            if (result == (lotteryModel.get(i).value - tmpb)) {
                isExist = true
                break
            }
        }
        if (isExist) {
            return randomNumber(top, bottom)
        }

        return result
    }

    Page {
        title: i18n.tr("薛定谔的抽奖机")

        Row {
            spacing: units.gu(2)
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            Column {
                spacing: units.gu(1)
                Label {
                    text: "上限："
                }

                TextField {
                    id: tfTop
                }

                Label {
                    text: "下限："
                }

                TextField {
                    id: tfBottom
                }

                Button{
                    text: "抽奖"

                    onClicked: {
                        lotteryModel.append({"value": Number(tfBottom.text) + randomNumber(tfTop.text, tfBottom.text)})
                    }
                }

                Item {
                    width: units.gu(3); height: width
                }

                Button{
                    text: "清除"

                    onClicked: {
                        lotteryModel.clear()
                    }
                }
            }


            ListView {
                width: parent.width / 2 - units.gu(1)
                anchors{
                    top: parent.top; bottom: parent.bottom
                }
                clip: true
                model: lotteryModel
                delegate: delegate
            }

            Component {
                id: delegate
                Standard {
                    height: units.gu(8)
                    removable: true
//                    text: value + " , " + index
                    Label{
                        anchors.centerIn: parent
                        text: value + " , " + index
                        fontSize: "x-large"
                    }

                    onItemRemoved: {
                        lotteryModel.remove(index)
                        console.log("lotteryModel count: ", lotteryModel.count)
                    }
                }
            }

            ListModel{
                id: lotteryModel
            }

        }
    }
}
