import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../../qml"

SceneBase {
    id:gameScene
    // the filename of the current level gets stored here, it is used for loading the
    property string activeLevelFileName
    // the currently loaded level gets stored here
    property variant activeLevel
    // score
    property int score: 0
    // countdown shown at level start
    property int countdown: 0
    // flag indicating if game is running
    property bool gameRunning: countdown == 0

    // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
        activeLevelFileName = fileName
    }

    // for creating entities (enemy and bullets) at runtime dynamically
    EntityManager {
      id: entityManager
      entityContainer: gameScene
    }

    PhysicsWorld {
      // set no gravity, the collider is not physics-based
    }

    focus: true
    Keys.forwardTo: twoAxisController

    Image {
        source: "../../assets/img/background.png"
        anchors.horizontalCenter: gameScene.horizontalCenter
        width: 480
        height: 320
    }

    Image {
        source: "../../assets/img/ui.png"
        anchors.horizontalCenter: gameScene.horizontalCenter
        width: 90
        height: 42
    }

    // Boundaries to make it impossible for the player to leave the screen:
    // left wall
    Wall {height:parent.height+150; anchors.right:parent.left}
    // right wall
    Wall {height:parent.height+150; anchors.left:parent.right}
    // ceiling
    Wall {width:parent.width; anchors.bottom:parent.top}
    // floor
    Wall {width:parent.width; anchors.bottom:parent.bottom}

    // Add one test enemy:
    ShootingEnemy{
        id: enemyShooter
        x: 200
        y: 200

        BoxCollider{
            id:enemyShooterBoxCollider
            anchors.fill: enemyShooter
            categories: Box.Category2
            collidesWith: Box.Category1
        }
    }

    // Add one test mine enemy
    Mine{
        id: mine
        x: 200
        y: 100

        BoxCollider {
          id: mineCollider
          anchors.fill: mine
          categories: Box.Category2
          collidesWith: Box.Category1
        }
    }

    // Add one test powerup
    PowerUp{
        id: powerup
        x: 200
        y: 250

        BoxCollider {
          id:powerupCollider
          anchors.fill: powerup
          categories: Box.Category4
          collidesWith: Box.Category1
        }
    }

    // Add one test rapidfire powerup
    RapidFire{
        id: rapidfire
        x: 200
        y: 150

        BoxCollider {
          id: rapdidfireCollider
          anchors.fill: rapidfire
          categories: Box.Category4
          collidesWith: Box.Category1
        }
    }

    Player {
      id: player
      x: 100
      y: 100

      BoxCollider {
          id: playerBoxCollider
          width: 32; height: 12
          categories: Box.Category1
          collidesWith: Box.Category2 | Box.Category3 | Box.Category4
      }
    }

    TwoAxisController {
        id: twoAxisController

        Keys.onRightPressed: {
             playerBoxCollider.linearVelocity = Qt.point(300,0)
        }

        Keys.onLeftPressed: {
            playerBoxCollider.linearVelocity = Qt.point(-300,0)
        }

        Keys.onUpPressed: {
          playerBoxCollider.linearVelocity = Qt.point(0,-300)
        }

        Keys.onDownPressed: {
          playerBoxCollider.linearVelocity = Qt.point(0,300)
        }

        Keys.onReleased: {
            playerBoxCollider.linearVelocity = Qt.point(0,0)
        }

        Keys.onPressed: {
            if(event.key === Qt.Key_Control){
                console.debug("Shoot!")
            }
        }
    }

//    // background
//    Rectangle {
//        anchors.fill: parent.gameWindowAnchorItem
//        color: "#dd94da"
//    }

//    // back button to leave scene
//    MenuButton {
//        text: "Back to menu"
//        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
//        anchors.right: gameScene.gameWindowAnchorItem.right
//        anchors.rightMargin: 10
//        anchors.top: gameScene.gameWindowAnchorItem.top
//        anchors.topMargin: 10
//        onClicked: {
//            backButtonPressed()
//            activeLevel = undefined
//            activeLevelFileName = ""
//        }
//    }

//    // name of the current level
//    Text {
//        anchors.left: gameScene.gameWindowAnchorItem.left
//        anchors.leftMargin: 10
//        anchors.top: gameScene.gameWindowAnchorItem.top
//        anchors.topMargin: 10
//        color: "white"
//        font.pixelSize: 20
//        text: activeLevel !== undefined ? activeLevel.levelName : ""
//    }

    // load levels at runtime
    Loader {
        id: loader
        source: activeLevelFileName != "" ? "../levels/" + activeLevelFileName : ""
        onLoaded: {
            // reset the score
            score = 0
            // since we did not define a width and height in the level item itself, we are doing it here
            item.width = gameScene.width
            item.height = gameScene.height
            // store the loaded level as activeLevel for easier access
            activeLevel = item
            // restarts the countdown
            countdown = 3
        }
    }

    // we connect the gameScene to the loaded level
    Connections {
        // only connect if a level is loaded, to prevent errors
        target: activeLevel !== undefined ? activeLevel : null
        // increase the score when the rectangle is clicked
        onRectanglePressed: {
            // only increase score when game is running
            if(gameRunning) {
                score++
            }
        }
    }

//    // name of the current level
//    Text {
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.top: gameScene.gameWindowAnchorItem.top
//        anchors.topMargin: 30
//        color: "white"
//        font.pixelSize: 40
//        text: score
//    }

//    // text displaying either the countdown or "tap!"
//    Text {
//        anchors.centerIn: parent
//        color: "white"
//        font.pixelSize: countdown > 0 ? 160 : 18
//        text: countdown > 0 ? countdown : "tap!"
//    }

    // if the countdown is greater than 0, this timer is triggered every second, decreasing the countdown (until it hits 0 again)
    Timer {
        repeat: true
        running: countdown > 0
        onTriggered: {
            countdown--
        }
    }
}

