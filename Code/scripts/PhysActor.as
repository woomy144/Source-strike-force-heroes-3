package
{
   import Box2D.Collision.Shapes.b2CircleShape;
   import Box2D.Collision.Shapes.b2PolygonShape;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.b2Settings;
   import Box2D.Dynamics.Joints.b2RevoluteJointDef;
   import Box2D.Dynamics.b2Body;
   import Box2D.Dynamics.b2BodyDef;
   import Box2D.Dynamics.b2FixtureDef;
   import flash.display.MovieClip;
   
   public class PhysActor
   {
       
      
      private var physWorld:PhysWorld;
      
      public var unit:Unit;
      
      private var weapon:Stats_Guns;
      
      public var x:Number;
      
      public var y:Number;
      
      private var body:b2Body;
      
      private var bodyDef:b2BodyDef;
      
      private var boxShape:b2PolygonShape;
      
      private var circleShape:b2CircleShape;
      
      private var fixtureDef:b2FixtureDef;
      
      private var curHead:uint;
      
      private var curHair:uint;
      
      private var curFace:uint;
      
      private var curBody:uint;
      
      private var curSkin:uint;
      
      public var parts:Array;
      
      public var rdBody:b2Body;
      
      public var rdHead:b2Body;
      
      public var rdLeg1:b2Body;
      
      private var physMod:String;
      
      private var evaporate:Boolean;
      
      private var alpha:Number = 1;
      
      public var flip:int;
      
      private var scale:Number;
      
      public var fc:uint = 0;
      
      public function PhysActor(_physWorld:PhysWorld, _unit:Unit, _killer:Unit, _weapon:Stats_Guns, _extra:Object)
      {
         super();
         this.physWorld = _physWorld;
         this.unit = _unit;
         this.weapon = _weapon;
         this.x = this.unit.x;
         this.y = this.unit.y - 40;
         this.scale = this.unit.scale;
         this.physMod = MatchSettings.useMap.phys;
         this.flip = this.unit.MC.scaleX > 0 ? 1 : -1;
         this.parts = [];
         this.curHead = this.unit.unitInfo.head + this.unit.unitInfo.color - 1;
         this.curHair = this.unit.unitInfo.hair;
         this.curFace = this.unit.unitInfo.face;
         this.curBody = this.unit.unitInfo.body + this.unit.unitInfo.color - 1;
         this.curSkin = this.unit.unitInfo.skin;
         this.fixtureDef = new b2FixtureDef();
         var body:b2Body = this.createPart(0,0,0.1,24,36,PhysBody,true);
         var head:b2Body = this.createPart(5,-16,0.05,24,24,PhysHead,false);
         this.createJoint(body,head,this.createVec(2,-5),-0.1,0.03);
         var legUp1:b2Body = this.createPart(-14,22,0,13,26,PhysUpperLeg,true);
         this.createJoint(body,legUp1,this.createVec(-14,16),-0.5,0.2);
         var legLow1:b2Body = this.createPart(-14,39,0,11,22,PhysLowerLeg,true);
         this.createJoint(legUp1,legLow1,this.createVec(-14,39 - 10),0,0.5);
         var foot1:b2Body = this.createPart(-10,47,0,17,7,PhysFoot,true);
         this.createJoint(legLow1,foot1,this.createVec(-10 - 4,47),-0.1,0.2);
         var legUp2:b2Body = this.createPart(-5,22,0,13,26,PhysUpperLeg,true);
         this.createJoint(body,legUp2,this.createVec(-5,16),-0.5,0.2);
         var legLow2:b2Body = this.createPart(-5,39,0,11,22,PhysLowerLeg,true);
         this.createJoint(legUp2,legLow2,this.createVec(-5,39 - 10),0,0.5);
         var foot2:b2Body = this.createPart(-1,47,0,17,7,PhysFoot,true);
         this.createJoint(legLow2,foot2,this.createVec(-1 - 4,47),-0.1,0.2);
         var armUp1:b2Body = this.createPart(-1,-3,-0.2,10,17,PhysUpperArm,true);
         this.createJoint(body,armUp1,this.createVec(-1,-4),0,0);
         var armLow1:b2Body = this.createPart(9,4,-0.5,9,17,PhysLowerArm,true);
         this.createJoint(armUp1,armLow1,this.createVec(7,4),-0.4,0.3);
         var hand1:b2Body = this.createPart(20,4,0,10,10,PhysHand,false);
         this.createJoint(armLow1,hand1,this.createVec(17,4),-0.2,0.2);
         var armUp2:b2Body = this.createPart(-1,-3,-0.2,10,17,PhysUpperArm,true);
         this.createJoint(body,armUp2,this.createVec(-1,-4),0,0);
         var armLow2:b2Body = this.createPart(9,4,-0.5,8,17,PhysLowerArm,true);
         this.createJoint(armUp2,armLow2,this.createVec(7,4),-0.4,0.3);
         var hand2:b2Body = this.createPart(20,4,0,10,10,PhysHand,false);
         this.createJoint(armLow2,hand2,this.createVec(17,4),-0.2,0.2);
         this.parts.push(armUp2,armLow2,hand2);
         this.parts.push(legLow2,legUp2,foot2);
         this.parts.push(body);
         this.parts.push(head);
         this.parts.push(legLow1,legUp1,foot1);
         this.parts.push(armUp1,armLow1,hand1);
         this.rdBody = body;
         this.rdHead = head;
         this.rdLeg1 = legUp1;
         var uneqiup:String = this.unit.gun.otherGun.unequip;
         if(uneqiup == "body")
         {
            uneqiup = "rdBody";
         }
         if(uneqiup == "legup1")
         {
            uneqiup = "rdLeg1";
         }
         var gunMC:MovieClip = this[uneqiup].GetDefinition().userData.gun;
         gunMC.visible = true;
         gunMC.gotoAndStop(this.unit.gun.otherGun.sprite);
         if(gunMC.clip)
         {
            gunMC.clip.gotoAndStop(this.unit.gun.otherGun.sprite);
         }
         if(gunMC.part)
         {
            gunMC.part.gotoAndStop(this.unit.gun.otherGun.sprite);
         }
         for(var i:uint = 0; i < this.parts.length; i++)
         {
            this.physWorld.addChild(this.parts[i].GetDefinition().userData);
         }
         if(this.physMod == "canyon")
         {
            this.forceAll(-2,0);
         }
         if(this.physMod == "frigate")
         {
            this.forceAll(-1,-1);
         }
      }
      
      public function EnterFrame() : void
      {
         ++this.fc;
         this.x = this.rdBody.GetDefinition().userData.x;
         this.y = this.rdBody.GetDefinition().userData.y;
         if(this.physMod == "frigate" && this.y > 1030)
         {
            this.physMod = "";
            this.forceAll(-8,4);
            this.impulseAll(new b2Vec2(-5,1));
         }
         if(MatchSettings.useMap.map == "gorge" && this.unit.human && UT.inBox(this.x,this.y,300,-1000,130,1060))
         {
            Stats_Achievements.setAchievement("secret1");
         }
         if(this.fc == 5 * 30)
         {
            this.physWorld.actors.splice(this.physWorld.actors.indexOf(this),1);
            this.destroy();
         }
      }
      
      public function destroy() : void
      {
         for(var i:uint = 0; i < this.parts.length; i++)
         {
            this.physWorld.removeChild(this.parts[i].GetDefinition().userData);
            this.physWorld.m_world.DestroyBody(this.parts[i]);
         }
      }
      
      public function impulseBody(_force:b2Vec2) : void
      {
         this.rdBody.ApplyImpulse(_force,this.rdBody.GetWorldCenter());
      }
      
      public function impulseHead(_force:b2Vec2) : void
      {
         this.rdHead.ApplyImpulse(_force,this.rdBody.GetWorldCenter());
      }
      
      public function impulseAll(_force:b2Vec2 = null, min:Number = -1, max:Number = 1) : void
      {
         for(var i:uint = 0; i < this.parts.length; i++)
         {
            if(_force)
            {
               this.parts[i].ApplyImpulse(_force,this.parts[i].GetWorldCenter());
            }
            else
            {
               this.parts[i].ApplyImpulse(new b2Vec2(UT.rand(min,max),UT.rand(min,max)),this.parts[i].GetWorldCenter());
            }
         }
      }
      
      public function forceAll(_x:Number, _y:Number) : void
      {
         for(var i:uint = 0; i < this.parts.length; i++)
         {
            this.parts[i].ApplyForce(new b2Vec2(_x,_y),this.parts[i].GetWorldCenter());
         }
      }
      
      public function createVec(_x:Number, _y:Number) : b2Vec2
      {
         return new b2Vec2((this.x + _x * this.flip) / 30,(this.y + _y) / 30);
      }
      
      public function createJoint(_baseBod:b2Body, _attchBod:b2Body, _joint:b2Vec2, _lowAng:Number, _highAng:Number) : void
      {
         var holdAng:Number = NaN;
         if(MatchSettings.useMod == "bodypop")
         {
            return;
         }
         if((Math.random() < this.weapon.bodBreak || this.unit.status.sFrozen) && SD.blood == 2)
         {
            return;
         }
         if(this.flip == -1)
         {
            holdAng = _lowAng;
            _lowAng = _highAng * this.flip;
            _highAng = holdAng * this.flip;
         }
         var jointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
         jointDef.Initialize(_baseBod,_attchBod,_joint);
         jointDef.lowerAngle = _lowAng * b2Settings.b2_pi;
         jointDef.upperAngle = _highAng * b2Settings.b2_pi;
         jointDef.enableLimit = _lowAng || _highAng;
         jointDef.maxMotorTorque = 0.02;
         jointDef.motorSpeed = 0;
         jointDef.enableMotor = true;
         this.physWorld.m_world.CreateJoint(jointDef);
      }
      
      public function createPart(_xPos:Number, _yPos:Number, _rot:Number, _width:Number, _height:Number, _part:*, _isBox:Boolean) : b2Body
      {
         _xPos *= this.scale;
         _yPos *= this.scale;
         _xPos *= this.flip;
         _rot *= this.flip;
         _xPos += this.x;
         _yPos += this.y;
         this.bodyDef = new b2BodyDef();
         this.bodyDef.type = b2Body.b2_dynamicBody;
         this.bodyDef.position.x = _xPos / 30;
         this.bodyDef.position.y = _yPos / 30;
         this.bodyDef.angle = _rot * b2Settings.b2_pi;
         var part:* = new _part();
         if(part is PhysHead)
         {
            part.gotoAndStop(this.curHead);
            if(part.face)
            {
               part.face.gotoAndStop(this.curFace);
               part.face.skin.gotoAndStop(this.curSkin);
            }
            if(part.hair)
            {
               part.hair.gotoAndStop(this.curHair);
            }
         }
         else
         {
            part.gotoAndStop(this.curBody);
         }
         if(part.skin)
         {
            part.skin.gotoAndStop(this.curSkin);
         }
         if(part.part)
         {
            part.part.gotoAndStop(this.curSkin);
         }
         if(part.gun)
         {
            part.gun.visible = false;
         }
         part.scaleX = part.scaleY = this.scale;
         part.scaleX *= this.flip;
         if(_isBox)
         {
            this.boxShape = new b2PolygonShape();
            this.boxShape.SetAsBox(_width / 60,_height / 60);
            this.fixtureDef.shape = this.boxShape;
         }
         else
         {
            this.circleShape = new b2CircleShape(_width / 60);
            this.fixtureDef.shape = this.circleShape;
         }
         if(_part is PhysBody)
         {
            this.fixtureDef.density = 1.5;
         }
         else
         {
            this.fixtureDef.density = 1;
         }
         this.fixtureDef.friction = 0.5;
         this.fixtureDef.restitution = 0.2;
         this.fixtureDef.filter.groupIndex = -1;
         this.bodyDef.userData = part;
         this.bodyDef.userData.rotation = _rot * 360;
         this.bodyDef.userData.x = _xPos;
         this.bodyDef.userData.y = _yPos;
         var b2body:b2Body = this.physWorld.m_world.CreateBody(this.bodyDef);
         b2body.CreateFixture(this.fixtureDef);
         return b2body;
      }
   }
}
