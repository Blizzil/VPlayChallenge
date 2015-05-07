import VPlay 2.0
import QtQuick 2.0

EntityBase {
  id: player
  entityType: "player"

  Image {
    id: plane
    //anchors.centerIn: parent
    source: "../assets/img/Player.png"
    width: 32
    height: 12
  }

}
