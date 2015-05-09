import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: highscoreScene

    Image {
        source: "../../assets/img/highscoreScreen.png"
        anchors.horizontalCenter: highscoreScene.horizontalCenter
        width: 480
        height: 320
    }

    Keys.onPressed: {

        if(event.key === Qt.Key_Space){
            // TODO Reset gameScene
            gameScene.tenSecondCountdown += 10
            window.state = "game"
        }
    }

    function test(){


    }

    Text {
        id: score1
        x: 215
        y: 100
        font.pixelSize: 15
        color: "#dcac97"
        text: "1:"
    }

    Text {
        id: score2
        x: 215
        y: 125
        font.pixelSize: 15
        color: "#dcac97"
        text: "2:"
    }

    Text {
        id: score3
        x: 215
        y: 150
        font.pixelSize: 15
        color: "#dcac97"
        text: "3:"
    }

    Text {
        id: score4
        x: 215
        y: 175
        font.pixelSize: 15
        color: "#dcac97"
        text: "4:"
    }

    Text {
        id: score5
        x: 215
        y: 200
        font.pixelSize: 15
        color: "#dcac97"
        text: "5:"
    }
}
