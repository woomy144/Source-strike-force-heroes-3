package
{
   import flash.display.MovieClip;
   
   public class NodePickup extends MovieClip
   {
       
      
      public var rim:MovieClip;
      
      public var game:Game;
      
      public var id:String;
      
      private var spawnTime:uint;
      
      public var taken:uint = 0;
      
      private var yRot:uint = 0;
      
      public function NodePickup()
      {
         super();
         var tstr:Array = name.split("_");
         this.id = tstr[0];
         this.spawnTime = Number(tstr[1]);
         switch(this.id)
         {
            case "ammo":
            case "ammobig":
               gotoAndStop("yellow");
               break;
            case "armor":
            case "armorbig":
               gotoAndStop("white");
               break;
            case "health":
            case "healthbig":
               gotoAndStop("green");
               break;
            default:
               this.id = this.id.substring(1);
               gotoAndStop("none");
         }
      }
      
      public function EnterFrame() : void
      {
         if(this.game.destroyed)
         {
            return;
         }
         if(!this.taken)
         {
            this.yRot += 5;
            this.game.bitscreen.paint(x + this.game.arena.x + rotation * 0.5,y + this.game.arena.y - 30 - UT.yMoveToRot(this.yRot,4),true,"pickups0",this.id);
            alpha = 1;
            if(this.rim)
            {
               this.rim.play();
            }
         }
         else
         {
            --this.taken;
            alpha = 0.5;
            if(this.rim)
            {
               this.rim.stop();
            }
         }
      }
      
      public function getPickup(param1:Unit) : void
      {
         var _loc2_:Number = NaN;
         switch(this.id)
         {
            case "health":
               if(param1.human)
               {
                  SH.playSound(S_Heal);
               }
               if(param1.human && param1.status.hpCur / param1.status.hpMax <= 0.25)
               {
                  Stats_Achievements.checkAchVariable("health",1);
               }
               _loc2_ = param1.status.hpMax * 0.5;
               if(param1.unitInfo.skills.pickup1)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup1;
               }
               if(param1.unitInfo.skills.pickup0)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup0;
               }
               param1.status.heal(_loc2_);
               break;
            case "healthbig":
               if(param1.human)
               {
                  SH.playSound(S_Heal);
               }
               if(param1.human && param1.status.hpCur / param1.status.hpMax <= 0.25)
               {
                  Stats_Achievements.checkAchVariable("health",1);
               }
               _loc2_ = param1.status.hpMax;
               if(param1.unitInfo.skills.pickup1)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup1;
               }
               if(param1.unitInfo.skills.pickup0)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup0;
               }
               param1.status.heal(_loc2_);
               break;
            case "armor":
               if(param1.human)
               {
                  SH.playSound(S_Equip);
               }
               if(param1.human && param1.status.arCur == 0)
               {
                  Stats_Achievements.checkAchVariable("armor",1);
               }
               _loc2_ = param1.status.arMax * 0.5;
               if(param1.unitInfo.skills.pickup1)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup1;
               }
               if(param1.unitInfo.skills.pickup0)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup0;
               }
               param1.status.repair(_loc2_);
               break;
            case "armorbig":
               if(param1.human)
               {
                  SH.playSound(S_Equip);
               }
               if(param1.human && param1.status.arCur == 0)
               {
                  Stats_Achievements.checkAchVariable("armor",1);
               }
               _loc2_ = param1.status.arMax;
               if(param1.unitInfo.skills.pickup1)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup1;
               }
               if(param1.unitInfo.skills.pickup0)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup0;
               }
               param1.status.repair(_loc2_);
               break;
            case "ammo":
               if(param1.unitInfo.skills.energy)
               {
                  return;
               }
               if(param1.human)
               {
                  SH.playSound(S_Ammo);
               }
               if(param1.human && param1.gun.curGun.spareAmmo / param1.gun.curGun.spareMax <= 0.25)
               {
                  Stats_Achievements.checkAchVariable("ammo",1);
               }
               _loc2_ = 0.5;
               if(param1.unitInfo.skills.pickup1)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup1;
               }
               if(param1.unitInfo.skills.pickup0)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup0;
               }
               param1.gun.addAmmo(_loc2_);
               break;
            case "ammobig":
               if(param1.unitInfo.skills.energy)
               {
                  return;
               }
               if(param1.human)
               {
                  SH.playSound(S_Ammo);
               }
               if(param1.human && param1.gun.curGun.spareAmmo / param1.gun.curGun.spareMax <= 0.25)
               {
                  Stats_Achievements.checkAchVariable("ammo",1);
               }
               _loc2_ = 1;
               if(param1.unitInfo.skills.pickup1)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup1;
               }
               if(param1.unitInfo.skills.pickup0)
               {
                  _loc2_ *= param1.unitInfo.skills.pickup0;
               }
               param1.gun.addAmmo(_loc2_);
               break;
         }
         this.taken = this.spawnTime * 30;
      }
   }
}
