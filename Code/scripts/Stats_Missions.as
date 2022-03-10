package
{
   public class Stats_Missions
   {
      
      public static var itemAr:Array;
      
      public static var chalAr:Array;
      
      public static var missAr:Array;
      
      public static var daily:Stats_Missions;
      
      public static var rewards:Array;
      
      public static var iReward:int = 0;
      
      public static var maps:Array;
      
      public static var iMap:int = 0;
       
      
      public var challenge:String;
      
      public var num:int;
      
      public var i:int;
      
      public var mode:String;
      
      public var score:int;
      
      public var map:String;
      
      public var team1:int;
      
      public var team2:int;
      
      public var rewards:Array;
      
      public var units:Array;
      
      public var extra:Object;
      
      public var squadExtra:Object;
      
      public var desc:String;
      
      public var song;
      
      public function Stats_Missions()
      {
         super();
      }
      
      public static function Init() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Object = null;
         itemAr = [];
         chalAr = [];
         missAr = [];
         rewards = [];
         rewards.push("Five Seven","Vector","Club","XM8A1","Judge","Lynx","TAC 12","SAW","MK32","Flame Thrower","Laser Cutter");
         rewards.push("P99","UMP 45","Axe","AK12","Sawed-Off","L115","MTS 255","HMG50","Panzer","Flak Cannon","Pulse Rifle");
         rewards.push("Crossbow","MTAR","Katana","FAL OSW","Uzi","MK14","DB12","XMG","GL06","Freeze Ray","DSR1");
         rewards.push("Desert Eagle","P90","Stun Baton","ARX 160","FMG9","G36R","USAS12","Vulcan","M202","Acid Hound","Rail Gun");
         maps = [];
         maps.push({
            "mode":"tdm",
            "map":"factory"
         });
         maps.push({
            "mode":"dom",
            "map":"frigate"
         });
         maps.push({
            "mode":"tdm",
            "map":"junkyard"
         });
         maps.push({
            "mode":"tgg",
            "map":"temple"
         });
         maps.push({
            "mode":"tdm",
            "map":"canyon"
         });
         maps.push({
            "mode":"ctf",
            "map":"frigate"
         });
         maps.push({
            "mode":"one",
            "map":"gorge"
         });
         maps.push({
            "mode":"tdm",
            "map":"forest"
         });
         maps.push({
            "mode":"gg",
            "map":"temple"
         });
         maps.push({
            "mode":"tgg",
            "map":"caves"
         });
         maps.push({
            "mode":"tdm",
            "map":"street"
         });
         maps.push({
            "mode":"ctf",
            "map":"forest"
         });
         maps.push({
            "mode":"tdm",
            "map":"caves"
         });
         maps.push({
            "mode":"tgg",
            "map":"junkyard"
         });
         maps.push({
            "mode":"one",
            "map":"construction"
         });
         maps.push({
            "mode":"tdm",
            "map":"cqc"
         });
         maps.push({
            "mode":"dom",
            "map":"factory"
         });
         maps.push({
            "mode":"tgg",
            "map":"forest"
         });
         maps.push({
            "mode":"ctf",
            "map":"volcano"
         });
         maps.push({
            "mode":"gg",
            "map":"forest"
         });
         maps.push({
            "mode":"tdm",
            "map":"temple"
         });
         maps.push({
            "mode":"ctf",
            "map":"factory"
         });
         maps.push({
            "mode":"tdm",
            "map":"volcano"
         });
         maps.push({
            "mode":"ctf",
            "map":"caves"
         });
         maps.push({
            "mode":"dom",
            "map":"junkyard"
         });
         maps.push({
            "mode":"ctf",
            "map":"cavesb"
         });
         maps.push({
            "mode":"ctf",
            "map":"construction"
         });
         maps.push({
            "mode":"dom",
            "map":"cavesb"
         });
         maps.push({
            "mode":"ctf",
            "map":"temple"
         });
         maps.push({
            "mode":"one",
            "map":"factory"
         });
         maps.push({
            "mode":"tgg",
            "map":"volcano"
         });
         maps.push({
            "mode":"dom",
            "map":"forest"
         });
         maps.push({
            "mode":"tdm",
            "map":"frigate"
         });
         maps.push({
            "mode":"ctf",
            "map":"gorge"
         });
         maps.push({
            "mode":"dom",
            "map":"caves"
         });
         maps.push({
            "mode":"dm",
            "map":"volcano"
         });
         maps.push({
            "mode":"ctf",
            "map":"canyon"
         });
         maps.push({
            "mode":"dom",
            "map":"volcano"
         });
         maps.push({
            "mode":"tgg",
            "map":"cavesb"
         });
         maps.push({
            "mode":"dom",
            "map":"canyon"
         });
         maps.push({
            "mode":"tgg",
            "map":"gorge"
         });
         maps.push({
            "mode":"ctf",
            "map":"junkyard"
         });
         maps.push({
            "mode":"dom",
            "map":"temple"
         });
         maps.push({
            "mode":"tgg",
            "map":"street"
         });
         maps.push({
            "mode":"tdm",
            "map":"construction"
         });
         maps.push({
            "mode":"tgg",
            "map":"canyon"
         });
         maps.push({
            "mode":"tdm",
            "map":"cavesb"
         });
         maps.push({
            "mode":"dom",
            "map":"gorge"
         });
         maps.push({
            "mode":"tgg",
            "map":"frigate"
         });
         maps.push({
            "mode":"tgg",
            "map":"cqc"
         });
         maps.push({
            "mode":"dm",
            "map":"canyon"
         });
         maps.push({
            "mode":"dom",
            "map":"construction"
         });
         addItem("","",7,"",1,1,["gun",0,0],null,"",null,{
            "tut1":1,
            "raiseLvl":-1
         });
         addItem("","",0,"",2,2,[0,-1,-1],null,"",null,{"tut2":1});
         addItem("","",15,"",2,2,["features",0,0]);
         addItem("","",0,"",3,3,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {
            "permRegen":1,
            "statMod":0.2
         };
         _loc1_.push(u("","eMed","",_loc2_));
         _loc1_.push(u("","eMed","",_loc2_));
         _loc1_.push(u("","eMed","",_loc2_));
         _loc1_.push(u("","eMed","",_loc2_));
         _loc1_.push(u("","eMed","",_loc2_));
         addItem("Doctors of Doom","tdm",15,"street",5,5,["med","random2","$med"],_loc1_,"Enemies have Super Healing");
         addItem("","",0,"",3,3,[-1,0,0]);
         addItem("","",0,"",4,4,["jug",-1,-1]);
         addItem("","",0,"",4,4,[-1,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {
            "skills":{"streak_":1},
            "statMod":0.4
         };
         _loc1_.push(u("","","",_loc2_));
         _loc1_.push(u("","","",_loc2_));
         _loc1_.push(u("","","",_loc2_));
         _loc1_.push(u("","","",_loc2_));
         _loc1_.push(u("","","",_loc2_));
         addItem("Reverse Perfection","gg",25,"street",1,5,["random2","random2","$gun"],_loc1_,"Gun Game, custom weapons",null,{"gungame":"reverse"});
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,[-1,-1,-1]);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {"statMod":0.2};
         _loc1_.push(u("","eNin","",_loc2_));
         _loc1_.push(u("","eNin","",_loc2_));
         _loc1_.push(u("","eNin","",_loc2_));
         _loc1_.push(u("","eNin","",_loc2_));
         addItem("Ninja Nights","tdm",10,"street",4,4,["nin","random2","$nin"],_loc1_,"Enemies are Invisible");
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,[-1,-1,-1]);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {"skills":{
            "turret1":1,
            "turret2":1,
            "coating":1,
            "energy":1,
            "proof":1,
            "boots":1,
            "gunplay":1,
            "inspire":1,
            "magnet":1,
            "assist":1,
            "deflect":1,
            "bomb":1,
            "aura":1,
            "love":1,
            "stealth":1,
            "dodge":1
         }};
         _loc1_.push(u("","enemy","",_loc2_));
         _loc1_.push(u("","enemy","",_loc2_));
         _loc1_.push(u("","enemy","",_loc2_));
         _loc1_.push(u("","enemy","",_loc2_));
         addItem("Raze Protocol","tdm",10,"street",4,4,["random2","random2","random2"],_loc1_,"Everyone has ALL possible traits",_loc2_);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,[-1,-1,-1]);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {
            "skills":{"streak_":1},
            "statMod":0.4
         };
         _loc1_.push(u("","eMer","",_loc2_));
         _loc1_.push(u("","eMer","",_loc2_));
         _loc1_.push(u("","eMer","",_loc2_));
         _loc1_.push(u("","eMer","",_loc2_));
         _loc1_.push(u("","eMer","",_loc2_));
         addItem("Rocket Race 4.0","gg",20,"street",1,5,["mer","random2","$mer"],_loc1_,"Like Gun Game, but more Boom!",null,{"gungame":"rocket"});
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,[-1,-1,-1]);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {
            "skills":{"streak_":1},
            "statMod":0.2
         };
         _loc1_.push(u("","enemy","",_loc2_));
         _loc1_.push(u("","enemy","",_loc2_));
         _loc1_.push(u("","enemy","",_loc2_));
         _loc1_.push(u("","enemy","",_loc2_));
         addItem("Going Streaking!","tdm",10,"street",4,4,["random2","random2","$eng"],_loc1_,"All Killstreaks are earned 2x quicker",{"skills":{"streak_":1}});
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,[-1,-1,-1]);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc1_.push(u("","eSni","",{
            "kills":2,
            "statMod":0.2
         }));
         _loc1_.push(u("","eSni","",{
            "kills":2,
            "statMod":0.2
         }));
         _loc1_.push(u("","eSni","",{
            "kills":2,
            "statMod":0.2
         }));
         _loc1_.push(u("","eSni","",{
            "kills":3,
            "statMod":0.2
         }));
         _loc1_.push(u("","eSni","",{
            "kills":3,
            "statMod":0.2
         }));
         addItem("Watch Your Back","tdm",15,"street",1,5,["sni","random2","$sni"],_loc1_,"You are Invisible",{"skills":{"stealth_":1}});
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,[-1,-1,-1]);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {"statMod":0.2};
         _loc1_.push(u("","enemy","",_loc2_));
         _loc1_.push(u("","enemy","",_loc2_));
         _loc1_.push(u("","enemy","",_loc2_));
         _loc1_.push(u("","enemy","",_loc2_));
         _loc1_.push(u("","hitman","",{
            "statMod":2,
            "raiseLvl":5,
            "scale":0.5
         }));
         addItem("The Hitman","tdm",10,"street",5,5,["random2","random2","$jug"],_loc1_,"Beware the Hitman");
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,[-1,-1,-1]);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {
            "skills":{"streak_":1},
            "statMod":0.25
         };
         _loc1_.push(u("","eEli0","",_loc2_));
         _loc1_.push(u("","eEli1","",_loc2_));
         _loc1_.push(u("","eEli2","",_loc2_));
         _loc1_.push(u("","eEli3","",_loc2_));
         _loc1_.push(u("","eEli4","",_loc2_));
         addItem("Elemental Fury","tdm",10,"street",5,5,["eli","random2","$eli"],_loc1_,"Face a team of Powerful Elites");
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,[-1,-1,-1]);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {
            "skills":{"streak__":1},
            "statMod":0.3
         };
         _loc1_.push(u("","$nin","",_loc2_));
         _loc1_.push(u("","$med","",_loc2_));
         _loc1_.push(u("","$gun","",_loc2_));
         _loc1_.push(u("","$eli","",_loc2_));
         addItem("Next Generation","tdm",10,"street",5,4,["random2","random2","random2"],_loc1_,"The Best of the Best",null,{"raiseLvl":3});
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,[-1,-1,-1]);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {
            "skills":{"streak_":1},
            "statMod":0.5
         };
         _loc1_.push(u("","$eng","",_loc2_));
         _loc1_.push(u("","$sni","",_loc2_));
         _loc1_.push(u("","$jug","",_loc2_));
         _loc1_.push(u("","$mer","",_loc2_));
         addItem("Veteran Heroes","tdm",10,"street",5,4,["random2","random2","random2"],_loc1_,"Defeat the OG Heroes",null,{"raiseLvl":3});
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,[-1,-1,-1]);
         addItem("","",0,"",5,5,[0,0,0]);
         addItem("","",0,"",5,5,["random2","random2","random2"]);
         _loc1_ = [];
         _loc2_ = {
            "statMod":1,
            "skills":{
               "streak_":1,
               "turret1":1,
               "turret2":1,
               "coating":1,
               "energy":1,
               "proof":1,
               "boots":1,
               "gunplay":1,
               "inspire":1,
               "magnet":1,
               "assist":1,
               "deflect":1,
               "bomb":1,
               "aura":1,
               "love":1,
               "dodge":1
            }
         };
         _loc1_.push(u("","justin","",_loc2_));
         _loc1_.push(u("","mike","",_loc2_));
         addItem("Devs de la muerte","tdm",25,"street",2,2,["random2","random2","random2"],_loc1_,"Defeat the Developers",null,{
            "raiseLvl":5,
            "developers":{},
            "song":M_SFH
         });
         setDefaultRewards();
         createDaily();
      }
      
      public static function u(cls:String, specific:String = "", name:String = "", extra:Object = null) : UnitInfo
      {
         var unit:UnitInfo = Stats_Classes.newHero(cls,specific,name);
         if(extra)
         {
            unit.extra = extra;
         }
         return unit;
      }
      
      public static function addItem(challenge:String, mode:String, score:int, map:String, team1:int, team2:int, rewards:Array, units:Array = null, desc:String = "", squadExtra:Object = null, extra:Object = null) : void
      {
         var item:Stats_Missions = new Stats_Missions();
         item.challenge = challenge;
         item.mode = mode;
         item.score = score;
         item.map = map;
         item.team1 = team1;
         item.team2 = team2;
         item.rewards = rewards;
         item.units = units;
         item.extra = !!extra ? extra : {};
         item.squadExtra = !!squadExtra ? squadExtra : {};
         item.desc = desc;
         if(!mode)
         {
            item.mode = maps[iMap].mode;
            item.map = maps[iMap].map;
            if(!Stats_Misc.getGameMode(maps[iMap].mode).teams)
            {
               item.team1 = 1;
               item.team2 = 7;
            }
            ++iMap;
         }
         if(!score)
         {
            item.score = Stats_Misc.getGameMode(item.mode).startscore;
         }
         for(var i:uint = 0; i < 3; i++)
         {
            if(item.rewards[i] == -1)
            {
               item.rewards[i] = 100 + Stats_Misc.getLevelReq(itemAr.length,i + 1) * 25;
            }
         }
         if(units)
         {
            item.team2 = units.length;
         }
         if(challenge && !item.extra.raiseLvl)
         {
            item.extra.raiseLvl = 2;
         }
         if(challenge)
         {
            item.song = M_French;
         }
         if(item.extra.song)
         {
            item.song = item.extra.song;
         }
         item.i = itemAr.length;
         itemAr.push(item);
         if(challenge)
         {
            item.num = chalAr.length;
            chalAr.push(item);
         }
         else
         {
            item.num = missAr.length;
            missAr.push(item);
         }
      }
      
      public static function createDaily() : void
      {
         daily = new Stats_Missions();
         var date:Date = new Date();
         var num:int = date.getUTCDate() + date.getUTCMonth();
         daily.mode = Stats_Misc.gameModes[num % Stats_Misc.gameModes.length];
         trace(Stats_Misc.gameModes.length,num);
         trace(num % Stats_Misc.gameModes.length);
         trace(daily.mode);
         trace(Stats_Misc.getGameMode(daily.mode).scorelist);
         trace(Stats_Misc.getGameMode(daily.mode).teams);
         daily.score = Stats_Misc.getGameMode(daily.mode).scorelist[3];
         daily.map = Stats_Maps.mapOrder[num % Stats_Maps.mapOrder.length];
         if(Stats_Misc.getGameMode(daily.mode).teams)
         {
            daily.team1 = 5;
            daily.team2 = 5;
         }
         else
         {
            daily.team1 = 1;
            daily.team2 = 9;
         }
         daily.units = null;
         daily.extra = {};
         daily.squadExtra = {};
         daily.desc = "";
      }
      
      public static function setDefaultRewards() : void
      {
         var j:uint = 0;
         for(var i:uint = 0; i < 3; i++)
         {
            for(j = 0; j < itemAr.length; j++)
            {
               if(!itemAr[j].rewards[i])
               {
                  if(iReward == rewards.length)
                  {
                     itemAr[j].rewards[i] = "random2";
                  }
                  else
                  {
                     itemAr[j].rewards[i] = rewards[iReward];
                     ++iReward;
                  }
               }
            }
         }
      }
   }
}
