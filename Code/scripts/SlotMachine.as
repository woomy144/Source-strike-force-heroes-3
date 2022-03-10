package
{
   import flash.display.MovieClip;
   import flash.media.SoundChannel;
   import flash.text.TextField;
   
   public class SlotMachine extends MovieClip
   {
      
      private static var slotChance:Array;
      
      private static var itemChance:Array;
       
      
      public var hitbox:MovieClip;
      
      public var slot1:MovieClip;
      
      public var slot2:MovieClip;
      
      public var slot3:MovieClip;
      
      public var txt_extra:TextField;
      
      public var txt_result:TextField;
      
      private var menu:Menu;
      
      private var fc:int;
      
      private var results:Array;
      
      private var cost:int;
      
      protected var showMore:Boolean;
      
      private var endTime:int;
      
      var slotSound:SoundChannel;
      
      public function SlotMachine()
      {
         var _loc1_:uint = 0;
         super();
         addFrameScript(11,this.frame12,19,this.frame20);
         this.menu = Menu(parent);
         visible = false;
         this.cost = UT.getCurvedRange(SD.getHighestLevel(),Stats_Misc.maxLvl,70,1000) * 0.8;
         stop();
         this.menu.txt_slotPrice.text = "$" + this.cost;
         if(!slotChance || !itemChance)
         {
            slotChance = [];
            _loc1_ = 0;
            while(_loc1_ < 0)
            {
               slotChance.push("");
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               slotChance.push("item");
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 0)
            {
               slotChance.push("money");
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 0)
            {
               slotChance.push("poop");
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 1)
            {
               slotChance.push("feast");
               _loc1_++;
            }
            itemChance = [];
            _loc1_ = 0;
            while(_loc1_ < 10)
            {
               itemChance.push("sfh");
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 10)
            {
               itemChance.push("sky");
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 10)
            {
               itemChance.push("star");
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 10)
            {
               itemChance.push("gun");
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 0)
            {
               itemChance.push("attach");
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < 0)
            {
               itemChance.push("armor");
               _loc1_++;
            }
         }
      }
      
      public function setText() : void
      {
         var txts:Array = null;
         if(SD.funds >= this.cost)
         {
            this.menu.bt_slots.visible = true;
            txts = [];
            txts.push("Test\nyour\nluck!");
            txts.push("Spin\nto\nwin!");
            txts.push("Give\nit a\nwhirl!");
            txts.push("Spin\nit to\nwin it!");
            txts.push("Just\ndo\nit!");
            txts.push("You\ncould\nwin!");
            txts.push("A\nwinner\nis you!");
            this.menu.txt_slotDesc.textColor = 16763904;
            this.menu.txt_slotDesc.text = UT.randEl(txts);
         }
         else
         {
            this.menu.bt_slots.visible = false;
            this.menu.txt_slotDesc.textColor = 16750848;
            this.menu.txt_slotDesc.text = "Can not afford!";
         }
      }
      
      public function Init() : void
      {
         gotoAndStop(1);
         visible = true;
         this.fc = 0;
         this.slot1.icon.gotoAndStop("sfh");
         this.slot2.icon.gotoAndStop("sfh");
         this.slot3.icon.gotoAndStop("sfh");
         this.slot1.play();
         this.slot2.play();
         this.slot3.play();
         this.menu.setFunds(-this.cost);
         Stats_Achievements.checkAchVariable("buy",this.cost);
         this.results = [UT.randEl(slotChance)];
         if(this.results[0] == "item")
         {
            this.results[0] = UT.randEl(itemChance);
         }
         if(this.results[0])
         {
            this.results.push(this.results[0],this.results[0],this.results[0]);
         }
         else
         {
            this.results.push(UT.randEl(["poop","money","armor","attach","gun","star","sky","sfh","feast"]));
            this.results.push(UT.randEl(["poop","money","armor","attach","gun","star","sky","sfh","feast"]));
            this.results.push(UT.randEl(["poop","money","armor","attach","gun","star","sky","sfh","feast"]));
            while(this.results[1] == this.results[2] && this.results[2] == this.results[3])
            {
               this.results[3] = UT.randEl(["poop","money","armor","attach","gun","star","sky","sfh","feast"]);
            }
         }
         trace(this.results);
         this.slotSound = SH.playSound(S_SlotSpin);
         this.showMore = false;
         this.endTime = 100;
      }
      
      public function EnterFrame() : void
      {
         var itemLevel:int = 0;
         var i:uint = 0;
         if(!visible)
         {
            return;
         }
         ++this.fc;
         if(this.fc == 30)
         {
            this.slot1.gotoAndPlay("end");
            this.slot1.icon.gotoAndStop(this.results[1]);
            SH.playSound(S_SlotClick);
         }
         if(this.fc == 35)
         {
            this.slot2.gotoAndPlay("end");
            this.slot2.icon.gotoAndStop(this.results[2]);
            SH.playSound(S_SlotClick);
         }
         if(this.fc == 40)
         {
            this.slot3.gotoAndPlay("end");
            this.slot3.icon.gotoAndStop(this.results[3]);
            SH.playSound(S_SlotClick);
         }
         if(this.results[0])
         {
            if(this.fc == 40)
            {
               if(this.slotSound)
               {
                  this.slotSound.stop();
               }
               play();
               switch(this.results[0])
               {
                  case "poop":
                     this.txt_result.text = "Gross!";
                     SH.playSound(S_Fart);
                     break;
                  case "money":
                     this.txt_result.text = "+$" + this.cost * 2;
                     SH.playSound(S_Buy);
                     break;
                  case "armor":
                     this.txt_result.text = "Armor Mod!";
                     SH.playSound(S_Win1);
                     break;
                  case "attach":
                     this.txt_result.text = "Weapon Mod!";
                     SH.playSound(S_Win1);
                     break;
                  case "gun":
                     this.txt_result.text = "Weapon!";
                     SH.playSound(S_Win1);
                     break;
                  case "star":
                     this.txt_result.text = "Refined!";
                     SH.playSound(S_Win1);
                     break;
                  case "sky":
                     this.txt_result.text = "Flawless!";
                     SH.playSound(S_Win1);
                     break;
                  case "sfh":
                     this.txt_result.text = "Perfect!";
                     this.txt_extra.text = "Я ебал овец";
                     this.showMore = true;
                     SH.playSound(S_Win3);
                     this.endTime = 150;
                     break;
                  case "feast":
                     this.txt_result.text = "Feast!";
                     this.txt_extra.text = "All Heroes healed by 1 day!";
                     this.showMore = true;
                     this.endTime = 150;
                     SH.playSound(S_Win1);
               }
            }
            if(this.fc == this.endTime)
            {
               itemLevel = UT.clamp(SD.getHighestLevel() + UT.irand(-3,0),1,Stats_Misc.maxLvl);
               switch(this.results[0])
               {
                  case "poop":
                     SD.storeItem = UT.randEl(Stats_Perks.poopAr).id;
                     break;
                  case "money":
                     this.menu.setFunds(this.cost * 2000);
                     break;
                  case "armor":
                     SD.storeItem = UT.randEl(Stats_Perks.perkAr).id;
                     break;
                  case "attach":
                     SD.storeItem = UT.randEl(Stats_Perks.weapAr).id;
                     break;
                  case "gun":
                     SD.storeItem = new GunInfo(Stats_Guns.getRandomGunId(),itemLevel,3);
                     break;
                  case "star":
                     SD.storeItem = new GunInfo(Stats_Guns.getRandomGunId(),itemLevel,3);
                     break;
                  case "sky":
                     SD.storeItem = new GunInfo(Stats_Guns.getRandomGunId(),itemLevel,3);
                     break;
                  case "sfh":
                     i = 3;
                     while(i < 5)
                     {
                        SD.storeItem = new GunInfo(Stats_Guns.getRandomGunId(),itemLevel,3);
                        SD.storeItem = new GunInfo(Stats_Guns.getRandomGunId(),itemLevel,3);
                        SD.storeItem = new GunInfo(Stats_Guns.getRandomGunId(),itemLevel,3);
                        SD.storeItem = new GunInfo(Stats_Guns.getRandomGunId(),itemLevel,3);
                        SD.storeItem = new GunInfo(Stats_Guns.getRandomGunId(),itemLevel,3);
                        SD.storeItem = new GunInfo(Stats_Guns.getRandomGunId(),itemLevel,3);
                        SD.storeItem = new GunInfo(Stats_Guns.getRandomGunId(),itemLevel,3);
                        i++;
                     }
                     break;
                  case "feast":
                     i = 0;
                     while(i < SD.heroes.length)
                     {
                        SD.heroes[i].status += 50;
                        if(SD.heroes[i].status > 400)
                        {
                           SD.heroes[i].status = 400;
                        }
                        i++;
                     }
               }
               this.menu.Init(true);
               visible = false;
               this.setText();
            }
         }
         else
         {
            if(this.fc == 40)
            {
               if(this.slotSound)
               {
                  this.slotSound.stop();
               }
               SH.playSound(S_Error);
            }
            if(this.fc == 70)
            {
               this.menu.Init(true);
               visible = false;
            }
         }
      }
      
      function frame12() : *
      {
         if(!this.showMore)
         {
            stop();
         }
      }
      
      function frame20() : *
      {
         stop();
      }
   }
}
