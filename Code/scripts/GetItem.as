package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   public class GetItem extends MovieClip
   {
       
      
      public var bt_build:SimpleButton;
      
      public var bt_buyNO:SimpleButton;
      
      public var bt_buyNo:SimpleButton;
      
      public var bt_buyYes:SimpleButton;
      
      public var bt_cancel:SimpleButton;
      
      public var bt_fire:SimpleButton;
      
      public var bt_hire:SimpleButton;
      
      public var bt_okay:SimpleButton;
      
      public var bt_sell:SimpleButton;
      
      public var bt_sellNo:SimpleButton;
      
      public var bt_sellYes:SimpleButton;
      
      public var bt_take:SimpleButton;
      
      public var hitbox:MovieClip;
      
      public var item:ItemBox;
      
      public var item2:ItemContainer;
      
      public var shine:MovieClip;
      
      public var txt_desc:TextField;
      
      public var txt_title:TextField;
      
      public var perkInfo:String;
      
      public var gunInfo:GunInfo;
      
      private var menu:Menu;
      
      public var SDname:String;
      
      public var mode:String;
      
      private var type:String;
      
      public var bpNum:int;
      
      public function GetItem()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,90,this.frame91,104,this.frame105,121,this.frame122,136,this.frame137,147,this.frame148,170,this.frame171);
         this.InitItem();
         this.menu = Menu(parent);
      }
      
      public function InitItem(info:* = null, SDname:String = "", mode:String = "get") : void
      {
         this.type = "item";
         this.perkInfo = "";
         this.gunInfo = null;
         if(info == null)
         {
            visible = false;
            gotoAndStop("blank");
            this.item.Init();
            return;
         }
         this.SDname = SDname;
         this.mode = mode;
         if(info is String && info.charAt(0) == "$")
         {
            this.InitUniqueClass(info.substring(1));
            return;
         }
         if(info is GunInfo)
         {
            this.gunInfo = info;
         }
         else
         {
            if(Stats_Guns.itemOb[info])
            {
               this.InitGetBlueprint(info);
               return;
            }
            if(info is UnitInfo)
            {
               if(info.unique)
               {
                  this.InitUniqueHero(info);
               }
               else
               {
                  this.InitHiredHero(info);
               }
               return;
            }
            if(Stats_Classes.itemOb[info])
            {
               this.InitHeroClass(info);
               return;
            }
            if(info is Number)
            {
               this.InitGold(info);
               return;
            }
            if(info == "features")
            {
               this.InitFeatures();
               return;
            }
            this.perkInfo = info;
         }
         this.item.armorPerk = true;
         switch(mode)
         {
            case "get":
               this.setGet();
               break;
            case "sell":
               this.setSell();
               break;
            case "buy":
               this.setBuy();
         }
         visible = true;
         this.item.Init(info);
         this.item.keepOpen();
      }
      
      public function InitBuild(i:int = -1) : void
      {
         this.type = "blueprint";
         if(i == -1)
         {
            visible = false;
            return;
         }
         this.bpNum = i;
         var stats:Stats_Guns = Stats_Guns.itemAr[this.bpNum];
         gotoAndPlay("build");
         this.item2.gotoAndStop("blueprint");
         this.item2.gun.gotoAndStop(Stats_Guns.itemAr[this.bpNum].sprite);
         Main.STAGE.invalidate();
         this.item2.gun.x = -this.item2.gun.reg_menu.x * this.item2.gun.scaleX;
         this.item2.gun.y = -this.item2.gun.reg_menu.y * this.item2.gun.scaleY;
         if(this.item2.gun.clip)
         {
            this.item2.gun.clip.gotoAndStop(stats.sprite);
         }
         if(this.item2.gun.part)
         {
            this.item2.gun.part.gotoAndStop(stats.sprite);
         }
         this.item2.txt_title.text = "BLUEPRINT " + (this.bpNum + 1);
         this.txt_title.text = "Build " + Stats_Guns.getGunType(stats.type) + " for $" + Stats_Guns.getBlueprintPrice(stats.costMod) + "?";
         visible = true;
      }
      
      public function InitUnlock(i:int = -1) : void
      {
         this.type = "unlockblueprint";
         if(i == -1)
         {
            visible = false;
            return;
         }
         gotoAndPlay("unlock");
         this.item2.gotoAndStop("gun");
         this.item2.gun.gotoAndStop(Stats_Guns.itemAr[this.bpNum].sprite);
         Main.STAGE.invalidate();
         this.item2.gun.x = -this.item2.gun.reg_menu.x * this.item2.gun.scaleX;
         this.item2.gun.y = -this.item2.gun.reg_menu.y * this.item2.gun.scaleY;
         if(this.item2.gun.clip)
         {
            this.item2.gun.clip.gotoAndStop(Stats_Guns.itemAr[this.bpNum].sprite);
         }
         if(this.item2.gun.part)
         {
            this.item2.gun.part.gotoAndStop(Stats_Guns.itemAr[this.bpNum].sprite);
         }
         this.txt_title.text = "Unlocked " + Stats_Guns.getGunType(Stats_Guns.itemAr[this.bpNum].type) + "!";
         this.txt_desc.text = "The " + Stats_Guns.itemAr[this.bpNum].name + " can now be found after matches, in the store, or in the slot machine!";
         visible = true;
         SH.playSound(S_Win2);
      }
      
      public function InitFullInventory(invType:int) : void
      {
         this.type = "features";
         gotoAndPlay("unlock");
         this.item2.gotoAndStop("none");
         this.shine.visible = false;
         this.txt_title.text = "Cannot Unequip!";
         this.txt_desc.text = "Your " + Stats_Guns.getGunType(invType) + " inventory is full. Make room first before changing your weapon.";
         visible = true;
         SH.playSound(S_Error);
      }
      
      public function InitGetBlueprint(id:String) : void
      {
         this.type = "getblueprint";
         gotoAndPlay("unlock");
         this.item2.gotoAndStop("blueprint");
         this.item2.gun.gotoAndStop(Stats_Guns.itemOb[id].sprite);
         Main.STAGE.invalidate();
         this.item2.gun.x = -this.item2.gun.reg_menu.x * this.item2.gun.scaleX;
         this.item2.gun.y = -this.item2.gun.reg_menu.y * this.item2.gun.scaleY;
         if(this.item2.gun.clip)
         {
            this.item2.gun.clip.gotoAndStop(Stats_Guns.itemOb[id].sprite);
         }
         if(this.item2.gun.part)
         {
            this.item2.gun.part.gotoAndStop(Stats_Guns.itemOb[id].sprite);
         }
         this.bpNum = Stats_Guns.itemOb[id].i;
         SD.bpOther.splice(SD.bpOwned.indexOf(this.bpNum),1);
         SD.bpOwned.push(this.bpNum);
         this.txt_title.text = Stats_Guns.getGunType(Stats_Guns.itemOb[id].type) + " blueprint Acquired!";
         this.txt_desc.text = "Build this blueprint in the Workshop to unlock it in the store, slot machine, and as random rewards!";
         this.item2.txt_title.text = "BLUEPRINT " + (this.bpNum + 1);
         if(SD[this.SDname] is Array)
         {
            SD[this.SDname].shift();
         }
         else
         {
            SD[this.SDname] = null;
         }
         visible = true;
         SH.playSound(S_Win2);
      }
      
      public function InitHiredHero(unitInfo:UnitInfo) : void
      {
         this.type = "hiredhero";
         gotoAndPlay("unlock");
         this.item2.gotoAndStop("class");
         this.item2.classicon.gotoAndStop(unitInfo.cls);
         this.txt_title.text = unitInfo.name + " recruited!";
         this.txt_desc.text = "Recruited " + unitInfo.name + ", the " + Stats_Classes.itemOb[unitInfo.cls].name + ". " + Stats_Classes.itemOb[unitInfo.cls].desc;
         visible = true;
         SH.playSound(S_Win3);
      }
      
      public function InitUniqueHero(unitInfo:UnitInfo) : void
      {
         this.type = "hiredhero";
         gotoAndPlay("unlock");
         this.item2.gotoAndStop("class3");
         this.item2.classicon.gotoAndStop(unitInfo.cls);
         this.txt_title.text = unitInfo.name + " recruited!";
         this.txt_desc.text = unitInfo.name + " is a Unique Hero. As one of the best Heroes in the world, " + unitInfo.name + " will fight by your side.";
         visible = true;
         SH.playSound(S_Win3);
      }
      
      public function InitGold(num:Number) : void
      {
         this.type = "gold";
         gotoAndPlay("unlock");
         this.item2.gotoAndStop("gold");
         this.menu.setFunds(num);
         this.txt_title.text = "$" + num + " earned!";
         this.txt_desc.text = "You\'ve earned some Funds! You can use them to build blueprints, recruit heroes, or buy/upgrade weapons!";
         if(SD[this.SDname] is Array)
         {
            SD[this.SDname].shift();
         }
         else
         {
            SD[this.SDname] = null;
         }
         visible = true;
         SH.playSound(S_Win1);
      }
      
      public function InitFeatures() : void
      {
         this.type = "features";
         gotoAndPlay("unlock");
         this.item2.gotoAndStop("features");
         this.txt_title.text = "Base Expanded!";
         this.txt_desc.text = "You are now able to visit the store, play the slot machine and can upgrade and enhance your weapons!";
         if(SD[this.SDname] is Array)
         {
            SD[this.SDname].shift();
         }
         else
         {
            SD[this.SDname] = null;
         }
         visible = true;
         SH.playSound(S_Win1);
      }
      
      public function InitHeroClass(id:String) : void
      {
         this.type = "getheroclass";
         gotoAndPlay("unlock");
         this.item2.gotoAndStop("class");
         this.item2.classicon.gotoAndStop(id);
         SD.bpClasses.push(Stats_Classes.itemOb[id].i);
         SD.achOb.classes = SD.bpClasses.length;
         Stats_Achievements.checkAchVariable("classes",0);
         if(id != "gun")
         {
            SD.uniqueClasses.push(id);
         }
         this.txt_title.text = "New Class: " + Stats_Classes.itemOb[id].name + "!";
         this.txt_desc.text = Stats_Classes.itemOb[id].name + "s can now be randomly recruited from the Heroes menu! " + Stats_Classes.itemOb[id].desc;
         if(SD[this.SDname] is Array)
         {
            SD[this.SDname].shift();
         }
         else
         {
            SD[this.SDname] = null;
         }
         visible = true;
         SH.playSound(S_Win2);
      }
      
      public function InitUniqueClass(id:String) : void
      {
         this.type = "getheroclass";
         gotoAndPlay("unlock");
         this.item2.gotoAndStop("class3");
         this.item2.classicon.gotoAndStop(id);
         SD.uniqueClasses.push("$" + id);
         this.txt_title.text = "Unique Hero: " + Stats_Classes.itemOb[id].name + "!";
         this.txt_desc.text = "A Unique " + Stats_Classes.itemOb[id].name + " is waiting to be recruited! Recruit a new Hero to gain this special Unique Hero!";
         if(SD[this.SDname] is Array)
         {
            SD[this.SDname].shift();
         }
         else
         {
            SD[this.SDname] = null;
         }
         visible = true;
         trace("showing hero",visible);
         SH.playSound(S_Win2);
      }
      
      public function InitHire() : void
      {
         this.type = "hire";
         gotoAndPlay("hire");
         this.txt_title.text = "Hire a new hero for $" + Stats_Classes.getHirePrice() + "?";
         this.txt_desc.text = "(You can only hire 1 hero per day)";
         visible = true;
      }
      
      public function InitFire() : void
      {
         this.type = "fire";
         gotoAndPlay("fire");
         this.txt_title.text = "Dismiss " + SD.heroes[SD.selHero].name + "?";
         this.txt_desc.text = "Really dismiss " + SD.heroes[SD.selHero].name + "?\nThis hero and their equipment will be gone forever.";
         visible = true;
      }
      
      public function MouseDown() : void
      {
         var item:GunInfo = null;
         var unitInfo:UnitInfo = null;
         trace(this.type);
         switch(this.type)
         {
            case "item":
               if(this.menu.htRaw(this.bt_take))
               {
                  if(this.gunInfo)
                  {
                     SH.playSound(S_Equip);
                     SD.items[this.gunInfo.stats.type].push(this.gunInfo);
                     if(SD[this.SDname] is Array)
                     {
                        SD[this.SDname].shift();
                     }
                     else
                     {
                        SD[this.SDname] = null;
                     }
                     this.InitItem();
                     this.menu.Init(true);
                  }
                  else
                  {
                     SH.playSound(S_Equip);
                     SD.items[Stats_Perks.getGunType(this.perkInfo)].push(this.perkInfo);
                     if(SD[this.SDname] is Array)
                     {
                        SD[this.SDname].shift();
                     }
                     else
                     {
                        SD[this.SDname] = null;
                     }
                     this.InitItem();
                     this.menu.Init(true);
                  }
                  return;
               }
               if(this.menu.htRaw(this.bt_sell))
               {
                  SH.playSound(S_Click);
                  this.setSell();
                  return;
               }
               if(this.menu.htRaw(this.bt_sellYes))
               {
                  SH.playSound(S_Buy);
                  if(this.mode == "sell")
                  {
                     if(this.gunInfo)
                     {
                        SD.items[this.gunInfo.stats.type].splice(SD.items[this.gunInfo.stats.type].indexOf(this.gunInfo),1);
                        SD.funds += Math.ceil(this.gunInfo.stats.cost * 0.5);
                        Stats_Achievements.checkAchVariable("sell",Math.ceil(this.gunInfo.stats.cost * 0.5));
                     }
                     else
                     {
                        SD.items[Stats_Perks.getGunType(this.perkInfo)].splice(SD.items[Stats_Perks.getGunType(this.perkInfo)].indexOf(this.perkInfo),1);
                        SD.funds += Math.ceil(Stats_Perks.itemOb[this.perkInfo].cost * 0.5);
                        Stats_Achievements.checkAchVariable("sell",Stats_Perks.itemOb[this.perkInfo].cost * 0.5);
                     }
                     this.menu.Init(true);
                  }
                  else
                  {
                     if(this.gunInfo)
                     {
                        SD.funds += Math.ceil(this.gunInfo.stats.cost * 0.5);
                        Stats_Achievements.checkAchVariable("sell",Math.ceil(this.gunInfo.stats.cost * 0.5));
                     }
                     else
                     {
                        SD.funds += Math.ceil(Stats_Perks.itemOb[this.perkInfo].cost * 0.5);
                        Stats_Achievements.checkAchVariable("sell",Math.ceil(Stats_Perks.itemOb[this.perkInfo].cost * 0.5));
                     }
                     if(SD[this.SDname] is Array)
                     {
                        SD[this.SDname].shift();
                     }
                     else
                     {
                        SD[this.SDname] = null;
                     }
                     this.menu.Init(true);
                  }
                  return;
               }
               if(this.menu.htRaw(this.bt_sellNo))
               {
                  if(this.mode == "sell")
                  {
                     this.InitItem();
                  }
                  else
                  {
                     this.setGet();
                  }
                  SH.playSound(S_Click);
                  return;
               }
               if(this.menu.htRaw(this.bt_buyYes))
               {
                  SH.playSound(S_Buy);
                  if(this.gunInfo)
                  {
                     SD.items[this.gunInfo.stats.type].push(this.gunInfo);
                     SD.funds -= this.gunInfo.stats.cost;
                     Stats_Achievements.checkAchVariable("buy",this.gunInfo.stats.cost);
                     SD.storeItems.splice(SD.storeItems.indexOf(this.gunInfo),1);
                  }
                  else
                  {
                     SD.items[Stats_Perks.getGunType(this.perkInfo)].push(this.perkInfo);
                     SD.funds -= Stats_Perks.itemOb[this.perkInfo].cost;
                     Stats_Achievements.checkAchVariable("buy",Stats_Perks.itemOb[this.perkInfo].cost);
                     SD.storeItems.splice(SD.storeItems.indexOf(this.perkInfo),1);
                  }
                  this.menu.Init(true);
                  return;
               }
               if(this.menu.htRaw(this.bt_buyNo))
               {
                  SH.playSound(S_Click);
                  this.InitItem();
                  return;
               }
               break;
            case "blueprint":
               if(this.menu.htRaw(this.bt_cancel))
               {
                  SH.playSound(S_Click);
                  this.InitBuild();
                  return;
               }
               if(this.menu.htRaw(this.bt_build))
               {
                  SH.playSound(S_Equip);
                  SD.funds -= Stats_Guns.getBlueprintPrice(Stats_Guns.itemAr[this.bpNum].costMod);
                  Stats_Achievements.checkAchVariable("buy",Stats_Guns.getBlueprintPrice(Stats_Guns.itemAr[this.bpNum].costMod));
                  item = new GunInfo();
                  item.id = Stats_Guns.itemAr[this.bpNum].id;
                  item.rarity = 5;
                  item.setStats();
                  SD.workshopItem = item;
                  SD.bpOwned.splice(SD.bpOwned.indexOf(this.bpNum),1);
                  SD.bpBuilt.push(this.bpNum);
                  this.InitUnlock(this.bpNum);
                  return;
               }
               break;
            case "unlockblueprint":
            case "getblueprint":
            case "getclass":
            case "getheroclass":
            case "gold":
            case "features":
               if(this.menu.htRaw(this.bt_okay))
               {
                  SH.playSound(S_Click);
                  trace("closed",this.type);
                  this.menu.Init(true);
                  return;
               }
               break;
            case "hiredhero":
               if(this.menu.htRaw(this.bt_okay))
               {
                  SH.playSound(S_Click);
                  this.menu.Init(true);
                  this.menu.hiredHero();
                  return;
               }
               break;
            case "hire":
               if(this.menu.htRaw(this.bt_cancel))
               {
                  SH.playSound(S_Click);
                  visible = false;
                  gotoAndStop("blank");
                  return;
               }
               if(this.menu.htRaw(this.bt_hire))
               {
                  SH.playSound(S_Click);
                  SD.funds -= Stats_Classes.getHirePrice();
                  Stats_Achievements.checkAchVariable("buy",Stats_Classes.getHirePrice());
                  if(SD.stages.length == 2 && SD.heroes.length == 1)
                  {
                     unitInfo = Stats_Classes.newHero("","starter2");
                  }
                  else if(SD.uniqueClasses.length)
                  {
                     unitInfo = Stats_Classes.newHero("",SD.uniqueClasses.shift());
                  }
                  else
                  {
                     trace("bpClasses",SD.bpClasses);
                     trace("id",Stats_Classes.itemAr[UT.randEl(SD.bpClasses)].id);
                     unitInfo = Stats_Classes.newHero(Stats_Classes.itemAr[UT.randEl(SD.bpClasses)].id);
                  }
                  SD.heroes.push(unitInfo);
                  SD.selHero = SD.heroes.length - 1;
                  SD.justHired = true;
                  this.menu.Init(true);
                  this.InitItem(unitInfo);
                  return;
               }
               break;
            case "fire":
               if(this.menu.htRaw(this.bt_cancel))
               {
                  SH.playSound(S_Click);
                  visible = false;
                  gotoAndStop("blank");
                  return;
               }
               if(this.menu.htRaw(this.bt_fire))
               {
                  SH.playSound(S_Error);
                  SH.playSound(S_Die1);
                  SD.heroes.splice(SD.selHero,1);
                  if(SD.squad.indexOf(SD.selHero) != -1)
                  {
                     SD.squad[SD.squad.indexOf(SD.selHero)] = -1;
                  }
                  if(SD.selHero > 0)
                  {
                     --SD.selHero;
                  }
                  this.menu.Init(true);
                  return;
               }
               break;
         }
      }
      
      public function setGet() : void
      {
         if(!visible)
         {
            SH.playSound(S_Win2);
         }
         gotoAndStop("get");
         if(this.gunInfo)
         {
            this.txt_title.text = Stats_Guns.getGunType(this.gunInfo.stats.type) + " Acquired!";
         }
         else
         {
            this.txt_title.text = Stats_Guns.getGunType(Stats_Perks.getGunType(this.perkInfo)) + " Acquired!";
         }
      }
      
      public function setSell() : void
      {
         if(this.gunInfo)
         {
            if(this.gunInfo.rarity == 2)
            {
               gotoAndPlay("sell2");
            }
            else if(this.gunInfo.rarity == 3)
            {
               gotoAndPlay("sell3");
            }
            else
            {
               gotoAndPlay("sell1");
            }
            this.txt_title.text = "Sell " + Stats_Guns.getGunType(this.gunInfo.stats.type) + " for $" + Math.ceil(this.gunInfo.stats.cost * 0.5) + "?";
         }
         else
         {
            if(Stats_Perks.getGunType(this.perkInfo) == 13)
            {
               gotoAndPlay("sell0");
            }
            else
            {
               gotoAndPlay("sell2");
            }
            this.txt_title.text = "Sell " + Stats_Guns.getGunType(Stats_Perks.getGunType(this.perkInfo)) + " for $" + Math.ceil(Stats_Perks.itemOb[this.perkInfo].cost * 0.5) + "?";
         }
      }
      
      public function setBuy() : void
      {
         gotoAndPlay("buy");
         if(this.gunInfo)
         {
            this.txt_title.text = "Buy " + Stats_Guns.getGunType(this.gunInfo.stats.type) + " for $" + this.gunInfo.stats.cost + "?";
         }
         else
         {
            this.txt_title.text = "Buy " + Stats_Guns.getGunType(Stats_Perks.getGunType(this.perkInfo)) + " for $" + Stats_Perks.itemOb[this.perkInfo].cost + "?";
         }
      }
      
      protected function inlayMatureSwing6() : void
      {
         var error:int = 0;
         switch(this.type)
         {
            case "item":
               if(this.gunInfo && SD.items[this.gunInfo.stats.type].length == 24)
               {
                  error = 1;
               }
               else if(this.perkInfo)
               {
                  if(Stats_Perks.getGunType(this.perkInfo) == 13)
                  {
                     error = 3;
                  }
                  else if(SD.items[Stats_Perks.getGunType(this.perkInfo)].length == 24)
                  {
                     error = 1;
                  }
               }
               if(this.mode == "buy")
               {
                  if(this.gunInfo && this.gunInfo.stats.cost > SD.funds)
                  {
                     error = 2;
                  }
                  else if(this.perkInfo && Stats_Perks.itemOb[this.perkInfo].cost > SD.funds)
                  {
                     error = 2;
                  }
               }
               break;
            case "blueprint":
               if(Stats_Guns.getBlueprintPrice(Stats_Guns.itemAr[this.bpNum].costMod) > SD.funds)
               {
                  error = 1;
               }
               break;
            case "hire":
               if(Stats_Classes.getHirePrice() > SD.funds)
               {
                  error = 1;
               }
         }
         if(error)
         {
            gotoAndStop(currentFrame + error);
         }
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         this.inlayMatureSwing6();
      }
      
      function frame91() : *
      {
         stop();
      }
      
      function frame105() : *
      {
         stop();
         this.inlayMatureSwing6();
      }
      
      function frame122() : *
      {
         stop();
         this.inlayMatureSwing6();
      }
      
      function frame137() : *
      {
         stop();
      }
      
      function frame148() : *
      {
         stop();
         this.inlayMatureSwing6();
      }
      
      function frame171() : *
      {
         stop();
      }
   }
}
