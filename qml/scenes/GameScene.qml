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
    property int highScore: 0
    // countdown shown at level start
    property int countdown: 0
    // flag indicating if game is running
    property bool gameRunning: countdown == 0
    // paused
    property bool isPaused: false
    property int tenSecondCountdown: 10
    property list<EntityBase> enemyShooterList

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

    // Time and Score Display
    // ------------------------------------------------------------

    Image {
        id: uiDisplay
        source: "../../assets/img/ui.png"
        anchors.horizontalCenter: gameScene.horizontalCenter
        width: 90
        height: 42
    }

    Image {
        id: timeAlarm
        source: "../../assets/img/alarm.png"
        width: 28
        height: 25.5
        x: 204
        y: 14
        z: -1 // 0
    }

    Text {
        x: 209
        y: 15
        font.pixelSize: 7
        color: "#dcac97"
        text: "Time:"
    }

    Text {
        x: 214
        y: 24
        font.pixelSize: 10
        font.bold: true
        color: "#dcac97"
        text: tenSecondCountdown
    }

    Text {
        x: 253
        y: 15
        font.pixelSize: 7
        color: "#dcac97"
        text: "Score:"
    }

    // Create boundaries to make it impossible for the player to leave the screen:
    // ---------------------------------------------------------------------------

    // left wall
    Wall {height:parent.height+150; anchors.right:parent.left}
    // right wall
    Wall {height:parent.height+150; anchors.left:parent.right}
    // ceiling
    Wall {width:parent.width; anchors.bottom:parent.top}
    // floor
    Wall {width:parent.width; anchors.bottom:parent.bottom}

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

    Image{
        id: pauseScreen
        source: "../../assets/img/pauseMenu.png"
        anchors.horizontalCenter: gameScene.horizontalCenter
        width: 480
        height: 320
        z: -100
    }

    // Components
    // ------------------------------------------------------------------------

    Component{
        id: playerBullet

        PlayerBullet{
        }
    }

    Component{
        id: enemyShooter

        ShootingEnemy{
        }
    }

    Component{
        id: enemyBullet

        EnemyBullet{
        }
    }

    Component{
        id: mine

        Mine{
        }
    }

    Component{
        id: powerup

        PowerUp{
        }
    }

    Component{
        id: rapidfire

        RapidFire{
        }
    }

    // Player Controller
    // ----------------------------------------------------------------
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
            // Shooting
            // ----------------------------------------------------------------
            if(event.key === Qt.Key_Control){

                var offset = Qt.point(player.x, player.y)

                // Determine where we wish to shoot the projectile to
                var realX = gameScene.gameWindowAnchorItem.width
                var ratio = offset.y / offset.x
                var realY = (realX * ratio) + player.y
                var destination = Qt.point(realX, realY)

                // Determine the length of how far we're shooting
                var offReal = Qt.point(realX - player.x, realY - player.y)
                var length = gameScene.width
                var velocity = 480 // speed of the projectile should be 480pt per second
                var realMoveDuration = length / velocity * 1000 // multiply by 1000 because duration of projectile is in milliseconds

                entityManager.createEntityFromComponentWithProperties(playerBullet, {"destination": destination, "moveDuration": realMoveDuration})
            }
            // Pause Game (TODO: Really pause the game)
            // ----------------------------------------------------------------
            else if(event.key === Qt.Key_P){

                if(isPaused === false){
                    isPaused = true
                    pauseScreen.z = 100
                    if(tenSecondCountdown > 0)
                        tenSecondTimer.stop()
                }
            }
            // Resume Game
            // ----------------------------------------------------------------
            else if(event.key === Qt.Key_Space){

                if(isPaused === true){
                    isPaused = false
                    pauseScreen.z = -100
                    if(tenSecondCountdown > 0)
                        tenSecondTimer.start()
                }
            }
        }
    }

    // if the countdown is greater than 0, this timer is triggered every second, decreasing the countdown (until it hits 0 again)
    Timer {
        id: tenSecondTimer
        repeat: true
        running: activeScene === gameScene && tenSecondCountdown >= 0
        onTriggered: {

            tenSecondCountdown--

            if(tenSecondCountdown <= 3 && timeAlarm.z == -1){
                timeAlarm.z = 0
            }
            else if(tenSecondCountdown > 3 && timeAlarm.z == 0){
                timeAlarm.z = -1
            }
            else if(tenSecondCountdown == 0){
                timeAlarm.z = -1
                window.state = "highscore"
            }
        }
    }

    // Add Enemies & PowerUps
    // ----------------------------------------------------------------
    Timer {
      running: activeScene === gameScene
      repeat: true
      interval: 1000
      onTriggered: addTarget() | enemyShot()
    }

    Timer {
      running: activeScene === gameScene
      repeat: true
      interval: 2500
      onTriggered: addPowerUp()
    }

    Timer {
      running: activeScene === gameScene
      repeat: true
      interval: 3000
      onTriggered: addRapidFire()
    }

    function addTarget() {
      entityManager.createEntityFromComponent(enemyShooter)
      entityManager.createEntityFromComponent(mine)
    }

    function addPowerUp(){
        entityManager.createEntityFromComponent(powerup)
    }

    function addRapidFire(){
      entityManager.createEntityFromComponent(rapidfire)
    }

    function enemyShot(){

        console.log("--- ENEMY SHOT ---")
        console.log(enemyBullet.x)

            var offset = Qt.point(enemyShooter.x - 60, enemyShooter.y - 30)

            // Determine where we wish to shoot the projectile to
            var realX = gameScene.gameWindowAnchorItem.width
            var ratio = offset.y / offset.x
            var realY = (realX * ratio) + enemyShooter.y
            var destination = Qt.point(realX, realY)

            // Determine the length of how far we're shooting
            var offReal = Qt.point(realX - enemyShooter.x, realY - enemyShooter.y)
            var length = gameScene.width
            var velocity = 480 // speed of the projectile should be 480pt per second
            var realMoveDuration = length / velocity * 1000 // multiply by 1000 because duration of projectile is in milliseconds

            entityManager.createEntityFromComponentWithProperties(enemyBullet, {"destination": destination, "moveDuration": realMoveDuration})

            //onEntityCreated: console.debug("entity created with id", entityId)

//            var entity = entityManager.getEntityById(enemyShooter)
//            console.log("ENEMY SHOOTER LIST: " + entity)

//            while(entityManager.getEntityArrayByType("enemyShooter")){

//            }
    }
}

