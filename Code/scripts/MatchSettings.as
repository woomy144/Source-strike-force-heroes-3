package
{
   import flash.display.MovieClip;
   
   public class MatchSettings
   {
      
      public static var qmMap:String;
      
      public static var qmMode:String;
      
      public static var qmScore:uint;
      
      public static var qmMod:String;
      
      public static var qmTeams:Boolean;
      
      public static var qmDiff:int;
      
      public static var qmEnemies:int;
      
      public static var qmAiBots:Boolean;
      
      public static var qmLevel:int;
      
      public static var qmSquadCodeBots:Array;
      
      public static var preCutSong;
      
      public static var preCutFrames:Array;
      
      public static var postCutSong;
      
      public static var postCutFrames:Array;
      
      public static var useMap:Object;
      
      public static var useMode:String;
      
      public static var useClassOnly:String;
      
      public static var useScore:uint;
      
      public static var useMod:String;
      
      public static var useBots:Array;
      
      public static var useTeams:Boolean;
      
      public static var useExtra:Object;
      
      public static var useFlag:String;
      
      public static var useSong;
      
      public static var matchType:int;
      
      public static var heroNames:Array;
      
      public static var evilNames:Array;
       
      
      private var game:Game;
      
      private var initiated:Boolean;
      
      private var team0:Array;
      
      public var team1:Array;
      
      public var team2:Array;
      
      public var team1score:int;
      
      public var team2score:int;
      
      private var fc:uint = 0;
      
      public function MatchSettings(_game:Game)
      {
         super();
         this.game = _game;
      }
      
      public static function Init() : void
      {
         heroNames = [];
         heroNames.push("Rodriguez","Volkov","Kafka","Thompson","Al Jabbar","Menendez","Mendoza","Smith","Smythe","Fisk","Assad","Liebowitz","Trung","Tran","Chang","Yan","Toulouse","Pushkin","Torn","Cage","Vasquez","Kidd","Alistair","Crimson","Blazkowicz","Bull","Wallace","Kane","Bison","Blair","Junior","Fury","Falcon","Olimar","Payne","Johnson","De Leon","Threepwood","Touchdown","Silverberg","Redfield","Strife","Raynor","Bosconovich","Jay","Kong","Gordo","Edgeworth","Everett","Da Firenze","Lombardi","McCloud","Long","West","Garrett","Howard","Freeman","Haggar","Mishima","Honda","Yagami","Jago","Masters","Kennedy","Lao","Law","Layton","LeChuck","Cohen","Mac","Fenix","Marston","Miles","Spencer","Bellic","Tobias","Funke","Bluth","Simpson","Miyamoto","Wright","Philips","Pitt","Chi","Price");
         evilNames = [];
         evilNames.push("KwikPain","GameKultist","Mc Swagger","Gen. Raxon","Pvt. Jael","Roxxar","Sheep","Poseidon","Medic of Vietnam","Sgt. Sledge","Pickle","Idan01","Thrax","Xap","Mir","Labraxadores","Bedomp","Math-E-Matic","Masterfish","Juice_Box","Sundalo37","Jo Jo","Rocky","Black Mage","Jacob");
         evilNames.push("Belle","Golgomot","MegaMrBob","Aswanson","KidBuuSmells101","Slicer","The Celt Viking","Caboose","Womble","elite commando","Gen. Ducko","NoobKiller","Vagueshade","Millennium","GS_Ourous","Dark123456789");
         evilNames.push("Kairosh","Captain Pwn","Your Cat","Juice-Box","Zetaprime","Platinum123","Col_Mukund","Fortytwopercent");
         evilNames.push("J.A. Prufrock","T. Lannister","P. North","S. Claus","M. Corleone","C.F. Kane","Pvt. Pile","T. Stark","E. Bachmann","G.R.R. Martin","Mischief","Pvt. Whitman","W. White","A. Ripburger","E.S. Blofeld");
         evilNames.push("Saint","Morde","Garen","PeeWee","Tiny","Bravo","Johnson","MrMatrix","Jeepers","Polly","Donut","Raze");
         evilNames.push("MaestroRage","WaterFlame","sonicmega");
         qmMap = Stats_Maps.mapOrder[0];
         qmMode = "tdm";
         qmTeams = true;
         qmScore = 10;
         qmMod = "none";
         qmDiff = 3;
         qmEnemies = 5;
         qmAiBots = true;
      }
      
      public static function setupMatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Stats_Missions = null;
         var _loc3_:UnitInfo = null;
         var _loc4_:int = 0;
         useExtra = {};
         useFlag = "flag";
         useSong = null;
         for(_loc1_ = 0; _loc1_ < SD.squad.length; _loc1_++)
         {
            if(SD.squad[_loc1_] >= 0)
            {
               SD.heroes[SD.squad[_loc1_]].extra = {};
            }
         }
         SD.soloTired = 1;
         switch(matchType)
         {
            case 0:
               _loc2_ = Stats_Missions.itemAr[SD.curStage];
               useMap = Stats_Maps.getMap(_loc2_.map);
               useMode = _loc2_.mode;
               useScore = _loc2_.score;
               useMod = "";
               useTeams = Stats_Misc.getGameMode(useMode).teams;
               if(_loc2_.song)
               {
                  useSong = _loc2_.song;
               }
               if(_loc2_.extra)
               {
                  useExtra = _loc2_.extra;
               }
               for(_loc1_ = 0; _loc1_ < SD.squad.length; _loc1_++)
               {
                  if(SD.squad[_loc1_] == -1)
                  {
                     SD.soloTired += 0.2;
                  }
               }
               trace("Tired Unbonus",SD.soloTired);
               useBots = [];
               for(_loc1_ = 0; _loc1_ < SD.squad.length; _loc1_++)
               {
                  if(SD.squad[_loc1_] >= 0)
                  {
                     _loc3_ = SD.heroes[SD.squad[_loc1_]];
                     if(useTeams)
                     {
                        _loc3_.team = 1;
                     }
                     else
                     {
                        _loc3_.team = 0;
                     }
                     if(_loc2_.squadExtra)
                     {
                        _loc3_.extra = _loc2_.squadExtra;
                     }
                     useBots.push(_loc3_);
                  }
               }
               if(_loc2_.units)
               {
                  for(_loc1_ = 0; _loc1_ < _loc2_.units.length; _loc1_++)
                  {
                     _loc4_ = UT.clamp(Math.round(Stats_Misc.getLevelReq(SD.curStage,SD.curDiff) * UT.rand(0.8,1.2)),1,Stats_Misc.maxLvl + 5);
                     if(_loc2_.extra.raiseLvl)
                     {
                        _loc4_ += _loc2_.extra.raiseLvl;
                     }
                     if(_loc2_.units[_loc1_].extra.raiseLvl)
                     {
                        _loc4_ += _loc2_.units[_loc1_].extra.raiseLvl;
                     }
                     _loc2_.units[_loc1_].setupLevelStats(_loc4_);
                     if(useTeams)
                     {
                        _loc2_.units[_loc1_].team = 2;
                     }
                     else
                     {
                        _loc2_.units[_loc1_].team = 0;
                     }
                     if(_loc2_.units[_loc1_].extra.team != undefined)
                     {
                        _loc2_.units[_loc1_].team = _loc2_.units[_loc1_].extra.team;
                     }
                     useBots.push(_loc2_.units[_loc1_]);
                  }
               }
               else
               {
                  for(_loc1_ = 0; _loc1_ < _loc2_.team2; _loc1_++)
                  {
                     _loc3_ = Stats_Classes.newHero(UT.randEl(Stats_Classes.classesBasic),"enemy");
                     _loc4_ = UT.clamp(Math.round(Stats_Misc.getLevelReq(SD.curStage,SD.curDiff) * UT.rand(0.8,1.2)),1,Stats_Misc.maxLvl + 5);
                     if(_loc2_.extra.raiseLvl)
                     {
                        _loc4_ += _loc2_.extra.raiseLvl;
                     }
                     _loc3_.setupLevelStats(_loc4_);
                     if(useTeams)
                     {
                        _loc3_.team = 2;
                     }
                     else
                     {
                        _loc3_.team = 0;
                     }
                     useBots.push(_loc3_);
                  }
               }
               break;
            case 2:
               _loc2_ = Stats_Missions.daily;
               useMap = Stats_Maps.getMap(_loc2_.map);
               useMode = _loc2_.mode;
               useScore = _loc2_.score;
               useMod = "";
               useTeams = Stats_Misc.getGameMode(useMode).teams;
               useBots = [];
               for(_loc1_ = 0; _loc1_ < SD.squad.length; _loc1_++)
               {
                  if(SD.squad[_loc1_] >= 0)
                  {
                     _loc3_ = SD.heroes[SD.squad[_loc1_]];
                     if(useTeams)
                     {
                        _loc3_.team = 1;
                     }
                     else
                     {
                        _loc3_.team = 0;
                     }
                     useBots.push(_loc3_);
                  }
               }
               for(_loc1_ = 0; _loc1_ < _loc2_.team2; _loc1_++)
               {
                  _loc3_ = Stats_Classes.newHero(Stats_Classes.itemAr[UT.randEl(SD.bpClasses)].id,"enemy");
                  _loc4_ = UT.clamp(Math.round(Stats_Misc.getLevelReq(SD.curStage,SD.curDiff) + UT.rand(1,2)),1,Stats_Misc.maxLvl + 5);
                  _loc3_.setupLevelStats(_loc4_);
                  if(useTeams)
                  {
                     _loc3_.team = 2;
                  }
                  else
                  {
                     _loc3_.team = 0;
                  }
                  useBots.push(_loc3_);
               }
               break;
            case 1:
               useMap = Stats_Maps.getMap(qmMap);
               useMode = qmMode;
               useScore = qmScore;
               useMod = qmMod;
               useTeams = qmTeams;
               useBots = [];
               for(_loc1_ = 0; _loc1_ < SD.squad.length; _loc1_++)
               {
                  if(SD.squad[_loc1_] >= 0)
                  {
                     _loc3_ = SD.heroes[SD.squad[_loc1_]];
                     if(useTeams)
                     {
                        _loc3_.team = 1;
                     }
                     else
                     {
                        _loc3_.team = 0;
                     }
                     useBots.push(_loc3_);
                  }
               }
               if(qmAiBots)
               {
                  for(_loc1_ = 0; _loc1_ < qmEnemies; _loc1_++)
                  {
                     _loc3_ = Stats_Classes.newHero(UT.randEl(Stats_Classes.classesAll),"enemy");
                     _loc4_ = UT.clamp(qmLevel * UT.rand(0.8,1.2),1,Stats_Misc.maxLvl + 5);
                     _loc3_.setupLevelStats(_loc4_);
                     if(useTeams)
                     {
                        _loc3_.team = 2;
                     }
                     else
                     {
                        _loc3_.team = 0;
                     }
                     useBots.push(_loc3_);
                  }
               }
               else
               {
                  for(_loc1_ = 0; _loc1_ < qmSquadCodeBots.length; _loc1_++)
                  {
                     _loc3_ = qmSquadCodeBots[_loc1_];
                     _loc3_.name = "EnemySquad " + (_loc1_ + 1);
                     if(useTeams)
                     {
                        _loc3_.team = 2;
                     }
                     else
                     {
                        _loc3_.team = 0;
                     }
                     useBots.push(_loc3_);
                  }
                  AGI.submitQuest("custom");
               }
         }
      }
      
      public function Init() : void
      {
         var i:uint = 0;
         this.initiated = true;
         if(!MatchSettings.useTeams)
         {
            this.team0 = this.game.units.concat();
            this.game.hud.setScoreBar(this.game.player.team,this.game.player.pscore,this.game.units[1].team,this.game.units[1].pscore);
         }
         else
         {
            this.team1 = [];
            this.team2 = [];
            for(i = 0; i < this.game.units.length; i++)
            {
               this["team" + this.game.units[i].team].push(this.game.units[i]);
            }
            this.game.hud.setScoreBar(1,0,2,0);
         }
         this.updateScores();
      }
      
      public function EnterFrame() : void
      {
         var i:uint = 0;
         ++this.fc;
         if(MatchSettings.useMode == "dom" && this.fc % (30 * 3) == 0)
         {
            for(i = 0; i < this.game.arena.holdpoints.length; i++)
            {
               if(this.game.arena.holdpoints[i].curTeam)
               {
                  ++this.game.arena.holdpoints[i].unitCaptured.pscore;
               }
            }
            this.updateScores();
         }
      }
      
      public function updateTeams() : void
      {
         var _loc3_:uint = 0;
         var _loc1_:Array = [];
         var _loc2_:Array = [];
         for(_loc3_ = 0; _loc3_ < this.team1.length; _loc3_++)
         {
            if(this.team1[_loc3_].team == 1)
            {
               _loc1_.push(this.team1[_loc3_]);
            }
            else if(this.team1[_loc3_].team == 2)
            {
               _loc2_.push(this.team1[_loc3_]);
            }
         }
         for(_loc3_ = 0; _loc3_ < this.team2.length; _loc3_++)
         {
            if(this.team2[_loc3_].team == 1)
            {
               _loc1_.push(this.team2[_loc3_]);
            }
            else if(this.team2[_loc3_].team == 2)
            {
               _loc2_.push(this.team2[_loc3_]);
            }
         }
         this.team1 = _loc1_;
         this.team2 = _loc2_;
      }
      
      public function updateScores() : void
      {
         var _loc2_:uint = 0;
         if(!this.initiated)
         {
            return;
         }
         var _loc1_:* = null;
         switch(useMode)
         {
            case "dm":
            case "gg":
            case "zom":
            case "one":
               for(_loc2_ = 0; _loc2_ < this.team0.length; _loc2_++)
               {
                  if(!this.team0[_loc2_].human && (!_loc1_ || this.team0[_loc2_].pscore > _loc1_.pscore))
                  {
                     _loc1_ = this.team0[_loc2_];
                  }
                  if(this.team0[_loc2_].pscore >= useScore)
                  {
                     this.team0[_loc2_].pscore = useScore;
                     this.game.endGame(this.team0[_loc2_].human);
                  }
               }
               this.game.hud.setScoreBar(this.game.player.team,this.game.player.pscore,_loc1_.team,_loc1_.pscore);
               break;
            case "tdm":
            case "tgg":
            case "dom":
            case "ctf":
               this.team1.sortOn("pscore",Array.NUMERIC | Array.DESCENDING);
               this.team2.sortOn("pscore",Array.NUMERIC | Array.DESCENDING);
               this.team1score = 0;
               for(_loc2_ = 0; _loc2_ < this.team1.length; this.team1score += this.team1[_loc2_].pscore,_loc2_++)
               {
               }
               this.team2score = 0;
               for(_loc2_ = 0; _loc2_ < this.team2.length; this.team2score += this.team2[_loc2_].pscore,_loc2_++)
               {
               }
               if(this.team1score >= useScore)
               {
                  this.team1score = useScore;
                  this.game.endGame(true);
               }
               else if(this.team2score >= useScore)
               {
                  this.team2score = useScore;
                  this.game.endGame(false);
               }
               this.game.hud.setScoreBar(1,this.team1score,2,this.team2score);
         }
      }
      
      public function showScores(param1:MovieClip) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc2_:Number = 0;
         param1.addChild(new ScoreBar(_loc2_,null,"top"));
         if(!useTeams)
         {
            this.team0.sortOn("pscore",Array.NUMERIC | Array.DESCENDING);
            for(_loc3_ = 0; _loc3_ < this.team0.length; _loc3_++)
            {
               if(!this.team0[_loc3_].unitInfo.extra.noSpawn)
               {
                  param1.addChild(new ScoreBar(_loc2_ = _loc2_ + 20,this.team0[_loc3_]));
               }
            }
         }
         else
         {
            this.team1.sortOn("pscore",Array.NUMERIC | Array.DESCENDING);
            this.team2.sortOn("pscore",Array.NUMERIC | Array.DESCENDING);
            this.team1score = 0;
            for(_loc3_ = 0; _loc3_ < this.team1.length; this.team1score += this.team1[_loc3_].pscore,_loc3_++)
            {
            }
            this.team2score = 0;
            for(_loc3_ = 0; _loc3_ < this.team2.length; this.team2score += this.team2[_loc3_].pscore,_loc3_++)
            {
            }
            if(this.team1score > useScore)
            {
               this.team1score = useScore;
            }
            if(this.team2score > useScore)
            {
               this.team2score = useScore;
            }
            if(this.team1score >= this.team2score)
            {
               _loc4_ = 1;
               _loc5_ = 2;
            }
            else
            {
               _loc4_ = 2;
               _loc5_ = 1;
            }
            param1.addChild(new ScoreBar(_loc2_ = _loc2_ + 20,null,"team" + _loc4_ + "_player",(_loc4_ == 1 ? "Blue" : "Orange") + " Team",this["team" + _loc4_ + "score"]));
            for(_loc3_ = 0; _loc3_ < this["team" + _loc4_].length; _loc3_++)
            {
               if(!this["team" + _loc4_][_loc3_].unitInfo.extra.noSpawn)
               {
                  param1.addChild(new ScoreBar(_loc2_ = _loc2_ + 20,this["team" + _loc4_][_loc3_]));
               }
            }
            param1.addChild(new ScoreBar(_loc2_ = _loc2_ + 20,null,"team" + _loc5_ + "_player",(_loc5_ == 1 ? "Blue" : "Orange") + " Team",this["team" + _loc5_ + "score"]));
            for(_loc3_ = 0; _loc3_ < this["team" + _loc5_].length; _loc3_++)
            {
               if(!this["team" + _loc5_][_loc3_].unitInfo.extra.noSpawn)
               {
                  param1.addChild(new ScoreBar(_loc2_ = _loc2_ + 20,this["team" + _loc5_][_loc3_]));
               }
            }
         }
      }
   }
}
