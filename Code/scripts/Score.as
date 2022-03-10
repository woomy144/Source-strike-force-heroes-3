package
{
   public class Score
   {
       
      
      private var unit:Unit;
      
      public var headshots:uint = 0;
      
      public var killed1:uint = 0;
      
      public var killed2:uint = 0;
      
      public var killed3:uint = 0;
      
      public var killed4:uint = 0;
      
      public var killed5:uint = 0;
      
      public var bulletsFired:uint = 0;
      
      public var bulletsHit:uint = 0;
      
      public var flagCap:uint = 0;
      
      public var domCap:uint = 0;
      
      public var jugKill:uint = 0;
      
      public var lives:int = 0;
      
      public var kills:uint = 0;
      
      public var deaths:uint = 0;
      
      public var suicides:uint = 0;
      
      public var betrayals:uint = 0;
      
      public var killtimer:uint = 0;
      
      public var multikill:uint = 0;
      
      public var spree:uint = 0;
      
      public var streak:Number = 0;
      
      public var streakKills:Number = 0;
      
      public function Score(_unit:Unit)
      {
         super();
         this.unit = _unit;
         if(MatchSettings.useMode == "elim" || MatchSettings.useMode == "telim")
         {
            this.lives = MatchSettings.useScore;
            this.updateScore();
         }
         if(this.unit.unitInfo.extra.kills)
         {
            this.setKills(this.unit.unitInfo.extra.kills);
         }
      }
      
      public function setKills(_amt:uint) : void
      {
         this.kills = _amt;
         this.updateScore();
      }
      
      public function EnterFrame() : void
      {
         if(this.killtimer)
         {
            --this.killtimer;
         }
         else
         {
            this.multikill = 0;
         }
      }
      
      public function addStreak(_amt:Number) : void
      {
         if(this.unit.streak.val && !this.streakReady())
         {
            if(this.unit.unitInfo.skills.streak0)
            {
               _amt *= this.unit.unitInfo.skills.streak0;
            }
            if(this.unit.unitInfo.skills.streak1)
            {
               _amt *= this.unit.unitInfo.skills.streak1;
            }
            if(this.unit.unitInfo.skills.streak2)
            {
               _amt *= this.unit.unitInfo.skills.streak2;
            }
            if(this.unit.unitInfo.skills.streak_)
            {
               _amt *= this.unit.unitInfo.skills.streak_;
            }
            if(this.unit.unitInfo.skills.streak__)
            {
               _amt *= this.unit.unitInfo.skills.streak__;
            }
            this.streak += _amt;
            this.unit.setKillstreakNum(this.streak);
            if(this.streakReady())
            {
               this.unit.startKillstreak();
            }
         }
      }
      
      public function streakReady() : Boolean
      {
         if(!this.unit.unitInfo.streak)
         {
            return false;
         }
         if(this.unit.streakInProgress)
         {
            return false;
         }
         if(this.unit.dead)
         {
            return false;
         }
         if(this.streak < this.unit.streak.val)
         {
            return false;
         }
         return true;
      }
      
      public function addKill() : void
      {
         ++this.multikill;
         ++this.spree;
         ++this.kills;
         this.killtimer = 3.5 * 30;
         this.addStreak(1);
         if(this.unit.streakInProgress && this.unit.human)
         {
            ++this.streakKills;
         }
         if(this.unit.human)
         {
            this.unit.game.hud.debug.debug1.text = "Streak: " + this.streak;
         }
         this.updateScore();
      }
      
      public function addDeath() : void
      {
         this.spree = 0;
         ++this.deaths;
         --this.lives;
         if(MatchSettings.useMode == "elim" || MatchSettings.useMode == "telim" && this.lives <= 0)
         {
            this.unit.unitInfo.extra.noSpawn = true;
         }
         if(!this.unit.unitInfo.skills.streak2)
         {
            this.streak = 0;
            this.unit.setKillstreakNum(this.streak);
         }
      }
      
      public function addSuicide() : void
      {
         ++this.suicides;
         this.updateScore();
      }
      
      public function addBetrayal() : void
      {
         ++this.betrayals;
         this.updateScore();
      }
      
      public function updateScore() : void
      {
         switch(MatchSettings.useMode)
         {
            case "dm":
            case "gg":
            case "tgg":
            case "tdm":
            case "one":
            case "zom":
               this.unit.pscore = this.kills - this.suicides - this.betrayals;
               break;
            case "elim":
               this.unit.pscore = this.lives;
         }
         this.unit.game.matchSettings.updateScores();
         if(MatchSettings.useMode == "gg" || MatchSettings.useMode == "tgg")
         {
            this.unit.setGunGameWeapon();
         }
      }
   }
}
