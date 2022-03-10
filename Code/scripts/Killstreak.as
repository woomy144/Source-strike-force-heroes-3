package
{
   import flash.geom.ColorTransform;
   
   public class Killstreak
   {
       
      
      protected var game:Game;
      
      public var unit:AI;
      
      protected var maxWidth:Number;
      
      public var x:Number;
      
      public var y:Number;
      
      public var shootable:Boolean;
      
      protected var target;
      
      public var fc:uint = 0;
      
      protected var shootTimer:uint = 0;
      
      protected var timer:uint = 0;
      
      protected var gun:Stats_Guns;
      
      protected var gunName:String;
      
      protected var MC;
      
      private var hpCur:Number;
      
      private var hpMax:Number;
      
      private var healthBar:Range;
      
      public var dead:Boolean = false;
      
      private var hpBarDist:Number;
      
      public function Killstreak(_game:Game, _unit:AI, _timer:Number, _gunName:String, _shootable:Boolean)
      {
         super();
         this.game = _game;
         this.unit = _unit;
         this.timer = _timer;
         if(this.unit.unitInfo.skills.turret2)
         {
            this.timer *= this.unit.unitInfo.skills.turret2;
         }
         this.shootable = _shootable;
         this.gunName = _gunName;
         this.gun = new GunInfo(_gunName,this.unit.unitInfo.level,0).stats;
      }
      
      public function setText(_MC:*) : void
      {
         if(!this.shootable)
         {
            return;
         }
         _MC.txt_level.text = this.unit.unitInfo.level;
         _MC.txt_name.text = this.unit.name;
         var colTrans:* = new ColorTransform();
         colTrans.color = this.unit.status.healthColor;
         _MC.txt_level.transform.colorTransform = colTrans;
         _MC.txt_level.alpha = 0.7;
         _MC.txt_name.transform.colorTransform = colTrans;
         _MC.txt_name.alpha = 0.7;
         this.hpMax = Stats_Classes.getStat(this.unit.unitInfo.level,"jug","health");
         if(this.unit.unitInfo.skills.turret2)
         {
            this.hpMax *= this.unit.unitInfo.skills.turret2;
         }
         this.hpCur = this.hpMax;
         this.healthBar = new Range(0,35 + this.hpMax * 0.05);
         this.healthBar.cur = this.healthBar.max;
         this.hpBarDist = this.hpMax / 25;
         trace("HP Bar amount",this.hpBarDist,"with max health",this.hpMax);
         this.hpBarDist = this.healthBar.max / this.hpBarDist;
         this.setBars();
      }
      
      public function damage(_amt:Number, _shooter:Unit, _weapon:Stats_Guns, _extra:Object, _forceDmg:Boolean = false) : void
      {
         if(!this.shootable)
         {
            return;
         }
         this.hpCur -= _amt;
         if(this.unit == _shooter)
         {
            if(_weapon.extra.noAllyDmg)
            {
               _amt *= 0.4;
            }
         }
         else if(this.unit.human)
         {
            _amt *= 0.3 + _shooter.diff * 0.07;
         }
         else if(MatchSettings.matchType == 0 && !this.unit.human && !_shooter.human)
         {
            _amt *= 0.4 + _shooter.diff * 0.03;
         }
         else if(!this.unit.human && !_shooter.human)
         {
            _amt *= 0.6 + _shooter.diff * 0.04;
         }
         if(this.hpCur <= 0)
         {
            this.hpCur = 0;
            this.end(true);
         }
         this.setBars();
      }
      
      public function setBars() : void
      {
         var hpBarDistWidth:Number = NaN;
         this.healthBar.cur = this.hpCur / this.hpMax * this.healthBar.max;
         this.MC.mc_hp.graphics.clear();
         this.MC.mc_hp.graphics.beginFill(16777113,1);
         this.MC.mc_hp.graphics.drawRect(this.healthBar.min,0,this.healthBar.cur,3);
         this.MC.mc_hp.graphics.endFill();
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
               this.MC.mc_hp.graphics.beginFill(0,0.2);
               this.MC.mc_hp.graphics.drawRect(i,0,hpBarDistWidth,3);
               this.MC.mc_hp.graphics.endFill();
            }
            showDarkBar = !showDarkBar;
         }
      }
      
      public function end(_forceEnd:Boolean = true) : void
      {
         if(_forceEnd)
         {
            this.unit.endKillstreak();
         }
         if(this.MC)
         {
            this.game.unitCont.removeChild(this.MC);
         }
         this.game.killstreaks.splice(this.game.killstreaks.indexOf(this),1);
      }
      
      protected function hitTestWall(offX:Number = 0, offY:Number = 0) : Boolean
      {
         var _pixel:uint = this.game.arena.wall.getPixel32(this.x + offX,this.y + offY);
         return _pixel && _pixel.toString(16).substring(0,2) == "ff";
      }
   }
}
