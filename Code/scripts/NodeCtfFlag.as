package
{
   import flash.display.MovieClip;
   
   public class NodeCtfFlag extends MovieClip
   {
       
      
      public var flag:MovieClip;
      
      public var rim:MovieClip;
      
      public var id:String;
      
      public var team:uint;
      
      public var unitCaptured;
      
      public function NodeCtfFlag()
      {
         var tstr:Array = null;
         super();
         tstr = name.split("__");
         this.id = tstr[0];
         this.flag.visible = true;
         this.team = Number(tstr[1]);
      }
      
      public function setTeam(_num:uint) : void
      {
         this.team = _num;
         gotoAndStop(_num);
         this.flag.gotoAndStop("flag" + _num);
      }
      
      public function capture(_unit:*) : void
      {
         var useExp:Number = NaN;
         if(this.team != _unit.team)
         {
            if(this.unitCaptured)
            {
               return;
            }
            this.unitCaptured = _unit;
            this.flag.visible = false;
            alpha = 0.7;
            this.rim.stop();
            _unit.status.sInvis = 0;
            _unit.hasFlag = this;
            _unit.gun.resetFrame();
            _unit.gun.swapGuns();
            _unit.game.playScreenSound(S_Equip,_unit.x,_unit.y);
         }
         else if(_unit.hasFlag)
         {
            if(_unit.human)
            {
               ++_unit.score.flagCap;
               useExp = Math.min(Stats_Classes.getUnitExp(_unit.unitInfo.level + 3),Stats_Classes.getUnitExp(_unit.game.enemyLvlAvg));
               useExp *= _unit.game.enemyAmt * 0.7;
               _unit.unitInfo.addExp(int(useExp));
               _unit.displayExp(useExp);
            }
            _unit.game.hud.addCustomFeed(_unit,"flag");
            ++_unit.pscore;
            _unit.gun.resetFrame();
            _unit.hasFlag.reset();
            _unit.game.matchSettings.updateScores();
            _unit.game.playScreenSound(S_Skill,_unit.x,_unit.y);
         }
      }
      
      public function reset() : void
      {
         var _unit:* = this.unitCaptured;
         this.unitCaptured.hasFlag = null;
         this.unitCaptured.gun.swapGuns();
         this.unitCaptured = null;
         this.flag.visible = true;
         alpha = 1;
         this.rim.play();
      }
   }
}
