package
{
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class ItemBox extends MovieClip
   {
       
      
      public var bg:MovieClip;
      
      public var cont:MovieClip;
      
      public var sel:MovieClip;
      
      public var stars:MovieClip;
      
      public var txt_level:TextField;
      
      public var perkInfo:Stats_Perks;
      
      public var gunInfo:GunInfo;
      
      public var open:Boolean;
      
      public var stats:MovieClip;
      
      public var armorPerk:Boolean;
      
      private var ox:Number;
      
      private var oy:Number;
      
      private var moveX:Number;
      
      private var moveY:Number;
      
      private var growX:Number;
      
      private var growY:Number;
      
      private var osx:Number;
      
      private var osy:Number;
      
      private var frameType:int;
      
      private var heroLevel:int;
      
      public var cantEquip:Boolean;
      
      public function ItemBox()
      {
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11,12,this.frame13,17,this.frame18,22,this.frame23,24,this.frame25,29,this.frame30,34,this.frame35,36,this.frame37,41,this.frame42,46,this.frame47);
      }
      
      public function Init(info:* = null, diffBox:Boolean = false, i:int = -1, growScale:Number = -1, heroLevel:int = 0) : void
      {
         this.perkInfo = null;
         this.gunInfo = null;
         this.cantEquip = false;
         this.heroLevel = heroLevel;
         if(info == null)
         {
            return;
         }
         if(info is GunInfo)
         {
            this.InitGun(info,diffBox,i,growScale);
         }
         else
         {
            this.InitPerk(info,diffBox,i,growScale);
         }
         UT.setMcTransform(this,0.8,0.8,0.8);
      }
      
      public function InitGun(gunInfo:GunInfo, diffBox:Boolean = false, i:int = -1, growScale:Number = -1) : void
      {
         var frame:int = 0;
         if(diffBox)
         {
            this.frameType = 2;
         }
         else
         {
            this.frameType = 1;
         }
         this.cantEquip = false;
         gotoAndStop("idle" + this.frameType);
         this.moveX = this.ox = x;
         this.moveY = this.oy = y;
         this.growX = this.osx = scaleX;
         this.growY = this.osy = scaleY;
         if(i !== -1)
         {
            if(i >= 0 && i < 24)
            {
               if((i + 1) % 4 == 0)
               {
                  this.moveX = this.ox - 20;
               }
               if(i == 0 || i % 4 == 0)
               {
                  this.moveX = this.ox + 20;
               }
               if(i < 4)
               {
                  this.moveY = this.oy + 60;
               }
               if(i > 19)
               {
                  this.moveY = this.oy - 30;
               }
            }
         }
         this.gunInfo = gunInfo;
         if(!gunInfo)
         {
            this.bg.gotoAndStop(1);
            this.txt_level.text = "";
            this.stars.gotoAndStop(1);
            this.cont.item.gotoAndStop("default");
            this.stats.gotoAndStop(3);
            return;
         }
         this.bg.gotoAndStop(gunInfo.rarity + 1);
         if(this.heroLevel && this.heroLevel < gunInfo.level)
         {
            this.cantEquip = true;
            this.txt_level.text = "Can\'t Equip\nLv " + gunInfo.level;
            this.txt_level.textColor = 16737792;
         }
         else
         {
            this.txt_level.text = "\nLv " + gunInfo.level;
            this.txt_level.textColor = 16763904;
         }
         this.stats.gotoAndStop(1);
         this.stats.mc_icon.gotoAndStop("gun" + gunInfo.stats.type);
         this.stats.txt_name.text = gunInfo.name;
         this.stats.txt_cost.text = "$" + Math.ceil(gunInfo.stats.cost * 0.5);
         this.setStat("pow",gunInfo.stats.dmgBase,-1,Stats_Guns.impactAr[gunInfo.stats.type] * 1.2);
         this.setStat("rps",gunInfo.stats.rps,-1,10);
         this.setStat("acc",gunInfo.stats.aim,-1,99);
         this.setStat("amm",gunInfo.stats.clipSize,-1,100);
         this.stats.txt_pow.scaleX = gunInfo.stats.dmgBase > 99 ? 0.65 : 1;
         this.stats.txt_pow.x = gunInfo.stats.dmgBase > 99 ? 125 : 114;
         this.stats.txt_amm.scaleX = gunInfo.stats.clipSize > 99 ? 0.65 : 1;
         this.stats.txt_amm.x = gunInfo.stats.clipSize > 99 ? 125 : 114;
         Stats_Guns.setRarity(this.stats.txt_rarity,gunInfo.rarity);
         this.stats.txt_dps.text = Math.ceil(gunInfo.stats.dmg * gunInfo.stats.rps) + "";
         if(gunInfo.rarity == 3)
         {
            this.stats.txt_special.text = gunInfo.stats.descPerf;
            this.stats.txt_special.textColor = 16776960;
            this.stats.txt_special.filters = [new GlowFilter(0,1,2,2,2)];
         }
         else if(gunInfo.rarity == 4 && !gunInfo.stats.isMelee)
         {
            this.stats.txt_special.text = "Chance to jam while firing";
            this.stats.txt_special.textColor = 10027008;
            this.stats.txt_special.filters = [];
         }
         else
         {
            this.stats.txt_special.text = gunInfo.stats.desc;
            this.stats.txt_special.textColor = 3355443;
            this.stats.txt_special.filters = [];
         }
         this.stars.gotoAndStop(gunInfo.upgradeAmt + 1);
         UT.setMcColor(this.stats.mc_pow,!!(gunInfo.upgrades & 1) ? uint(16777062) : uint(16777215));
         UT.setMcColor(this.stats.mc_rps,!!(gunInfo.upgrades & 2) ? uint(16777062) : uint(16777215));
         UT.setMcColor(this.stats.mc_acc,!!(gunInfo.upgrades & 4) ? uint(16777062) : uint(16777215));
         UT.setMcColor(this.stats.mc_amm,!!(gunInfo.upgrades & 8) ? uint(16777062) : uint(16777215));
         this.stats.star_pow.visible = gunInfo.upgrades & 1;
         this.stats.star_rps.visible = gunInfo.upgrades & 2;
         this.stats.star_acc.visible = gunInfo.upgrades & 4;
         this.stats.star_amm.visible = gunInfo.upgrades & 8;
         this.stats.star_lvl.visible = gunInfo.upgrades & 16;
         if(gunInfo.stats.type == 4)
         {
            this.cont.item.gotoAndStop("gun2");
         }
         else
         {
            this.cont.item.gotoAndStop("gun");
         }
         this.cont.item.gun.gotoAndStop(gunInfo.id);
         frame = this.cont.item.gun.currentFrame;
         if(gunInfo.rarity <= 3)
         {
            frame += gunInfo.rarity;
            this.cont.item.gun.gotoAndStop(frame);
         }
         if(this.cont.item.gun.clip)
         {
            this.cont.item.gun.clip.gotoAndStop(frame);
         }
         if(this.cont.item.gun.part)
         {
            this.cont.item.gun.part.gotoAndStop(frame);
         }
         if(gunInfo.stats.type == 4)
         {
            this.cont.item.gun2.gotoAndStop(frame);
            if(this.cont.item.gun2.clip)
            {
               this.cont.item.gun2.clip.gotoAndStop(frame);
            }
            if(this.cont.item.gun2.part)
            {
               this.cont.item.gun2.part.gotoAndStop(frame);
            }
         }
         Main.STAGE.invalidate();
         this.cont.item.gun.x = -this.cont.item.gun.reg_menu.x * this.cont.item.gun.scaleX;
         this.cont.item.gun.y = -this.cont.item.gun.reg_menu.y * this.cont.item.gun.scaleY;
         switch(gunInfo.rarity)
         {
            case 4:
               UT.setMcTransform(this.cont.item.gun,1,0.9,0.8);
               break;
            case 5:
               UT.setMcTransform(this.cont.item.gun,0.9,0.9,1);
               break;
            default:
               UT.resetMcColor(this.cont.item.gun);
         }
         if(gunInfo.stats.type == 4)
         {
            this.cont.item.gun.rotation = 8;
            this.cont.item.gun.x -= 15;
            this.cont.item.gun.y += 8;
            this.cont.item.gun2.x = -this.cont.item.gun2.reg_menu.x * this.cont.item.gun2.scaleX + 15;
            this.cont.item.gun2.y = -this.cont.item.gun2.reg_menu.y * this.cont.item.gun2.scaleY - 8;
            switch(gunInfo.rarity)
            {
               case 4:
                  UT.setMcTransform(this.cont.item.gun2,1,0.9,0.8);
                  break;
               case 5:
                  UT.setMcTransform(this.cont.item.gun2,0.9,0.9,1);
                  break;
               default:
                  UT.resetMcColor(this.cont.item.gun2);
            }
         }
         else
         {
            this.cont.item.gun.rotation = 0;
         }
         this.compareGun();
      }
      
      private function compareGun(compare:GunInfo = null) : void
      {
         if(!compare)
         {
            this.stats.mc2_pow.width = this.stats.mc2_rps.width = this.stats.mc2_acc.width = this.stats.mc2_amm.width = 0;
            this.stats.txt_dps.textColor = 0;
            this.stats.ar_dps.gotoAndStop(4);
            return;
         }
         if(compare.stats.dmg * compare.stats.rps < this.gunInfo.stats.dmg * this.gunInfo.stats.rps)
         {
            this.stats.txt_dps.textColor = 26112;
            this.stats.ar_dps.gotoAndStop(1);
         }
         else if(compare.stats.dmg * compare.stats.rps > this.gunInfo.stats.dmg * this.gunInfo.stats.rps)
         {
            this.stats.txt_dps.textColor = 10027008;
            this.stats.ar_dps.gotoAndStop(2);
         }
         else
         {
            this.stats.txt_dps.textColor = 3355443;
            this.stats.ar_dps.gotoAndStop(3);
         }
         var maxSize:Number = Math.max(Stats_Guns.impactAr[this.gunInfo.stats.type],Stats_Guns.impactAr[compare.stats.type]) * 1.2;
         this.setStat("pow",this.gunInfo.stats.dmgBase,-1,maxSize);
         this.setStat("pow",this.gunInfo.stats.dmgBase,compare.stats.dmgBase,maxSize);
         this.setStat("rps",this.gunInfo.stats.rps,compare.stats.rps,10);
         this.setStat("acc",this.gunInfo.stats.aim,compare.stats.aim,99);
         this.setStat("amm",this.gunInfo.stats.clipSize,compare.stats.clipSize,100);
      }
      
      private function setStat(mc:String, gStat:Number, cStat:Number, size:Number) : void
      {
         var bargStat:* = Math.min(gStat,size);
         var barcStat:* = Math.min(cStat,size);
         if(cStat == -1)
         {
            this.stats["mc_" + mc].width = Math.min(bargStat / size * 100,100);
            this.stats["txt_" + mc].text = Math.round(gStat * (mc == "rps" ? 3 : 1)) + "";
            this.stats["txt_" + mc].textColor = 0;
            this.stats["ar_" + mc].gotoAndStop(4);
            return;
         }
         if(gStat > cStat)
         {
            UT.setMcColor(this.stats["mc2_" + mc],65280);
            this.stats["mc2_" + mc].alpha = 0.5;
            this.stats["mc2_" + mc].width = (bargStat - cStat) / size * 100;
            this.stats["mc2_" + mc].x = this.stats["mc_" + mc].x + this.stats["mc_" + mc].width - this.stats["mc2_" + mc].width;
            this.stats["ar_" + mc].gotoAndStop(1);
            this.stats["txt_" + mc].textColor = 26112;
         }
         else if(gStat < cStat)
         {
            UT.setMcColor(this.stats["mc2_" + mc],16711680);
            this.stats["mc2_" + mc].alpha = 0.5;
            this.stats["mc2_" + mc].width = (barcStat - gStat) / size * 100;
            this.stats["mc2_" + mc].x = this.stats["mc_" + mc].x + this.stats["mc_" + mc].width;
            this.stats["ar_" + mc].gotoAndStop(2);
            this.stats["txt_" + mc].textColor = 10027008;
         }
         else
         {
            this.stats["ar_" + mc].gotoAndStop(3);
            this.stats["txt_" + mc].textColor = 0;
         }
      }
      
      public function InitPerk(id:String, diffBox:Boolean = false, i:int = -1, growScale:Number = -1) : void
      {
         if(diffBox)
         {
            this.frameType = 4;
         }
         else
         {
            this.frameType = 3;
         }
         this.cantEquip = false;
         this.moveX = this.ox = x;
         this.moveY = this.oy = y;
         this.growX = this.osx = scaleX;
         this.growY = this.osy = scaleY;
         if(i !== -1)
         {
            if(i >= 0 && i < 24)
            {
               if((i + 1) % 4 == 0)
               {
                  this.moveX = this.ox - 20;
               }
               if(i == 0 || i % 4 == 0)
               {
                  this.moveX = this.ox + 20;
               }
               if(i < 4)
               {
                  this.moveY = this.oy + 30;
               }
               if(i > 19)
               {
                  this.moveY = this.oy - 30;
               }
            }
            else
            {
               this.moveX = this.ox + i;
            }
         }
         if(growScale >= 0)
         {
            this.growX = this.growY = growScale;
         }
         gotoAndStop("idle" + this.frameType);
         if(!id)
         {
            this.bg.gotoAndStop(1);
            this.cont.item.gotoAndStop("none");
            return;
         }
         this.perkInfo = Stats_Perks.itemOb[id];
         this.cont.item.gotoAndStop("perk");
         this.cont.item.perk.gotoAndStop(this.perkInfo.sprite);
         this.stats.gotoAndStop(2);
         this.stats.txt_name.text = this.perkInfo.name;
         this.stats.txt_desc.text = this.perkInfo.desc;
         Stats_Perks.setType(this.stats.txt_rarity,this.perkInfo.type);
         if(this.perkInfo.type == 5)
         {
            this.stats.txt_cost.text = "$" + Math.ceil(this.perkInfo.cost * 0.5);
         }
         trace(1);
         if(this.armorPerk && this.perkInfo.armorname)
         {
            this.stats.txt_name.text = this.perkInfo.armorname;
            this.bg.gotoAndStop(20);
            this.cont.item.perk.gotoAndStop("_" + this.perkInfo.sprite);
            this.stats.txt_cost.text = "$" + Math.ceil(this.perkInfo.cost * 0.5);
         }
         else
         {
            this.bg.gotoAndStop(this.perkInfo.type + 10);
         }
      }
      
      public function setStorePrice(amt:int = 0) : *
      {
         if(amt)
         {
            this.stats.txt_cost.text = "$" + amt;
         }
         else if(this.gunInfo)
         {
            this.stats.txt_cost.text = "$" + Math.ceil(this.gunInfo.stats.cost);
         }
         else
         {
            this.stats.txt_cost.text = "$" + Math.ceil(this.perkInfo.cost);
         }
      }
      
      public function setOpen(opening:Boolean, compare:* = null) : *
      {
         if(this.open == opening)
         {
            return;
         }
         if(!this.gunInfo && !this.perkInfo)
         {
            return;
         }
         if(!(compare is GunInfo))
         {
            compare = null;
         }
         this.open = opening;
         if(this.open)
         {
            this.cont.gotoAndPlay("hover");
            gotoAndPlay("open" + this.frameType);
            if(compare)
            {
               this.compareGun(compare);
            }
            UT.resetMcColor(this);
         }
         else
         {
            this.cont.gotoAndStop(1);
            gotoAndPlay("close" + this.frameType);
            UT.setMcTransform(this,0.8,0.8,0.8);
         }
      }
      
      public function keepOpen() : *
      {
         this.cont.gotoAndPlay("hover");
         gotoAndPlay("open" + this.frameType);
      }
      
      public function resetSize() : void
      {
         scaleX = this.osx;
         scaleY = this.osy;
         x = this.ox;
         y = this.oy;
         this.open = false;
      }
      
      public function EnterFrame() : void
      {
         if(!this.perkInfo && !this.gunInfo)
         {
            return;
         }
         x += ((!!this.open ? this.moveX : this.ox) - x) * 0.5;
         y += ((!!this.open ? this.moveY : this.oy) - y) * 0.5;
         scaleX += ((!!this.open ? this.growX : this.osx) - scaleX) * 0.5;
         scaleY += ((!!this.open ? this.growY : this.osy) - scaleY) * 0.5;
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame6() : *
      {
         stop();
      }
      
      function frame11() : *
      {
         gotoAndStop("idle1");
      }
      
      function frame13() : *
      {
         stop();
      }
      
      function frame18() : *
      {
         stop();
      }
      
      function frame23() : *
      {
         gotoAndStop("idle2");
      }
      
      function frame25() : *
      {
         stop();
      }
      
      function frame30() : *
      {
         stop();
      }
      
      function frame35() : *
      {
         gotoAndStop("idle3");
      }
      
      function frame37() : *
      {
         stop();
      }
      
      function frame42() : *
      {
         stop();
      }
      
      function frame47() : *
      {
         gotoAndStop("idle4");
      }
   }
}
