package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class ScoreBar extends MovieClip
   {
       
      
      public var icon_class:MovieClip;
      
      public var icon_status:MovieClip;
      
      public var txt_deaths:TextField;
      
      public var txt_kills:TextField;
      
      public var txt_name:TextField;
      
      public var txt_score:TextField;
      
      private var unit;
      
      public function ScoreBar(_y:Number, _unit:* = null, _frame:String = "", _txt:String = "", _score:int = 0)
      {
         super();
         y = _y;
         this.unit = _unit;
         if(_frame && !_txt)
         {
            gotoAndStop(_frame);
            this.icon_status.visible = false;
            this.icon_class.visible = false;
         }
         else if(_frame && _txt)
         {
            gotoAndStop(_frame);
            this.icon_status.visible = false;
            this.icon_class.visible = false;
            this.txt_name.text = _txt;
            this.txt_score.text = "" + _score;
            this.txt_kills.text = "";
            this.txt_deaths.text = "";
         }
         else
         {
            if(!this.unit.team)
            {
               gotoAndStop("ffa_" + (!!this.unit.human ? "player" : "ai"));
            }
            else
            {
               gotoAndStop("team" + this.unit.team + "_" + (!!this.unit.human ? "player" : "ai"));
            }
            this.icon_class.gotoAndStop(this.unit.unitInfo.cls);
            this.txt_name.text = this.unit.name;
            this.txt_score.text = "" + this.unit.pscore;
            this.txt_kills.text = "" + this.unit.score.kills;
            this.txt_deaths.text = "" + this.unit.score.deaths;
            if(this.unit.dead)
            {
               this.icon_status.gotoAndStop("dm");
            }
            else
            {
               this.icon_status.visible = false;
            }
         }
      }
   }
}
