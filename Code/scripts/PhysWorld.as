package
{
   import Box2D.Collision.Shapes.b2PolygonShape;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Dynamics.b2Body;
   import Box2D.Dynamics.b2BodyDef;
   import Box2D.Dynamics.b2DebugDraw;
   import Box2D.Dynamics.b2FixtureDef;
   import Box2D.Dynamics.b2World;
   import flash.display.Sprite;
   
   public class PhysWorld extends Sprite
   {
       
      
      public var game:Game;
      
      public var m_world:b2World;
      
      public var m_velocityIterations:int = 10;
      
      public var m_positionIterations:int = 10;
      
      public var m_timeStep:Number = 0.03333333333333333;
      
      private var body:b2Body;
      
      private var bodyDef:b2BodyDef;
      
      private var boxShape:b2PolygonShape;
      
      private var fixtureDef:b2FixtureDef;
      
      public var actors:Array;
      
      public function PhysWorld(_game:Game)
      {
         super();
         this.game = _game;
         this.actors = [];
         this.m_world = new b2World(new b2Vec2(0,10),true);
         if(MatchSettings.useMap.phys == "space")
         {
            this.m_world.SetGravity(new b2Vec2(0,0));
         }
         var debugDraw:b2DebugDraw = new b2DebugDraw();
         debugDraw.SetSprite(this);
         debugDraw.SetDrawScale(30);
         debugDraw.SetFillAlpha(0.3);
         debugDraw.SetLineThickness(1);
         debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
         this.m_world.SetDebugDraw(debugDraw);
      }
      
      public function generateWorld(_boxes:Array) : void
      {
         var _rot:Number = NaN;
         for(var i:uint = 0; i < _boxes.length; i++)
         {
            _rot = _boxes[i].rotation;
            _boxes[i].rotation = 0;
            this.bodyDef = new b2BodyDef();
            this.bodyDef.position.Set(_boxes[i].x / 30,_boxes[i].y / 30);
            this.boxShape = new b2PolygonShape();
            this.boxShape.SetAsBox(_boxes[i].width / 60,_boxes[i].height / 60);
            this.bodyDef.angle = _rot / (180 / Math.PI);
            this.fixtureDef = new b2FixtureDef();
            this.fixtureDef.shape = this.boxShape;
            this.fixtureDef.friction = 0.3;
            this.fixtureDef.density = 0;
            this.body = this.m_world.CreateBody(this.bodyDef);
            this.body.CreateFixture(this.fixtureDef);
            _boxes[i].rotation = _rot;
         }
      }
      
      public function createCorpse(_corpse:Unit, _killer:Unit, _weapon:Stats_Guns, _extra:*) : PhysActor
      {
         var shotRot:Number = NaN;
         var actor:PhysActor = new PhysActor(this,_corpse,_killer,_weapon,_extra);
         this.actors.push(actor);
         actor.impulseAll();
         actor.impulseBody(new b2Vec2(_corpse.mov.xVel,_corpse.mov.yVel));
         var force:Number = _weapon.force;
         if(MatchSettings.useMod == "sky9")
         {
            force += 40;
            if(force > 80)
            {
               force = 80;
            }
         }
         if(force)
         {
            if(_weapon.splash)
            {
               if(_extra.hitX == _corpse.x && _extra.hitY == _corpse.y)
               {
                  ++_extra.hitY;
               }
               shotRot = UT.getRotation(_extra.hitX,_extra.hitY,_corpse.x,_corpse.y - 40);
            }
            else
            {
               if(_killer.x == _corpse.x && _killer.y == _corpse.y)
               {
                  _corpse.y -= 5;
               }
               shotRot = UT.getRotation(_killer.x,_killer.y,_corpse.x,_corpse.y);
            }
            if(isNaN(shotRot))
            {
               shotRot = 0;
            }
            actor.impulseBody(new b2Vec2(UT.xMoveToRot(shotRot,force),UT.yMoveToRot(shotRot,force)));
         }
         if(_extra.headMult)
         {
            if(_killer.x == _corpse.x && _killer.y == _corpse.y - 10)
            {
               --_corpse.y;
            }
            shotRot = UT.getRotation(_killer.x,_killer.y,_corpse.x,_corpse.y - 10);
            if(isNaN(shotRot))
            {
               shotRot = 0;
            }
            actor.impulseHead(new b2Vec2(UT.xMoveToRot(shotRot,8),UT.yMoveToRot(shotRot,8)));
         }
         return actor;
      }
      
      public function hitCorpse(_corpse:PhysActor, _shooter:Unit, _weapon:Stats_Guns, _extra:*) : void
      {
         var shotRot:Number = NaN;
         _corpse.impulseAll(null,-0.5,0.5);
         var force:Number = _weapon.force;
         if(MatchSettings.useMod == "sky9")
         {
            force *= 1.5;
         }
         if(force)
         {
            if(_weapon.splash)
            {
               if(_extra.hitX == _corpse.rdBody.GetDefinition().userData.x && _extra.hitY == _corpse.rdBody.GetDefinition().userData.y)
               {
                  ++_extra.hitY;
               }
               shotRot = UT.getRotation(_extra.hitX,_extra.hitY,_corpse.rdBody.GetDefinition().userData.x,_corpse.rdBody.GetDefinition().userData.y - 40);
            }
            else
            {
               if(_shooter.x == _corpse.rdBody.GetDefinition().userData.x && _shooter.y == _corpse.rdBody.GetDefinition().userData.y)
               {
                  --_corpse.rdBody.GetDefinition().userData.y;
               }
               shotRot = UT.getRotation(_shooter.x,_shooter.y,_corpse.rdBody.GetDefinition().userData.x,_corpse.rdBody.GetDefinition().userData.y);
            }
            if(isNaN(shotRot))
            {
               shotRot = 0;
            }
            _corpse.impulseBody(new b2Vec2(UT.xMoveToRot(shotRot,force),UT.yMoveToRot(shotRot,force)));
         }
      }
      
      public function EnterFrame() : void
      {
         var sprite:Sprite = null;
         this.m_world.Step(this.m_timeStep,this.m_velocityIterations,this.m_positionIterations);
         var bb:b2Body = this.m_world.GetBodyList();
         while(bb)
         {
            if(bb.GetUserData() is Sprite)
            {
               sprite = bb.GetUserData() as Sprite;
               sprite.x = bb.GetPosition().x * 30;
               sprite.y = bb.GetPosition().y * 30;
               sprite.rotation = bb.GetAngle() * (180 / Math.PI);
            }
            bb = bb.GetNext();
         }
         for(var i:uint = 0; i < this.actors.length; this.actors[i].EnterFrame(),i++)
         {
         }
      }
      
      public function destroy() : void
      {
      }
   }
}
