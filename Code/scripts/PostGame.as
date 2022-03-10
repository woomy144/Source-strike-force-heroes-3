package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   public class PostGame extends MovieClip
   {
       
      
      public var bar0:MovieClip;
      
      public var bar1:MovieClip;
      
      public var bar2:MovieClip;
      
      public var bar3:MovieClip;
      
      public var bar4:MovieClip;
      
      public var bar5:MovieClip;
      
      public var bt_back:SimpleButton;
      
      public var char:MovieClip;
      
      public var levelup:MovieClip;
      
      public var squad0:MovieClip;
      
      public var squad1:MovieClip;
      
      public var squad2:MovieClip;
      
      public var squad3:MovieClip;
      
      public var squad4:MovieClip;
      
      public var txt_back:TextField;
      
      public var txt_day:TextField;
      
      public var txt_funds:TextField;
      
      public var txt_title:TextField;
      
      private var main:Main;
      
      private var sharedExp:Number;
      
      private var earnedFunds:Number;
      
      private var squadAmt:int = 0;
      
      private var curChar:UnitInfo;
      
      private var showedChar:UnitInfo;
      
      private var curCharNum:int;
      
      private var expSpd:Number;
      
      private var state:String;
      
      private var tempFunds:Number;
      
      public function PostGame(_main:Main, _extra:Object)
      {
         var unitInfo:UnitInfo = null;
         var mc:MovieClip = null;
         super();
         this.main = _main;
         SH.playMusic(M_Menu);
         this.txt_back.mouseEnabled = false;
         this.txt_back.visible = false;
         this.bt_back.visible = false;
         this.squadAmt = 0;
         this.sharedExp = 0;
         this.earnedFunds = 0;
         this.showedChar = SD.heroes[SD.squad[0]];
         Stats_Classes.setSkin(this.char,this.showedChar,false,false,true);
         this.char.gun.gotoAndStop("Empty");
         this.char.gun.visible = false;
         this.char.x = 800;
         for(var i:uint = 0; i < 5; i++)
         {
            this["squad" + i].gotoAndStop(2);
            if(!(SD.squad[i] < 0 || i >= SD.squad.length))
            {
               ++this.squadAmt;
               unitInfo = SD.heroes[SD.squad[i]];
               mc = this["squad" + i];
               mc.gotoAndStop(1);
               mc.txt_name.text = unitInfo.name;
               mc.txt_level.text = "Lv " + unitInfo.level;
               Stats_Classes.setActiveStatus(mc.txt_status,unitInfo);
               Stats_Classes.setSkin(mc.icon,unitInfo,true);
               mc.icon.mc_class.gotoAndStop(unitInfo.cls);
               mc.icon.gotoAndStop(Math.ceil(unitInfo.status / 100));
               mc.icon.bt.visible = false;
               mc.icon.selected.visible = false;
               mc.icon.newskill.visible = false;
               mc.bar.width = unitInfo.exp / Stats_Classes.getNextExp(unitInfo.level) * 215;
               if(unitInfo.level >= Stats_Misc.maxLvl)
               {
                  mc.bar.width = 225;
               }
               if(unitInfo.skills.gold1)
               {
                  unitInfo.earnedFunds *= unitInfo.skills.gold1;
               }
               if(unitInfo.skills.gold0)
               {
                  unitInfo.earnedFunds *= unitInfo.skills.gold0;
               }
               if(unitInfo.skills.exp1)
               {
                  unitInfo.earnedExp *= unitInfo.skills.exp1;
               }
               if(unitInfo.skills.exp0)
               {
                  unitInfo.earnedExp *= unitInfo.skills.exp0;
               }
               this.earnedFunds += unitInfo.earnedFunds;
               this.sharedExp += unitInfo.earnedExp * 0.6;
               unitInfo.earnedExp -= unitInfo.earnedExp * 0.6;
            }
         }
         this.txt_day.text = "" + SD.day;
         this.txt_funds.text = "$" + Math.ceil(SD.funds) + "    $" + Math.ceil(this.earnedFunds);
         this.state = "exp";
         this.curCharNum = -1;
         this.setNextExpChar();
         this.tempFunds = SD.funds;
      }
      
      private function setNextExpChar() : void
      {
         ++this.curCharNum;
         if(this.curCharNum >= SD.squad.length)
         {
            this.setFunds();
            return;
         }
         if(SD.squad[this.curCharNum] < 0)
         {
            this.setNextExpChar();
            return;
         }
         this.curChar = SD.heroes[SD.squad[this.curCharNum]];
         this.curChar.earnedExp += this.sharedExp / this.squadAmt;
         if(this.curChar.earnedExp > Stats_Classes.getNextExp(this.curChar.level))
         {
            this.curChar.earnedExp = Stats_Classes.getNextExp(this.curChar.level);
         }
         this.expSpd = this.curChar.earnedExp / 30;
         trace(this.curChar.exp,this.curChar.earnedExp,this.expSpd);
         var reduceStatus:Number = 15 + SD.stages.length * 0.25;
         reduceStatus *= SD.soloTired;
         if(this.curChar.skills.tired1)
         {
            reduceStatus *= this.curChar.skills.tired1;
         }
         if(this.curChar.skills.tired0)
         {
            reduceStatus *= this.curChar.skills.tired0;
         }
         trace(this.curChar.name,reduceStatus);
         if(this.curChar.status <= 300)
         {
            if(this.curChar.status > 200)
            {
               reduceStatus *= 1.1;
            }
            else if(this.curChar.status > 100)
            {
               reduceStatus *= 1.5;
            }
            else
            {
               reduceStatus *= 10;
            }
         }
         this.curChar.status -= reduceStatus;
         if(this.curChar.status < 0)
         {
            this.curChar.status = 0;
         }
         Stats_Classes.setActiveStatus(this["squad" + this.curCharNum].txt_status,this.curChar);
         this.showBar(this.curCharNum);
      }
      
      private function setFunds() : void
      {
         this.state = "funds";
         ++SD.day;
         this.expSpd = this.earnedFunds / 60;
         this.showBar(5);
      }
      
      private function showBar(num:int = -1) : void
      {
         for(var i:uint = 0; i < 6; this["bar" + i].visible = false,i++)
         {
         }
         if(num > 0)
         {
            this["bar" + num].visible = true;
         }
      }
      
      public function EnterFrame() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:MovieClip = null;
         switch(this.state)
         {
            case "exp":
               _loc2_ = false;
               this.curChar.earnedExp -= this.expSpd;
               if(this.curChar.earnedExp <= 0)
               {
                  this.expSpd = -this.curChar.earnedExp;
                  _loc2_ = true;
               }
               this.curChar.exp += this.expSpd;
               if(this.curChar.level >= Stats_Misc.maxLvl)
               {
                  this.curChar.exp = Stats_Classes.getNextExp(this.curChar.level);
               }
               else if(this.curChar.exp > Stats_Classes.getNextExp(this.curChar.level) && this.curChar.level < Stats_Misc.maxLvl)
               {
                  this.curChar.exp -= Stats_Classes.getNextExp(this.curChar.level);
                  ++this.curChar.level;
                  this["squad" + this.curCharNum].icon.selected.visible = true;
                  this["squad" + this.curCharNum].icon.newskill.visible = true;
                  this["squad" + this.curCharNum].scaleX = this["squad" + this.curCharNum].scaleY = 1.2;
                  if(this.showedChar != this.curChar)
                  {
                     this.showedChar = this.curChar;
                     Stats_Classes.setSkin(this.char,this.showedChar,false,false,true);
                     this.char.gun.gotoAndStop("Empty");
                     this.char.gun.visible = false;
                     this.char.x = 800;
                  }
                  this.char.gotoAndPlay("levelup");
                  this.char.gun.gotoAndStop("Empty");
                  this.char.gun.visible = false;
                  SH.playSound(S_Win1);
                  this.levelup.gotoAndPlay(1);
                  if(this.curChar.level == Stats_Misc.maxLvl)
                  {
                     Stats_Achievements.setAchievement("levelmax");
                  }
               }
               this["squad" + this.curCharNum].bar.width = this.curChar.exp / Stats_Classes.getNextExp(this.curChar.level) * 215;
               this["squad" + this.curCharNum].txt_level.text = "Lv " + this.curChar.level;
               if(_loc2_)
               {
                  this.setNextExpChar();
               }
               break;
            case "funds":
               _loc2_ = false;
               this.earnedFunds -= this.expSpd;
               if(this.earnedFunds <= 0)
               {
                  this.expSpd = -this.earnedFunds;
                  _loc2_ = true;
               }
               this.tempFunds += this.expSpd;
               this.txt_day.text = "" + SD.day;
               this.txt_funds.text = "$" + Math.ceil(this.tempFunds) + "    $" + Math.ceil(this.earnedFunds);
               if(_loc2_)
               {
                  this.state = "done";
                  this.showBar();
                  SD.funds = Math.ceil(this.tempFunds);
                  this.txt_funds.text = "$" + SD.funds;
                  this.finalThings();
               }
               break;
            case "done":
         }
         for(var _loc1_:uint = 0; _loc1_ < SD.squad.length; _loc1_++)
         {
            _loc3_ = this["squad" + _loc1_];
            _loc3_.scaleX += (1 - _loc3_.scaleX) * 0.1;
            _loc3_.scaleY += (1 - _loc3_.scaleY) * 0.1;
         }
         this.char.x += (600 - this.char.x) * 0.3;
      }
      
      public function finalThings() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         for(_loc1_ = 0; _loc1_ < SD.heroes.length; _loc1_++)
         {
            if(SD.squad.indexOf(_loc1_) == -1)
            {
               SD.heroes[_loc1_].status += 50;
               if(SD.heroes[_loc1_].status > 400)
               {
                  SD.heroes[_loc1_].status = 400;
               }
            }
         }
         SD.nextStoreRow();
         switch(MatchSettings.matchType)
         {
            case 0:
               trace("Stage",SD.curStage,"completed");
               if(SD.curStage == 11)
               {
                  trace("Stage 10 completed");
                  AGI.submitQuest("stage10");
               }
               for(_loc1_ = 0; _loc1_ < 3; _loc1_++)
               {
                  if(SD.curDiff > SD.stages[SD.curStage] && SD.stages[SD.curStage] == _loc1_)
                  {
                     SD.stages[SD.curStage] = _loc1_ + 1;
                     if(Stats_Missions.itemAr[SD.curStage].rewards[_loc1_] == "random2")
                     {
                        SD.mapItem.push(this.getHighRarity());
                     }
                     else
                     {
                        SD.mapItem.push(Stats_Missions.itemAr[SD.curStage].rewards[_loc1_]);
                     }
                     _loc2_ = true;
                  }
               }
               if(!_loc2_)
               {
                  SD.mapItem.push(this.getLowRarity());
               }
               if(!Stats_Missions.itemAr[SD.curStage].challenge)
               {
                  if(SD.curStage == SD.stages.length - 1 && SD.stages.length < Stats_Misc.maxMission)
                  {
                     if(SD.stages.length == 4)
                     {
                        SD.autoShowAd = true;
                     }
                     SD.stages.push(0);
                     SD.curStage = SD.stages.length - 1;
                     if(Stats_Missions.itemAr[SD.stages.length - 1].challenge && SD.stages.length < Stats_Misc.maxMission)
                     {
                        SD.stages.push(0);
                        SD.curStage = SD.stages.length - 1;
                     }
                  }
               }
               trace("Mission stats");
               if(SD.stages.length >= Stats_Misc.maxMission)
               {
                  _loc3_ = 99;
                  _loc4_ = 99;
                  _loc5_ = 99;
                  for(_loc1_ = 0; _loc1_ < Stats_Misc.maxMission; _loc1_++)
                  {
                     if(Stats_Missions.itemAr[_loc1_].challenge)
                     {
                        if(SD.stages[_loc1_] < _loc4_)
                        {
                           _loc4_ = SD.stages[_loc1_];
                        }
                        trace(_loc1_,"Chal",SD.stages[_loc1_],_loc4_);
                     }
                     else
                     {
                        if(SD.stages[_loc1_] < _loc3_)
                        {
                           _loc3_ = SD.stages[_loc1_];
                        }
                        trace(_loc1_,"Miss",SD.stages[_loc1_],_loc3_);
                     }
                     if(SD.stages[_loc1_] < _loc5_)
                     {
                        _loc5_ = SD.stages[_loc1_];
                     }
                  }
                  if(_loc3_ >= 1)
                  {
                     Stats_Achievements.setAchievement("campaign");
                  }
                  if(_loc4_ >= 1)
                  {
                     Stats_Achievements.setAchievement("challenges");
                  }
                  if(_loc5_ >= 2)
                  {
                     Stats_Achievements.setAchievement("hard");
                  }
                  if(_loc5_ >= 3)
                  {
                     Stats_Achievements.setAchievement("insane");
                  }
                  trace(_loc3_,_loc4_,_loc5_);
               }
               break;
            case 2:
               if(!SD.checkDaily())
               {
                  SD.mapItem.push(this.getHighRarity());
               }
               SD.saveDaily();
               break;
            case 1:
         }
         SD.justHired = false;
         SD.saveGame();
         this.txt_back.visible = true;
         this.bt_back.visible = true;
      }
      
      private function getLowRarity() : GunInfo
      {
         var id:String = Stats_Guns.getRandomGunId();
         var rarity:int = UT.randEl(SD.randRarity);
         var level:int = Stats_Misc.getLevelReq(SD.curStage,SD.curDiff);
         if(level < 1)
         {
            level = 1;
         }
         if(level > 31)
         {
            level = 31;
         }
         return new GunInfo(id,level,rarity);
      }
      
      private function getHighRarity() : GunInfo
      {
         var id:String = Stats_Guns.getRandomGunId();
         var rarity:int = UT.randEl(SD.randHighRarity);
         var level:int = Stats_Misc.getLevelReq(SD.curStage,SD.curDiff) + UT.irand(-3,2);
         if(level < 1)
         {
            level = 1;
         }
         if(level > 31)
         {
            level = 31;
         }
         return new GunInfo(id,level,rarity);
      }
      
      public function MouseDown() : void
      {
         if(this.bt_back.visible && this.bt_back.hitTestPoint(mouseX,mouseY))
         {
            this.main.startClass(Menu);
            SH.playSound(S_Click);
         }
      }
      
      public function MouseUp() : void
      {
      }
      
      public function KeyDown(e:int) : void
      {
      }
      
      public function KeyUp(e:int) : void
      {
      }
      
      public function flashActivate() : void
      {
      }
      
      public function flashDeactivate() : void
      {
      }
      
      public function MouseWheel(e:int) : void
      {
      }
   }
}
