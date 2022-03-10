package
{
   import flash.system.System;
   
   public class AI extends Unit
   {
       
      
      private var curWp:NodeWaypoint;
      
      private var nextWp:NodeWaypoint;
      
      private var wpTimer:uint;
      
      private var focusX:Number;
      
      private var focusY:Number;
      
      private var path:String;
      
      private var getTargetTimer:uint;
      
      private var getTargetEvent:uint;
      
      private var wait:uint;
      
      private var nowait:uint;
      
      public var crouch:uint;
      
      public var nocrouch:uint;
      
      private var shootSpd:Number;
      
      private var waitMod:Number;
      
      private var waitNormal:Number;
      
      private var waitTarget:Number;
      
      private var crouchNormal:Number;
      
      private var crouchTarget:Number;
      
      private var waitFlag:Number;
      
      private var shotChance:Number;
      
      private var aimSpeed:Number;
      
      private var aimRange:Number;
      
      private var pressedUp:Boolean;
      
      public function AI(_game:Game, _unitInfo:UnitInfo)
      {
         super(_game,_unitInfo);
         MC.goto("idle");
         this.path = "@@";
         this.getTargetEvent = UT.irand(1,12);
      }
      
      public function setDiffStats() : void
      {
         this.waitMod = UT.getLinearRange(unitInfo.mobile,9,0.8,0.2);
         this.waitNormal = UT.getLinearRange(unitInfo.mobile,9,0.04,0.001);
         this.waitTarget = UT.getLinearRange(unitInfo.mobile,9,0.07,0.02);
         this.crouchNormal = UT.getLinearRange(unitInfo.mobile,9,0.06,0.01);
         this.crouchTarget = UT.getLinearRange(unitInfo.mobile,9,0.1,0.03);
         this.waitFlag = UT.getLinearRange(unitInfo.mobile,9,0.01,0.001);
         this.shotChance = UT.getLinearRange(unitInfo.aggro,9,1,4);
         this.aimSpeed = UT.getLinearRange(unitInfo.aim,9,0.09,0.9);
         this.aimRange = UT.getLinearRange(unitInfo.aim,9,400,650);
         if(gun.curGun.vision > 0.5)
         {
            this.aimRange *= 1.3;
         }
         diff = unitInfo.level / 30;
      }
      
      override public function spawn(_x:Number = 0, _y:Number = 0, _node:String = "", _showRope:Boolean = true) : void
      {
         if(human)
         {
            game.hud.reset();
         }
         unitSpawn(_x,_y,_node,_showRope);
         aimX = x + 200;
         aimY = y - 50;
         if(unitInfo.extra.aimReverse)
         {
            trace("reverse");
            aimX = y - 100;
            MC.scaleX = -1;
         }
      }
      
      override protected function setAiSpawnNode(_node:NodeSpawn) : void
      {
         this.getNextWaypoint(_node.waypoint,true);
      }
      
      private function shrugUppityHose() : void
      {
         if(!hasFlag)
         {
            if(Math.random() < 0.3 && !game.arena["flag" + (team == 1 ? 2 : 1)].unitCaptured)
            {
               this.path = this.pathFind(game.arena["flag" + (team == 1 ? 2 : 1)].id,5);
               trace("SET PATH TO ENEMY FLAG",this.path);
            }
         }
         else
         {
            this.path = this.pathFind(game.arena["flag" + team].id,5);
            trace("SET PATH TO HOME FLAG",this.path);
         }
      }
      
      override public function getNextWaypoint(_wp:NodeWaypoint = null, _force:Boolean = false) : void
      {
         this.wpTimer = 0;
         if(!_force && mov.jumping && Math.abs(y - this.nextWp.y) > 30)
         {
            return;
         }
         if(_wp)
         {
            this.curWp = this.nextWp;
            this.nextWp = _wp;
         }
         else
         {
            this.curWp = this.nextWp;
            if(MatchSettings.useMode == "ctf" && !this.path && this.path.charAt(0) != "@")
            {
               this.shrugUppityHose();
            }
            if(Math.abs(y - this.curWp.y) > 50)
            {
               this.getClosestWp();
            }
            else if(Math.abs(y - this.curWp.y) < 50)
            {
               if(this.path && this.path.charAt(0) != "@")
               {
                  this.nextWp = game.arena.wpOb[this.path.charAt(0)];
                  this.path = this.path.substring(1);
                  if(this.path == "")
                  {
                     this.path = "@";
                  }
                  trace(this.path);
               }
               else
               {
                  this.nextWp = UT.randEl(this.curWp.connects);
                  if(this.path.charAt(0) == "@")
                  {
                     this.path = this.path.substring(1);
                  }
               }
            }
         }
         if(Main.DEBUGMODE)
         {
            txt_name.text = (!!this.curWp ? this.curWp.id.toUpperCase() : "Null") + " to " + this.nextWp.id.toUpperCase();
         }
      }
      
      public function getClosestWp() : void
      {
         this.wpTimer = 0;
         this.path = "@";
         var closestWps:Array = new Array();
         for(var i:uint = 0; i < game.arena.waypoints.length; i++)
         {
            if(Math.abs(y - game.arena.waypoints[i].y) < 100)
            {
               closestWps.push({
                  "dist":Math.abs(x - game.arena.waypoints[i].x),
                  "wp":game.arena.waypoints[i]
               });
            }
         }
         if(closestWps.length)
         {
            closestWps.sortOn("dist",Array.NUMERIC);
            this.nextWp = closestWps[0].wp;
         }
         else
         {
            this.nextWp = UT.randEl(this.curWp.connects);
         }
      }
      
      public function pathFind(_end:String, _randNode:uint = 0) : String
      {
         var pathFindAr:Array = [];
         for(var i:uint = 0; i < this.curWp.connects.length; i++)
         {
            this.searchNode(this.curWp.connects[i].id,_end,this.curWp.id,pathFindAr);
         }
         pathFindAr.sortOn("dist",Array.NUMERIC);
         if(_randNode > pathFindAr.length - 1)
         {
            _randNode = pathFindAr.length - 1;
         }
         return pathFindAr[UT.irand(0,_randNode)].path.substring(1);
      }
      
      private function searchNode(_src:String, _end:String, _path:String, _pathFindAr:Array) : void
      {
         var next:String = null;
         _path += _src;
         if(_src == _end)
         {
            _pathFindAr.push(new NodeWaypointPath(_path,game.arena.wpOb));
         }
         for(var i:uint = 0; i < game.arena.wpOb[_src].connects.length; i++)
         {
            next = game.arena.wpOb[_src].connects[i].id;
            if(_path.indexOf(next) == -1)
            {
               this.searchNode(next,_end,_path,_pathFindAr);
            }
         }
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Array = null;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:uint = 0;
         var _loc8_:* = undefined;
         if(game.destroyed)
         {
            return;
         }
         if(unitInfo.extra.noSpawn)
         {
            return;
         }
         if(dead)
         {
            if(respawnTimer > 0)
            {
               if(human && respawnTimer < 3 * 30)
               {
                  game.hud.setRespawnText("Respawn in " + Math.ceil(respawnTimer / 30));
               }
               --respawnTimer;
               for(_loc1_ = 0; _loc1_ < game.units.length; _loc1_++)
               {
                  if(game.units[_loc1_].unitInfo.skills.love)
                  {
                     if(game.units[_loc1_] != this)
                     {
                        if(!game.units[_loc1_].dead)
                        {
                           if(!(!game.units[_loc1_].team || game.units[_loc1_].team != team))
                           {
                              if(UT.getDist(dead.x,dead.y,game.units[_loc1_].x,game.units[_loc1_].y) < 200)
                              {
                                 respawnTimer += 2;
                              }
                           }
                        }
                     }
                  }
               }
            }
            else
            {
               this.spawn();
            }
            return;
         }
         MCfilters = [];
         if(!human)
         {
            if(!mov.jumping && !this.wait && !this.crouch)
            {
               ++this.wpTimer;
            }
            if(this.wpTimer >= 30 * 4)
            {
               this.getClosestWp();
            }
         }
         if(status.sFrozen)
         {
            status.EnterFrame();
            return;
         }
         if(human)
         {
            _loc2_ = UT.getDist(x + MC.arm1.x,y + MC.arm1.y,game.arena.mouseX,game.arena.mouseY);
            _loc2_ *= _loc2_;
            _loc2_ *= 2;
            _loc3_ = Math.sqrt(_loc2_ - _loc2_ * Math.cos(gun.dynRecoilMod * Math.PI / 180));
            game.aimer.line1.y = -_loc3_;
            game.aimer.line2.x = _loc3_;
            game.aimer.line3.y = _loc3_;
            game.aimer.line4.x = -_loc3_;
            game.aimer.circle.width = game.aimer.circle.height = _loc3_ * 2;
            if(unitInfo.extra.noAim)
            {
               game.aimer.x = -1000;
               game.aimer.y = -1000;
            }
            else
            {
               game.aimer.x = game.mouseX;
               game.aimer.y = game.mouseY;
               aimX += (game.arena.mouseX - aimX) * 0.5;
               aimY += (game.arena.mouseY - aimY) * 0.5;
            }
            if(mDown)
            {
               gun.shoot();
            }
            UnitEnterFrame();
            return;
         }
         keys = 0;
         if(mov.dontStop || unitInfo.extra.dontStop)
         {
            this.wait = 0;
            this.crouch = 0;
         }
         if(this.nextWp.x > x - 30 && this.nextWp.x < x + 30)
         {
            this.getNextWaypoint();
         }
         else if(!this.wait && this.nextWp.x > x)
         {
            keys |= RIGHT;
         }
         else if(!this.wait && this.nextWp.x < x)
         {
            keys |= LEFT;
         }
         if(MatchSettings.useMode == "dom")
         {
            for(_loc1_ = 0; _loc1_ < game.arena.holdpoints.length; _loc1_++)
            {
               if(UT.inBox(x,y,game.arena.holdpoints[_loc1_].x - 120,game.arena.holdpoints[_loc1_].y - 150,240,200))
               {
                  if(!this.wait && !this.nowait && (team != game.arena.holdpoints[_loc1_].curTeam || game.arena.holdpoints[_loc1_].flag > -50))
                  {
                     if(Math.random() < 0.5)
                     {
                        this.wait = UT.irand(1,8) * 30;
                     }
                     else
                     {
                        this.crouch = UT.irand(1,8) * 30;
                     }
                     this.nowait = 0;
                  }
               }
            }
         }
         if(MatchSettings.useMode == "ctf")
         {
            if(!game.arena["flag" + team].unitCaptured && UT.inBox(x,y,game.arena["flag" + team].x - 100,game.arena["flag" + team].y - 40,200,100))
            {
               if(!this.wait && !this.nowait && !hasFlag)
               {
                  defendingFlag = true;
                  if(Math.random() < 0.5)
                  {
                     this.wait = UT.irand(1,8) * 30;
                  }
                  else
                  {
                     this.crouch = UT.irand(1,8) * 30;
                  }
                  this.nowait = this.wait + UT.irand(1,3) * 30;
               }
            }
            if(!this.wait && !this.nowait)
            {
               defendingFlag = false;
            }
         }
         if(!this.wait && !this.nowait && !mov.jumping && Math.random() < (!!target ? this.waitTarget : this.waitNormal) && !status.sSpawn)
         {
            this.wait = UT.irand(1,3) * this.waitMod * 30;
            this.nowait = this.wait + UT.irand(2,4) * this.waitMod * 30;
            if(hasFlag)
            {
               this.wait *= 0.2;
            }
         }
         if(!this.crouch && Math.random() < (!!target ? this.crouchTarget : 0) && !status.sSpawn && !this.nocrouch)
         {
            this.crouch = UT.irand(2,4) * this.waitMod * 30;
            this.nocrouch = this.crouch + UT.irand(0,2) * 30;
         }
         if(this.wait)
         {
            --this.wait;
         }
         if(this.nowait)
         {
            --this.nowait;
         }
         if(mov.dontStop || unitInfo.extra.dontStop)
         {
            this.wait = 0;
            this.crouch = 0;
         }
         if(this.crouch && keys & LEFT && mov.hitTest(-19,-20))
         {
            this.crouch = 0;
         }
         if(this.crouch && keys & RIGHT && mov.hitTest(19,-20))
         {
            this.crouch = 0;
         }
         if(this.crouch)
         {
            keys |= DOWN;
            --this.crouch;
         }
         if(this.nocrouch)
         {
            --this.nocrouch;
         }
         ++this.getTargetTimer;
         if(this.getTargetTimer > 12)
         {
            this.getTargetTimer = 0;
         }
         if(this.getTargetTimer == this.getTargetEvent)
         {
            _loc4_ = [];
            for(_loc1_ = 0; _loc1_ < game.units.length; _loc1_++)
            {
               if(game.units[_loc1_] != this)
               {
                  if(!game.units[_loc1_].dead)
                  {
                     if(!(team && team == game.units[_loc1_].team))
                     {
                        if(game.units[_loc1_].status.sInvis != 1)
                        {
                           if(!game.units[_loc1_].status.sSpawn)
                           {
                              _loc2_ = UT.getDist(x,y,game.units[_loc1_].x,game.units[_loc1_].y);
                              _loc5_ = this.aimRange - 100 + game.units[_loc1_].loudness;
                              if(game.units[_loc1_].status.sTag)
                              {
                                 _loc5_ += 150;
                              }
                              _loc5_ += game.units[_loc1_].gun.curGun.loud;
                              _loc5_ = Math.max(100,_loc5_);
                              if(_loc2_ < Math.min(gun.curGun.range * 10,_loc5_))
                              {
                                 _loc4_.push({
                                    "dist":_loc2_,
                                    "unit":game.units[_loc1_],
                                    "rot":UT.getRotation(x,y,game.units[_loc1_].x,game.units[_loc1_].y)
                                 });
                              }
                           }
                        }
                     }
                  }
               }
            }
            if(!status.sWallhack)
            {
               for(_loc1_ = 0; _loc1_ < _loc4_.length; _loc1_++)
               {
                  _loc6_ = true;
                  _loc7_ = 0;
                  while(_loc6_ && _loc7_ < _loc4_[_loc1_].dist)
                  {
                     if(mov.hitTest(UT.xMoveToRot(_loc4_[_loc1_].rot,_loc7_),UT.yMoveToRot(_loc4_[_loc1_].rot,_loc7_) - (!!mov.crouching ? 20 : 50)))
                     {
                        _loc6_ = false;
                     }
                     _loc7_ += 20;
                  }
                  if(!_loc6_)
                  {
                     _loc4_.splice(_loc1_,1);
                     _loc1_--;
                  }
               }
            }
            if(_loc4_.length)
            {
               _loc4_.sortOn("dist",Array.NUMERIC);
               target = _loc4_[0].unit;
            }
            else
            {
               target = null;
            }
            if(!target)
            {
               for(_loc1_ = 0; _loc1_ < game.killstreaks.length; _loc1_++)
               {
                  if(game.killstreaks[_loc1_].shootable)
                  {
                     if(game.killstreaks[_loc1_].unit != this)
                     {
                        if(!(team && team == game.killstreaks[_loc1_].unit.team))
                        {
                           _loc2_ = UT.getDist(x,y,game.killstreaks[_loc1_].x,game.killstreaks[_loc1_].y);
                           if(_loc2_ < Math.min(gun.curGun.range * 10,this.aimRange))
                           {
                              _loc6_ = true;
                              _loc8_ = UT.getRotation(x,y,game.killstreaks[_loc1_].x,game.killstreaks[_loc1_].y);
                              _loc7_ = 0;
                              while(_loc6_ && _loc7_ < _loc2_)
                              {
                                 if(mov.hitTest(UT.xMoveToRot(_loc8_,_loc7_),UT.yMoveToRot(_loc8_,_loc7_) - (!!mov.crouching ? 20 : 50)))
                                 {
                                    _loc6_ = false;
                                 }
                                 _loc7_ += 20;
                              }
                              if(_loc6_)
                              {
                                 target = game.killstreaks[_loc1_];
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         if(!target)
         {
            this.focusX = x + MC.scaleX * 50 + mov.xVel * 10;
            this.focusY = y - 40 + mov.yVel * 8;
            aimX += (this.focusX - aimX) * 0.4;
            aimY += (this.focusY - aimY) * 0.3;
         }
         else
         {
            this.focusX = !target.dead ? Number(target.x) : Number(target.dead.rdBody.GetDefinition().userData.x);
            this.focusY = !target.dead ? Number(target.y - (!!target.mov.crouching ? 20 : 40)) : Number(target.dead.rdBody.GetDefinition().userData.y + 10);
            aimX += (this.focusX - aimX) * this.aimSpeed;
            aimY += (this.focusY - aimY) * this.aimSpeed;
         }
         if(gun.secondary.isMelee)
         {
            if(target && UT.getDist(x,y,target.x,target.y) < gun.secondary.range * 10 + 30)
            {
               if(gun.curGun != gun.secondary && !gun.shootDelay)
               {
                  gun.swapGuns();
               }
            }
            else if(gun.curGun != gun.primary && !gun.shootDelay)
            {
               gun.swapGuns();
            }
         }
         if(game.gameStarted && target && !status.sSpawn)
         {
            this.shootSpd = 0.06 + gun.curGun.rps * 0.006;
            this.shootSpd *= this.shotChance;
            if(gun.curGun.type == 9)
            {
               this.shootSpd = 1;
            }
            if(Math.random() < this.shootSpd)
            {
               gun.shoot();
            }
         }
         if(score.streakReady())
         {
            useKillstreak();
         }
         for(_loc1_ = 0; _loc1_ < this.nextWp.actionBoxes.length; _loc1_++)
         {
            if(!UT.inBox(x,y,this.nextWp.actionBoxes[_loc1_].x,this.nextWp.actionBoxes[_loc1_].y,this.nextWp.actionBoxes[_loc1_].width,this.nextWp.actionBoxes[_loc1_].height))
            {
               continue;
            }
            if(keys & DOWN)
            {
               keys ^= DOWN;
            }
            switch(this.nextWp.actionBoxes[_loc1_].action)
            {
               case "j":
                  if(!capturing)
                  {
                     this.wait = 0;
                     this.nowait = 30;
                     if(!mov.jumping)
                     {
                        mov.doJump();
                     }
                  }
                  break;
               case "c":
                  keys |= DOWN;
                  break;
               case "fc":
                  this.getNextWaypoint(game.arena.wpOb["c"],true);
                  break;
               case "fp":
                  this.getNextWaypoint(game.arena.wpOb["p"],true);
                  break;
               case "fd":
                  this.getNextWaypoint(game.arena.wpOb["d"],true);
                  break;
               case "fx":
                  if(this.nextWp.id != "m" && this.nextWp.id != "l")
                  {
                     this.getNextWaypoint(game.arena.wpOb[UT.coinFlip("m","l")],true);
                  }
                  break;
            }
         }
         UnitEnterFrame();
      }
      
      public function MouseDown() : void
      {
         if(!human)
         {
            return;
         }
         if(!game.gameStarted || unitInfo.extra.noShoot || game.paused || status.sFrozen)
         {
            return;
         }
         mDown = true;
      }
      
      public function RightMouseDown() : void
      {
         if(!human)
         {
            return;
         }
         switch(SD.rightclick)
         {
            case 0:
               this.doKey(82);
               break;
            case 1:
               this.doKey(69);
               break;
            case 2:
               this.doKey(81);
         }
      }
      
      public function MouseUp() : void
      {
         if(!human)
         {
            return;
         }
         mDown = false;
         gun.releaseMouse();
      }
      
      public function KeyDown(e:uint) : void
      {
         this.doKey(e);
      }
      
      private function doKey(param1:uint) : void
      {
         var _loc2_:* = false;
         var _loc3_:uint = 0;
         if(!game.gameStarted || status.sSpawn)
         {
            return;
         }
         switch(param1)
         {
            case 27:
            case 80:
               game.togglePause();
               break;
            case 69:
            case 17:
               if(!human)
               {
                  break;
               }
               if(dead)
               {
                  break;
               }
               if(game.paused)
               {
                  break;
               }
               if(status.sFrozen)
               {
                  break;
               }
               useKillstreak();
               break;
            case 67:
               if(!Main.DEBUGMODE)
               {
                  break;
               }
               System.setClipboard(game.arena.mouseX + ", " + game.arena.mouseY);
               break;
            case 79:
               if(!Main.DEBUGMODE)
               {
                  break;
               }
               _loc2_ = !game.arena.wallMC.visible;
               game.arena.wallMC.visible = _loc2_;
               for(_loc3_ = 0; _loc3_ < game.arena.spawns.length; game.arena.spawns[_loc3_].visible = _loc2_,_loc3_++)
               {
               }
               for(_loc3_ = 0; _loc3_ < game.arena.spawnsT1.length; game.arena.spawnsT1[_loc3_].visible = _loc2_,_loc3_++)
               {
               }
               for(_loc3_ = 0; _loc3_ < game.arena.spawnsT2.length; game.arena.spawnsT2[_loc3_].visible = _loc2_,_loc3_++)
               {
               }
               for(_loc3_ = 0; _loc3_ < game.arena.waypoints.length; game.arena.waypoints[_loc3_].visible = _loc2_,_loc3_++)
               {
               }
               for(_loc3_ = 0; _loc3_ < game.arena.waypoints.length; game.arena.waypoints[_loc3_].showConnectors(_loc2_),_loc3_++)
               {
               }
               for(_loc3_ = 0; _loc3_ < game.arena.aiactions.length; game.arena.aiactions[_loc3_].visible = _loc2_,_loc3_++)
               {
               }
               for(_loc3_ = 0; _loc3_ < game.arena.physboxes.length; game.arena.physboxes[_loc3_].visible = _loc2_,_loc3_++)
               {
               }
               game.hud.debug.y = !!_loc2_ ? Number(0) : Number(-200);
               break;
            case 72:
               if(!Main.DEBUGMODE)
               {
                  break;
               }
               game.hud.visible = !game.hud.visible;
               break;
            case 76:
               if(!Main.DEBUGMODE)
               {
                  break;
               }
               SD.graphLights = !SD.graphLights;
               game.arena.toggleLights();
               break;
            case 82:
               if(!human)
               {
                  break;
               }
               if(dead)
               {
                  break;
               }
               if(game.paused)
               {
                  break;
               }
               if(status.sFrozen)
               {
                  break;
               }
               gun.manualReload();
               break;
            case 16:
            case 81:
               if(!human)
               {
                  break;
               }
               if(dead)
               {
                  break;
               }
               if(game.paused)
               {
                  break;
               }
               if(status.sFrozen)
               {
                  break;
               }
               gun.swapGuns();
               break;
            case 40:
            case 83:
               if(!human)
               {
                  break;
               }
               keys |= DOWN;
               break;
            case 37:
            case 65:
               if(!human)
               {
                  break;
               }
               keys |= LEFT;
               break;
            case 39:
            case 68:
               if(!human)
               {
                  break;
               }
               keys |= RIGHT;
               break;
            case 38:
            case 87:
            case 32:
               if(!human)
               {
                  break;
               }
               if(this.pressedUp)
               {
                  break;
               }
               if(game.paused)
               {
                  break;
               }
               if(status.sFrozen)
               {
                  break;
               }
               keys |= UP;
               mov.doJump();
               this.pressedUp = true;
               break;
            case 48:
               if(!Main.DEBUGMODE)
               {
                  break;
               }
               game.createEffect(x,y - 50,"bloodmist");
               game.createEffect(x,y - 50,"bloodmist");
               status.damage(25,this,Stats_Guns.itemOb["env"],{});
               break;
            case 49:
               if(!Main.DEBUGMODE)
               {
                  break;
               }
               if(human)
               {
                  unitInfo.streak = UT.getNextEl(Stats_Perks.itemOb[unitInfo.streak],true,Stats_Perks.streakAr).id;
                  streak = Stats_Perks.itemOb[unitInfo.streak];
                  game.hud.setHudStuff();
               }
               break;
            case 187:
               if(!Main.DEBUGMODE)
               {
                  break;
               }
               game.endGame(true);
               break;
         }
      }
      
      public function KeyUp(e:uint) : void
      {
         if(!human)
         {
            return;
         }
         switch(e)
         {
            case 38:
            case 87:
            case 32:
               if(keys & UP)
               {
                  keys ^= UP;
                  this.pressedUp = false;
               }
               break;
            case 40:
            case 83:
               if(keys & DOWN)
               {
                  keys ^= DOWN;
               }
               break;
            case 37:
            case 65:
               if(keys & LEFT)
               {
                  keys ^= LEFT;
               }
               break;
            case 39:
            case 68:
               if(keys & RIGHT)
               {
                  keys ^= RIGHT;
               }
         }
      }
      
      public function releaseKeys() : void
      {
         if(!human)
         {
            return;
         }
         if(keys & DOWN)
         {
            keys ^= DOWN;
         }
         if(keys & LEFT)
         {
            keys ^= LEFT;
         }
         if(keys & RIGHT)
         {
            keys ^= RIGHT;
         }
      }
   }
}
