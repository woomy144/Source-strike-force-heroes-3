package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class Hud extends MovieClip
   {
       
      
      public var barCont:MovieClip;
      
      public var bloodyscreen:MovieClip;
      
      public var bt_bloody:SimpleButton;
      
      public var bt_eff:SimpleButton;
      
      public var bt_glow:SimpleButton;
      
      public var bt_gore:SimpleButton;
      
      public var bt_music:SimpleButton;
      
      public var bt_qual:SimpleButton;
      
      public var bt_quit:SimpleButton;
      
      public var bt_resume:SimpleButton;
      
      public var bt_right:SimpleButton;
      
      public var bt_select:SimpleButton;
      
      public var bt_shake:SimpleButton;
      
      public var bt_sound:SimpleButton;
      
      public var bt_voice:SimpleButton;
      
      public var debug:MovieClip;
      
      public var flag1:MovieClip;
      
      public var flag2:MovieClip;
      
      public var flag3:MovieClip;
      
      public var head0:MovieClip;
      
      public var head1:MovieClip;
      
      public var head2:MovieClip;
      
      public var head3:MovieClip;
      
      public var head4:MovieClip;
      
      public var hud_bg:MovieClip;
      
      public var logo1:Logo_LogoBox;
      
      public var logo2:Logo_LogoBox;
      
      public var mc_class:MovieClip;
      
      public var mc_mode:MovieClip;
      
      public var mc_song:MovieClip;
      
      public var mc_speak:MovieClip;
      
      public var mc_startmode:MovieClip;
      
      public var mc_streak:MovieClip;
      
      public var mc_streakarrow:DownArrow;
      
      public var nextSong:SimpleButton;
      
      public var prevSong:SimpleButton;
      
      public var scorebar:MovieClip;
      
      public var txt_ammo:TextField;
      
      public var txt_ar:TextField;
      
      public var txt_bloody:TextField;
      
      public var txt_classname:TextField;
      
      public var txt_curgun:TextField;
      
      public var txt_eff:TextField;
      
      public var txt_feed:TextField;
      
      public var txt_flags:TextField;
      
      public var txt_glow:TextField;
      
      public var txt_gore:TextField;
      
      public var txt_hp:TextField;
      
      public var txt_level:TextField;
      
      public var txt_music:TextField;
      
      public var txt_qual:TextField;
      
      public var txt_quit:TextField;
      
      public var txt_respawn:TextField;
      
      public var txt_resume:TextField;
      
      public var txt_right:TextField;
      
      public var txt_shake:TextField;
      
      public var txt_song:TextField;
      
      public var txt_sound:TextField;
      
      public var txt_spare:TextField;
      
      public var txt_startdesc:TextField;
      
      public var txt_starttitle:TextField;
      
      public var txt_streakready:TextField;
      
      public var txt_voice:TextField;
      
      public var txt_win:TextField;
      
      private var game:Game;
      
      private var classChange:Boolean;
      
      private var pauseButs:Array;
      
      public var won:Boolean;
      
      public var msgForce:Boolean;
      
      public var msgTimer:Number;
      
      public var respawnTimer:uint;
      
      private var feeds:Array;
      
      private var txtFmt:TextFormat;
      
      private var curSong;
      
      private var changeHero:AI;
      
      public function Hud(_game:Game)
      {
         super();
         addFrameScript(7,this.frame8,69,this.frame70,99,this.frame100,100,this.frame101,250,this.frame251);
         this.game = _game;
         gotoAndPlay("start");
         this.mc_startmode.gotoAndStop(MatchSettings.useMode);
         this.txt_starttitle.text = Stats_Misc.getGameMode(MatchSettings.useMode).name;
         this.txt_startdesc.text = Stats_Misc.getGameMode(MatchSettings.useMode).desc;
         this.reset();
         this.scorebar.modetxt.text = Stats_Misc.getGameMode(MatchSettings.useMode).name;
         this.feeds = [];
         this.txtFmt = new TextFormat();
         this.processFeed();
         if(MatchSettings.useMode == "dom")
         {
            this.flag1.txt_letter.text = "A";
            this.flag2.txt_letter.text = "B";
            this.flag3.txt_letter.text = "C";
         }
         else if(MatchSettings.useMode == "ctf")
         {
            this.flag2.visible = false;
            this.flag1.gotoAndStop(this.game.arena.flag1.team * 5);
            this.flag3.gotoAndStop(this.game.arena.flag2.team * 5);
            this.flag1.txt_letter.text = "";
            this.flag3.txt_letter.text = "";
         }
         else
         {
            this.flag1.visible = false;
            this.flag2.visible = false;
            this.flag3.visible = false;
         }
         this.txt_flags.text = "";
         if(MatchSettings.useSong)
         {
            this.curSong = MatchSettings.useSong;
         }
         else
         {
            this.curSong = UT.randEl(SH.songList);
         }
         SH.playMusic(this.curSong);
         this.mc_streakarrow.visible = false;
         this.txt_streakready.text = "";
         this.bloodyscreen.gotoAndStop(!!SD.screenBlood ? 1 : 2);
         this.mc_mode.gotoAndStop(MatchSettings.useMode);
      }
      
      public function createHeads() : void
      {
         var unitInfo:UnitInfo = null;
         for(var i:uint = 0; i < 5; i++)
         {
            this["head" + i].visible = false;
            if(!(SD.squad[i] < 0 || i >= SD.squad.length))
            {
               unitInfo = SD.heroes[SD.squad[i]];
               Stats_Classes.setSkin(this["head" + i],unitInfo,true);
               this["head" + i].mc_class.gotoAndStop(unitInfo.cls);
               this["head" + i].newskill.visible = false;
               this["head" + i].gotoAndStop(Math.ceil(unitInfo.status / 100));
               this["head" + i].selected.visible = unitInfo == this.game.player.unitInfo;
               this["head" + i].bt.visible = unitInfo != this.game.player.unitInfo;
            }
         }
      }
      
      public function reset() : void
      {
         this.txt_respawn.text = "";
      }
      
      public function setGuns(_curGun:Stats_Guns, _nextGun:Stats_Guns) : void
      {
         this.txt_curgun.text = _curGun.name;
      }
      
      public function setAmmoCount(_curGun:Stats_Guns) : void
      {
         if(_curGun.noAmmo)
         {
            this.txt_ammo.text = "-";
            this.txt_spare.text = "---";
            this.hud_bg.bar_ammo.bar.width = 100;
         }
         else
         {
            this.txt_ammo.text = "" + Math.ceil(_curGun.clipAmmo);
            this.hud_bg.bar_ammo.bar.width = _curGun.clipAmmo / _curGun.clipSize * 100;
            if(_curGun.spareMax == 0)
            {
               this.txt_spare.text = "---";
            }
            else if(_curGun.spareAmmo < 10)
            {
               this.txt_spare.text = "00" + _curGun.spareAmmo;
            }
            else if(_curGun.spareAmmo < 100)
            {
               this.txt_spare.text = "0" + _curGun.spareAmmo;
            }
            else
            {
               this.txt_spare.text = "" + _curGun.spareAmmo;
            }
         }
      }
      
      public function setPauseText() : void
      {
         this.txt_qual.text = ["Low","Medium","High"][SD.graphQual];
         this.txt_eff.text = ["Low","Medium","High"][SD.graphPart];
         this.txt_glow.text = !!SD.graphLights ? "On" : "Off";
         this.txt_music.text = !!SD.music ? "On" : "Off";
         this.txt_sound.text = !!SD.sound ? "On" : "Off";
         this.txt_voice.text = !!SD.voices ? "On" : "Off";
         this.txt_shake.text = !!SD.screenShake ? "On" : "Off";
         this.txt_bloody.text = !!SD.screenBlood ? "On" : "Off";
         this.txt_gore.text = ["Low","Medium","High"][SD.blood];
         this.txt_right.text = ["Reload","Killstreak","Swap Gun"][SD.rightclick];
      }
      
      public function InitPause() : void
      {
         this.pauseButs = ["qual","eff","glow","music","sound","voice","shake","bloody","gore","right"];
         this.setPauseText();
         this.game.matchSettings.showScores(this.barCont);
         this.txt_quit.mouseEnabled = false;
         this.txt_resume.mouseEnabled = false;
         if(MatchSettings.useSong)
         {
            this.nextSong.visible = this.prevSong.visible = false;
         }
         this.txt_song.text = SH.songNames[SH.songList.indexOf(this.curSong)];
      }
      
      public function InitEnd() : void
      {
         this.txt_respawn.text = "";
         this.txt_win.text = !!this.won ? "Victory" : "Defeat";
         this.txt_win.textColor = !!this.won ? uint(13434879) : uint(16764057);
         this.game.matchSettings.showScores(this.barCont);
         SD.saveGame();
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(this.game.destroyed)
         {
            return;
         }
         if(this.game.paused)
         {
            this.txt_resume.alpha = !!this.txt_resume.hitTestPoint(mouseX,mouseY,false) ? Number(1) : Number(0.5);
            this.txt_quit.alpha = !!this.txt_quit.hitTestPoint(mouseX,mouseY,false) ? Number(1) : Number(0.5);
            return;
         }
         if(this.msgTimer == 1)
         {
            this.mc_speak.gotoAndPlay("close");
            this.msgForce = false;
         }
         if(this.msgTimer)
         {
            --this.msgTimer;
         }
         if(this.respawnTimer == 1)
         {
            this.txt_respawn.text = "";
         }
         if(this.respawnTimer)
         {
            --this.respawnTimer;
         }
         for(_loc1_ = 0; _loc1_ < this.feeds.length; _loc1_++)
         {
            --this.feeds[_loc1_].timer;
            if(!this.feeds[_loc1_].timer)
            {
               this.feeds.pop();
               this.processFeed();
            }
         }
         if(MatchSettings.useMode == "dom")
         {
            _loc2_ = 0;
            for(_loc1_ = 0; _loc1_ < this.game.arena.holdpoints.length; _loc1_++)
            {
               if(this.game.arena.holdpoints[_loc1_].curTeam == 1)
               {
                  _loc2_++;
               }
               this["flag" + (_loc1_ + 1)].gotoAndStop(this.game.arena.holdpoints[_loc1_].curTeam + 1);
            }
            this.txt_flags.text = _loc2_ + " point" + (_loc2_ != 1 ? "s" : "") + " per 3 sec";
         }
         else if(MatchSettings.useMode == "ctf")
         {
            this.txt_flags.text = "";
            if(this.game.arena.flag1.unitCaptured)
            {
               this.flag1.gotoAndStop(this.game.arena.flag1.team * 5 + 1);
               this.flag1.txt_letter.text = this.game.arena.flag1.team == 1 ? "?" : "!";
               if(this.game.arena.flag1.team == 1)
               {
                  this.txt_flags.text = "Your flag is taken!";
               }
            }
            else
            {
               this.flag1.gotoAndStop(this.game.arena.flag1.team * 5);
               this.flag1.txt_letter.text = "";
            }
            if(this.game.arena.flag2.unitCaptured)
            {
               this.flag3.gotoAndStop(this.game.arena.flag2.team * 5 + 1);
               this.flag3.txt_letter.text = this.game.arena.flag2.team == 1 ? "?" : "!";
               if(this.game.arena.flag2.team == 1)
               {
                  this.txt_flags.text = "Your flag is taken!";
               }
            }
            else
            {
               this.flag3.gotoAndStop(this.game.arena.flag2.team * 5);
               this.flag3.txt_letter.text = "";
            }
         }
         if(this.game.player)
         {
            for(_loc1_ = 0; _loc1_ < 5; _loc1_++)
            {
               if(!(SD.squad[_loc1_] < 0 || _loc1_ >= SD.squad.length))
               {
                  this["head" + _loc1_].visible = this.game.player.dead || !this.game.player.human;
               }
            }
            this.bt_select.visible = !this.game.player.human;
         }
      }
      
      public function EndGame() : void
      {
         this.game.destroy();
      }
      
      public function MouseUp() : void
      {
      }
      
      public function MouseDown() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this.game.paused)
         {
            for(_loc2_ = 0; _loc2_ < this.pauseButs.length; _loc2_++)
            {
               if(this["bt_" + this.pauseButs[_loc2_]].hitTestPoint(mouseX,mouseY,false))
               {
                  switch(this.pauseButs[_loc2_])
                  {
                     case "qual":
                        SD.graphQual = ++SD.graphQual % 3;
                        Main.STAGE.quality = ["low","medium","high"][SD.graphQual];
                        break;
                     case "eff":
                        SD.graphPart = ++SD.graphPart % 3;
                        break;
                     case "glow":
                        SD.graphLights = !SD.graphLights;
                        break;
                     case "music":
                        SD.music = !SD.music;
                        break;
                     case "sound":
                        SD.sound = !SD.sound;
                        break;
                     case "voice":
                        SD.voices = !SD.voices;
                        break;
                     case "shake":
                        SD.screenShake = !SD.screenShake;
                        break;
                     case "bloody":
                        SD.screenBlood = !SD.screenBlood;
                        this.bloodyscreen.gotoAndStop(!!SD.screenBlood ? 1 : 2);
                        break;
                     case "gore":
                        SD.blood = ++SD.blood % 3;
                        break;
                     case "right":
                        SD.rightclick = ++SD.rightclick % 3;
                  }
                  this.setPauseText();
                  break;
               }
            }
            if(this.bt_resume.hitTestPoint(mouseX,mouseY,false))
            {
               if(this.txt_resume.text == "Resume")
               {
                  this.game.togglePause();
               }
               else if(this.txt_resume.text == "Confirm")
               {
                  this.game.destroy();
               }
            }
            else if(this.bt_quit.hitTestPoint(mouseX,mouseY,false))
            {
               if(this.txt_quit.text == "Quit")
               {
                  this.txt_resume.text = "Confirm";
                  this.txt_quit.text = "Cancel";
               }
               else if(this.txt_quit.text == "Cancel")
               {
                  this.txt_resume.text = "Resume";
                  this.txt_quit.text = "Quit";
               }
            }
            if(this.curSong && this.nextSong.visible && this.nextSong.hitTestPoint(mouseX,mouseY,false))
            {
               this.curSong = UT.getNextEl(this.curSong,true,SH.songList);
               SH.playMusic(this.curSong);
               this.txt_song.text = SH.songNames[SH.songList.indexOf(this.curSong)];
            }
            if(this.curSong && this.prevSong.visible && this.prevSong.hitTestPoint(mouseX,mouseY,false))
            {
               this.curSong = UT.getNextEl(this.curSong,false,SH.songList);
               SH.playMusic(this.curSong);
               this.txt_song.text = SH.songNames[SH.songList.indexOf(this.curSong)];
            }
            return;
         }
         var _loc1_:int = -1;
         for(_loc2_ = 0; _loc2_ < 5; _loc2_++)
         {
            if(!(SD.squad[_loc2_] < 0 || _loc2_ >= SD.squad.length))
            {
               if(this["head" + _loc2_].bt.visible && this["head" + _loc2_].bt.hitTestPoint(mouseX,mouseY))
               {
                  for(_loc3_ = 0; _loc3_ < this.game.units.length; _loc3_++)
                  {
                     if(SD.heroes[SD.squad[_loc2_]] == this.game.units[_loc3_].unitInfo)
                     {
                        _loc1_ = _loc2_;
                        this.changeHero = this.game.units[_loc3_];
                        this.game.setPlayer(this.changeHero,false);
                     }
                  }
               }
            }
         }
         if(_loc1_ >= 0)
         {
            for(_loc2_ = 0; _loc2_ < 5; _loc2_++)
            {
               this["head" + _loc2_].bt.visible = _loc2_ != _loc1_;
               this["head" + _loc2_].selected.visible = _loc2_ == _loc1_;
            }
         }
         if(this.bt_select.visible && this.bt_select.hitTestPoint(mouseX,mouseY))
         {
            this.game.setPlayer(this.changeHero,true);
            this.setHudStuff();
            this.changeHero = null;
         }
      }
      
      public function setHudStuff() : void
      {
         this.mc_class.gotoAndStop(this.game.player.unitInfo.cls);
         this.mc_streak.gotoAndStop(this.game.player.unitInfo.streak);
      }
      
      public function setScoreBar(_team1:int, _score1:int, _team2:int, _score2:int) : void
      {
         this.scorebar.scorebar1.bar.gotoAndStop(_team1 + (_team1 == 0 ? 1 : 2));
         this.scorebar.scorebar2.bar.gotoAndStop(_team2 + 2);
         this.scorebar.scorebar1.bar.width = _score1 / MatchSettings.useScore * 130;
         this.scorebar.scorebar2.bar.width = _score2 / MatchSettings.useScore * 130;
         this.scorebar.scorebar1.cap.x = this.scorebar.scorebar1.bar.x + this.scorebar.scorebar1.bar.width;
         this.scorebar.scorebar2.cap.x = this.scorebar.scorebar2.bar.x + this.scorebar.scorebar2.bar.width;
         this.scorebar.scoretxt1.text = "> " + _score1;
         this.scorebar.scoretxt2.text = "" + _score2;
      }
      
      public function startGame() : void
      {
         this.game.startGame();
      }
      
      public function setRespawnText(_txt:String, _col:uint = 16777215) : void
      {
         this.txt_respawn.text = _txt;
         this.txt_respawn.textColor = _col;
         this.respawnTimer = 3 * 30;
      }
      
      public function setMsg(_unit:AI, _desc:String, _timer:uint = 0, _force:Boolean = false, _voice:* = null) : void
      {
         var i:uint = 0;
         if(this.msgForce && !_force)
         {
            return;
         }
         if(_unit is String)
         {
            for(i = 0; i < this.game.units.length; i++)
            {
               if(this.game.units[i] != this.game.player)
               {
                  if(this.game.units[i].name == _unit)
                  {
                     _unit = this.game.units[i];
                     break;
                  }
               }
            }
            if(_unit is String)
            {
               return;
            }
         }
         this.mc_speak.gotoAndPlay("open");
         Stats_Classes.setSkin(this.mc_speak,_unit.unitInfo,true);
         this.mc_speak.txt_name.text = _unit.unitInfo.name;
         this.mc_speak.txt_desc.text = _desc;
         this.msgForce = _force;
         if(_voice)
         {
            _timer = SH.playVoice(_voice);
            trace("Voice length:",_timer);
            if(_timer < 2)
            {
               _timer = 2;
            }
            _timer += 1.5;
            trace("Final Voice length:",_timer);
         }
         else if(!_timer)
         {
            _timer = 4;
         }
         this.msgTimer = _timer * 30;
      }
      
      public function setCharMsg(_cls:String, _head:uint, _camo:uint, _name:String, _desc:String, _timer:uint = 4, _force:Boolean = false, _voice:* = null) : void
      {
         if(this.msgForce && !_force)
         {
            return;
         }
         this.mc_speak.gotoAndPlay("open");
         if(this.mc_speak.head.camo)
         {
            this.mc_speak.head.camo.gotoAndStop(_camo);
         }
         this.mc_speak.txt_name.text = _name;
         this.mc_speak.txt_desc.text = _desc;
         this.msgForce = _force;
         if(_voice)
         {
            _timer = SH.playVoice(_voice);
            if(_timer < 1)
            {
               _timer = 1;
            }
            _timer += 1.5;
         }
         else if(!_timer)
         {
            _timer = 4;
         }
         this.msgTimer = _timer * 30;
      }
      
      public function setMsgRandomTeammate(_team:uint, _desc:String) : void
      {
         var _unit:* = undefined;
         var tries:uint = 0;
         do
         {
            _unit = UT.randEl(this.game.units);
            tries++;
            if(tries == 20)
            {
               _unit = this.game.player;
               break;
            }
         }
         while(_unit.team != _team || _unit == this.game.player);
         
         this.setMsg(_unit,_desc,4);
      }
      
      public function addCustomFeed(_user:*, _type:String) : void
      {
         switch(_type)
         {
            case "levelup":
               this.feeds.unshift({
                  "txt":[_user.name," has LEVELED UP"],
                  "col":[this.getUnitColour(_user),16776960],
                  "timer":90
               });
               break;
            case "flag":
               this.feeds.unshift({
                  "txt":[_user.name + " has captured " + (_user.team == 1 ? "the enemy" : "your") + " flag!"],
                  "col":[this.getUnitColour(_user)],
                  "timer":90
               });
               break;
            case "jug":
               this.feeds.unshift({
                  "txt":[_user.name + " is the One Man Army!"],
                  "col":[this.getUnitColour(_user)],
                  "timer":90
               });
               break;
            case "holdpoint":
               this.feeds.unshift({
                  "txt":[(_user.team == 1 ? "An enemy" : "Your") + " point has been captured!"],
                  "col":[this.getUnitColour(_user)],
                  "timer":90
               });
         }
         this.processFeed();
      }
      
      public function addKillstreakFeed(_user:*, _killstreak:Stats_Perks) : void
      {
         this.feeds.unshift({
            "txt":[_user.name," used killstreak ",_killstreak.name],
            "col":[this.getUnitColour(_user),13421772,13434879],
            "timer":90
         });
         this.processFeed();
      }
      
      public function addKillFeed(_dead:*, _killer:*, _weapon:Stats_Guns) : void
      {
         var killCol:uint = this.getUnitColour(_killer);
         var deadCol:uint = this.getUnitColour(_dead);
         if(_dead == _killer)
         {
            this.feeds.unshift({
               "txt":["Suicide"," [" + _weapon.name + "] ",_killer.name],
               "col":[16751103,13421772,killCol],
               "timer":90
            });
            this.processFeed();
            return;
         }
         this.feeds.unshift({
            "txt":[_killer.name," [" + _weapon.name + "] ",_dead.name],
            "col":[killCol,13421772,deadCol],
            "timer":90
         });
         this.processFeed();
      }
      
      public function processFeed() : void
      {
         var _loc1_:uint = 0;
         var _loc3_:uint = 0;
         if(this.feeds.length > 13)
         {
            this.feeds.pop();
         }
         this.txt_feed.text = "";
         for(_loc1_ = 0; _loc1_ < this.feeds.length; _loc1_++)
         {
            this.txt_feed.text += this.feeds[_loc1_].txt.join("") + "\n";
         }
         var _loc2_:uint = 0;
         for(_loc1_ = 0; _loc1_ < this.feeds.length; _loc1_++)
         {
            for(_loc3_ = 0; _loc3_ < this.feeds[_loc1_].txt.length; _loc3_++)
            {
               this.txtFmt.color = this.feeds[_loc1_].col[_loc3_];
               this.txt_feed.setTextFormat(this.txtFmt,_loc2_,_loc2_ + this.feeds[_loc1_].txt[_loc3_].length + 1);
               _loc2_ += this.feeds[_loc1_].txt[_loc3_].length;
            }
            _loc2_ += 1;
         }
      }
      
      public function getUnitColour(_unit:*) : uint
      {
         return !!_unit.human ? uint(10079487) : (_unit.team == 1 ? uint(6724095) : uint(16737792));
      }
      
      public function gotoFrame(_frame:*) : void
      {
         if(!this.game.gameEnded)
         {
            gotoAndStop(_frame);
         }
      }
      
      public function setDebug(num:uint, str:String) : void
      {
         this.debug["debug" + num].text = str;
      }
      
      function frame8() : *
      {
         this.InitPause();
      }
      
      function frame70() : *
      {
         this.startGame();
      }
      
      function frame100() : *
      {
         gotoAndStop("idle");
      }
      
      function frame101() : *
      {
         this.InitEnd();
      }
      
      function frame251() : *
      {
         this.EndGame();
      }
   }
}
