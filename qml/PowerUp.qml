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
  }
}
