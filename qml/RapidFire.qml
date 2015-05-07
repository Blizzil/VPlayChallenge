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
}
