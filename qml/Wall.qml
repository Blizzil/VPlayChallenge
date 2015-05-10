import QtQuick 2.0
import VPlay 2.0

// For the level boundaries (prevent player from leaving the screen)

EntityBase {
  entityType: "wall"
  width: 1
  height: 1

  BoxCollider {
    anchors.fill: parent
    bodyType: Body.Static
    categories: Box.Category3
    collidesWith: Box.Category1
  }
}
