import VPlay 2.0
import QtQuick 2.0

EntityBase {
  id: mine
  entityType: "enemy"

  Image {
    id: mineImage
    //anchors.centerIn: parent
    source: "../assets/img/Mine.png"
    width: 16
    height: 16
  }

  BoxCollider {
    id: mineCollider
    anchors.fill: mineImage
    categories: Box.Category2
    collidesWith: Box.Category1
  }

  // Movement:
  // --------------------------------------------------------------

  y: utils.generateRandomValueBetween(42, gameScene.height-30) // y is random and stays the same

  NumberAnimation on x{
    from: gameScene.width // start at the right side
    to: -mineImage.width // move it to the left side of the screen
    duration: utils.generateRandomValueBetween(2000, 4000) // vary animation duration between 2-4 seconds for the 480 px scene width
  }
}
