import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: menuScene

    Image {
        source: "../../assets/img/MainMenu.png"
        anchors.horizontalCenter: menuScene.horizontalCenter
        width: 480
        height: 320
    }

    Keys.onPressed: {

        if(event.key === Qt.Key_Space){
            window.state = "game"
        }
    }

    // a little V-Play logo is always nice to have, right?
    Image {
        source: "../../assets/img/vplay-logo.png"
        width: 60
        height: 60
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.rightMargin: 2
        anchors.bottom: menuScene.gameWindowAnchorItem.bottom
        anchors.bottomMargin: 1
    }

}

