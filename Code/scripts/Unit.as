package
{
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.text.TextField;
   
   public class Unit extends MovieClip
   {
       
      
      public var charselect:MovieClip;
      
      public var icon:MovieClip;
      
      public var icon2:MovieClip;
      
      public var mc_hp:MovieClip;
      
      public var txt_level:TextField;
      
      public var txt_name:TextField;
      
      public var game:Game;
      
      public var mDown:Boolean;
      
      public var laserColor:uint = 16711680;
      
      public var laserX:Number;
      
      public var laserY:Number;
      
      public var laserOX:Number;
      
      public var laserOY:Number;
      
      public var human:Boolean;
      
      public var focused:Boolean;
      
      public var unitInfo:UnitInfo;
      
      public var team:uint;
      
      public var odiff:uint;
      
      public var diff:uint;
      
      public var pscore:int = 0;
      
      public var canRotate:Boolean;
      
      public var dead:PhysActor;
      
      private var firstSpawn:Boolean = true;
      
      public var respawnTimer:uint;
      
      public var streakInProgress:uint;
      
      public var sEvent:uint = 1;
      
      public var loudness:uint;
      
      public var hasFlag:NodeCtfFlag;
      
      public var isJug:Boolean;
      
      public var onPoint:Boolean;
      
      public var capturing:Boolean;
      
      public var defendingFlag:Boolean;
      
      private var hudGlow:Array;
      
      private var hudShadow:Array;
      
      public var flip:Boolean;
      
      public var aimX:Number;
      
      public var aimY:Number;
      
      public var aimRoation:Number;
      
      private var rotArm:Number;
      
      private var rotReload:Number = 0;
      
      public var mov:Movement;
      
      public var gun:Guns;
      
      public var status:Status;
      
      public var score:Score;
      
      public var target;
      
      public var keys:uint = 0;
      
      public const UP:uint = 1;
      
      public const DOWN:uint = 2;
      
      public const LEFT:uint = 4;
      
      public const RIGHT:uint = 8;
      
      public var MC:UnitMC;
      
      public var MCfilters:Array;
      
      public var scale:Number;
      
      public var oscale:Number;
      
      public var nextAnim:String;
      
      private var surface:String;
      
      public var constAnim:String;
      
      public var streak:Stats_Perks;
      
      private var fc:uint;
      
      public function Unit(_game:Game, _unitInfo:UnitInfo)
      {
         super();
         addFrameScript(0,this.frame1);
         this.game = _game;
         this.unitInfo = _unitInfo;
         this.streak = Stats_Perks.itemOb[this.unitInfo.streak];
         this.loudness = 100;
         if(this.unitInfo.skills.detect1)
         {
            this.loudness *= this.unitInfo.skills.detect1;
         }
         if(this.unitInfo.skills.detect0)
         {
            this.loudness *= this.unitInfo.skills.detect0;
         }
         this.MC = new UnitMC(this);
         addChild(this.MC);
         this.oscale = Stats_Classes.itemOb[this.unitInfo.cls].size;
         if(this.unitInfo.extra.scale)
         {
            this.oscale += this.unitInfo.extra.scale;
         }
         this.scale = this.oscale;
         this.MC.scaleX = this.MC.scaleY = this.scale;
         this.mov = new Movement(this);
         this.gun = new Guns(this);
         this.status = new Status(this);
         this.score = new Score(this);
         this.team = this.unitInfo.team;
         name = this.unitInfo.name;
         if(this.unitInfo.extra.kills)
         {
            this.score.setKills(this.unitInfo.extra.kills);
         }
         this.MCfilters = [];
         this.hudGlow = [new DropShadowFilter(5,45,0,1,5,5,1,1),new GlowFilter(65535,1,3,3,1,1)];
         this.hudShadow = [new DropShadowFilter(5,45,0,1,5,5,1,1)];
         this.icon.gotoAndStop(this.unitInfo.cls);
         this.icon2.gotoAndStop(this.unitInfo.cls);
         this.txt_name.text = name;
         this.txt_level.text = this.unitInfo.level + "";
         if(MatchSettings.useMode == "gg" || MatchSettings.useMode == "tgg")
         {
            this.setGunGameWeapon(true);
         }
         else
         {
            this.setGuns();
         }
         this.setBarColour();
         this.changeTeam(this.unitInfo.team);
         setChildIndex(this.MC,0);
         if(this.unitInfo.extra.noSpawn)
         {
            visible = false;
            x = -4000;
            y = -4000;
         }
         else if(this.unitInfo.extra.spawn)
         {
            this.spawn(this.unitInfo.extra.spawn.x,this.unitInfo.extra.spawn.y,this.unitInfo.extra.spawn.node);
         }
         else
         {
            this.spawn();
         }
         if(MatchSettings.useMode == "one" && !this.isJug)
         {
            this.changeTeam(1);
         }
      }
      
      public function setGuns(_pri:String = "", _sec:String = "", rarity:int = 0, swapToo:Boolean = false) : void
      {
         this.gun.setGuns(!!_pri ? new GunInfo(_pri,this.unitInfo.level,rarity) : this.unitInfo.primary,!!_sec ? new GunInfo(_sec,this.unitInfo.level,rarity) : this.unitInfo.secondary);
         if(swapToo)
         {
            this.gun.swapGuns();
         }
      }
      
      public function changeTeam(_teamNum:uint) : void
      {
         this.team = _teamNum;
         this.setBarColour();
         Stats_Classes.setSkin(this.MC,this.unitInfo,false,true);
      }
      
      public function setBarColour() : void
      {
         var colTrans:* = new ColorTransform();
         switch(this.team)
         {
            case 0:
               if(this.human)
               {
                  this.status.healthColor = 16763904;
                  colTrans.color = 16763904;
               }
               else
               {
                  this.status.healthColor = 16777215;
                  colTrans.color = 16777215;
               }
               break;
            case 1:
               if(this.human)
               {
                  this.status.healthColor = 39423;
               }
               else
               {
                  this.status.healthColor = 65535;
               }
               colTrans.color = 65535;
               break;
            case 2:
               this.status.healthColor = 16750848;
               colTrans.color = 16750848;
         }
         this.icon.transform.colorTransform = colTrans;
         this.icon.alpha = 0.7;
         this.txt_level.textColor = colTrans.color;
         this.txt_level.alpha = 0.7;
         this.txt_name.textColor = colTrans.color;
         this.txt_name.alpha = 0.7;
      }
      
      public function spawn(_x:Number = 0, _y:Number = 0, _node:String = "", _showRope:Boolean = true) : void
      {
      }
      
      public function getNextWaypoint(_wp:NodeWaypoint = null, _force:Boolean = false) : void
      {
      }
      
      public function unitSpawn(_x:Number, _y:Number, _node:String, _showRope:Boolean) : void
      {
         var i:uint = 0;
         var curSpawn:NodeSpawn = null;
         if(this.unitInfo.extra.noSpawn)
         {
            this.unitInfo.extra.noSpawn = false;
         }
         if(this.unitInfo.extra.noRope)
         {
            _showRope = false;
            this.unitInfo.extra.noRope = false;
         }
         this.mov.reset();
         this.status.reset();
         this.gun.reset();
         this.MC.prepareSpawn(_showRope);
         this.dead = null;
         visible = true;
         if(_x && _y && _node)
         {
            if(!this.human)
            {
               for(i = 0; i < this.game.arena.waypoints.length; i++)
               {
                  if(this.game.arena.waypoints[i].id == _node)
                  {
                     this.getNextWaypoint(this.game.arena.waypoints[i],true);
                     break;
                  }
               }
            }
            x = _x;
            y = _y;
         }
         else
         {
            curSpawn = this.getSpawnNode();
            this.setAiSpawnNode(curSpawn);
            x = curSpawn.x + UT.rand(-5,5);
            y = curSpawn.y;
         }
         this.MC.rotation = 0;
         if(this.unitInfo.extra.permaStreak)
         {
            this.useKillstreak(this.unitInfo.extra.permaStreak);
         }
      }
      
      protected function getSpawnNode() : NodeSpawn
      {
         var spawnAr:Array = null;
         var _node:NodeSpawn = null;
         if(MatchSettings.useMode == "ctf" && this.team || this.unitInfo.extra.teamSpawn)
         {
            spawnAr = this.game.arena["spawnsT" + this.team];
         }
         else
         {
            spawnAr = this.game.arena.spawns;
         }
         if(this.firstSpawn)
         {
            do
            {
               _node = UT.randEl(spawnAr);
            }
            while(_node.initialSpawned);
            
            _node.initialSpawned = true;
            this.firstSpawn = false;
            return _node;
         }
         return UT.randEl(spawnAr);
      }
      
      protected function setAiSpawnNode(_node:NodeSpawn) : void
      {
      }
      
      public function die(_killer:Unit, _weapon:Stats_Guns, _extra:Object) : void
      {
         var newJug:* = undefined;
         var useExp:uint = 0;
         this.dead = this.game.physWorld.createCorpse(this,_killer,_weapon,_extra);
         if(!this.game.gameEnded)
         {
            this.game.hud.addKillFeed(this,_killer,_weapon);
            this.score.addDeath();
            if(this == _killer)
            {
               this.score.addSuicide();
               if(this.isJug)
               {
                  do
                  {
                     newJug = UT.randEl(this.game.units);
                  }
                  while(newJug == this || newJug.dead || newJug.status.sSpawn);
                  
                  newJug.setJug();
               }
            }
            else if(_extra.teamkill)
            {
               this.score.addBetrayal();
            }
            else
            {
               if(_killer.human)
               {
                  Stats_Achievements.checkAchVariable("enemies",1);
                  if(_killer.unitInfo.cls == "sni" && _extra.headMult)
                  {
                     Stats_Achievements.checkAchVariable("sni",1);
                  }
                  if(_killer.unitInfo.cls == "eng" && _weapon.isTurret)
                  {
                     Stats_Achievements.checkAchVariable("eng",1);
                  }
                  if(_killer.unitInfo.cls == "mer" && _killer.streakInProgress)
                  {
                     Stats_Achievements.checkAchVariable("mer",1);
                  }
                  if(_killer.unitInfo.cls == "eli" && (this.status.sIce || this.status.sZap || this.status.sFire || this.status.sAcid || this.status.sFrozen))
                  {
                     Stats_Achievements.checkAchVariable("eli",1);
                  }
                  if(_killer.unitInfo.cls == "nin" && this.target != _killer)
                  {
                     Stats_Achievements.checkAchVariable("nin",1);
                  }
               }
               if(_killer.unitInfo.skills.gunplay)
               {
                  this.game.createParticle(_killer.x + UT.rand(-5,5),_killer.y - UT.rand(50,55),"text",0,null,"bigText","gunplay");
                  _killer.gun.reloadOther();
               }
               if(_killer.unitInfo.skills.theif)
               {
                  this.game.createParticle(_killer.x + UT.rand(-5,5),_killer.y - UT.rand(50,55),"text",0,null,"bigText","ammo");
                  _killer.gun.addAmmo(_killer.unitInfo.skills.theif);
               }
               _killer.score.addKill();
               if(_extra.headMult)
               {
                  ++_killer.score.headshots;
               }
               if(this.isJug)
               {
                  _extra.jugKill = true;
                  _killer.setJug();
               }
               if(this.hasFlag)
               {
                  _extra.hasFlag = true;
               }
               if(MatchSettings.useExtra.vampire)
               {
                  _killer.status.heal(_killer.status.hpMax * 0.6,true);
               }
               useExp = Math.min(Stats_Classes.getUnitExp(_killer.unitInfo.level + 3),Stats_Classes.getUnitExp(this.unitInfo.level));
               if(MatchSettings.useExtra.expMod)
               {
                  useExp *= MatchSettings.useExtra.expMod;
               }
               if(MatchSettings.useMod)
               {
                  useExp *= Stats_Misc.getMod(MatchSettings.useMod).expmod;
               }
               if(_killer.human)
               {
                  this.displayExp(useExp);
               }
               _killer.unitInfo.addExp(useExp);
               this.unitInfo.addDeath();
            }
            if(this.constAnim)
            {
               this.game.createParticle(x,y - 110,"move",0,{
                  "xspd":-50,
                  "yspd":0
               },this.constAnim,"animate");
            }
         }
         if(this.hasFlag)
         {
            this.hasFlag.reset();
            this.hasFlag = null;
         }
         visible = false;
         this.respawnTimer = 30 * 5;
         if(this.unitInfo.skills.spawn0)
         {
            this.respawnTimer += this.unitInfo.skills.spawn0 * 30;
         }
         if(this.unitInfo.skills.spawn1)
         {
            this.respawnTimer += this.unitInfo.skills.spawn1 * 30;
         }
         if(this.human)
         {
            this.endKillstreak();
            this.game.aimer.x = -5000;
            this.game.aimer.y = -5000;
         }
      }
      
      public function displayExp(_amt:uint) : void
      {
         var px:Number = x + UT.rand(-5,5) - 8;
         var py:Number = y - UT.rand(55,60);
         this.game.createParticle(px,py,"slowText",0,null,"expText","idle",11);
         if(_amt < 10)
         {
            this.game.createParticle(px + 8,py,"slowText",0,null,"expText","idle",_amt + 1);
         }
         else
         {
            this.game.createParticle(px + 8,py,"slowText",0,null,"expText","idle",uint(_amt * 0.1) + 1);
            this.game.createParticle(px + 16,py,"slowText",0,null,"expText","idle",_amt % 10 + 1);
         }
      }
      
      public function setJug() : void
      {
         var _loc1_:uint = 0;
         if(!this.human)
         {
         }
         for(_loc1_ = 0; _loc1_ < this.game.units.length; _loc1_++)
         {
            this.game.units[_loc1_].changeTeam(1);
            this.game.units[_loc1_].isJug = false;
            this.game.units[_loc1_].gotoAndStop(1);
            this.game.units[_loc1_].scale = this.game.units[_loc1_].oscale;
            this.game.units[_loc1_].MC.scaleX = this.game.units[_loc1_].MC.scaleY = this.game.units[_loc1_].oscale;
         }
         this.changeTeam(2);
         this.status.heal(999,false);
         this.game.arena.setShake(10,10);
         for(_loc1_ = 0; _loc1_ < 20; this.game.createParticle(x + UT.rand(-10,10),y + UT.rand(-40,0),"spark",20,{
            "xSpd":UT.rand(-5,5),
            "ySpd":UT.rand(-8,-3)
         },"ember"),_loc1_++)
         {
         }
         this.game.createEffect(x,y - 100,"oneManArmy","idle",true);
         this.isJug = true;
         gotoAndStop(2);
         this.game.hud.addCustomFeed(this,"jug");
         this.scale += 0.3;
         this.MC.scaleX = this.MC.scaleY = this.scale;
      }
      
      public function stopFrames() : void
      {
         this.MC.stop();
         this.MC.arm1.stop();
      }
      
      public function playFrames() : void
      {
         this.MC.play();
         if(this.gun.curFrame != "idle")
         {
            this.MC.arm1.play();
         }
      }
      
      public function UnitEnterFrame() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Point = null;
         ++this.fc;
         if(this.streakInProgress)
         {
            --this.streakInProgress;
            if(this.streakInProgress == 0)
            {
               this.endKillstreak();
            }
         }
         if(x < 0 || y < 0 || x > this.game.arena.wall.width || y > this.game.arena.wall.height)
         {
            trace("OUT OF BOUNDS",this.unitInfo.name,x,y);
            this.status.damage(9999,this,Stats_Guns.itemOb["env"],{},true);
         }
         this.status.EnterFrame();
         this.gun.EnterFrame();
         this.MC.EnterFrame();
         this.mov.resetMods();
         this.surface = this.getPixel(0,1).toString(16).substring(2);
         if(this.human && Main.DEBUGMODE)
         {
            this.game.hud.setDebug(1,this.surface);
         }
         switch(this.surface)
         {
            case "33cc99":
            case "32cb99":
               this.mov.falltimer = 0;
               break;
            case "ff9900":
            case "ff9800":
            case "ff9700":
               Stats_Achievements.setAchievement("secret2");
               break;
            case "ff6699":
               this.mov.modJump = 0.3;
               this.mov.doJump();
               this.mov.falltimer = 0;
               if(this.mov.yVel > -2.4)
               {
                  this.mov.yVel -= 1.1;
               }
               break;
            case "ff6666":
               this.mov.modJump = 0.3;
               this.mov.doJump();
               this.mov.falltimer = 0;
               if(this.mov.yVel > -2.4)
               {
                  this.mov.yVel -= 0.7;
               }
               break;
            case "999966":
               this.mov.modMove = 2;
               this.mov.dontStop = true;
               break;
            case "0066ff":
               this.mov.modJump = 1;
               this.mov.doJump();
               this.game.hud.setDebug(2,"Surface Type = Force Jump");
               if(!this.mov.climb)
               {
                  for(_loc1_ = 0; _loc1_ < UT.irand(10,25); this.game.createParticle(UT.rand(848,911),UT.rand(778,934),"spark",UT.irand(0,15),null,"ember"),_loc1_++)
                  {
                  }
               }
               break;
            case "0069ff":
               this.mov.modJump = 1;
               this.mov.doJump();
               this.game.hud.setDebug(2,"Surface Type = Force Jump");
               if(!this.mov.climb)
               {
                  for(_loc1_ = 0; _loc1_ < UT.irand(10,25); this.game.createParticle(UT.rand(1963,2015),UT.rand(777,939),"spark",UT.irand(0,15),null,"ember"),_loc1_++)
                  {
                  }
               }
               break;
            case "0077ff":
               this.mov.modJump = 1.4;
               this.mov.doJump();
               this.game.hud.setDebug(2,"Surface Type = Force Jump");
               break;
            case "0079ff":
               this.mov.modJump = 1.4;
               this.mov.doJump();
               this.game.hud.setDebug(2,"Surface Type = Force Jump");
               break;
            case "0096ff":
               this.mov.modJump = 2;
               this.mov.doJump();
               this.game.hud.setDebug(2,"Surface Type = Force Jump");
               break;
            case "0099ff":
               this.mov.modJump = 2;
               this.mov.doJump();
               this.game.hud.setDebug(2,"Surface Type = Force Jump");
               break;
            case "3360ff":
               this.mov.modJump = 1.15;
               break;
            case "3363ff":
            case "3262ff":
               this.mov.modGrav = 0.5;
               break;
            case "3366ff":
               this.mov.modJump = 1.4;
               break;
            case "3369ff":
               this.mov.modJump = 1.4;
               break;
            case "600060":
               this.mov.falltimer = 0;
               this.mov.modJump = 0.8;
               this.mov.modGrav = 0.5;
               break;
            case "6600ff":
               this.mov.falltimer = 0;
               this.mov.modJump = 1.4;
               this.mov.modGrav = 0.3;
               break;
            case "620060":
               this.mov.falltimer = 0;
               this.mov.modJump = 0.75;
               this.mov.modGrav = 0.45;
               break;
            case "6200ff":
               this.mov.falltimer = 0;
               this.mov.modJump = 1.1;
               this.mov.modGrav = 0.3;
               break;
            case "6699ff":
               this.mov.modMax = 0.8;
               this.mov.modBrake = 1.8;
               this.mov.modJump = 0.8;
               this.status.sFire = this.status.sAcid = 0;
               if(this.status.sZap)
               {
                  ++this.status.sZap;
               }
               if(this.status.sIce)
               {
                  ++this.status.sIce;
               }
               break;
            case "ffffff":
               this.mov.modBrake = 2;
               if(Math.abs(this.mov.xVel) > 1 && this.fc % 3 == 0)
               {
                  this.game.createEffect(x,y - 4,"snowSplash");
               }
               break;
            case "666666":
               this.mov.modMove = 5;
               this.mov.dontStop = true;
               break;
            case "00ffff":
               this.mov.modJump = 1.8;
               break;
            case "330000":
            case "320000":
            case "2c0000":
            case "2a0000":
            case "2e0000":
            case "2b0000":
            case "2f0000":
            case "2d0000":
               this.status.damage(9999,this,Stats_Guns.itemOb["env"],{},true);
               break;
            case "660000":
            case "620000":
            case "630000":
            case "640000":
               break;
            case "990000":
               if(this.fc % 5 == 0 && this.human)
               {
                  this.status.damage(Stats_Guns.getDamageAtLevel("mechlaser",this.game.units[1].unitInfo.level),this.game.units[1],Stats_Guns.itemOb["mechlaser"],{},true);
               }
         }
         this.mov.EnterFrame();
         if(this.constAnim)
         {
            this.game.bitscreen.paint(x + this.game.arena.x,y + this.game.arena.y - 110,true,this.constAnim + "0");
         }
         for(_loc1_ = 0; _loc1_ < this.game.arena.pickups.length; _loc1_++)
         {
            if(!this.game.arena.pickups[_loc1_].taken)
            {
               if(UT.inBox(x,y,this.game.arena.pickups[_loc1_].x - 40,this.game.arena.pickups[_loc1_].y - 80,80,150))
               {
                  this.game.arena.pickups[_loc1_].getPickup(this);
               }
            }
         }
         this.onPoint = false;
         this.capturing = false;
         _loc1_ = 0;
         while(this.game.gameStarted && _loc1_ < this.game.arena.holdpoints.length)
         {
            if(UT.inBox(x,y,this.game.arena.holdpoints[_loc1_].x - 120,this.game.arena.holdpoints[_loc1_].y - 100,240,200))
            {
               this.onPoint = true;
               this.capturing = this.game.arena.holdpoints[_loc1_].curTeam != this.team;
               this.game.arena.holdpoints[_loc1_].capture(this);
            }
            _loc1_++;
         }
         for(_loc1_ = 0; _loc1_ < this.game.arena.ctfflags.length; _loc1_++)
         {
            if(UT.inBox(x,y,this.game.arena.ctfflags[_loc1_].x - 40,this.game.arena.ctfflags[_loc1_].y - 70,80,95))
            {
               this.game.arena.ctfflags[_loc1_].capture(this);
            }
         }
         if(this.hasFlag)
         {
            if(this.fc % (this.keys & this.LEFT || this.keys & this.RIGHT ? 7 : 20) == 0)
            {
               this.game.createEffect(x + UT.rand(-7,7),y - UT.rand(10,20),"paper","idle" + UT.irand(1,2));
            }
         }
         if(this.MC.head.cigar && this.fc % 40 < 8)
         {
            _loc2_ = this.MC.head.localToGlobal(new Point(this.MC.head.cigar.x,this.MC.head.cigar.y));
            this.game.createParticle(_loc2_.x - this.game.arena.x,_loc2_.y - this.game.arena.y,"move",0,{
               "xSpd":0,
               "ySpd":-2
            },"gas_tiny","idle");
         }
         this.MC.goto(this.nextAnim);
         this.flip = !!this.mov.jumping ? this.aimX < x : UT.fixRotation(this.aimRoation - this.MC.rotation) < 0;
         this.MC.scaleX = !!this.flip ? Number(-1) : Number(1);
         this.MC.scaleX *= this.scale;
         this.rotArm = UT.getRotation(x + this.MC.arm1.x + this.MC.rotation * 1.2,y + this.MC.arm1.y,this.aimX,this.aimY) - 90;
         this.aimRoation = UT.fixRotation(this.rotArm + 90);
         if(this.flip)
         {
            this.rotArm = -this.rotArm + 180;
         }
         this.rotArm = UT.fixRotation(this.rotArm - rotation) + (!!this.flip ? this.MC.rotation : -this.MC.rotation);
         this.rotReload += ((this.gun.reloading && this.rotArm < 30 ? 30 : 0) - this.rotReload) * 0.2;
         this.MC.arm1.rotation = this.rotReload + this.rotArm;
         this.MC.arm2.rotation = this.rotReload + this.rotArm;
         this.MC.head.rotation = this.rotReload + this.rotArm * 0.6;
         this.MC.filters = this.MCfilters;
      }
      
      public function useKillstreak(param1:String = "", param2:Boolean = false) : void
      {
         var _loc3_:String = null;
         var _loc4_:NodeSpawn = null;
         var _loc5_:uint = 0;
         if(!(Main.DEBUGMODE && this.human))
         {
            if(!this.score.streakReady() && !param1 && !param2)
            {
               return;
            }
         }
         if(this.dead)
         {
            return;
         }
         if(this.game.beamDelay && (this.streak.id == "firebeam" || this.streak.id == "icebeam"))
         {
            return;
         }
         if(this.human)
         {
            this.game.hud.mc_streakarrow.visible = false;
            this.game.hud.hud_bg.filters = this.hudShadow;
         }
         if(!param1)
         {
            if(this.human)
            {
               this.game.hud.txt_streakready.text = "In Progress!";
            }
            this.game.createEffect(x,y - 100,"useStreak");
            this.game.hud.addKillstreakFeed(this,this.streak);
         }
         if(param1)
         {
            _loc3_ = param1;
         }
         else
         {
            _loc3_ = this.streak.id;
         }
         if(this.human && this.unitInfo.cls == "gun")
         {
            Stats_Achievements.checkAchVariable("gun",1);
         }
         if(this.human && this.unitInfo.cls == "med")
         {
            Stats_Achievements.checkAchVariable("med",1);
         }
         switch(_loc3_)
         {
            case "firebeam":
               this.game.playScreenSound(S_Radar,x,y);
               this.streakInProgress = 3.5 * 30;
               this.game.beamDelay = 4 * 30;
               if(this.team)
               {
                  for(_loc5_ = 0; _loc5_ < this.game.units.length; _loc5_++)
                  {
                     if(!this.game.units[_loc5_].dead)
                     {
                        if(this.game.units[_loc5_].team != this.team)
                        {
                           this.game.units[_loc5_].status.sFireBeam = 3 * 30;
                           this.game.units[_loc5_].status.sBeamUnit = this;
                        }
                     }
                  }
               }
               else
               {
                  for(_loc5_ = 0; _loc5_ < this.game.units.length; _loc5_++)
                  {
                     if(!this.game.units[_loc5_].dead)
                     {
                        if(this.game.units[_loc5_] != this)
                        {
                           this.game.units[_loc5_].status.sFireBeam = 3 * 30;
                           this.game.units[_loc5_].status.sBeamUnit = this;
                        }
                     }
                  }
               }
               break;
            case "icebeam":
               this.game.playScreenSound(S_Radar,x,y);
               this.streakInProgress = 3.5 * 30;
               this.game.beamDelay = 4 * 30;
               if(this.team)
               {
                  for(_loc5_ = 0; _loc5_ < this.game.units.length; _loc5_++)
                  {
                     if(!this.game.units[_loc5_].dead)
                     {
                        if(this.game.units[_loc5_].team != this.team)
                        {
                           this.game.units[_loc5_].status.sIceBeam = 3 * 30;
                           this.game.units[_loc5_].status.sBeamUnit = this;
                        }
                     }
                  }
               }
               else
               {
                  for(_loc5_ = 0; _loc5_ < this.game.units.length; _loc5_++)
                  {
                     if(!this.game.units[_loc5_].dead)
                     {
                        if(this.game.units[_loc5_] != this)
                        {
                           this.game.units[_loc5_].status.sIceBeam = 3 * 30;
                           this.game.units[_loc5_].status.sBeamUnit = this;
                        }
                     }
                  }
               }
               break;
            case "dualtur":
               this.game.playScreenSound(S_Radar,x,y);
               this.streakInProgress = this.setTimer(10 * 30);
               if(this.unitInfo.skills.turret2)
               {
                  this.streakInProgress *= this.unitInfo.skills.turret2;
               }
               this.game.killstreaks.push(new Killstreak_Turret(this.game,this,this.setTimer(12 * 30,param1),"turret"));
               break;
            case "rockettur":
               this.game.playScreenSound(S_Radar,x,y);
               this.streakInProgress = this.setTimer(10 * 30);
               if(this.unitInfo.skills.turret2)
               {
                  this.streakInProgress *= this.unitInfo.skills.turret2;
               }
               this.game.killstreaks.push(new Killstreak_Turret(this.game,this,this.setTimer(12 * 30,param1),"sentry"));
               break;
            case "akimbo":
               this.streakInProgress = this.status.sAkimbo = this.setTimer(7 * 30,param1);
               this.game.playScreenSound(S_Skill,x,y);
               this.game.createEffect(x,y - 80,"surge");
               this.game.arena.setShake(5,5);
               break;
            case "betsy":
               this.streakInProgress = uint.MAX_VALUE;
               this.game.playScreenSound(S_Ammo,x,y);
               this.game.createEffect(x,y - 80,"surge");
               this.game.arena.setShake(5,5);
               this.gun.setTempGun("Betsy");
               break;
            case "heal":
               this.streakInProgress = this.setTimer(8 * 30,param1);
               if(this.team)
               {
                  SH.playSound(S_Heal);
                  for(_loc5_ = 0; _loc5_ < this.game.units.length; _loc5_++)
                  {
                     if(!this.game.units[_loc5_].dead)
                     {
                        if(this.game.units[_loc5_].team == this.team)
                        {
                           this.game.units[_loc5_].status.sRegenBoost = this.setTimer(8 * 30,param1);
                           this.game.createEffect(this.game.units[_loc5_].x,this.game.units[_loc5_].y - 40,"healthPickup");
                        }
                     }
                  }
               }
               else
               {
                  this.game.playScreenSound(S_Heal,x,y);
                  this.status.sRegenBoost = this.setTimer(8 * 30,param1);
                  this.game.createEffect(x,y - 40,"healthPickup");
               }
               break;
            case "armor":
               if(this.team)
               {
                  SH.playSound(S_Equip);
                  for(_loc5_ = 0; _loc5_ < this.game.units.length; _loc5_++)
                  {
                     if(!this.game.units[_loc5_].dead)
                     {
                        if(this.game.units[_loc5_].team == this.team)
                        {
                           this.game.units[_loc5_].status.repair(9999);
                           this.game.createEffect(this.game.units[_loc5_].x,this.game.units[_loc5_].y - 40,"shieldHex");
                        }
                     }
                  }
               }
               else
               {
                  this.game.playScreenSound(S_Equip,x,y);
                  this.status.repair(9999);
                  this.game.createEffect(x,y - 40,"shieldHex");
               }
               this.endKillstreak();
               break;
            case "rofboost":
               this.streakInProgress = this.setTimer(8 * 30,param1);
               if(this.team)
               {
                  SH.playSound(S_Powerup);
                  for(_loc5_ = 0; _loc5_ < this.game.units.length; _loc5_++)
                  {
                     if(!this.game.units[_loc5_].dead)
                     {
                        if(this.game.units[_loc5_].team == this.team)
                        {
                           this.game.units[_loc5_].status.sAimBoost = this.setTimer(8 * 30,param1);
                           this.game.createEffect(this.game.units[_loc5_].x,this.game.units[_loc5_].y - 80,"surgeGreen");
                        }
                     }
                  }
               }
               else
               {
                  this.game.playScreenSound(S_Powerup,x,y);
                  this.status.sAimBoost = this.setTimer(8 * 30,param1);
                  this.game.createEffect(x,y - 80,"surgeGreen");
               }
               break;
            case "critboost":
               this.streakInProgress = this.setTimer(8 * 30,param1);
               if(this.team)
               {
                  SH.playSound(S_Powerup);
                  for(_loc5_ = 0; _loc5_ < this.game.units.length; _loc5_++)
                  {
                     if(!this.game.units[_loc5_].dead)
                     {
                        if(this.game.units[_loc5_].team == this.team)
                        {
                           this.game.units[_loc5_].status.sCritBoost = this.setTimer(8 * 30,param1);
                           this.game.createEffect(this.game.units[_loc5_].x,this.game.units[_loc5_].y - 80,"surgeGreen");
                        }
                     }
                  }
               }
               else
               {
                  this.game.playScreenSound(S_Powerup,x,y);
                  this.status.sCritBoost = this.setTimer(8 * 30,param1);
                  this.game.createEffect(x,y - 80,"surgeGreen");
               }
               break;
            case "smoke":
               this.game.playScreenSound(S_AcidHit,x,y);
               this.game.createEffect(x,y - 80,"ninjaFlash","idle",true);
               _loc4_ = UT.randEl(this.game.arena.spawns);
               this.setAiSpawnNode(_loc4_);
               x = _loc4_.x + UT.rand(-5,5);
               y = _loc4_.y;
               this.mov.xVel = 0;
               this.mov.yVel = 0;
               this.game.createEffect(x,y - 80,"ninjaFlash","idle",true);
               this.status.sStealth = this.setTimer(2 * 30,param1);
               this.endKillstreak();
               break;
            case "shuriken":
               this.streakInProgress = uint.MAX_VALUE;
               this.game.playScreenSound(S_Ammo,x,y);
               this.game.createEffect(x,y - 80,"surge");
               this.game.arena.setShake(5,5);
               this.gun.setTempGun("Shuriken");
               break;
            case "aimbot":
               this.streakInProgress = this.status.sAimbot = this.setTimer(8 * 30,param1);
               this.game.playScreenSound(S_Skill,x,y);
               this.game.createEffect(x,y - 80,"surgeGreen");
               this.game.arena.setShake(5,5);
               break;
            case "wallhack":
               this.streakInProgress = this.status.sWallhack = this.setTimer(8 * 30,param1);
               this.game.playScreenSound(S_Skill,x,y);
               this.game.createEffect(x,y - 80,"surgeGreen");
               this.game.arena.setShake(5,5);
               break;
            case "mirror":
               this.streakInProgress = this.status.sReflect = this.setTimer(7 * 30,param1);
               this.status.repair(9999);
               this.game.playScreenSound(S_Skill,x,y);
               this.game.createEffect(x,y - 30,"shieldHexBlue");
               this.game.arena.setShake(5,5);
               break;
            case "element":
               this.streakInProgress = this.status.sElement = this.setTimer(7 * 30,param1);
               this.status.repair(9999);
               this.game.playScreenSound(S_Skill,x,y);
               this.game.createEffect(x,y - 30,"shieldHexBlue");
               this.game.arena.setShake(5,5);
         }
      }
      
      private function setTimer(_num:Number, _infinite:String = "") : uint
      {
         if(_infinite)
         {
            return uint.MAX_VALUE;
         }
         if(this.unitInfo.skills.length0)
         {
            _num *= this.unitInfo.skills.length0;
         }
         if(this.unitInfo.skills.length1)
         {
            _num *= this.unitInfo.skills.length1;
         }
         return _num;
      }
      
      public function startKillstreak() : void
      {
         this.streakInProgress = 0;
         this.game.createParticle(x,y - 70,"slowText",0,null,"bigText","killstreak");
         this.game.createParticle(x,y - 60,"slowText",0,null,"bigText","ready");
         if(this.human)
         {
            this.game.hud.txt_streakready.text = this.streak.name + " ready!";
            this.game.hud.mc_streakarrow.visible = true;
            this.game.hud.hud_bg.filters = this.hudGlow;
         }
      }
      
      public function endKillstreak() : void
      {
         this.streakInProgress = 0;
         this.score.streak = 0;
         this.setKillstreakNum(0);
         if(this.human)
         {
            this.game.hud.txt_streakready.text = "";
            this.game.hud.mc_streakarrow.visible = false;
         }
         this.score.streakKills = 0;
      }
      
      public function setKillstreakNum(_amt:Number) : void
      {
         if(this.game.player != this || !this.unitInfo.streak || this.streakInProgress)
         {
            return;
         }
         this.game.hud.hud_bg.bar_streak.width = _amt / Stats_Perks.itemOb[this.unitInfo.streak].val * 116;
         this.game.hud.mc_streakarrow.visible = _amt == Stats_Perks.itemOb[this.unitInfo.streak].val;
      }
      
      public function setGunGameWeapon(_ignoreTeam:Boolean = false) : void
      {
         var gunName:String = null;
         var i:uint = 0;
         var rarity:int = 0;
         if(MatchSettings.useMode == "gg")
         {
            gunName = Stats_Misc.getGunGameWeapon(this.pscore);
            if(gunName.charAt(0) == "$")
            {
               rarity = 3;
               gunName = gunName.substring(1);
            }
            this.setGuns(gunName,"Empty",rarity,true);
            if(!_ignoreTeam)
            {
               this.game.createEffect(x,y - 40,"ammoPickup");
            }
         }
         else if(MatchSettings.useMode == "tgg")
         {
            if(_ignoreTeam)
            {
               gunName = Stats_Misc.getGunGameWeapon(this.game.matchSettings["team" + this.team + "score"]);
               if(gunName.charAt(0) == "$")
               {
                  rarity = 3;
                  gunName = gunName.substring(1);
               }
               this.setGuns(gunName,"Empty",rarity,true);
            }
            else
            {
               gunName = Stats_Misc.getGunGameWeapon(this.game.matchSettings["team" + this.team + "score"]);
               if(gunName.charAt(0) == "$")
               {
                  rarity = 3;
                  gunName = gunName.substring(1);
               }
               for(i = 0; i < this.game.matchSettings["team" + this.team].length; i++)
               {
                  this.game.matchSettings["team" + this.team][i].setGuns(gunName,"Empty",rarity,true);
                  this.game.createEffect(this.game.matchSettings["team" + this.team][i].x,this.game.matchSettings["team" + this.team][i].y - 40,"ammoPickup");
               }
            }
         }
      }
      
      private function hitTestAll(param1:Number = 0, param2:Number = 0, param3:Boolean = false) : *
      {
         var _loc5_:uint = 0;
         var _loc4_:uint = this.game.arena.wall.getPixel32(x + param1,y + param2);
         if(_loc4_ && _loc4_.toString(16).substring(0,2) == "ff" && _loc4_.toString(16).substring(2).indexOf("00000") == -1)
         {
            return _loc4_.toString(16).substring(2);
         }
         for(_loc5_ = 0; _loc5_ < this.game.units.length; _loc5_++)
         {
            if(this.game.units[_loc5_] != this)
            {
               if(!this.game.units[_loc5_].dead)
               {
                  if(!(this.team && this.team == this.game.units[_loc5_].team))
                  {
                     if(UT.inBox(x + param1,y + param2,this.game.units[_loc5_].x - 20,this.game.units[_loc5_].y - 80,40,80))
                     {
                        return this.game.units[_loc5_];
                     }
                  }
               }
            }
         }
         if(param3)
         {
            for(_loc5_ = 0; _loc5_ < this.game.physWorld.actors.length; _loc5_++)
            {
               if(UT.getDist(x + param1,y + param2,this.game.physWorld.actors[_loc5_].rdBody.GetDefinition().userData.x,this.game.physWorld.actors[_loc5_].rdBody.GetDefinition().userData.y) < 30)
               {
                  return this.game.physWorld.actors[_loc5_];
               }
            }
         }
         return null;
      }
      
      protected function getPixel(offX:Number = 0, offY:Number = 0) : uint
      {
         return this.game.arena.wall.getPixel32(x + offX,y + offY);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
