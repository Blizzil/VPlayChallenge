import VPlay 2.0
import QtQuick 2.0
import "../qml"

EntityBase {
  id: enemyShooter
  entityType: "enemy"

  Image {
    id: enemyPlaneImage
    //anchors.centerIn: parent
    source: "../assets/img/enemyShooting.png"
    width: 30
    height: 16
  }

  // Movement:
  // --------------------------------------------------------------

  y: utils.generateRandomValueBetween(42, gameScene.height-30)

  NumberAnimation on x{
    from: gameScene.width // start at the right side
    to: -enemyPlaneImage.width // move it to the left side of the screen
    duration: utils.generateRandomValueBetween(2000, 4000) // vary animation duration between 2-4 seconds for the 480 px scene width
  }

  BoxCollider {
    id:enemyShooterBoxCollider
    anchors.fill: enemyPlaneImage
    //collisionTestingOnlyMode: true // use Box2D only for collision detection, move the entity with the NumberAnimation above
    categories: Box.Category2
    collidesWith: Box.Category1
  }

//  // Shooting:
//  // --------------------------------------------------------------

//  Timer {
//    running: gameScene.visible == true
//    repeat: true
//    interval: 1000
//    onTriggered: enemyShot()
//  }

//  function enemyShot(){

//      console.log("--- ENEMY SHOT ---")

//          var offset = Qt.point(enemyShooter.x - 60, enemyShooter.y - 30)

//          // Determine where we wish to shoot the projectile to
//          var realX = gameScene.gameWindowAnchorItem.width
//          var ratio = offset.y / offset.x
//          var realY = (realX * ratio) + enemyShooter.y
//          var destination = Qt.point(realX, realY)

//          // Determine the length of how far we're shooting
//          var offReal = Qt.point(realX - enemyShooter.x, realY - enemyShooter.y)
//          var length = gameScene.width
//          var velocity = 480 // speed of the projectile should be 480pt per second
//          var realMoveDuration = length / velocity * 1000 // multiply by 1000 because duration of projectile is in milliseconds

//          entityManager.createEntityFromComponentWithProperties(enemyBullet, {"destination": destination, "moveDuration": realMoveDuration})
//  }
}
