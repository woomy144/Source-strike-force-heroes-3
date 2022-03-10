package
{
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class Game extends Sprite
   {
       
      
      private var main:Main;
      
      public var bg2:Bg;
      
      public var bg1:Bg;
      
      public var bgSky:BgSky;
      
      public var arena:Arena;
      
      private var mapParticles:Stats_MapParticles;
      
      public var physWorld:PhysWorld;
      
      public var hud:Hud;
      
      public var player:AI;
      
      public var units:Array;
      
      public var unitCont:Sprite;
      
      public var lineCont:Shape;
      
      public var killstreaks:Array;
      
      public var effects:Array;
      
      public var bullets:Array;
      
      public var matchSettings:MatchSettings;
      
      public var bitscreen:BitScreen;
      
      private var fc:uint = 0;
      
      public var aimer:Aimer;
      
      public var radar:Radar;
      
      public var water:Water;
      
      public var gameStarted:Boolean;
      
      public var gameEnded:Boolean;
      
      public var paused:Boolean;
      
      private var lvlOb:Object;
      
      public var mapExtra:String;
      
      public var enemyLvlAvg:uint;
      
      public var enemyAmt:uint;
      
      public var destroyed:Boolean;
      
      public var beamDelay:int = 0;
      
      private var script:int = 0;
      
      public function Game(_main:Main, _extra:Object)
      {
         super();
         this.main = _main;
         this.matchSettings = new MatchSettings(this);
         this.bgSky = new BgSky();
         addChild(this.bgSky);
         this.bg2 = new Bg();
         addChild(this.bg2);
         this.bg1 = new Bg();
         addChild(this.bg1);
         this.mapParticles = new Stats_MapParticles(this,MatchSettings.useMap.particles);
         this.physWorld = new PhysWorld(this);
         this.water = new Water(this);
         this.arena = new Arena(this);
         UT.forceGarbageCollection();
      }
      
      public function InitGame(param1:*) : void
      {
         var _loc2_:uint = 0;
         trace("=== Init Game ===");
         this.arena = param1;
         addChild(this.arena);
         this.aimer = new Aimer();
         this.aimer.gotoAndStop(1);
         this.script = 0;
         this.bitscreen = new BitScreen(this);
         addChild(this.bitscreen);
         this.unitCont = new Sprite();
         this.lineCont = new Shape();
         this.arena.midCont.addChild(this.unitCont);
         this.arena.midCont.addChild(this.lineCont);
         this.arena.midCont.addChild(this.physWorld);
         this.arena.midCont.addChild(this.water);
         this.effects = new Array();
         this.bullets = new Array();
         this.units = new Array();
         this.killstreaks = new Array();
         this.radar = new Radar(this,this.arena.wallMC);
         this.hud = new Hud(this);
         addChild(this.hud);
         this.hud.addChild(this.radar);
         for(_loc2_ = 0; _loc2_ < MatchSettings.useBots.length; _loc2_++)
         {
            this.createUnit(_loc2_ == 0,MatchSettings.useBots[_loc2_]);
         }
         this.setPlayer(this.units[0]);
         this.hud.createHeads();
         this.hud.setHudStuff();
         for(_loc2_ = 0; _loc2_ < this.units.length; _loc2_++)
         {
            if(this.units[_loc2_] != this.player)
            {
               if(this.units[_loc2_].team == 0 || this.units[_loc2_].team == 2)
               {
                  this.enemyLvlAvg += this.units[_loc2_].unitInfo.level;
                  ++this.enemyAmt;
               }
            }
         }
         this.enemyLvlAvg /= this.enemyAmt;
         trace("Enemy average level:",this.enemyLvlAvg,"with enemy #:",this.enemyAmt);
         if(MatchSettings.useMode == "one")
         {
            UT.randEl(this.units).setJug();
         }
         addChild(this.aimer);
         this.matchSettings.Init();
         this.mapParticles.mapInit();
         this.setMapExtra(MatchSettings.useMap.extra);
         Main.STAGE.quality = UT.getEl(SD.graphQual,["low","medium","high"]);
      }
      
      public function setPlayer(_unit:AI, becomeHuman:Boolean = true) : void
      {
         if(this.player)
         {
            this.player.human = false;
            this.player.focused = false;
            this.player.mDown = false;
            this.player.gun.shotPressed = false;
            this.player.setBarColour();
            this.player.charselect.visible = false;
         }
         this.player = _unit;
         this.player.focused = true;
         this.player.status.setHudStuff();
         this.player.gun.setHudStuff();
         this.hud.txt_classname.text = Stats_Classes.itemOb[this.player.unitInfo.cls].name;
         this.hud.txt_level.text = "LVL: " + this.player.unitInfo.level;
         if(becomeHuman)
         {
            this.player.human = true;
            this.player.setBarColour();
            this.player.keys = 0;
         }
         else
         {
            this.player.charselect.visible = true;
         }
         if(this.hud)
         {
            this.player.setKillstreakNum(this.player.score.streak);
         }
         this.arena.setFocus(this.player,this.player.gun.curGun.vision);
      }
      
      public function setMapExtra(_extra:String) : void
      {
         this.mapExtra = _extra;
         this.lvlOb = {};
      }
      
      public function startGame() : void
      {
         this.gameStarted = true;
         this.paused = false;
      }
      
      public function endGame(_won:Boolean) : void
      {
         if(this.gameEnded)
         {
            return;
         }
         this.gameEnded = true;
         this.hud.won = _won;
         this.hud.gotoAndPlay("end");
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         if(this.paused)
         {
            this.hud.EnterFrame();
            return;
         }
         ++this.fc;
         this.lineCont.graphics.clear();
         this.bitscreen.EnterFrame();
         if(this.beamDelay)
         {
            --this.beamDelay;
            if(this.beamDelay == 45)
            {
               SH.playSound(S_Karthus);
            }
         }
         if(MatchSettings.useExtra.randomTeam && this.fc % MatchSettings.useExtra.randomTeam == 0)
         {
            for(_loc1_ = 0; _loc1_ < 20; _loc1_++)
            {
               _loc3_ = UT.irand(1,this.units.length - 1);
               _loc4_ = UT.irand(1,this.units.length - 1);
               _loc5_ = this.units[_loc3_];
               _loc6_ = this.units[_loc4_];
               this.units[_loc3_] = _loc6_;
               this.units[_loc4_] = _loc5_;
            }
            _loc2_ = this.units.length * 0.5;
            for(_loc1_ = 1; _loc1_ < _loc2_; this.units[_loc1_].changeTeam(1),_loc1_++)
            {
            }
            for(_loc1_ = _loc2_; _loc1_ < this.units.length; this.units[_loc1_].changeTeam(2),_loc1_++)
            {
            }
            this.hud.setMsg(this.player,"Teams have been changed!");
         }
         if(MatchSettings.useExtra.tut1)
         {
            switch(this.script)
            {
               case 0:
                  if(this.matchSettings.team1score == 0 && this.gameStarted && this.hud.currentFrame == 1)
                  {
                     this.hud.gotoAndStop("tutmove");
                     ++this.script;
                  }
                  break;
               case 1:
                  if(this.matchSettings.team1score >= 1)
                  {
                     this.hud.gotoAndStop("tutswitch");
                     ++this.script;
                  }
                  break;
               case 2:
                  if(this.matchSettings.team1score >= 2)
                  {
                     this.hud.gotoAndStop("idle");
                     ++this.script;
                  }
                  break;
               case 3:
                  if(this.matchSettings.team1score >= 5)
                  {
                     this.hud.gotoAndStop("tutstreak");
                     ++this.script;
                  }
                  break;
               case 4:
                  if(this.matchSettings.team1score >= 6)
                  {
                     this.hud.gotoAndStop("idle");
                     ++this.script;
                  }
            }
         }
         if(MatchSettings.useExtra.tut2)
         {
            switch(this.script)
            {
               case 0:
                  if(this.matchSettings.team1score >= 5)
                  {
                     this.hud.gotoAndStop("tutmember");
                     ++this.script;
                  }
                  break;
               case 1:
                  if(this.matchSettings.team1score >= 20)
                  {
                     this.hud.gotoAndStop("idle");
                     ++this.script;
                  }
            }
         }
         if(MatchSettings.useExtra.developers)
         {
            switch(this.script)
            {
               case 0:
                  MatchSettings.useExtra.developers.mike.unitInfo.extra = {};
                  MatchSettings.useExtra.developers.mike.status.reset();
                  MatchSettings.useExtra.developers.justin.unitInfo.extra = {};
                  MatchSettings.useExtra.developers.justin.status.reset();
                  ++this.script;
                  break;
               case 1:
                  if(this.matchSettings.team1score >= 4)
                  {
                     this.hud.setMsg(MatchSettings.useExtra.developers.mike,"We\'re taking damage, Defensive Stance!");
                     MatchSettings.useExtra.developers.mike.unitInfo.extra.permReflect = 1;
                     MatchSettings.useExtra.developers.mike.status.reset();
                     MatchSettings.useExtra.developers.justin.unitInfo.extra.permReflect = 1;
                     MatchSettings.useExtra.developers.justin.status.reset();
                     ++this.script;
                  }
                  break;
               case 2:
                  if(this.matchSettings.team1score >= 8)
                  {
                     this.hud.setMsg(MatchSettings.useExtra.developers.justin,"I\'ve got an idea, Stick to the Shadows!");
                     MatchSettings.useExtra.developers.mike.unitInfo.extra.permReflect = 0;
                     MatchSettings.useExtra.developers.mike.unitInfo.skills.stealth_ = 1;
                     MatchSettings.useExtra.developers.mike.status.reset();
                     MatchSettings.useExtra.developers.justin.unitInfo.extra.permReflect = 0;
                     MatchSettings.useExtra.developers.justin.unitInfo.skills.stealth_ = 1;
                     MatchSettings.useExtra.developers.justin.status.reset();
                     ++this.script;
                  }
                  break;
               case 3:
                  if(this.matchSettings.team1score >= 12)
                  {
                     this.hud.setMsg(MatchSettings.useExtra.developers.mike,"I\'m in pain, here comes the Heal Train!");
                     MatchSettings.useExtra.developers.mike.unitInfo.skills.stealth_ = 0;
                     MatchSettings.useExtra.developers.mike.unitInfo.extra.permRegen = 1;
                     MatchSettings.useExtra.developers.mike.status.reset();
                     MatchSettings.useExtra.developers.justin.unitInfo.skills.stealth_ = 0;
                     MatchSettings.useExtra.developers.justin.unitInfo.extra.permRegen = 1;
                     MatchSettings.useExtra.developers.justin.status.reset();
                     ++this.script;
                  }
               case 4:
                  if(this.matchSettings.team1score >= 16)
                  {
                     this.hud.setMsg(MatchSettings.useExtra.developers.justin,"This isn\'t working... Bring on the Hax!");
                     MatchSettings.useExtra.developers.mike.unitInfo.extra.permRegen = 0;
                     MatchSettings.useExtra.developers.mike.unitInfo.extra.permWallhack = 1;
                     MatchSettings.useExtra.developers.mike.status.reset();
                     MatchSettings.useExtra.developers.justin.unitInfo.extra.permRegen = 0;
                     MatchSettings.useExtra.developers.justin.unitInfo.extra.permWallhack = 1;
                     MatchSettings.useExtra.developers.justin.status.reset();
                     ++this.script;
                  }
                  break;
               case 5:
                  if(this.matchSettings.team1score >= 20)
                  {
                     this.hud.setMsg(MatchSettings.useExtra.developers.mike,"Time for our TRUE FORMS!");
                     MatchSettings.useExtra.developers.mike.unitInfo.extra.permReflect = 1;
                     MatchSettings.useExtra.developers.mike.unitInfo.extra.permWallhack = 1;
                     MatchSettings.useExtra.developers.mike.unitInfo.extra.permRegen = 1;
                     MatchSettings.useExtra.developers.mike.unitInfo.skills.stealth_ = 1;
                     MatchSettings.useExtra.developers.mike.status.reset();
                     MatchSettings.useExtra.developers.mike.MC.scaleX = MatchSettings.useExtra.developers.mike.MC.scaleY = MatchSettings.useExtra.developers.mike.oscale = MatchSettings.useExtra.developers.mike.scale = 1.3;
                     MatchSettings.useExtra.developers.justin.unitInfo.extra.permReflect = 1;
                     MatchSettings.useExtra.developers.justin.unitInfo.extra.permWallhack = 1;
                     MatchSettings.useExtra.developers.justin.unitInfo.extra.permRegen = 1;
                     MatchSettings.useExtra.developers.justin.unitInfo.skills.stealth_ = 1;
                     MatchSettings.useExtra.developers.justin.status.reset();
                     MatchSettings.useExtra.developers.justin.MC.scaleX = MatchSettings.useExtra.developers.justin.MC.scaleY = MatchSettings.useExtra.developers.justin.oscale = MatchSettings.useExtra.developers.justin.scale = 1.3;
                     ++this.script;
                  }
                  break;
               case 6:
                  if(this.matchSettings.team1score >= 23)
                  {
                     this.hud.setMsg(MatchSettings.useExtra.developers.justin,"That\'s it, DOUBLE WEAPONS!");
                     MatchSettings.useExtra.developers.mike.unitInfo.extra.permAkimbo = 1;
                     MatchSettings.useExtra.developers.mike.status.reset();
                     MatchSettings.useExtra.developers.justin.unitInfo.extra.permAkimbo = 1;
                     MatchSettings.useExtra.developers.justin.status.reset();
                     ++this.script;
                  }
            }
         }
         this.mapParticles.EnterFrame();
         this.arena.EnterFrame();
         this.physWorld.EnterFrame();
         for(_loc1_ = 0; _loc1_ < this.killstreaks.length; this.killstreaks[_loc1_].EnterFrame(),_loc1_++)
         {
         }
         this.hud.EnterFrame();
         for(_loc1_ = 0; _loc1_ < this.units.length; this.units[_loc1_].EnterFrame(),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < this.arena.pickups.length; this.arena.pickups[_loc1_].EnterFrame(),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < this.bullets.length; this.bullets[_loc1_].EnterFrame(),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < this.bullets.length; _loc1_++)
         {
            if(this.bullets[_loc1_].remove)
            {
               this.bullets.splice(_loc1_,1);
            }
         }
         for(_loc1_ = 0; _loc1_ < this.effects.length; this.effects[_loc1_].EnterFrame(),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < this.effects.length; _loc1_++)
         {
            if(this.effects[_loc1_].remove)
            {
               this.effects.splice(_loc1_,1);
            }
         }
         this.matchSettings.EnterFrame();
         this.radar.EnterFrame();
         this.water.EnterFrame();
      }
      
      public function mechAction(_action:String) : void
      {
      }
      
      private function warmActuallyYam26(_x:Number, _y:Number, _angle1:Number, _angle2:Number, _gun:Stats_Guns) : void
      {
         this.createEffect(_x,_y,_gun.effShoot);
         this.bullets.push(new _gun.cls(this,this.units[1],UT.rand(_angle1,_angle2),_x,_y,0,_gun));
      }
      
      public function onScreen(_x:Number, _y:Number, _pad:uint = 0) : Boolean
      {
         var checkX:Number = _x + this.arena.x;
         var checkY:Number = _y + this.arena.y;
         return checkX > 0 - _pad && checkX < Main.WIDTH + _pad && checkY > 0 - _pad && checkY < Main.HEIGHT + _pad;
      }
      
      public function playScreenSound(_snd:*, _x:Number, _y:Number, _louder:Boolean = false) : void
      {
         if(this.onScreen(_x,_y))
         {
            SH.playSound(_snd,_louder);
         }
      }
      
      public function createEffect(_x:Number, _y:Number, _name:String, _sub:String = "idle", _force:Boolean = false) : void
      {
         if(!_force && !this.onScreen(_x,_y,80))
         {
            return;
         }
         this.effects.push(new Effect(this,_x,_y,_name,_sub,1));
      }
      
      public function createEffectAtFrame(_x:Number, _y:Number, _name:String, _sub:String = "idle", _frame:uint = 1, _force:Boolean = false) : void
      {
         if(!_force && !this.onScreen(_x,_y,80))
         {
            return;
         }
         this.effects.push(new Effect(this,_x,_y,_name,_sub,_frame));
      }
      
      public function createParticle(_x:Number, _y:Number, _behave:String, _hitFrame:uint, _extra:Object, _name:String, _sub:String = "idle", _frame:uint = 0, _force:Boolean = false) : void
      {
         if(!_force && !this.onScreen(_x,_y,300))
         {
            return;
         }
         this.effects.push(new Particle(this,_x,_y,_behave,_hitFrame,_extra,_name,_sub,_frame));
      }
      
      public function createUnit(isCaptain:Boolean, _unitInfo:UnitInfo, _x:Number = 0, _y:Number = 0) : void
      {
         _unitInfo.prepareForGame(isCaptain);
         var _newunit:AI = new AI(this,_unitInfo);
         if(_x)
         {
            _newunit.x = _x;
         }
         if(_y)
         {
            _newunit.y = _y;
         }
         this.unitCont.addChild(_newunit);
         this.units.push(_newunit);
         _newunit.setDiffStats();
         if(MatchSettings.useExtra.developers)
         {
            if(_newunit.unitInfo.name == "Justin")
            {
               MatchSettings.useExtra.developers.justin = _newunit;
            }
            if(_newunit.unitInfo.name == "Mike")
            {
               MatchSettings.useExtra.developers.mike = _newunit;
            }
         }
      }
      
      public function MouseDown() : void
      {
         this.player.MouseDown();
         this.hud.MouseDown();
      }
      
      public function RightMouseDown() : void
      {
         this.player.RightMouseDown();
      }
      
      public function MouseUp() : void
      {
         this.player.MouseUp();
         this.hud.MouseUp();
      }
      
      public function KeyDown(e:uint) : void
      {
         this.player.KeyDown(e);
      }
      
      public function KeyUp(e:uint) : void
      {
         this.player.KeyUp(e);
      }
      
      public function flashActivate() : void
      {
      }
      
      public function flashDeactivate() : void
      {
         if(!this.gameStarted || this.gameEnded)
         {
            return;
         }
         if(!this.paused)
         {
            this.togglePause();
         }
         this.player.releaseKeys();
      }
      
      public function togglePause() : void
      {
         var _loc1_:uint = 0;
         if(!this.gameStarted || this.gameEnded)
         {
            return;
         }
         if(this.destroyed)
         {
            return;
         }
         if(!this.paused)
         {
            this.paused = true;
            this.aimer.visible = false;
            for(_loc1_ = 0; _loc1_ < this.units.length; _loc1_++)
            {
               this.units[_loc1_].stopFrames();
            }
            this.hud.gotoFrame("pause");
         }
         else
         {
            Main.STAGE.focus = Main.STAGE;
            this.paused = false;
            this.aimer.visible = true;
            for(_loc1_ = 0; _loc1_ < this.units.length; _loc1_++)
            {
               this.units[_loc1_].playFrames();
            }
            this.hud.gotoFrame("idle");
         }
         SD.saveGame();
      }
      
      public function MouseWheel() : void
      {
         this.player.gun.swapGuns();
      }
      
      public function destroy() : void
      {
         this.destroyed = true;
         this.arena.destroy();
         this.physWorld.destroy();
         this.bitscreen.destroy();
         if(this.hud.won)
         {
            if(MatchSettings.matchType == 0 && SD.curStage == Stats_Misc.maxMission - 1)
            {
               this.main.startClass(Cutscene,{
                  "start":11,
                  "end":19,
                  "showCredits":true
               });
            }
            else
            {
               this.main.startClass(PostGame);
            }
         }
         else
         {
            this.main.startClass(Menu);
         }
      }
   }
}
