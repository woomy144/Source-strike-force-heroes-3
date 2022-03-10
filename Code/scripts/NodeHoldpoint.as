package
{
   import flash.display.MovieClip;
   
   public class NodeHoldpoint extends MovieClip
   {
       
      
      public var flag:MovieClip;
      
      public var rim:MovieClip;
      
      public var curTeam:uint;
      
      public var unitCaptured;
      
      private var flagPos:Number;
      
      private var flagSpd:Number;
      
      public var letter:String = "X";
      
      public function NodeHoldpoint()
      {
         super();
         this.curTeam = 0;
         this.flagPos = -65;
         this.flagSpd = 1;
         this.flag.y = this.flagPos;
         gotoAndStop(this.curTeam + 1);
         this.flag.gotoAndStop(this.curTeam + 1);
      }
      
      public function capture(_unit:*) : void
      {
         var useExp:Number = NaN;
         if(_unit.team != this.curTeam)
         {
            this.flagPos += this.flagSpd;
            if(this.flagPos >= -10)
            {
               this.curTeam = _unit.team;
               gotoAndStop(this.curTeam + 1);
               this.flag.gotoAndStop(this.curTeam + 1);
               this.unitCaptured = _unit;
               _unit.game.hud.addCustomFeed(_unit,"holdpoint");
               if(_unit.human)
               {
                  ++_unit.score.domCap;
                  useExp = Math.min(Stats_Classes.getUnitExp(_unit.unitInfo.level + 3),Stats_Classes.getUnitExp(_unit.game.enemyLvlAvg));
                  useExp *= _unit.game.enemyAmt * 0.4;
                  _unit.unitInfo.addExp(int(useExp));
                  _unit.displayExp(useExp);
               }
               this.flagPos = -15;
            }
         }
         else
         {
            this.flagPos -= this.flagSpd;
            if(this.flagPos < -65)
            {
               this.flagPos = -65;
            }
         }
         this.flag.y = this.flagPos;
      }
   }
}
