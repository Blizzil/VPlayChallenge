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

  BoxCollider {
      id: playerBoxCollider
      width: 32; height: 12
      categories: Box.Category1
      collidesWith: Box.Category2 | Box.Category3 | Box.Category4

//      fixture.onBeginContact: {

//          var collidedEntity = other.parent.parent.parent
//          console.debug("collided with entity", collidedEntity.entityType)

//          if(collidedEntity.entityType === "mine" || collidedEntity.entityType === "enemyBullet" ||
//                  collidedEntity.entityType ==="enemyShooter") {
//               tenSecondCountdown-=2
//          }
//       }
  }
}
