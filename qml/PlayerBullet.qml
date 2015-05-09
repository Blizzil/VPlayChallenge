import VPlay 2.0
import QtQuick 2.0
import "..//qml//scenes"

EntityBase {
  id: playerBullet
  entityType: "projectile"

  Image {
    id: playerBulletImage
    source: "../assets/img/Bullet.png"
    width: 8
    height: 2.5
  }

  property int moveDuration : 1

  PropertyAnimation on x {
    from: player.x
    to: gameScene.width
    duration: moveDuration
  }

  PropertyAnimation on y {
    from: player.y
    to: player.y
    duration: moveDuration
  }

  BoxCollider {
    anchors.fill: playerBulletImage
    collisionTestingOnlyMode: true
  }
}

