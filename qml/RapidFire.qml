import VPlay 2.0
import QtQuick 2.0

EntityBase {
  id: rapidfire
  entityType: "powerup"

  Image {
    id: rapidfireImage
    //anchors.centerIn: parent
    source: "../assets/img/RapidFire.png"
    width: 21
    height: 22
  }

  BoxCollider {
    id: rapdidfireCollider
    anchors.fill: rapidfire
    categories: Box.Category4
    collidesWith: Box.Category1
  }

  // Movement:
  // --------------------------------------------------------------

  y: utils.generateRandomValueBetween(42, gameScene.height-30)

  NumberAnimation on x{
    from: gameScene.width // start at the right side
    to: -rapidfireImage.width // move it to the left side of the screen
    duration: utils.generateRandomValueBetween(2000, 4000) // vary animation duration between 2-4 seconds for the 480 px scene width
  }
}
