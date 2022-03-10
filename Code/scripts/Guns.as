package
{
   import flash.filters.BevelFilter;
   
   public class Guns
   {
       
      
      private var unit:Unit;
      
      public var shootDelay:uint;
      
      public var shotPressed:Boolean;
      
      private var burstCount:uint;
      
      private var burstTimer:uint;
      
      public var reloading:Boolean;
      
      private var dualFire:Boolean;
      
      public var curFrame:String;
      
      public var dynRecoil:Number;
      
      public var dynRecoilMod:Number;
      
      public var primary:Stats_Guns;
      
      public var secondary:Stats_Guns;
      
      public var curGun:Stats_Guns;
      
      public var otherGun:Stats_Guns;
      
      private var soundFrames:uint = 0;
      
      private var shotTimer:uint = 0;
      
      private var fc:uint = 0;
      
      public function Guns(_unit:Unit)
      {
         super();
         this.unit = _unit;
      }
      
      public function setGuns(_primary:GunInfo, _secondary:GunInfo) : void
      {
         this.dualFire = false;
         if(!_primary)
         {
            _primary = Stats_Classes.getDefaultWeapon(this.unit.unitInfo.cls,"primary");
         }
         if(!_secondary)
         {
            _secondary = Stats_Classes.getDefaultWeapon(this.unit.unitInfo.cls,"secondary");
         }
         this.primary = Stats_Guns.cloneStats(_primary.stats);
         this.secondary = Stats_Guns.cloneStats(_secondary.stats);
         if(MatchSettings.useMode == "gg" || MatchSettings.useMode == "tgg")
         {
            this.primary.infSpare = true;
            if(this.primary.noClip || this.primary.clipSpare == 0)
            {
               this.primary.noAmmo = true;
            }
            this.primary.ksWeap = false;
         }
         else
         {
            this.setGunMods(this.primary,0);
            this.setGunMods(this.secondary,1);
         }
         this.setAmmoAmount(this.primary);
         this.setAmmoAmount(this.secondary);
      }
      
      public function setGunMods(_gun:Stats_Guns, type:int) : void
      {
         if(this.unit.unitInfo.skills.dmg1 && !_gun.isMelee && _gun.type <= 10)
         {
            _gun.dmg *= this.unit.unitInfo.skills.dmg1;
         }
         if(this.unit.unitInfo.skills.dmg2 && _gun.isMelee)
         {
            _gun.dmg *= this.unit.unitInfo.skills.dmg2;
         }
         if(this.unit.unitInfo.skills.bfire && !_gun.isMelee)
         {
            _gun.dmg *= this.unit.unitInfo.skills.bfire;
            _gun.fire += 0.1;
         }
         if(this.unit.unitInfo.skills.bice && !_gun.isMelee)
         {
            _gun.dmg *= this.unit.unitInfo.skills.bice;
            _gun.ice += 0.1;
         }
         if(this.unit.unitInfo.skills.bacid && !_gun.isMelee)
         {
            _gun.dmg *= this.unit.unitInfo.skills.bacid;
            _gun.acid += 0.1;
         }
         if(this.unit.unitInfo.skills.bzap && !_gun.isMelee)
         {
            _gun.dmg *= this.unit.unitInfo.skills.bzap;
            _gun.acid += 0.1;
         }
         if(this.unit.unitInfo.skills.radius && _gun.splash && !_gun.isMelee)
         {
            _gun.splash *= this.unit.unitInfo.skills.radius;
         }
         if(this.unit.unitInfo.skills.range && !_gun.isMelee)
         {
            _gun.range *= this.unit.unitInfo.skills.range;
         }
         if(this.unit.unitInfo.skills.auto && type == 0 && !_gun.isMelee)
         {
            _gun.dmg *= this.unit.unitInfo.skills.auto;
            _gun.fireType = 1;
         }
         if(this.unit.unitInfo.skills.burst && type == 0 && !_gun.isMelee)
         {
            _gun.dmg *= this.unit.unitInfo.skills.burst;
            _gun.fireType = 2;
         }
         if(this.unit.unitInfo.skills.ammo1 && !_gun.isMelee)
         {
            _gun.clipSize *= this.unit.unitInfo.skills.ammo1;
         }
         if(this.unit.unitInfo.skills.ammo2 && !_gun.isMelee)
         {
            _gun.clipSpare *= this.unit.unitInfo.skills.ammo2;
         }
         if(this.unit.unitInfo.skills.ammo3 && !_gun.isMelee)
         {
            _gun.clipSize *= _gun.clipSpare + 1;
            _gun.clipSize *= this.unit.unitInfo.skills.ammo3;
            _gun.clipSpare = 0;
         }
      }
      
      public function setAmmoAmount(_gun:Stats_Guns) : void
      {
         if(_gun.noClip)
         {
            _gun.clipSpare = 0;
         }
         if(_gun.infSpare)
         {
            _gun.clipAmmo = _gun.ammoTotal = _gun.clipSize;
            _gun.spareAmmo = _gun.spareMax = 0;
         }
         else if(_gun.clipSize == 0)
         {
            _gun.noAmmo = true;
            _gun.noClip = true;
            _gun.clipAmmo = _gun.clipSize = _gun.ammoTotal = _gun.spareAmmo = _gun.spareMax = 0;
         }
         else if(_gun.clipSpare == 0)
         {
            _gun.noClip = true;
            _gun.ammoTotal = Math.ceil(_gun.clipSize * (_gun.clipSpare + 1));
            if(_gun.ammoTotal > 999)
            {
               _gun.ammoTotal = 999;
            }
            _gun.clipAmmo = _gun.clipSize = _gun.ammoTotal;
            _gun.spareAmmo = _gun.spareMax = 0;
         }
         else
         {
            _gun.ammoTotal = Math.ceil(_gun.clipSize * (_gun.clipSpare + 1));
            if(_gun.ammoTotal > 999)
            {
               _gun.ammoTotal = 999;
            }
            _gun.clipAmmo = _gun.clipSize;
            _gun.spareAmmo = _gun.spareMax = _gun.ammoTotal - _gun.clipSize;
         }
      }
      
      public function setTempGun(id:String, rarity:int = 0) : void
      {
         if(MatchSettings.useMode == "gg" || MatchSettings.useMode == "tgg")
         {
            this.unit.endKillstreak();
            return;
         }
         this.dualFire = false;
         this.curGun = new GunInfo(id,this.unit.unitInfo.level,rarity).stats;
         this.setAmmoAmount(this.curGun);
         this.setFrame("idle");
         this.displayCurGun();
         this.reloading = false;
         if(this.unit.focused)
         {
            this.unit.game.arena.setFocus(this.unit,this.curGun.vision);
            this.unit.game.hud.setAmmoCount(this.curGun);
         }
      }
      
      public function reset() : void
      {
         this.shootDelay = 0;
         this.curGun = null;
         this.setAmmoAmount(this.primary);
         this.setAmmoAmount(this.secondary);
         this.swapGuns();
         if(this.unit.unitInfo.extra.forcePistol)
         {
            this.swapGuns();
         }
      }
      
      public function swapGuns() : void
      {
         this.dualFire = false;
         if(this.curGun == this.primary && this.secondary.id == "Empty")
         {
            return;
         }
         if(this.curGun && this.curGun.ksWeap)
         {
            return;
         }
         if(this.unit.hasFlag)
         {
            this.curGun = this.primary;
         }
         if(this.curGun != this.primary)
         {
            this.curGun = this.primary;
            this.otherGun = this.secondary;
            if(this.unit.focused)
            {
               this.unit.game.hud.setGuns(this.primary,this.secondary);
            }
         }
         else
         {
            this.curGun = this.secondary;
            this.otherGun = this.primary;
            if(this.unit.focused)
            {
               this.unit.game.hud.setGuns(this.secondary,this.primary);
            }
         }
         this.dynRecoil = this.curGun.recoil;
         this.setFrame("idle");
         this.displayCurGun();
         if(this.unit.mDown)
         {
            this.shotPressed = true;
         }
         if(this.unit.focused)
         {
            this.unit.game.arena.setFocus(this.unit,this.curGun.vision);
            this.unit.game.hud.setAmmoCount(this.curGun);
         }
         if(this.unit.hasFlag)
         {
            this.unit.MC.body.gun.visible = true;
            this.unit.MC.body.gun.gotoAndStop("flag" + this.unit.hasFlag.team);
         }
         this.burstCount = 0;
         this.burstTimer = 0;
         this.reloading = false;
         this.checkReload();
      }
      
      public function displayCurGun() : void
      {
         var frame:int = 0;
         this.unit.MC.body.gun.visible = false;
         this.unit.MC.legup1.gun.visible = false;
         this.unit.MC.legup2.gun.visible = false;
         if(this.unit.MC.arm1.gun)
         {
            this.unit.MC.arm1.gun.gotoAndStop(this.curGun.sprite);
            frame = this.unit.MC.arm1.gun.currentFrame;
            if(this.curGun.rarity <= 3)
            {
               frame += this.curGun.rarity;
               this.unit.MC.arm1.gun.gotoAndStop(frame);
            }
            if(this.unit.MC.arm1.gun.clip)
            {
               this.unit.MC.arm1.gun.clip.gotoAndStop(frame);
            }
            if(this.unit.MC.arm1.gun.part)
            {
               this.unit.MC.arm1.gun.part.gotoAndStop(frame);
            }
         }
         if(this.unit.MC.arm2.gun2)
         {
            this.unit.MC.arm2.gun2.gotoAndStop(this.curGun.sprite);
            frame = this.unit.MC.arm2.gun2.currentFrame;
            if(this.curGun.rarity <= 3)
            {
               frame += this.curGun.rarity;
               this.unit.MC.arm2.gun2.gotoAndStop(frame);
            }
            if(this.unit.MC.arm2.gun2.clip)
            {
               this.unit.MC.arm2.gun2.clip.gotoAndStop(frame);
            }
            if(this.unit.MC.arm2.gun2.part)
            {
               this.unit.MC.arm2.gun2.part.gotoAndStop(frame);
            }
         }
         this.unit.MC[this.otherGun.unequip].gun.visible = true;
         this.unit.MC[this.otherGun.unequip].gun.gotoAndStop(this.otherGun.sprite);
         frame = this.unit.MC[this.otherGun.unequip].gun.currentFrame;
         if(this.otherGun.rarity <= 3)
         {
            frame += this.otherGun.rarity;
            this.unit.MC[this.otherGun.unequip].gun.gotoAndStop(frame);
         }
         if(this.unit.MC[this.otherGun.unequip].gun.clip)
         {
            this.unit.MC[this.otherGun.unequip].gun.clip.gotoAndStop(frame);
         }
         if(this.unit.MC[this.otherGun.unequip].gun.part)
         {
            this.unit.MC[this.otherGun.unequip].gun.part.gotoAndStop(frame);
         }
      }
      
      public function addAmmo(_perc:Number, _effect:Boolean = true) : void
      {
         if(!this.primary.infSpare)
         {
         }
         if(this.primary.noClip)
         {
            this.primary.clipAmmo += Math.ceil(this.primary.clipSize * _perc);
            if(this.primary.clipAmmo > this.primary.clipSize)
            {
               this.primary.clipAmmo = this.primary.clipSize;
            }
         }
         else
         {
            this.primary.spareAmmo += Math.ceil(this.primary.spareMax * _perc);
            if(this.primary.spareAmmo > this.primary.spareMax)
            {
               this.primary.spareAmmo = this.primary.spareMax;
            }
         }
         if(!this.secondary.infSpare)
         {
            if(this.secondary.noClip)
            {
               this.secondary.clipAmmo += Math.ceil(this.secondary.clipSize * _perc);
               if(this.secondary.clipAmmo > this.secondary.clipSize)
               {
                  this.secondary.clipAmmo = this.secondary.clipSize;
               }
            }
            else
            {
               this.secondary.spareAmmo += Math.ceil(this.secondary.spareMax * _perc);
               if(this.secondary.spareAmmo > this.secondary.spareMax)
               {
                  this.secondary.spareAmmo = this.secondary.spareMax;
               }
            }
         }
         if(this.unit.focused)
         {
            this.unit.game.hud.setAmmoCount(this.curGun);
         }
         if(_effect)
         {
            this.unit.game.createEffect(this.unit.x,this.unit.y - 40,"ammoPickup");
         }
         this.checkReload();
      }
      
      public function EnterFrame() : void
      {
         ++this.fc;
         if(this.shootDelay > 0)
         {
            --this.shootDelay;
         }
         else
         {
            this.shootDelay = 0;
         }
         if(this.burstTimer)
         {
            --this.burstTimer;
            if(this.burstTimer == 0 && this.burstCount)
            {
               this.burstTimer = 3;
               --this.burstCount;
               this.shoot(true);
            }
         }
         var useRecoil:Number = this.curGun.recoil;
         if(this.unit.unitInfo.skills.acc1)
         {
            useRecoil *= this.unit.unitInfo.skills.acc1;
         }
         if(this.unit.unitInfo.skills.assist)
         {
            useRecoil *= this.unit.unitInfo.skills.assist;
         }
         if(this.dynRecoil > useRecoil)
         {
            this.dynRecoil -= 0.05;
         }
         var crouchMod:Number = 0.6;
         if(this.unit.unitInfo.skills.aim3)
         {
            crouchMod = 0.3;
         }
         if(this.unit.unitInfo.skills.aim0)
         {
            if(this.unit.mov.crouching)
            {
               this.dynRecoilMod = this.dynRecoil * crouchMod;
            }
            else if(this.unit.mov.jumping)
            {
               this.dynRecoilMod = this.dynRecoil * 1.4;
            }
            else if(this.unit.mov.xVel)
            {
               this.dynRecoilMod = this.dynRecoil * 1.3;
            }
            else
            {
               this.dynRecoilMod = this.dynRecoil;
            }
         }
         else if(this.unit.unitInfo.skills.aim2)
         {
            if(this.unit.mov.crouching)
            {
               this.dynRecoilMod = this.dynRecoil * crouchMod;
            }
            else
            {
               this.dynRecoilMod = this.dynRecoil;
            }
         }
         else if(this.unit.mov.crouching)
         {
            this.dynRecoilMod = this.dynRecoil * crouchMod;
         }
         else if(this.unit.mov.jumping)
         {
            this.dynRecoilMod = this.dynRecoil * 1.2;
         }
         else if(this.unit.mov.xVel)
         {
            this.dynRecoilMod = this.dynRecoil * 1.1;
         }
         else
         {
            this.dynRecoilMod = this.dynRecoil;
         }
         if(this.unit.unitInfo.skills.energy && this.fc % (30 * 3) == 0)
         {
            this.addAmmo(0.01,false);
         }
         if(this.soundFrames)
         {
            --this.soundFrames;
         }
      }
      
      public function resetFrame() : void
      {
         this.unit.MC.arm1.gotoAndStop(this.curGun.frameIdle);
         this.unit.MC.arm2.gotoAndStop(this.curGun.frameIdle);
      }
      
      public function setFrame(_frame:String) : void
      {
         this.curFrame = _frame;
         var newFrame:* = "";
         switch(_frame)
         {
            case "idle":
               newFrame = this.curGun.frameIdle;
               break;
            case "fire":
               newFrame = this.curGun.frameFire;
               break;
            case "reload":
            case "reload_fast":
               newFrame = this.curGun.frameReload;
         }
         switch(_frame)
         {
            case "idle":
               this.unit.MC.arm1.gotoAndStop(newFrame);
               this.unit.MC.arm2.gotoAndStop(newFrame);
               break;
            case "fire":
               newFrame += "_" + _frame;
               if(this.dualFire)
               {
                  newFrame += "2";
               }
               this.unit.MC.arm1.gotoAndPlay(newFrame);
               this.unit.MC.arm2.gotoAndPlay(newFrame);
               break;
            case "reload":
            case "reload_fast":
               newFrame += "_" + _frame;
               this.unit.MC.arm1.gotoAndPlay(newFrame);
               this.unit.MC.arm2.gotoAndPlay(newFrame);
         }
      }
      
      public function releaseMouse() : void
      {
         this.shotPressed = false;
      }
      
      public function shoot(_force:Boolean = false) : void
      {
         var i:uint = 0;
         if(this.unit.status.sSpawn)
         {
            return;
         }
         if(this.unit.status.sFrozen)
         {
            return;
         }
         if((this.shootDelay || this.shotPressed) && !_force || this.reloading)
         {
            return;
         }
         if(!this.curGun.clipAmmo && !this.curGun.noAmmo)
         {
            this.unit.game.playScreenSound(S_GunClick,this.unit.x,this.unit.y);
            return;
         }
         if(this.curGun.extra.noShoot)
         {
            return;
         }
         this.unit.status.setStealthDelay(true);
         this.setFrame("fire");
         if(this.curGun.fireType == 0 && this.unit.human)
         {
            this.shotPressed = true;
         }
         if((this.curGun.fireType == 2 || this.unit.unitInfo.skills.burst) && !_force)
         {
            if(this.unit.human)
            {
               this.shotPressed = true;
            }
            this.burstTimer = 3;
            this.burstCount = this.curGun.burst - 1;
         }
         if(this.curGun.isDual)
         {
            this.dualFire = !this.dualFire;
         }
         if(this.curGun.reflectFrames)
         {
            this.unit.status.sReflect = this.curGun.reflectFrames;
         }
         if(this.curGun.effShell && SD.graphPart)
         {
            this.unit.game.createParticle(this.unit.x + UT.xMoveToRot(this.unit.aimRoation,28),this.unit.y + this.unit.MC.arm1.y + UT.yMoveToRot(this.unit.aimRoation,28),"shell",0,{
               "rot":this.unit.aimRoation,
               "flip":this.unit.MC.scaleX
            },"shell",this.curGun.effShell);
         }
         if(SD.graphPart == 2 || SD.graphPart == 1 && this.unit.focused)
         {
            this.unit.MCfilters.push(new BevelFilter(7,this.unit.aimRoation + 90,Math.random() < 0.5 ? uint(16777164) : uint(16777113),1,0,0.5,10,10,1,1));
         }
         this.shootDelay = this.curGun.shootDelay;
         if(this.unit.status.sRage)
         {
            this.shootDelay *= 0.75;
         }
         if(this.unit.status.sAimBoost)
         {
            this.shootDelay *= 0.6;
         }
         if(this.unit.unitInfo.skills.rof1)
         {
            this.shootDelay *= this.unit.unitInfo.skills.rof1;
         }
         if(MatchSettings.useMod != "ammo" && !this.curGun.noAmmo)
         {
            this.curGun.clipAmmo -= this.curGun.consume;
            if(this.curGun.clipAmmo < 0)
            {
               this.curGun.clipAmmo = 0;
            }
            if(this.curGun.jam && Math.random() < this.curGun.jam)
            {
               this.unit.game.createParticle(this.unit.x + UT.rand(-5,5),this.unit.y - UT.rand(50,55),"text",0,null,"bigText","jam");
               this.manualReload(true);
               return;
            }
         }
         if(this.unit.focused)
         {
            this.unit.game.hud.setAmmoCount(this.curGun);
            this.unit.game.arena.setShake(2,2);
            if(!this.unit.unitInfo.skills.aim1 && this.dynRecoil < this.curGun.recoil * 1.7)
            {
               this.dynRecoil += this.curGun.recoilSpread;
            }
         }
         this.unit.status.sFocus = 0;
         if(this.curGun.shotSound)
         {
            if(this.curGun.soundFrames)
            {
               if(!this.soundFrames)
               {
                  this.unit.game.playScreenSound(this.curGun.shotSound,this.unit.x,this.unit.y);
                  this.soundFrames = this.curGun.soundFrames;
               }
            }
            else
            {
               this.unit.game.playScreenSound(this.curGun.shotSound,this.unit.x,this.unit.y);
            }
         }
         if(this.curGun.multiShots)
         {
            for(i = 0; i < this.curGun.multiShots; i++)
            {
               this.makeBullet(this.curGun);
            }
         }
         else
         {
            this.makeBullet(this.curGun);
         }
         if(this.unit.status.sAkimbo && this.curGun.clipAmmo >= this.curGun.consume * 2)
         {
            if(MatchSettings.useMod != "ammo")
            {
               this.curGun.clipAmmo -= this.curGun.consume;
            }
            this.makeBullet(this.curGun);
         }
         this.checkReload();
      }
      
      public function setHudStuff() : *
      {
         this.unit.game.hud.setGuns(this.primary,this.secondary);
         this.unit.game.hud.setAmmoCount(this.curGun);
      }
      
      public function makeBullet(_gun:Stats_Guns) : void
      {
         this.unit.game.bullets.push(new _gun.cls(this.unit.game,this.unit,this.unit.aimRoation + UT.rand(-this.dynRecoil,this.dynRecoilMod),this.unit.x + this.unit.MC.rotation * 1.2,this.unit.y + this.unit.MC.arm1.y,int(_gun.xOff * this.unit.scale),_gun));
      }
      
      public function reloaded() : void
      {
         this.reloading = false;
         this.setFrame("idle");
         if(this.unit.unitInfo.skills.butter && Math.random() < this.unit.unitInfo.skills.butter)
         {
            this.unit.game.createParticle(this.unit.x + UT.rand(-5,5),this.unit.y - UT.rand(50,55),"text",0,null,"bigText","jam");
            this.manualReload(true);
            return;
         }
         var ammoNeeded:uint = this.curGun.clipSize - this.curGun.clipAmmo;
         if(this.curGun.infSpare)
         {
            this.curGun.clipAmmo = this.curGun.clipSize;
         }
         else if(this.curGun.spareAmmo < ammoNeeded)
         {
            this.curGun.clipAmmo += this.curGun.spareAmmo;
            if(MatchSettings.useMod != "clips")
            {
               this.curGun.spareAmmo = 0;
            }
         }
         else
         {
            this.curGun.clipAmmo = this.curGun.clipSize;
            if(MatchSettings.useMod != "clips")
            {
               this.curGun.spareAmmo -= ammoNeeded;
            }
         }
         if(this.unit.focused)
         {
            this.unit.game.hud.setAmmoCount(this.curGun);
         }
         if(this.unit.unitInfo.skills.reload)
         {
            this.unit.status.sRage = 30 * 2;
         }
      }
      
      public function reloadOther() : void
      {
         var ammoNeeded:uint = this.otherGun.clipSize - this.otherGun.clipAmmo;
         if(this.otherGun.spareAmmo < ammoNeeded)
         {
            this.otherGun.clipAmmo += this.otherGun.spareAmmo;
            if(MatchSettings.useMod != "clips" && !this.curGun.infSpare)
            {
               this.otherGun.spareAmmo = 0;
            }
         }
         else
         {
            this.otherGun.clipAmmo = this.otherGun.clipSize;
            if(MatchSettings.useMod != "clips" && !this.curGun.infSpare)
            {
               this.otherGun.spareAmmo -= ammoNeeded;
            }
         }
      }
      
      public function manualReload(_force:Boolean = false) : void
      {
         if(this.unit.status.sFrozen)
         {
            return;
         }
         if(this.curGun.clipAmmo == this.curGun.clipSize || !this.curGun.spareAmmo && !this.curGun.infSpare)
         {
            return;
         }
         if(this.reloading || this.shootDelay && !_force)
         {
            return;
         }
         if(this.curGun.extra.noShoot || this.curGun.noAmmo)
         {
            return;
         }
         this.checkReload(true);
      }
      
      public function checkReload(_force:Boolean = false) : void
      {
         if(this.unit.status.sFrozen)
         {
            return;
         }
         if(this.curGun.extra.noShoot || this.curGun.noAmmo)
         {
            return;
         }
         if(!this.unit.human && (!this.curGun.clipAmmo && (!this.curGun.spareAmmo && !this.curGun.infSpare)))
         {
            this.swapGuns();
            return;
         }
         if(this.curGun.ksWeap && this.curGun.clipAmmo == 0)
         {
            this.unit.endKillstreak();
            this.curGun = null;
            this.swapGuns();
            return;
         }
         if(!_force && (this.curGun.clipAmmo || !this.curGun.spareAmmo && !this.curGun.infSpare))
         {
            return;
         }
         this.setFrame("reload");
         this.reloading = true;
      }
   }
}
