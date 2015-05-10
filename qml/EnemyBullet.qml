import VPlay 2.0
import QtQuick 2.0
import "..//qml//scenes"

EntityBase {
  id: enemyBullet
  entityType: "projectile"

  Image {
    id: enemyBulletImage
    source: "../assets/img/EnemyBullet.png"
    width: 8
    height: 2.5
  }

  property int moveDuration : 1

//  PropertyAnimation on x {
//    from: enemyShooter.x
//    to: -enemyBulletImage.width
//    duration: moveDuration
//  }

//  y : enemyShooter.y

  BoxCollider {
    anchors.fill: enemyBulletImage
    collisionTestingOnlyMode: true
  }
}

