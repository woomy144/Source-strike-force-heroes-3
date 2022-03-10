package
{
   import flash.display.MovieClip;
   
   public class UnitMC extends MovieClip
   {
       
      
      public var arm1:MovieClip;
      
      public var arm1hold:MovieClip;
      
      public var arm2:MovieClip;
      
      public var body:MovieClip;
      
      public var foot1:MovieClip;
      
      public var foot2:MovieClip;
      
      public var head:MovieClip;
      
      public var headhold:MovieClip;
      
      public var leglow1:MovieClip;
      
      public var leglow2:MovieClip;
      
      public var legup1:MovieClip;
      
      public var legup2:MovieClip;
      
      public var rope:MovieClip;
      
      public var waist:MovieClip;
      
      private var unit:Unit;
      
      private var curAnim:String;
      
      public function UnitMC(_unit:Unit)
      {
         super();
         addFrameScript(29,this.frame30,51,this.frame52,57,this.frame58,63,this.frame64,85,this.frame86,103,this.frame104,125,this.frame126,143,this.frame144,171,this.frame172,192,this.frame193,220,this.frame221,241,this.frame242,268,this.frame269,324,this.frame325,339,this.frame340,350,this.frame351,354,this.frame355,370,this.frame371,403,this.frame404,436,this.frame437,440,this.frame441,445,this.frame446,457,this.frame458,498,this.frame499);
         this.unit = _unit;
      }
      
      public function EnterFrame() : void
      {
         this.head.x = this.headhold.x;
         this.head.y = this.headhold.y;
         this.arm1.x = this.arm1hold.x;
         this.arm1.y = this.arm1hold.y;
         this.arm2.x = this.arm1hold.x;
         this.arm2.y = this.arm1hold.y;
      }
      
      public function allowRotation() : void
      {
         this.unit.canRotate = true;
      }
      
      public function prepareSpawn(_showRope:Boolean) : void
      {
         this.headhold.visible = true;
         this.arm1hold.visible = true;
         this.head.visible = false;
         this.arm1.visible = false;
         this.arm2.visible = false;
         if(_showRope)
         {
            this.unit.status.sSpawn = 1.5 * 30;
            this.goto("spawn",true);
            this.unit.canRotate = false;
         }
         else
         {
            this.showGuns();
            this.unit.canRotate = true;
         }
      }
      
      public function showGuns() : void
      {
         this.headhold.visible = false;
         this.arm1hold.visible = false;
         this.head.visible = true;
         this.arm1.visible = true;
         this.arm2.visible = true;
      }
      
      public function spawned() : void
      {
         this.unit.status.sSpawn = 0;
      }
      
      public function setClip(_MC:MovieClip) : void
      {
         _MC.visible = false;
         for(var i:uint = 0; i < _MC.currentLabels.length; i++)
         {
            if(_MC.currentLabels[i].name == this.unit.gun.curGun.sprite)
            {
               _MC.visible = true;
               _MC.gotoAndStop(this.unit.gun.curGun.sprite);
            }
         }
      }
      
      public function doneShoot() : void
      {
         this.unit.gun.setFrame("idle");
      }
      
      public function doneReload() : void
      {
         this.unit.gun.setFrame("idle");
         this.unit.gun.reloaded();
      }
      
      public function reloadSound() : void
      {
         if(this.unit.human)
         {
            trace("reload sound",this.unit.gun.curGun.frameReload);
         }
         switch(this.unit.gun.curGun.frameReload)
         {
            case "pistol":
            case "magnum":
               this.unit.game.playScreenSound(S_PistolReload,this.unit.x,this.unit.y,true);
               break;
            case "magnum2":
               this.unit.game.playScreenSound(S_Magnum2Reload,this.unit.x,this.unit.y,true);
               break;
            case "pistol2":
            case "smg2":
               this.unit.game.playScreenSound(S_MpistolBReload,this.unit.x,this.unit.y,true);
               break;
            case "rifle":
               this.unit.game.playScreenSound(S_RifleReload,this.unit.x,this.unit.y,true);
               break;
            case "smg":
            case "top":
            case "bottom":
               this.unit.game.playScreenSound(S_SMGReload,this.unit.x,this.unit.y,true);
               break;
            case "shotgun":
            case "judgement":
               this.unit.game.playScreenSound(S_ShotgunReload,this.unit.x,this.unit.y,true);
               break;
            case "sbullpup":
               this.unit.game.playScreenSound(S_ShotgunBReload,this.unit.x,this.unit.y,true);
               break;
            case "heavy":
               this.unit.game.playScreenSound(S_HeavyReload,this.unit.x,this.unit.y,true);
               break;
            case "sniper":
               this.unit.game.playScreenSound(S_SniperReload,this.unit.x,this.unit.y,true);
               break;
            case "rocket":
               this.unit.game.playScreenSound(S_RocketReload,this.unit.x,this.unit.y,true);
               break;
            case "launcher":
               this.unit.game.playScreenSound(S_RocketReload,this.unit.x,this.unit.y,true);
               break;
            case "bullpup":
               this.unit.game.playScreenSound(S_BulpupReload,this.unit.x,this.unit.y,true);
               break;
            case "hbullpup":
               this.unit.game.playScreenSound(S_BulpupBReload,this.unit.x,this.unit.y,true);
         }
      }
      
      public function checkFastReload() : void
      {
      }
      
      public function setUnitVar(_var:String, _val:*) : void
      {
         this.unit[_var] = _val;
      }
      
      public function setUnitObVar(_ob:String, _var:String, _val:*) : void
      {
         this.unit[_ob][_var] = _val;
      }
      
      public function setClipFrame(mc:MovieClip) : void
      {
         if(mc && this.unit.gun.curGun)
         {
            mc.gotoAndStop(this.unit.gun.curGun.sprite);
            if(this.unit.gun.curGun.rarity <= 3)
            {
               mc.gotoAndStop(mc.currentFrame + this.unit.gun.curGun.rarity);
            }
         }
      }
      
      public function showGunClip(show:Boolean) : void
      {
         if(this.arm1.gun && this.arm1.gun.clip)
         {
            this.arm1.gun.clip.visible = show;
         }
         if(this.arm2.gun2 && this.arm2.gun2.clip)
         {
            this.arm2.gun2.clip.visible = show;
         }
      }
      
      public function showGunPart(show:Boolean) : void
      {
         if(this.arm1.gun && this.arm1.gun.part)
         {
            this.arm1.gun.part.visible = show;
         }
         if(this.arm2.gun2 && this.arm2.gun2.part)
         {
            this.arm2.gun2.part.visible = show;
         }
      }
      
      public function goto(frame:String, force:Boolean = false) : void
      {
         if(frame == null)
         {
            frame = "idle";
         }
         if(!force)
         {
            if(this.curAnim == "spawn")
            {
               return;
            }
            if(this.curAnim == frame)
            {
               return;
            }
            if(this.curAnim == "climbsmall" || this.curAnim == "climbbig")
            {
               return;
            }
            if(this.curAnim == "landhard")
            {
               return;
            }
            if(this.curAnim == "jump" && frame == "fall")
            {
               return;
            }
            if(this.curAnim == "tuck" && frame == "fall")
            {
               return;
            }
            if(this.curAnim == "land" && frame == "idle")
            {
               return;
            }
            if(this.curAnim == "landrun" + this.unit.unitInfo.runType && frame == "run" + this.unit.unitInfo.runType)
            {
               return;
            }
            if(this.curAnim == "landrunback" + this.unit.unitInfo.runType && frame == "runback" + this.unit.unitInfo.runType)
            {
               return;
            }
            if(this.curAnim == "duckloop" && frame == "duck")
            {
               return;
            }
            if(this.curAnim == "duckrun" && frame == "duck")
            {
               frame = "duckloop";
            }
            if(this.curAnim == "duckrunback" && frame == "duck")
            {
               frame = "duckloop";
            }
            if(this.curAnim == "slide" && frame == "duck")
            {
               frame = "duckloop";
            }
            if(this.curAnim == "duck" && frame == "idle")
            {
               frame = "getup";
            }
            if((this.curAnim == "run" + this.unit.unitInfo.runType || this.curAnim == "landrun" + this.unit.unitInfo.runType) && frame == "duckrun")
            {
               frame = "slide";
            }
            if(this.curAnim == "runback" + this.unit.unitInfo.runType && frame == "duckrunback")
            {
               frame = "duck";
            }
            if(this.curAnim == "duckrun" && frame == "run" + this.unit.unitInfo.runType)
            {
               frame = "getup";
            }
            if(this.curAnim == "duckrunback" && frame == "runback" + this.unit.unitInfo.runType)
            {
               frame = "getup";
            }
            if(this.curAnim == "slide")
            {
               return;
            }
            if(this.curAnim == "duck" && frame == "duckrun")
            {
               return;
            }
            if(this.curAnim == "duck" && frame == "duckrunback")
            {
               return;
            }
            if(this.curAnim == "getup" && frame == "run" + this.unit.unitInfo.runType)
            {
               return;
            }
            if(this.curAnim == "getup" && frame == "runback" + this.unit.unitInfo.runType)
            {
               return;
            }
            if(this.curAnim == "duckloop" && frame == "idle")
            {
               frame = "getup";
            }
            if(this.curAnim == "getup" && frame == "idle")
            {
               return;
            }
         }
         this.curAnim = frame;
         gotoAndPlay(this.curAnim);
      }
      
      function frame30() : *
      {
         this.goto("idle",true);
      }
      
      function frame52() : *
      {
         this.allowRotation();
      }
      
      function frame58() : *
      {
         this.showGuns();
      }
      
      function frame64() : *
      {
         this.spawned();
         this.goto("idle",true);
      }
      
      function frame86() : *
      {
         this.goto("run1",true);
      }
      
      function frame104() : *
      {
         this.goto("run1",true);
      }
      
      function frame126() : *
      {
         this.goto("runback1",true);
      }
      
      function frame144() : *
      {
         this.goto("runback1",true);
      }
      
      function frame172() : *
      {
         this.goto("run2",true);
      }
      
      function frame193() : *
      {
         this.goto("run2",true);
      }
      
      function frame221() : *
      {
         this.goto("runback2",true);
      }
      
      function frame242() : *
      {
         this.goto("runback2",true);
      }
      
      function frame269() : *
      {
         this.goto("fall");
      }
      
      function frame325() : *
      {
         gotoAndPlay("fallloop");
      }
      
      function frame340() : *
      {
         this.goto("idle",true);
      }
      
      function frame351() : *
      {
         this.goto("duckloop",true);
      }
      
      function frame355() : *
      {
         this.goto("duckloop");
      }
      
      function frame371() : *
      {
         this.goto("duckloop",true);
      }
      
      function frame404() : *
      {
         this.goto("duckrun",true);
      }
      
      function frame437() : *
      {
         this.goto("duckrunback",true);
      }
      
      function frame441() : *
      {
         this.goto("idle",true);
      }
      
      function frame446() : *
      {
         this.setUnitObVar("mov","climb",0);
         this.goto("idle",true);
      }
      
      function frame458() : *
      {
         this.setUnitObVar("mov","climb",0);
         this.goto("idle",true);
      }
      
      function frame499() : *
      {
         this.setUnitObVar("mov","landHard",false);
         this.goto("idle",true);
      }
   }
}
