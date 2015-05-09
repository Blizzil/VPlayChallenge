import VPlay 2.0
import QtQuick 2.0

EntityBase {
  id: enemyShooter
  entityType: "enemy"

  Image {
    id: enemyPlaneImage
    //anchors.centerIn: parent
    source: "../assets/img/enemyShooting.png"
    width: 30
    height: 16
  }

  // Movement:
  // --------------------------------------------------------------

  y: utils.generateRandomValueBetween(42, gameScene.height-30)

  NumberAnimation on x{
    from: gameScene.width // start at the right side
    to: -enemyPlaneImage.width // move it to the left side of the screen
    duration: utils.generateRandomValueBetween(2000, 4000) // vary animation duration between 2-4 seconds for the 480 px scene width
  }

  BoxCollider {
    id:enemyShooterBoxCollider
    anchors.fill: enemyPlaneImage
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
