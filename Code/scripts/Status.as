package
{
   import flash.filters.BlurFilter;
   import flash.filters.GlowFilter;
   
   public class Status
   {
       
      
      private var unit:Unit;
      
      public var hpCur:Number;
      
      public var hpMax:Number;
      
      public var arCur:Number;
      
      public var arMax:Number;
      
      private var hpBarDist:Number;
      
      private var healthBar:Range;
      
      private var hurtBar:Range;
      
      private var armorBar:Range;
      
      private var regenDelay:uint;
      
      public var stealthDelay:uint;
      
      public var sFireUnit:Unit;
      
      public var sAcidUnit:Unit;
      
      public var sSpawn:uint = 0;
      
      public var sFire:Number = 0;
      
      public var sIce:Number = 0;
      
      public var sFrozen:Number = 0;
      
      public var sFrozenTimer:Number = 0;
      
      public var sZap:Number = 0;
      
      public var sAcid:Number = 0;
      
      public var sCrap:Number = 0;
      
      public var sScan:Number = 0;
      
      public var sAdren:Number = 0;
      
      public var sFocus:Number = 0;
      
      public var sReflect:Number = 0;
      
      public var sTag:Number = 0;
      
      public var sElement:Number = 0;
      
      public var sDodge:Number = 0;
      
      public var sInvis:Number = 0;
      
      public var sSurge:Number = 0;
      
      public var sRegenBoost:Number = 0;
      
      public var sCritBoost:Number = 0;
      
      public var sCritBoost2:Number = 0;
      
      public var sAimBoost:Number = 0;
      
      public var sWallhack:Number = 0;
      
      public var sAimbot:Number = 0;
      
      public var sStealth:Number = 0;
      
      public var sBloodthirst:Number = 0;
      
      public var sRage:Number = 0;
      
      public var sAkimbo:Number = 0;
      
      public var sFireBeam:Number = 0;
      
      public var sIceBeam:Number = 0;
      
      public var sBeamUnit:Unit;
      
      public var overkill:Number = 0;
      
      public var usedTrap:Boolean;
      
      private var fc:uint = 0;
      
      public var healthColor:uint;
      
      public function Status(_unit:Unit)
      {
         super();
         this.unit = _unit;
         this.stealthDelay = 60;
      }
      
      public function reset() : void
      {
         this.hpMax = this.unit.unitInfo.health;
         if(this.unit.unitInfo.skills.sacrifice)
         {
            this.hpMax *= this.unit.unitInfo.skills.sacrifice;
         }
         this.hpCur = this.hpMax;
         this.arMax = this.unit.unitInfo.armor;
         this.arCur = 0;
         this.sFire = 0;
         this.sIce = 0;
         this.sFrozen = 0;
         this.sFrozenTimer = 0;
         this.sZap = 0;
         this.sAcid = 0;
         this.sCrap = 0;
         this.sAdren = 0;
         this.sFocus = 0;
         this.sReflect = 0;
         this.sTag = 0;
         this.sElement = 0;
         this.sDodge = 0;
         this.sInvis = 0;
         this.sSurge = 0;
         this.sRegenBoost = 0;
         this.sCritBoost = 0;
         this.sCritBoost2 = 0;
         this.sAimBoost = 0;
         this.sWallhack = 0;
         this.sAimbot = 0;
         this.sStealth = 0;
         this.sBloodthirst = 0;
         this.sRage = 0;
         this.sAkimbo = 0;
         this.sFireBeam = 0;
         this.sIceBeam = 0;
         this.overkill = 0;
         this.usedTrap = false;
         this.healthBar = new Range(0,10 + this.hpMax * 0.085);
         this.healthBar.cur = this.healthBar.max;
         this.armorBar = new Range(0,this.arMax * 0.1);
         this.armorBar.cur = this.armorBar.max;
         this.hurtBar = new Range(0,0,0);
         this.hpBarDist = this.hpMax / 25;
         this.hpBarDist = this.healthBar.max / this.hpBarDist;
         this.heal(this.hpMax,false,true);
         if(this.unit.focused)
         {
            this.unit.game.hud.bloodyscreen.alpha = 0;
            this.unit.game.hud.bloodyscreen.scaleX = UT.coinFlip(1,-1);
            this.unit.game.hud.bloodyscreen.scaleY = UT.coinFlip(1,-1);
            this.unit.game.hud.bloodyscreen.gotoAndStop(!!SD.screenBlood ? 1 : 2);
         }
         if(this.unit.unitInfo.skills.stealth || this.unit.unitInfo.skills.stealth_)
         {
            this.sInvis = 1;
         }
         if(this.unit.unitInfo.extra.permRegen)
         {
            this.sRegenBoost = Number.MAX_VALUE;
         }
         if(this.unit.unitInfo.extra.permReflect)
         {
            this.sReflect = Number.MAX_VALUE;
         }
         if(this.unit.unitInfo.extra.permWallhack)
         {
            this.sWallhack = Number.MAX_VALUE;
         }
         if(this.unit.unitInfo.extra.permAkimbo)
         {
            this.sAkimbo = Number.MAX_VALUE;
         }
      }
      
      public function heal(_amt:Number, _effect:Boolean = true, _force:Boolean = false) : void
      {
         if(this.unit.dead && !_force)
         {
            return;
         }
         this.hpCur += _amt;
         if(this.hpCur > this.hpMax)
         {
            this.hpCur = this.hpMax;
         }
         if(_effect)
         {
            this.unit.game.createEffect(this.unit.x,this.unit.y - 40,"healthPickup");
         }
         this.setBars();
      }
      
      public function repair(_amt:Number, _effect:Boolean = true, _force:Boolean = false) : void
      {
         if(this.unit.dead && !_force)
         {
            return;
         }
         this.arCur += _amt;
         if(this.arCur > this.arMax)
         {
            this.arCur = this.arMax;
         }
         if(_effect)
         {
            this.unit.game.createEffect(this.unit.x,this.unit.y - 40,"armorPickup");
         }
         this.setBars();
      }
      
      public function setFire(_unit:Unit, _time:uint) : void
      {
         this.sFireUnit = _unit;
         if(_time < this.sFire)
         {
            return;
         }
         this.sFire = _time;
      }
      
      public function setAcid(_unit:Unit, _time:uint) : void
      {
         this.sAcidUnit = _unit;
         if(_time < this.sAcid)
         {
            return;
         }
         this.sAcid = _time;
      }
      
      public function damage(_amt:Number, _shooter:Unit, _weapon:Stats_Guns, _extra:Object, _forceDmg:Boolean = false) : void
      {
         var hpPerc:Number = NaN;
         var headDmg:Number = NaN;
         var critDmg:Number = NaN;
         if(this.unit.dead)
         {
            return;
         }
         if(this.sSpawn && !_forceDmg)
         {
            return;
         }
         if(this.unit.unitInfo.skills.luck1 && Math.random() < this.unit.unitInfo.skills.luck1)
         {
            this.unit.game.createParticle(this.unit.x + UT.rand(-5,5),this.unit.y - UT.rand(25,50),"text",0,null,"bigText","lucky");
            return;
         }
         if(this.unit.unitInfo.skills.dodge && Math.random() < this.unit.unitInfo.skills.dodge)
         {
            this.unit.game.createParticle(this.unit.x + UT.rand(-5,5),this.unit.y - UT.rand(25,50),"text",0,null,"bigText","dodge");
            this.sDodge = 20;
            return;
         }
         if(_shooter.unitInfo.level == 0)
         {
            _amt *= 0.5;
         }
         var selfDmg:Boolean = false;
         if(this.unit == _shooter)
         {
            selfDmg = true;
            if(!this.unit.human && _weapon.type == 9)
            {
               _amt = 0;
            }
            else if(!this.unit.human)
            {
               _amt *= 0.3;
            }
            _amt *= _weapon.selfDmg;
            if(this.unit.unitInfo.skills.self0)
            {
               _amt *= this.unit.unitInfo.skills.self0;
            }
            if(this.unit.unitInfo.skills.self1)
            {
               _amt *= this.unit.unitInfo.skills.self1;
            }
         }
         else if(this.unit.human)
         {
            _amt *= 0.6 + _shooter.diff * 0.4;
         }
         else if(MatchSettings.matchType == 0 && !this.unit.human && !_shooter.human)
         {
            if(this.unit.team == 1)
            {
               _amt *= 0.6 + _shooter.diff * 0.4;
            }
            else
            {
               _amt *= 0.7 + _shooter.diff * 0.3;
            }
         }
         else if(!this.unit.human && !_shooter.human)
         {
            _amt *= 0.7 + _shooter.diff * 0.3;
         }
         if(!_shooter.human && this.unit.team == _shooter.team && this.unit.team > 0)
         {
            _amt *= 0.3;
         }
         if(this.sZap > 0)
         {
            _amt *= 1.1;
         }
         if(this.unit.unitInfo.skills.damage0)
         {
            _amt *= this.unit.unitInfo.skills.damage0;
         }
         if(this.unit.unitInfo.skills.damage1)
         {
            _amt *= this.unit.unitInfo.skills.damage1;
         }
         if(_shooter.unitInfo.skills.sacrifice)
         {
            _amt *= _shooter.unitInfo.skills.sacrifice;
         }
         if(this.unit.unitInfo.skills.will)
         {
            _amt *= 1 - (1 - this.hpCur / this.hpMax) * this.unit.unitInfo.skills.will;
         }
         if(_shooter.unitInfo.skills.rage)
         {
            hpPerc = 1 - _shooter.status.hpCur / _shooter.status.hpMax;
            _amt *= 1 + hpPerc * _shooter.unitInfo.skills.rage;
         }
         if(_weapon.id == "fire" || _weapon.id == "acid")
         {
            if(this.unit.unitInfo.skills.burn0)
            {
               _amt *= this.unit.unitInfo.skills.burn0;
            }
            if(this.unit.unitInfo.skills.burn1)
            {
               _amt *= this.unit.unitInfo.skills.burn1;
            }
         }
         if(_weapon.isExplosive)
         {
            if(this.unit.unitInfo.skills.explo0)
            {
               _amt *= this.unit.unitInfo.skills.explo0;
            }
            if(this.unit.unitInfo.skills.explo1)
            {
               _amt *= this.unit.unitInfo.skills.explo1;
            }
         }
         if(_shooter.unitInfo.skills.tag)
         {
            this.sTag = 5 * 30;
         }
         if(_shooter.unitInfo.skills.killsteal && this.unit.target != _shooter && !this.unit.human)
         {
            _amt *= _shooter.unitInfo.skills.killsteal;
         }
         if(_shooter.unitInfo.skills.focus && _shooter.status.sFocus > 1 * 30)
         {
            _amt *= _shooter.unitInfo.skills.focus;
         }
         if(this.unit.isJug)
         {
            _amt *= 0.7;
         }
         if(this.unit.team && this.unit.team == _shooter.team && this.unit != _shooter)
         {
            _amt *= 0.3;
            _extra.teamkill = true;
         }
         var rand:Number = Math.random();
         if(this.unit.unitInfo.skills.status0)
         {
            rand += this.unit.unitInfo.skills.status0;
         }
         if(this.unit.unitInfo.skills.status1)
         {
            rand += this.unit.unitInfo.skills.status1;
         }
         if(_shooter.unitInfo.skills.coating)
         {
            rand += _shooter.unitInfo.skills.coating;
         }
         if(_shooter.unitInfo.skills.coating_)
         {
            rand += _shooter.unitInfo.skills.coating_;
         }
         if(rand < 0)
         {
            rand = 0;
         }
         if(!selfDmg)
         {
            if(rand < _weapon.fire)
            {
               this.setFire(_shooter,2 * 30);
            }
            if(rand < _weapon.acid)
            {
               this.setAcid(_shooter,10 * 30);
            }
            if(rand < _weapon.ice)
            {
               this.sIce = 2 * 30;
            }
            if(rand < _weapon.zap)
            {
               this.sZap = 2 * 30;
            }
            if(rand < _weapon.crap)
            {
               this.sCrap = 3 * 30;
            }
         }
         if(_shooter.status.sAimbot && Math.random() < 0.7)
         {
            _extra.headMult = 1;
         }
         var critChance:Number = _shooter.unitInfo.crit / 100 + _weapon.crit;
         if(_shooter.status.sCritBoost)
         {
            critChance += 0.5;
         }
         if(_shooter.status.sCritBoost2)
         {
            critChance += 0.1;
         }
         if(this.unit.unitInfo.skills.luck0 && Math.random() < this.unit.unitInfo.skills.luck0)
         {
            critChance = 999;
         }
         if(this.unit.unitInfo.skills.magnet && Math.random() < this.unit.unitInfo.skills.magnet)
         {
            _extra.headMult = 1;
         }
         if(_extra.headMult && !_weapon.noHead && this.unit != _shooter)
         {
            headDmg = 1.4 + _weapon.headDmg;
            if(_shooter.unitInfo.skills.headdmg)
            {
               headDmg += _shooter.unitInfo.skills.headdmg;
            }
            _amt *= headDmg;
            this.unit.game.createParticle(this.unit.x + UT.rand(-5,5),this.unit.y - UT.rand(50,55),"text",0,null,"bigText","headshot");
         }
         else if(Math.random() <= critChance && !_weapon.noCrit && this.unit != _shooter)
         {
            _extra.critMult = true;
            critDmg = 1.3 + _weapon.critDmg;
            if(_shooter.unitInfo.skills.critdmg)
            {
               critDmg += _shooter.unitInfo.skills.critdmg;
            }
            _amt *= critDmg;
            this.unit.game.createParticle(this.unit.x + UT.rand(-5,5),this.unit.y - UT.rand(25,50),"text",0,null,"bigText","critical");
         }
         if(_extra.splashMult)
         {
            _amt *= _extra.splashMult;
         }
         if(_extra.headMult)
         {
            if(_shooter.unitInfo.skills.head0)
            {
               _amt *= _shooter.unitInfo.skills.head0;
            }
            if(_shooter.unitInfo.skills.head1)
            {
               _amt *= _shooter.unitInfo.skills.head1;
            }
         }
         if(this.unit.human && this.unit.unitInfo.cls == "jug")
         {
            Stats_Achievements.checkAchVariable("jug",_amt);
         }
         var hitArmor:Boolean = false;
         if(this.arCur && !_forceDmg)
         {
            hitArmor = true;
            this.arCur -= _amt;
            if(this.arCur <= 0)
            {
               _amt = -this.arCur;
               this.arCur = 0;
            }
            else
            {
               _amt = 0;
            }
         }
         var canAdren:Boolean = this.hpCur > 20 && this.hpCur / this.hpMax > 0.3;
         this.hpCur -= _amt;
         if(this.unit.unitInfo.skills.adren && canAdren && this.hpCur < 1 && !_forceDmg)
         {
            this.unit.game.createParticle(this.unit.x + UT.rand(-5,5),this.unit.y - UT.rand(50,55),"text",0,null,"bigText","adren");
            this.hpCur = 1;
         }
         if(this.hpCur <= 0)
         {
            if(this.unit.unitInfo.skills.bomb)
            {
               this.unit.gun.makeBullet(Stats_Guns.getStatsAtLevel("bomb",this.unit.unitInfo.level));
            }
            this.hpCur = 0;
            this.unit.die(_shooter,_weapon,_extra);
            if(this.unit.focused)
            {
               this.unit.game.hud.bloodyscreen.alpha = 1;
            }
         }
         this.setStealthDelay();
         this.regenDelay = 30 * 3;
         if(this.unit.unitInfo.skills.regen1)
         {
            this.regenDelay = 0;
         }
         this.setBars();
      }
      
      public function setBars() : void
      {
         this.healthBar.old = this.healthBar.cur;
         this.healthBar.cur = this.hpCur / this.hpMax * this.healthBar.max;
         this.armorBar.old = this.armorBar.cur;
         this.armorBar.cur = this.arCur / this.arMax * this.armorBar.max;
         if(this.healthBar.old - this.healthBar.cur <= 0 && this.armorBar.old - this.armorBar.cur <= 0)
         {
            this.hurtBar.cur = 0;
         }
         else
         {
            this.hurtBar.cur += this.healthBar.old - this.healthBar.cur + (this.armorBar.old - this.armorBar.cur);
         }
         this.drawHpBars();
         if(this.unit.focused)
         {
            this.setHudStuff();
         }
      }
      
      public function setHudStuff() : void
      {
         this.unit.game.hud.txt_ar.text = "" + Math.ceil(this.arCur);
         this.unit.game.hud.txt_hp.text = "" + Math.ceil(this.hpCur);
         this.unit.game.hud.hud_bg.bar_ar.bar.width = this.arCur / this.arMax * 100;
         this.unit.game.hud.hud_bg.bar_hp.bar.width = this.hpCur / this.hpMax * 100;
         if(this.unit.focused && this.unit.dead)
         {
            this.unit.game.hud.bloodyscreen.alpha = 1;
         }
      }
      
      public function drawHpBars() : void
      {
         var hpBarDistWidth:Number = NaN;
         this.hurtBar.cur += (0 - this.hurtBar.cur) * 0.1;
         this.unit.mc_hp.graphics.clear();
         this.unit.mc_hp.graphics.beginFill(this.healthColor,1);
         this.unit.mc_hp.graphics.drawRect(this.healthBar.min,0,this.healthBar.cur,3);
         this.unit.mc_hp.graphics.endFill();
         this.unit.mc_hp.graphics.beginFill(16777215,1);
         this.unit.mc_hp.graphics.drawRect(this.healthBar.cur,0,this.armorBar.cur,3);
         this.unit.mc_hp.graphics.endFill();
         this.unit.mc_hp.graphics.beginFill(16711680,0.5);
         this.unit.mc_hp.graphics.drawRect(this.healthBar.cur + this.armorBar.cur,0,this.hurtBar.cur,3);
         this.unit.mc_hp.graphics.endFill();
         var showDarkBar:* = true;
         for(var i:uint = this.hpBarDist; i < this.healthBar.cur; i += this.hpBarDist)
         {
            if(showDarkBar)
            {
               hpBarDistWidth = this.hpBarDist;
               if(i + this.hpBarDist > this.healthBar.cur)
               {
                  hpBarDistWidth = this.healthBar.cur - i;
               }
               this.unit.mc_hp.graphics.beginFill(0,0.2);
               this.unit.mc_hp.graphics.drawRect(i,0,hpBarDistWidth,3);
               this.unit.mc_hp.graphics.endFill();
            }
            showDarkBar = !showDarkBar;
         }
      }
      
      public function setStealthDelay(_shooting:Boolean = false) : void
      {
         this.stealthDelay = 10;
         this.sStealth = 0;
      }
      
      public function EnterFrame() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         ++this.fc;
         ++this.sFocus;
         if(this.unit.unitInfo.skills.focus && this.sFocus == 1 * 30)
         {
            if(this.sInvis < 0.7)
            {
               this.unit.game.createParticle(this.unit.x + UT.rand(-5,5),this.unit.y - UT.rand(50,55),"text",0,null,"bigText","focus");
            }
         }
         if(this.sWallhack)
         {
            if(this.sWallhack > 10 || this.sWallhack % 2 != 0)
            {
               if(this.sInvis < 0.7)
               {
                  this.unit.game.bitscreen.paint(this.unit.x + this.unit.game.arena.x,this.unit.y + this.unit.game.arena.y - 30,true,"lightningGreen0","idle",this.fc % 6 + 1);
               }
            }
            --this.sWallhack;
         }
         if(this.sAimbot)
         {
            if(this.sAimbot > 10 || this.sAimbot % 2 != 0)
            {
               if(this.sInvis < 0.7)
               {
                  this.unit.game.bitscreen.paint(this.unit.x + this.unit.game.arena.x,this.unit.y + this.unit.game.arena.y - 30,true,"lightningYellow0","idle",this.fc % 6 + 1);
               }
            }
            --this.sAimbot;
         }
         if(this.sAkimbo)
         {
            if(this.sAkimbo > 10 || this.sAkimbo % 2 != 0)
            {
               if(this.sInvis < 0.7)
               {
                  this.unit.game.bitscreen.paint(this.unit.x + this.unit.game.arena.x,this.unit.y + this.unit.game.arena.y - 30,true,"lightningRed0","idle",this.fc % 6 + 1);
               }
            }
            --this.sAkimbo;
         }
         if(this.sTag)
         {
            if(this.sInvis < 0.7)
            {
               this.unit.game.bitscreen.paint(this.unit.x + this.unit.game.arena.x,this.unit.y + this.unit.game.arena.y - 30,true,"scan0");
            }
            --this.sTag;
         }
         if(this.sRage)
         {
            if(this.sRage > 10 || this.sRage % 2 != 0)
            {
               if(SD.graphGlow)
               {
                  this.unit.MCfilters.push(new GlowFilter(16776960,1,20,20,1.5,1,true,false),new GlowFilter(16711680,1,5,5,1));
               }
               else
               {
                  this.unit.MCfilters.push(new GlowFilter(16776960,1,10,10,1.5));
               }
            }
            --this.sRage;
         }
         if(this.sReflect)
         {
            if(this.sReflect > 10 || this.sReflect % 2 != 0)
            {
               if(this.sInvis < 0.7)
               {
                  this.unit.game.bitscreen.paint(this.unit.x + this.unit.game.arena.x,this.unit.y + this.unit.game.arena.y - 40,true,"tankFire0","idle",this.fc % 11 + 1);
               }
            }
            --this.sReflect;
         }
         if(this.sElement)
         {
            if(this.sElement > 10 || this.sElement % 2 != 0)
            {
               if(this.sInvis < 0.7)
               {
                  this.unit.game.bitscreen.paint(this.unit.x + this.unit.game.arena.x,this.unit.y + this.unit.game.arena.y - 40,true,"tankIce0","idle",this.fc % 13 + 1);
               }
            }
            if(this.fc % 20)
            {
               for(_loc1_ = 0; _loc1_ < this.unit.game.units.length; _loc1_++)
               {
                  if(this.unit.game.units[_loc1_] != this.unit)
                  {
                     if(!this.unit.game.units[_loc1_].dead)
                     {
                        if(!this.unit.game.units[_loc1_].status.sSpawn)
                        {
                           if(!(this.unit.team && this.unit.game.units[_loc1_].team == this.unit.team))
                           {
                              if(UT.getDist(this.unit.x,this.unit.y,this.unit.game.units[_loc1_].x,this.unit.game.units[_loc1_].y) < 230)
                              {
                                 this.unit.game.units[_loc1_].status.setFire(this.unit,20);
                                 this.unit.game.units[_loc1_].status.setAcid(this.unit,20);
                              }
                           }
                        }
                     }
                  }
               }
            }
            --this.sElement;
         }
         if(this.sFireBeam)
         {
            --this.sFireBeam;
            if(this.sFireBeam > 30)
            {
               this.unit.game.lineCont.graphics.lineStyle((1 - this.sFireBeam / 60) * 2,16711680,1.3 - this.sFireBeam / 60);
            }
            else if(this.fc % 2 == 0)
            {
               this.unit.game.lineCont.graphics.lineStyle(1,16711680,1);
            }
            if(this.sFireBeam == 2)
            {
               this.unit.game.createEffect(this.unit.x,this.unit.y - 50,"explosionTiny");
               this.damage(Stats_Guns.getDamageAtLevel("firebeam",this.sBeamUnit.unitInfo.level),this.sBeamUnit,Stats_Guns.itemOb["firebeam"],{});
               this.setFire(this.sBeamUnit,2 * 30);
               this.unit.game.lineCont.graphics.lineStyle(15,16750848,1);
            }
            if(this.sFireBeam == 1)
            {
               this.unit.game.lineCont.graphics.lineStyle(7,16750848,1);
            }
            if(this.sFireBeam == 0)
            {
               this.unit.game.lineCont.graphics.lineStyle(4,16750848,1);
            }
            this.unit.game.lineCont.graphics.moveTo(this.unit.x,this.unit.y - 50);
            this.unit.game.lineCont.graphics.lineTo(this.unit.x,this.unit.y - 600);
         }
         if(this.sIceBeam)
         {
            --this.sIceBeam;
            if(this.sIceBeam > 30)
            {
               this.unit.game.lineCont.graphics.lineStyle((1 - this.sIceBeam / 60) * 2,3381759,1.3 - this.sIceBeam / 60);
            }
            else if(this.fc % 2 == 0)
            {
               this.unit.game.lineCont.graphics.lineStyle(1,3381759,1);
            }
            if(this.sIceBeam == 2)
            {
               this.unit.game.createEffect(this.unit.x,this.unit.y - 50,"bulletsparkIce");
               this.damage(Stats_Guns.getDamageAtLevel("icebeam",this.sBeamUnit.unitInfo.level),this.sBeamUnit,Stats_Guns.itemOb["icebeam"],{});
               this.sFrozen = 2 * 30;
               this.sIce = 2 * 30;
               this.unit.stopFrames();
               this.unit.game.lineCont.graphics.lineStyle(15,6750207,1);
            }
            if(this.sIceBeam == 1)
            {
               this.unit.game.lineCont.graphics.lineStyle(7,6750207,1);
            }
            if(this.sIceBeam == 0)
            {
               this.unit.game.lineCont.graphics.lineStyle(4,6750207,1);
            }
            this.unit.game.lineCont.graphics.moveTo(this.unit.x,this.unit.y - 50);
            this.unit.game.lineCont.graphics.lineTo(this.unit.x,this.unit.y - 600);
         }
         if(this.sFire > 0)
         {
            if(this.sFire > 10 || this.sFire % 2 != 0)
            {
               if(SD.graphGlow)
               {
                  this.unit.MCfilters.push(new GlowFilter(16758272,1,20,20,1.5,1,true,false),new GlowFilter(16758272,1,5,5,1));
               }
               else
               {
                  this.unit.MCfilters.push(new GlowFilter(16758272,1,10,10,1.5));
               }
               if(this.sInvis < 0.7)
               {
                  this.unit.game.createEffect(this.unit.x + UT.rand(-10,10),this.unit.y + UT.rand(-55,-10),"flame");
               }
            }
            if(this.fc % 10 == 0)
            {
               this.damage(Stats_Guns.getDamageAtLevel("fire",this.sFireUnit.unitInfo.level),this.sFireUnit,Stats_Guns.itemOb["fire"],{});
            }
            --this.sFire;
            if(this.unit.unitInfo.skills.proof)
            {
               --this.sFire;
            }
         }
         if(this.sAcid > 0)
         {
            if(this.sAcid > 10 || this.sAcid % 2 != 0)
            {
               if(SD.graphGlow)
               {
                  this.unit.MCfilters.push(new GlowFilter(11324416,1,20,20,1.5,1,true,false),new GlowFilter(11324416,1,5,5,1));
               }
               else
               {
                  this.unit.MCfilters.push(new GlowFilter(11324416,1,10,10,1.5));
               }
               if(this.sInvis < 0.7)
               {
                  this.unit.game.createEffect(this.unit.x + UT.rand(-10,10),this.unit.y + UT.rand(-55,-10),"bubble");
               }
            }
            if(this.fc % 10 == 0)
            {
               this.damage(Stats_Guns.getDamageAtLevel("acid",this.sAcidUnit.unitInfo.level),this.sAcidUnit,Stats_Guns.itemOb["acid"],{});
            }
            --this.sAcid;
            if(this.unit.unitInfo.skills.proof)
            {
               --this.sAcid;
            }
         }
         if(this.sIce > 0)
         {
            if(this.sIce > 10 || this.sIce % 2 != 0)
            {
               if(SD.graphGlow)
               {
                  this.unit.MCfilters.push(new GlowFilter(13434879,1,20,20,1.5,1,true,false),new GlowFilter(13434879,1,5,5,1));
               }
               else
               {
                  this.unit.MCfilters.push(new GlowFilter(13434879,1,10,10,1.5));
               }
            }
            --this.sIce;
            ++this.sFrozenTimer;
            if(this.sFrozenTimer >= 2 * 30)
            {
               if(!this.sFrozen)
               {
                  this.unit.game.playScreenSound(S_Ice,this.unit.x,this.unit.y);
               }
               this.sFrozenTimer = 0;
               this.sFrozen = 2 * 30;
               this.sIce = 2 * 30;
            }
         }
         else
         {
            this.sFrozenTimer = 0;
         }
         if(this.sFrozen > 0)
         {
            this.unit.game.bitscreen.paint(this.unit.x + this.unit.game.arena.x,this.unit.y + this.unit.game.arena.y - 30,true,"ice0");
            --this.sFrozen;
            if(this.unit.unitInfo.skills.proof)
            {
               --this.sFrozen;
            }
            if(this.sFrozen <= 0)
            {
               this.sIce = 0;
               this.sFrozenTimer = 0;
            }
         }
         if(this.sZap > 0)
         {
            if(this.sZap > 10 || this.sZap % 2 != 0)
            {
               if(SD.graphGlow)
               {
                  this.unit.MCfilters.push(new GlowFilter(6711039,1,20,20,1.5,1,true,false),new GlowFilter(6711039,1,5,5,1));
               }
               else
               {
                  this.unit.MCfilters.push(new GlowFilter(6711039,1,10,10,1.5));
               }
            }
            --this.sZap;
            if(this.unit.unitInfo.skills.proof)
            {
               --this.sZap;
            }
         }
         if(this.sCrap > 0)
         {
            if(this.sCrap > 10 || this.sCrap % 2 != 0)
            {
               if(SD.graphGlow)
               {
                  this.unit.MCfilters.push(new GlowFilter(10053120,1,20,20,1.5,1,true,false),new GlowFilter(10053120,1,5,5,1));
               }
               else
               {
                  this.unit.MCfilters.push(new GlowFilter(10053120,1,10,10,1.5));
               }
            }
            --this.sCrap;
            if(this.unit.unitInfo.skills.proof)
            {
               --this.sCrap;
            }
         }
         if(this.arCur)
         {
            if(SD.graphGlow)
            {
               this.unit.MCfilters.push(new GlowFilter(16777215,this.arCur / this.arMax,10,10,1,1,true,false),new GlowFilter(16777215,this.arCur / this.arMax + 0.5,4,4,1));
            }
            else
            {
               this.unit.MCfilters.push(new GlowFilter(16777215,this.arCur / 120 + 0.5,10,10,1.5));
            }
         }
         if(this.sDodge)
         {
            this.unit.MCfilters.push(new BlurFilter(5,0,1));
            --this.sDodge;
         }
         if(this.unit.isJug)
         {
            this.unit.MCfilters.push(new GlowFilter(16711680,1,8,8,2));
         }
         this.drawHpBars();
         if(this.sInvis)
         {
            if(this.unit.focused || this.unit.team == 1)
            {
               this.unit.MC.alpha = 1 - this.sInvis * 0.8;
            }
            else
            {
               this.unit.alpha = 1 - this.sInvis;
            }
         }
         else
         {
            this.unit.alpha = 1;
            this.unit.MC.alpha = 1;
         }
         if(this.sStealth > 0)
         {
            --this.sStealth;
            this.sInvis = 1;
         }
         else if(this.unit.unitInfo.skills.stealth || this.unit.unitInfo.skills.stealth_)
         {
            if(this.fc % 5 == 0)
            {
               for(_loc1_ = 0; _loc1_ < this.unit.game.units.length; _loc1_++)
               {
                  if(this.unit.game.units[_loc1_] != this)
                  {
                     if(!this.unit.game.units[_loc1_].dead)
                     {
                        if(!(this.unit.team && this.unit.team == this.unit.game.units[_loc1_].team))
                        {
                           if(this.unit.unitInfo.skills.stealth && UT.getDist(this.unit.x,this.unit.y,this.unit.game.units[_loc1_].x,this.unit.game.units[_loc1_].y) < 325)
                           {
                              this.stealthDelay = 15;
                           }
                        }
                     }
                  }
               }
            }
            if(this.unit.hasFlag)
            {
               this.stealthDelay = 60;
            }
            if(this.stealthDelay)
            {
               --this.stealthDelay;
               this.sInvis -= 0.05;
               if(this.sInvis < 0)
               {
                  this.sInvis = 0;
               }
            }
            else
            {
               this.sInvis += 0.05;
               if(this.sInvis > 1)
               {
                  this.sInvis = 1;
               }
            }
         }
         else
         {
            this.sInvis -= 0.05;
            if(this.sInvis < 0)
            {
               this.sInvis = 0;
            }
         }
         if(this.sCritBoost)
         {
            if(this.fc % 3 == 0 && this.sInvis < 0.7)
            {
               this.unit.game.createEffect(this.unit.x + UT.rand(-10,10),this.unit.y + UT.rand(-45,-10),"critBoost");
            }
            if(this.sCritBoost > 10 || this.sCritBoost % 2 != 0)
            {
               this.unit.MCfilters.push(new GlowFilter(16711680,0.8,10,10,1,1,true));
            }
            --this.sCritBoost;
         }
         if(this.sCritBoost2)
         {
            if(this.fc % 5 == 0 && this.sInvis < 0.7)
            {
               this.unit.game.createEffect(this.unit.x + UT.rand(-10,10),this.unit.y + UT.rand(-45,-10),"critBoost");
            }
            --this.sCritBoost2;
         }
         if(this.sAimBoost)
         {
            if(this.fc % 3 == 0 && this.sInvis < 0.7)
            {
               this.unit.game.createEffect(this.unit.x + UT.rand(-10,10),this.unit.y + UT.rand(-45,-10),"aimBoost");
            }
            if(this.sAimBoost > 10 || this.sAimBoost % 2 != 0)
            {
               this.unit.MCfilters.push(new GlowFilter(16776960,0.8,10,10,1,1,true));
            }
            --this.sAimBoost;
         }
         if(this.sRegenBoost)
         {
            if(this.fc % 3 == 0)
            {
               if(this.sInvis < 0.7)
               {
                  this.unit.game.createEffect(this.unit.x + UT.rand(-10,10),this.unit.y + UT.rand(-45,-10),"healthRegen");
               }
               this.heal(this.hpMax * 0.01,false);
            }
            if(this.sRegenBoost > 10 || this.sRegenBoost % 2 != 0)
            {
               this.unit.MCfilters.push(new GlowFilter(65280,0.8,10,10,1,1,true));
            }
            --this.sRegenBoost;
         }
         else if(this.regenDelay)
         {
            --this.regenDelay;
         }
         else if(this.hpCur < this.hpMax)
         {
            if(this.unit.unitInfo.skills.regen2)
            {
               if(this.fc % 3 == 0)
               {
                  this.heal(this.hpMax * 0.01,false);
                  if(this.sInvis < 0.7)
                  {
                     this.unit.game.createEffect(this.unit.x + UT.rand(-10,10),this.unit.y + UT.rand(-45,-10),"healthRegen");
                  }
               }
            }
            else if(!this.unit.unitInfo.skills.regen0 && this.fc % 9 == 0)
            {
               this.heal(this.hpMax * 0.01,false);
               if(this.sInvis < 0.7)
               {
                  this.unit.game.createEffect(this.unit.x + UT.rand(-10,10),this.unit.y + UT.rand(-45,-10),"healthRegen");
               }
            }
         }
         if(this.unit.focused)
         {
            _loc2_ = this.hpCur / this.hpMax;
            if(_loc2_ > 0.5)
            {
               this.unit.game.hud.bloodyscreen.alpha = 0;
            }
            else
            {
               this.unit.game.hud.bloodyscreen.alpha = 1 - _loc2_ * 1.8;
            }
         }
         if(this.unit.team && this.unit.unitInfo.skills.aura && this.fc % (3 * 30) == 0)
         {
            for(_loc1_ = 0; _loc1_ < this.unit.game.units.length; _loc1_++)
            {
               if(this.unit.game.units[_loc1_] != this.unit)
               {
                  if(this.unit.team == this.unit.game.units[_loc1_].team)
                  {
                     if(UT.getDist(this.unit.x,this.unit.y,this.unit.game.units[_loc1_].x,this.unit.game.units[_loc1_].y) < 200)
                     {
                        this.unit.game.units[_loc1_].status.heal(this.unit.game.units[_loc1_].status.hpMax * 0.15);
                     }
                  }
               }
            }
         }
         if(this.unit.team && this.unit.unitInfo.skills.inspire && this.fc % 15 == 0)
         {
            for(_loc1_ = 0; _loc1_ < this.unit.game.units.length; _loc1_++)
            {
               if(this.unit.game.units[_loc1_] != this.unit)
               {
                  if(this.unit.team == this.unit.game.units[_loc1_].team)
                  {
                     if(UT.getDist(this.unit.x,this.unit.y,this.unit.game.units[_loc1_].x,this.unit.game.units[_loc1_].y) < 200)
                     {
                        this.unit.game.units[_loc1_].status.sCritBoost2 = 15;
                     }
                  }
               }
            }
         }
         if(this.unit.unitInfo.skills.boots && this.hpCur / this.hpMax < 0.4)
         {
            this.sRage = 5;
         }
      }
   }
}
