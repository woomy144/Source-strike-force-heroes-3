package
{
   public class Bullet
   {
       
      
      protected var game:Game;
      
      protected var unit:Unit;
      
      protected var stats:Stats_Guns;
      
      public var remove:Boolean;
      
      protected var rotation:Number;
      
      protected var x:Number;
      
      protected var y:Number;
      
      protected var ox:Number;
      
      protected var oy:Number;
      
      protected var xVel:Number;
      
      protected var yVel:Number;
      
      private var isProjectile:Boolean;
      
      protected var hitType:String;
      
      protected var hitObject;
      
      protected var curDist:Number;
      
      protected var maxDist:Number;
      
      protected var dmgMod:Number;
      
      protected var extra:Object;
      
      public function Bullet(_game:Game, _unit:Unit, _rotation:Number, _x:Number, _y:Number, _dist:uint, _gun:Stats_Guns, _isProjectile:Boolean, _extra:Object = null)
      {
         var i:uint = 0;
         super();
         this.game = _game;
         this.unit = _unit;
         if(_extra)
         {
            this.extra = _extra;
         }
         else
         {
            this.extra = {};
         }
         this.dmgMod = !!this.extra.dmgMod ? Number(this.extra.dmgMod) : Number(1);
         this.stats = _gun;
         this.isProjectile = _isProjectile;
         this.curDist = 0;
         this.maxDist = (!!this.extra.range ? this.extra.range : this.stats.range) + UT.irand(-3,3);
         this.maxDist *= 10;
         if(this.extra.noMove)
         {
            this.xVel = 0;
            this.yVel = 0;
         }
         else
         {
            this.rotation = _rotation;
            if(!this.extra.noUnit)
            {
               this.x = _x + UT.xMoveToRot(this.rotation + 90 * (this.unit.MC.scaleX > 0 ? 1 : -1),this.stats.yOff * this.unit.scale);
               this.y = _y + UT.yMoveToRot(this.rotation + 90 * (this.unit.MC.scaleX > 0 ? 1 : -1),this.stats.yOff * this.unit.scale);
            }
            else
            {
               this.x = _x;
               this.y = _y;
            }
            this.xVel = UT.xMoveToRot(this.rotation,10);
            this.yVel = UT.yMoveToRot(this.rotation,10);
            for(i = 0; i <= _dist; i++)
            {
               this.x += this.xVel * 0.5;
               this.y += this.yVel * 0.5;
               if(this.hitObject = this.hitTestAll())
               {
                  break;
               }
            }
         }
         this.ox = this.x;
         this.oy = this.y;
         if(this.stats.effShoot)
         {
            this.game.createEffect(this.ox,this.oy,this.stats.effShoot);
         }
      }
      
      protected function doHitEffect(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Number = NaN;
         var _loc4_:* = undefined;
         if(!this.hitType)
         {
            if(!param1)
            {
               return;
            }
            this.hitType = "wall";
         }
         if(this.hitType && this.stats.extra.bounceShots)
         {
            if(this.hitType == "unit")
            {
               this.hitObject.status.damage(this.stats.dmg * this.dmgMod,this.unit,this.stats,this.extra);
            }
            this.x -= this.xVel * 3;
            this.y -= this.yVel * 3;
            for(_loc2_ = 0; _loc2_ < this.stats.extra.bounceShots; this.unit.game.bullets.push(new Stats_Guns.itemOb["bouncer"].cls(this.unit.game,this.unit,UT.rand(0,360),this.x,this.y,0,"bouncer")),_loc2_++)
            {
            }
            if(this.isProjectile)
            {
               this.removeMe();
            }
            return;
         }
         if(this.hitType == "unit")
         {
            if(!this.stats.isMelee && (this.hitObject.status.sReflect || this.hitObject.unitInfo.skills.deflect && Math.random() < this.hitObject.unitInfo.skills.deflect))
            {
               _loc3_ = this.hitObject.aimRoation - UT.getRotation(this.hitObject.x,this.hitObject.y,this.x,this.y);
               if(Math.abs(_loc3_) < 100)
               {
                  if(this.extra.reflect)
                  {
                     return;
                  }
                  _loc4_ = UT.rotBounceOff(this.rotation,this.x - this.xVel * 10,this.y - this.yVel * 10,this.hitObject.x,this.hitObject.y - 10);
                  this.unit.game.bullets.push(new this.stats.cls(this.unit.game,this.hitObject,_loc4_ + UT.rand(-10,10),this.x,this.y,0,this.stats,{"reflect":this.unit}));
                  if(this.isProjectile)
                  {
                     this.removeMe();
                  }
                  this.game.playScreenSound(UT.randEl([S_Reflect1,S_Reflect2,S_Reflect3]),this.x,this.y);
                  this.game.createEffect(this.x,this.y,"bulletspark");
               }
            }
            if(!this.hitObject.status.sSpawn && !this.stats.noBlood)
            {
               if(this.extra.shielded || this.hitObject.status.arCur)
               {
                  this.game.createEffect(this.x,this.y,"bulletspark");
               }
               else if(SD.blood)
               {
                  this.game.createEffect(this.x,this.y,"bloodmist");
               }
            }
            if(this.isProjectile)
            {
               this.x -= this.xVel;
               this.y -= this.yVel;
               if(!this.stats.extra.pierce)
               {
                  this.removeMe();
               }
            }
            else
            {
               this.x -= this.xVel * 0.5;
               this.y -= this.yVel * 0.5;
            }
            if(this.stats.effHit)
            {
               this.game.createEffect(this.x,this.y,this.stats.effHit);
            }
            if(this.stats.splash)
            {
               this.extra.hitX = this.x;
               this.extra.hitY = this.y;
            }
            this.hitObject.status.damage(this.stats.dmg * this.dmgMod,this.unit,this.stats,this.extra);
         }
         if(this.hitType == "corpse")
         {
            if(SD.blood)
            {
               this.game.createEffect(this.x,this.y,"bloodmist");
            }
            if(this.isProjectile)
            {
               this.x -= this.xVel;
               this.y -= this.yVel;
               if(!this.stats.extra.pierce)
               {
                  this.removeMe();
               }
            }
            if(this.stats.effHit)
            {
               this.game.createEffect(this.x,this.y,this.stats.effHit);
            }
            if(this.stats.splash)
            {
               this.extra.hitX = this.x;
               this.extra.hitY = this.y;
            }
            this.game.physWorld.hitCorpse(this.hitObject,this.unit,this.stats,this.extra);
         }
         if(this.hitType == "wall")
         {
            if(this.isProjectile)
            {
               this.x -= this.xVel;
               this.y -= this.yVel;
               if(!this.stats.extra.burrow)
               {
                  this.removeMe();
               }
               else
               {
                  this.extra.burrowMult = 2;
                  this.yVel -= this.stats.params[2] * 0.1;
               }
            }
            if(!this.stats.extra.burrow)
            {
               if(this.stats.effHit)
               {
                  this.game.createEffect(this.x,this.y,this.stats.effHit);
               }
            }
            else
            {
               this.game.createEffect(this.x,this.y,"mud_splash");
            }
            switch(this.hitObject)
            {
               case "":
                  break;
               case "ff0000":
                  break;
               case "ffff20":
                  if(this.unit.human && Math.random() < this.stats.fire)
                  {
                     Stats_Achievements.setAchievement("secret3");
                  }
                  break;
               case "00ffff":
                  break;
               case "993300":
                  if(SD.graphPart)
                  {
                     this.game.createEffect(this.x,this.y,"mud_splash");
                  }
                  break;
               case "670067":
                  break;
               case "6699ff":
                  break;
               case "ffffff":
                  if(SD.graphPart)
                  {
                     this.game.createEffect(this.x,this.y,"snowSplash");
                  }
                  break;
               case "006600":
                  this.game.createEffect(this.x,this.y,"leaf_splash");
                  for(_loc2_ = 0; _loc2_ < SD.graphPart; this.game.createParticle(this.x + UT.rand(-10,10),this.y,"leaf",null,"leaves","leaf" + UT.irand(1,4)),_loc2_++)
                  {
                  }
            }
         }
         if(this.hitType == "killstreak")
         {
            this.game.createEffect(this.x,this.y,"bulletspark");
            if(this.isProjectile)
            {
               this.x -= this.xVel;
               this.y -= this.yVel;
               if(!this.stats.extra.pierce)
               {
                  this.removeMe();
               }
            }
            else
            {
               this.x -= this.xVel * 0.5;
               this.y -= this.yVel * 0.5;
            }
            if(this.stats.effHit)
            {
               this.game.createEffect(this.x,this.y,this.stats.effHit);
            }
            if(this.stats.splash)
            {
               this.extra.hitX = this.x;
               this.extra.hitY = this.y;
            }
            this.hitObject.damage(this.stats.dmg * this.dmgMod,this.unit,this.stats,this.extra);
         }
         if(this.stats.hitSound)
         {
            this.unit.game.playScreenSound(this.stats.hitSound,this.x,this.y);
         }
         this.checkSplash();
      }
      
      protected function hitTestAll(param1:Number = 0, param2:Number = 0, param3:Boolean = false) : *
      {
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:uint = 0;
         var _loc4_:uint = this.game.arena.wall.getPixel32(this.x + param1,this.y + param2);
         if(!this.unit.status.sWallhack && !param3 && _loc4_ && _loc4_.toString(16).substring(0,2) == "ff")
         {
            this.hitType = "wall";
            return _loc4_.toString(16).substring(2);
         }
         for(_loc5_ = 0; _loc5_ < this.game.units.length; _loc5_++)
         {
            if(this.game.units[_loc5_] != this.unit)
            {
               if(!this.game.units[_loc5_].dead)
               {
                  if(!(this.unit.team && this.unit.team == this.game.units[_loc5_].team))
                  {
                     _loc6_ = this.game.units[_loc5_].x - 13 * this.game.units[_loc5_].scale;
                     _loc7_ = 26 * this.game.units[_loc5_].scale;
                     _loc8_ = 78 * this.game.units[_loc5_].scale;
                     _loc9_ = 64 * this.game.units[_loc5_].scale;
                     _loc10_ = 50 * this.game.units[_loc5_].scale;
                     _loc11_ = 38 * this.game.units[_loc5_].scale;
                     _loc12_ = 0;
                     if(!this.game.units[_loc5_].mov.crouching)
                     {
                        if(!UT.inBox(this.x,this.y,_loc6_,this.game.units[_loc5_].y - _loc8_,_loc7_,_loc8_))
                        {
                           continue;
                        }
                        if(UT.inBox(this.x,this.y,_loc6_,this.game.units[_loc5_].y - _loc9_,_loc7_,_loc9_))
                        {
                           _loc12_ = 1;
                        }
                        else
                        {
                           _loc12_ = 2;
                        }
                     }
                     else
                     {
                        if(!UT.inBox(this.x,this.y,_loc6_,this.game.units[_loc5_].y - _loc10_,_loc7_,_loc10_))
                        {
                           continue;
                        }
                        if(UT.inBox(this.x,this.y,_loc6_,this.game.units[_loc5_].y - _loc11_,_loc7_,_loc11_))
                        {
                           _loc12_ = 1;
                        }
                        else
                        {
                           _loc12_ = 2;
                        }
                     }
                     if(_loc12_ == 1)
                     {
                        this.hitType = "unit";
                        if(this.stats.splash >= 80)
                        {
                           this.extra.splashDirect = true;
                        }
                        return this.game.units[_loc5_];
                     }
                     if(_loc12_ == 2)
                     {
                        if(UT.getPosNegSign(this.unit.x - this.game.units[_loc5_].x) != this.game.units[_loc5_].MC.scaleX)
                        {
                           this.extra.assassin = 1.5;
                        }
                        this.extra.headMult = 1.5;
                        this.hitType = "unit";
                        if(this.stats.splash >= 80)
                        {
                           this.extra.splashDirect = true;
                        }
                        return this.game.units[_loc5_];
                     }
                  }
               }
            }
         }
         for(_loc5_ = 0; _loc5_ < this.game.physWorld.actors.length; _loc5_++)
         {
            if(UT.getDist(this.x,this.y,this.game.physWorld.actors[_loc5_].rdBody.GetDefinition().userData.x,this.game.physWorld.actors[_loc5_].rdBody.GetDefinition().userData.y) < 30)
            {
               this.hitType = "corpse";
               return this.game.physWorld.actors[_loc5_];
            }
         }
         for(_loc5_ = 0; _loc5_ < this.game.killstreaks.length; _loc5_++)
         {
            if(this.game.killstreaks[_loc5_].shootable)
            {
               if(this.game.killstreaks[_loc5_].unit != this.unit)
               {
                  if(!(this.unit.team && this.game.killstreaks[_loc5_].unit.team == this.unit.team))
                  {
                     if(UT.inBox(this.x,this.y,this.game.killstreaks[_loc5_].x - 15,this.game.killstreaks[_loc5_].y - 55,30,55))
                     {
                        this.hitType = "killstreak";
                        return this.game.killstreaks[_loc5_];
                     }
                  }
               }
            }
         }
         this.hitType = "";
         return null;
      }
      
      protected function hitTestWall(offX:Number = 0, offY:Number = 0) : Boolean
      {
         var _pixel:uint = this.game.arena.wall.getPixel32(this.x + offX,this.y + offY);
         return _pixel && _pixel.toString(16).substring(0,2) == "ff" && _pixel.toString(16).substring(2).indexOf("00000") == -1;
      }
      
      protected function checkSplash() : void
      {
         var _rot:Number = NaN;
         var _pixel:uint = 0;
         if(!this.stats.splash)
         {
            return;
         }
         var splashSize:Number = this.stats.splash;
         for(var i:uint = 0; i < this.game.units.length; i++)
         {
            if(!this.game.units[i].dead)
            {
               if(!(this.hitType == "unit" && this.hitObject == this.game.units[i]))
               {
                  if(UT.getDist(this.x,this.y,this.game.units[i].x,this.game.units[i].y - 45) < splashSize)
                  {
                     this.cleanExtra();
                     _rot = UT.getRotation(this.x,this.y,this.game.units[i].x,this.game.units[i].y - 45);
                     _pixel = this.game.arena.wall.getPixel32(this.x + UT.xMoveToRot(_rot,10),this.y + UT.yMoveToRot(_rot,10));
                     if(!(_pixel && _pixel.toString(16).substring(0,2) == "ff"))
                     {
                        if(this.stats.splash && this.stats.splash < 80)
                        {
                           this.extra.splashIndirect = true;
                        }
                        this.extra.hitX = this.x;
                        this.extra.hitY = this.y;
                        this.extra.splashMult = this.stats.splashMult;
                        this.game.units[i].status.damage(this.stats.dmg,this.unit,this.stats,this.extra);
                     }
                  }
               }
            }
         }
      }
      
      protected function removeMe() : void
      {
         this.remove = true;
      }
      
      protected function cleanExtra() : void
      {
         var newExtra:* = {};
         newExtra.corpseStick = this.extra.corpseStick;
         newExtra.reflect = this.extra.reflect;
         this.extra = newExtra;
      }
   }
}
