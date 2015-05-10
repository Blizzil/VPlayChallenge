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

  y: utils.generateRandomValueBetween(42, gameScene.height-30) // y is random and stays the same

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
}
