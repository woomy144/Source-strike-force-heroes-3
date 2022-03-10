package
{
   public class Stats_Misc
   {
      
      public static var gameModes:Array;
      
      public static var mods:Array;
      
      public static var randGunGame:Array;
      
      public static const maxLvl:int = 30;
      
      public static const maxMission:int = 60;
       
      
      public function Stats_Misc()
      {
         super();
      }
      
      public static function Init() : void
      {
         gameModes = ["dm","one","gg","tdm","ctf","dom","tgg"];
      }
      
      public static function buildModList() : void
      {
         mods = ["none","sky9","clips"];
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("secret1")) != -1)
         {
            mods.push("bodypop");
         }
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("secret2")) != -1)
         {
            mods.push("ammo");
         }
         if(SD.achievements.indexOf(Stats_Achievements.achOrder.indexOf("secret3")) != -1)
         {
            mods.push("party");
         }
      }
      
      public static function getMod(_id:String) : Object
      {
         var ob:Object = {"id":_id};
         switch(_id)
         {
            case "none":
               ob.name = "None";
               ob.desc = "No mod selected.";
               ob.expmod = 1;
               break;
            case "sky9":
               ob.name = "Sky9";
               ob.desc = "Super Physics!";
               ob.expmod = 1;
               break;
            case "clips":
               ob.name = "Pack Mule";
               ob.desc = "Infinite spare ammo.";
               ob.expmod = 0.4;
               break;
            case "ammo":
               ob.name = "Wizardry";
               ob.desc = "Magically infinite ammo.";
               ob.expmod = 0.2;
               break;
            case "party":
               ob.name = "Fiesta";
               ob.desc = "Random weapons, every spawn.";
               ob.expmod = 0.7;
               break;
            case "bodypop":
               ob.name = "Tin Man";
               ob.desc = "Joints are held on with glue.";
               ob.expmod = 1;
         }
         if(ob.expmod == 1)
         {
            ob.exp = "";
         }
         else
         {
            ob.exp = "-" + (100 - ob.expmod * 100) + "% EXP";
         }
         return ob;
      }
      
      public static function getGameMode(_id:String) : Object
      {
         var ob:Object = {"id":_id};
         ob.sprite = _id;
         switch(_id)
         {
            case "dm":
               ob.name = "Deathmatch";
               ob.desc = "Kill enemies to reach the score.";
               ob.scoretype = "KILLS";
               ob.startscore = 10;
               ob.scorelist = [5,10,15,25,50];
               ob.teams = false;
               break;
            case "tdm":
               ob.name = "Team Deathmatch";
               ob.desc = "Kill enemies to reach the score.";
               ob.scoretype = "KILLS";
               ob.startscore = 25;
               ob.scorelist = [10,15,25,50,100];
               ob.teams = true;
               break;
            case "elim":
               ob.name = "Elimination";
               ob.desc = "Kill all enemies and be the survivor.";
               ob.scoretype = "LIVES";
               ob.startscore = 5;
               ob.scorelist = [3,5,10,15,25];
               ob.teams = false;
               break;
            case "telim":
               ob.name = "Team Elimination";
               ob.desc = "Kill the enemy team and be the surviving team.";
               ob.scoretype = "LIVES";
               ob.startscore = 5;
               ob.scorelist = [3,5,10,15,25];
               ob.teams = true;
               break;
            case "ctf":
               ob.name = "Capture the Flag";
               ob.desc = "Capture the enemy\'s flag.";
               ob.scoretype = "FLAGS";
               ob.startscore = 3;
               ob.scorelist = [3,5,7,10,15];
               ob.teams = true;
               break;
            case "dom":
               ob.name = "Domination";
               ob.desc = "Capture and hold zones to gain points.";
               ob.scoretype = "POINTS";
               ob.startscore = 50;
               ob.scorelist = [50,75,100,150,200];
               ob.teams = true;
               break;
            case "one":
               ob.name = "One Man Army";
               ob.desc = "Work as a team to kill the One Man Army.";
               ob.scoretype = "KILLS";
               ob.startscore = 10;
               ob.scorelist = [5,10,25,50,100];
               ob.teams = false;
               break;
            case "zom":
               ob.name = "Outbreak";
               ob.desc = "Survive the zombies. Get killed by one, and become one.";
               ob.scoretype = "LIVES";
               ob.startscore = 10;
               ob.scorelist = [5,10,25,50,100];
               ob.teams = false;
               break;
            case "gg":
               ob.name = "Gun Game";
               ob.desc = "Kill to upgrade your weapon.";
               ob.scoretype = "KILLS";
               ob.startscore = 15;
               ob.scorelist = [10,15,25,50,75];
               ob.teams = false;
               break;
            case "tgg":
               ob.name = "Team Gun Game";
               ob.desc = "Kills upgrade your team weapons.";
               ob.scoretype = "KILLS";
               ob.startscore = 25;
               ob.scorelist = [10,15,25,50,75];
               ob.teams = true;
         }
         return ob;
      }
      
      public static function getGunGameWeapon(_score:int) : String
      {
         var ar:Array = [];
         switch(MatchSettings.useExtra.gungame)
         {
            case "rocket":
               ar.push("$Desert Eagle");
               ar.push("Flak Cannon");
               ar.push("Flame Thrower");
               ar.push("Laser Cutter");
               ar.push("MK32");
               ar.push("GL06");
               ar.push("SMAWG");
               ar.push("Panzer");
               ar.push("M202");
               ar.push("Betsy");
               ar.push("$Flak Cannon");
               ar.push("$Flame Thrower");
               ar.push("$Laser Cutter");
               ar.push("$MK32");
               ar.push("$GL06");
               ar.push("$SMAWG");
               ar.push("$Panzer");
               ar.push("$M202");
               ar.push("$Betsy");
               ar.push("$Axe");
               break;
            case "reverse":
               ar.push("$Shuriken");
               ar.push("$Betsy");
               ar.push("$M202");
               ar.push("$MK32");
               ar.push("$Vulcan");
               ar.push("$SAW");
               ar.push("$FAL OSW");
               ar.push("$ARX 160");
               ar.push("$L115");
               ar.push("$Lynx");
               ar.push("$DSR1");
               ar.push("$Rail Gun");
               ar.push("$Acid Hound");
               ar.push("$Freeze Ray");
               ar.push("$TAC 12");
               ar.push("$MTS 255");
               ar.push("$Sawed-Off");
               ar.push("$Judge");
               ar.push("$P90");
               ar.push("$UMP 45");
               ar.push("$Desert Eagle");
               ar.push("$Crossbow");
               ar.push("$Katana");
               ar.push("$Stun Baton");
               ar.push("$Knife");
               break;
            default:
               switch(MatchSettings.useScore)
               {
                  case 10:
                     ar.push("P99");
                     ar.push("MTAR");
                     ar.push("AK12");
                     ar.push("Uzi");
                     ar.push("MK14");
                     ar.push("DB12");
                     ar.push("Vulcan");
                     ar.push("Acid Hound");
                     ar.push("DSR1");
                     ar.push("M202");
                     break;
                  case 15:
                     ar.push("P99");
                     ar.push("MTAR");
                     ar.push("AK12");
                     ar.push("Sawed-Off");
                     ar.push("Uzi");
                     ar.push("MK14");
                     ar.push("DB12");
                     ar.push("XMG");
                     ar.push("Vulcan");
                     ar.push("Freeze Ray");
                     ar.push("Acid Hound");
                     ar.push("DSR1");
                     ar.push("GL06");
                     ar.push("M202");
                     ar.push("Rail Gun");
                     break;
                  case 25:
                     ar.push("Crossbow");
                     ar.push("Desert Eagle");
                     ar.push("MTAR");
                     ar.push("P90");
                     ar.push("AK12");
                     ar.push("FAL OSW");
                     ar.push("Sawed-Off");
                     ar.push("Uzi");
                     ar.push("FMG9");
                     ar.push("L115");
                     ar.push("MK14");
                     ar.push("MTS 255");
                     ar.push("DB12");
                     ar.push("USAS12");
                     ar.push("HMG50");
                     ar.push("XMG");
                     ar.push("Vulcan");
                     ar.push("Panzer");
                     ar.push("GL06");
                     ar.push("M202");
                     ar.push("Freeze Ray");
                     ar.push("Acid Hound");
                     ar.push("Pulse Rifle");
                     ar.push("DSR1");
                     ar.push("Rail Gun");
                     break;
                  case 50:
                     ar.push("TAC 45");
                     ar.push("Five Seven");
                     ar.push("P99");
                     ar.push("Crossbow");
                     ar.push("Desert Eagle");
                     ar.push("Bizon");
                     ar.push("Vector");
                     ar.push("UMP 45");
                     ar.push("MTAR");
                     ar.push("P90");
                     ar.push("Honey Badger");
                     ar.push("XM8A1");
                     ar.push("AK12");
                     ar.push("FAL OSW");
                     ar.push("ARX 160");
                     ar.push("BM9");
                     ar.push("Judge");
                     ar.push("Sawed-Off");
                     ar.push("Uzi");
                     ar.push("FMG9");
                     ar.push("Intervention");
                     ar.push("Lynx");
                     ar.push("L115");
                     ar.push("MK14");
                     ar.push("G36R");
                     ar.push("R870");
                     ar.push("TAC 12");
                     ar.push("MTS 255");
                     ar.push("DB12");
                     ar.push("USAS12");
                     ar.push("MK48");
                     ar.push("SAW");
                     ar.push("HMG50");
                     ar.push("XMG");
                     ar.push("Vulcan");
                     ar.push("SMAWG");
                     ar.push("MK32");
                     ar.push("Panzer");
                     ar.push("GL06");
                     ar.push("M202");
                     ar.push("Tesla");
                     ar.push("Flame Thrower");
                     ar.push("Flak Cannon");
                     ar.push("Freeze Ray");
                     ar.push("Acid Hound");
                     ar.push("Ion Cannon");
                     ar.push("Laser Cutter");
                     ar.push("Pulse Rifle");
                     ar.push("DSR1");
                     ar.push("Rail Gun");
                     break;
                  case 75:
                     ar.push("TAC 45");
                     ar.push("Five Seven");
                     ar.push("P99");
                     ar.push("Crossbow");
                     ar.push("Desert Eagle");
                     ar.push("$P99");
                     ar.push("$Desert Eagle");
                     ar.push("Bizon");
                     ar.push("Vector");
                     ar.push("UMP 45");
                     ar.push("MTAR");
                     ar.push("P90");
                     ar.push("$Bizon");
                     ar.push("$UMP 45");
                     ar.push("Honey Badger");
                     ar.push("XM8A1");
                     ar.push("AK12");
                     ar.push("FAL OSW");
                     ar.push("ARX 160");
                     ar.push("$XM8A1");
                     ar.push("$AK12");
                     ar.push("BM9");
                     ar.push("Judge");
                     ar.push("Sawed-Off");
                     ar.push("Uzi");
                     ar.push("FMG9");
                     ar.push("$Judge");
                     ar.push("$Sawed-Off");
                     ar.push("Intervention");
                     ar.push("Lynx");
                     ar.push("L115");
                     ar.push("MK14");
                     ar.push("G36R");
                     ar.push("$Lynx");
                     ar.push("$L115");
                     ar.push("R870");
                     ar.push("TAC 12");
                     ar.push("MTS 255");
                     ar.push("DB12");
                     ar.push("USAS12");
                     ar.push("$R870");
                     ar.push("$TAC 12");
                     ar.push("MK48");
                     ar.push("SAW");
                     ar.push("HMG50");
                     ar.push("XMG");
                     ar.push("Vulcan");
                     ar.push("$SAW");
                     ar.push("$HMG50");
                     ar.push("SMAWG");
                     ar.push("MK32");
                     ar.push("Panzer");
                     ar.push("GL06");
                     ar.push("M202");
                     ar.push("$MK32");
                     ar.push("$M202");
                     ar.push("Tesla");
                     ar.push("Flame Thrower");
                     ar.push("Flak Cannon");
                     ar.push("Freeze Ray");
                     ar.push("Acid Hound");
                     ar.push("$Flame Thrower");
                     ar.push("$Freeze Ray");
                     ar.push("Ion Cannon");
                     ar.push("Laser Cutter");
                     ar.push("Pulse Rifle");
                     ar.push("DSR1");
                     ar.push("Rail Gun");
                     ar.push("$Ion Cannon");
                     ar.push("$Pulse Rifle");
                     ar.push("Katana");
                     ar.push("Stun Baton");
                     ar.push("Club");
                     ar.push("Axe");
                     ar.push("Knife");
               }
         }
         if(_score >= ar.length)
         {
            _score = ar.length - 1;
         }
         if(_score < 0)
         {
            _score = 0;
         }
         return ar[_score];
      }
      
      public static function getLevelReq(curStage:int, diff:int) : int
      {
         var lvl:int = 0;
         switch(diff)
         {
            case 0:
               lvl = 0;
               break;
            case 1:
               lvl = Math.ceil((curStage + 1) * 0.3);
               break;
            case 2:
               lvl = Math.ceil((curStage + 1) * 0.3) + 10;
               break;
            case 3:
               lvl = maxLvl;
         }
         return lvl;
      }
   }
}
