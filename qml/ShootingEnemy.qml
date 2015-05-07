import VPlay 2.0
import QtQuick 2.0

EntityBase {
  id: enemyShooter
  entityType: "enemy"

  Image {
    id: enemyPlane
    //anchors.centerIn: parent
    source: "../assets/img/enemyShooting.png"
    width: 30
    height: 16
  }

  BoxCollider {
    anchors.fill: enemyPlane
    //collisionTestingOnlyMode: true // use Box2D only for collision detection, move the entity with the NumberAnimation above
    categories: Box.Category2
    collidesWith: Box.Category1


//      // if the collided type was a projectile, both can be destroyed and the player gets a point
//      var collidedEntity = other.parent.parent.parent
//      console.debug("collided with entity", collidedEntity.entityType)
//      // monsters could also collide with other monsters because they have a random speed - alternatively, collider categories could be used
//      if(collidedEntity.entityType === "projectile") {
//        monstersDestroyed++
//        // remove the projectile entity
//        collidedEntity.removeEntity()
//        // remove the monster
//        removeEntity()
//      }
  }

}
