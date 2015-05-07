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
}
