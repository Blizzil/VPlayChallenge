import QtQuick 2.0
import VPlay 2.0

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
