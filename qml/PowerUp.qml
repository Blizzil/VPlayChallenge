import VPlay 2.0
import QtQuick 2.0

EntityBase {
  id: powerup
  entityType: "powerup"

  Image {
    id: powerupImage
    //anchors.centerIn: parent
    source: "../assets/img/PowerUp.png"
    width: 13
    height: 13
  }

  BoxCollider {
    id:powerupCollider
    anchors.fill: powerup
    categories: Box.Category4
    collidesWith: Box.Category1

//    fixture.onBeginContact: {

//        var collidedEntity = other.parent.parent.parent
//        console.debug("collided with entity", collidedEntity.entityType)

//        if(collidedEntity.entityType === "player") {
//          tenSecondCountdown+=3 // increase time limit
//          removeEntity() // remove the powerUp
//        }
//     }
  }

  // Movement:
  // --------------------------------------------------------------

  y: utils.generateRandomValueBetween(42, gameScene.height-30)

  NumberAnimation on x{
    from: gameScene.width // start at the right side
    to: -powerupImage.width // move it to the left side of the screen
    duration: utils.generateRandomValueBetween(2000, 4000) // vary animation duration between 2-4 seconds for the 480 px scene width
  }
}
