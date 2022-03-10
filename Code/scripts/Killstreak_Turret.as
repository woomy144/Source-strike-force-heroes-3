package
{
   public class Killstreak_Turret extends Killstreak
   {
       
      
      private var sub:String;
      
      private var followSpd:Number;
      
      private var rot:Number;
      
      public var mov:Movement;
      
      private var yVel:Number = 0;
      
      private var active:Boolean;
      
      private var laserX:Number;
      
      private var laserY:Number;
      
      public function Killstreak_Turret(_game:Game, _unit:*, _timer:uint, _id:String)
      {
         super(_game,_unit,_timer,_id,true);
         if(unit.unitInfo.extra.permaStreak)
         {
            timer = 9999999;
         }
         if(_id == "turret")
         {
            MC = new Turret();
         }
         if(_id == "sentry")
         {
            MC = new Sentry();
         }
         game.unitCont.addChild(MC);
         MC.x = x = unit.x;
         MC.y = y = unit.y;
         setText(MC);
         this.followSpd = UT.rand(0.2,0.4);
         shootTimer = UT.irand(0,25);
         this.rot = 0;
         this.mov = new Movement(null);
         this.active = false;
         this.laserX = x;
         this.laserY = y - 40;
      }
      
      public function EnterFrame() : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:Number = NaN;
         if(!this.active)
         {
            this.yVel += 1;
            if(this.yVel > 25)
            {
               this.yVel = 25;
            }
            y += this.yVel;
            if(hitTestWall(0,2))
            {
               while(hitTestWall(0,2))
               {
                  y = y - 1;
               }
               this.active = true;
               MC.gotoAndPlay(2);
               game.playScreenSound(S_Deploy,x,y);
            }
            MC.y = y;
            return;
         }
         ++fc;
         if(fc < 33)
         {
            return;
         }
         ++shootTimer;
         if(fc % 20 == 0)
         {
            _loc2_ = [];
            for(_loc3_ = 0; _loc3_ < game.units.length; _loc3_++)
            {
               if(game.units[_loc3_] != unit)
               {
                  if(!game.units[_loc3_].dead)
                  {
                     if(!(unit.team && unit.team == game.units[_loc3_].team))
                     {
                        if(game.units[_loc3_].status.sInvis != 1)
                        {
                           if(!game.units[_loc3_].status.sSpawn)
                           {
                              _loc5_ = UT.getDist(x,y,game.units[_loc3_].x,game.units[_loc3_].y);
                              if(_loc5_ < gun.range * 10)
                              {
                                 _loc2_.push({
                                    "dist":_loc5_,
                                    "unit":game.units[_loc3_],
                                    "rot":UT.getRotation(x,y,game.units[_loc3_].x,game.units[_loc3_].y)
                                 });
                              }
                           }
                        }
                     }
                  }
               }
            }
            for(_loc3_ = 0; _loc3_ < _loc2_.length; _loc3_++)
            {
               _loc4_ = true;
               _loc6_ = 0;
               while(_loc4_ && _loc6_ < _loc2_[_loc3_].dist)
               {
                  if(hitTestWall(UT.xMoveToRot(_loc2_[_loc3_].rot,_loc6_),UT.yMoveToRot(_loc2_[_loc3_].rot,_loc6_) - 40))
                  {
                     _loc4_ = false;
                  }
                  _loc6_ += 20;
               }
               if(!_loc4_)
               {
                  _loc2_.splice(_loc3_,1);
                  _loc3_--;
               }
            }
            if(_loc2_.length)
            {
               _loc2_.sortOn("dist",Array.NUMERIC);
               target = _loc2_[0].unit;
            }
            else
            {
               target = null;
               this.laserX = x;
               this.laserY = y - 40;
            }
         }
         if(target)
         {
            this.laserX += (target.x - this.laserX) * 0.5;
            this.laserY += (target.y - 40 - this.laserY) * 0.5;
            game.lineCont.graphics.lineStyle(1,16711680,0.5);
            game.lineCont.graphics.moveTo(x,y - 40);
            game.lineCont.graphics.lineTo(this.laserX,this.laserY);
            _loc7_ = UT.getRotation(x,y - 40,target.x,target.y - 35);
            if(Math.abs(this.rot - _loc7_) > 5)
            {
               this.rot += UT.rotateDirection(this.rot,_loc7_) * 6;
            }
            else
            {
               this.rot = _loc7_;
            }
            if(target.dead || UT.getDist(x,y,target.x,target.y) > gun.range * 10)
            {
               target = null;
            }
         }
         else
         {
            this.laserX += (x - this.laserX) * 0.7;
            this.laserY += (y - 40 - this.laserY) * 0.7;
         }
         MC.head.rotation = this.rot;
         var _loc1_:Number = gun.shootDelay;
         if(unit.unitInfo.skills.turret1)
         {
            _loc1_ *= unit.unitInfo.skills.turret1;
         }
         if(target && shootTimer > _loc1_)
         {
            shootTimer = 0;
            game.playScreenSound(gun.shotSound,x,y);
            if(gun.multiShots)
            {
               for(_loc3_ = 0; _loc3_ < gun.multiShots; game.bullets.push(new gun.cls(game,unit,this.rot + UT.rand(-5,5),x,y - 40,5,gun,{"noUnit":true})),_loc3_++)
               {
               }
            }
            else
            {
               game.bullets.push(new gun.cls(game,unit,this.rot + UT.rand(-5,5),x,y - 40,5,gun,{"noUnit":true}));
            }
            MC.head.gotoAndPlay(2);
            unit.game.createParticle(x,y + MC.head.y,"shell",0,{
               "rot":MC.head.rotation - 90,
               "flip":false
            },"shell",gun.effShell);
         }
         if(unit.dead || fc >= timer)
         {
            this.end();
         }
      }
      
      override public function end(_forceEnd:Boolean = true) : void
      {
         if(_forceEnd)
         {
            unit.endKillstreak();
         }
         if(MC)
         {
            game.unitCont.removeChild(MC);
         }
         game.killstreaks.splice(game.killstreaks.indexOf(this),1);
         game.createEffect(x,y - 20,"explosionSmall");
         game.playScreenSound(S_rocketExplode,x,y);
      }
   }
}
