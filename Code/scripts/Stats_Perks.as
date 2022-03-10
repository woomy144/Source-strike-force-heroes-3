package
{
   import flash.text.TextField;
   
   public class Stats_Perks
   {
      
      public static var itemOb:Object;
      
      public static var itemAr:Array;
      
      public static var traitOb:Object;
      
      public static var traitAr:Object;
      
      public static var perkAr:Array;
      
      public static var perk0Ar:Array;
      
      public static var perk1Ar:Array;
      
      public static var perk2Ar:Array;
      
      public static var armorAr:Array;
      
      public static var flawAr:Array;
      
      public static var weapAr:Array;
      
      public static var streakAr:Array;
      
      public static var lockedAr:Array;
      
      public static var poopAr:Array;
       
      
      public var type:int;
      
      public var id:String;
      
      public var sprite:String;
      
      public var name:String;
      
      public var armorname:String;
      
      public var val:Number;
      
      public var lvlCost:Number;
      
      public var clash:String;
      
      public var desc:String;
      
      public var cost:int;
      
      public var i:int;
      
      public var iType:int;
      
      public var iTypeArmor:int;
      
      public function Stats_Perks()
      {
         super();
      }
      
      public static function Init() : void
      {
         itemOb = {};
         itemAr = [];
         traitOb = {};
         traitAr = [];
         perkAr = [];
         perk0Ar = [];
         perk1Ar = [];
         perk2Ar = [];
         armorAr = [];
         flawAr = [];
         weapAr = [];
         streakAr = [];
         lockedAr = [];
         poopAr = [];
         addItem(-1,"none","","",0,0,"","");
         addItem(0,"gold1","Pickpocket","Credit Card",1.15,24,"gold0","+15% Gold per kill.");
         addItem(0,"exp1","Quick Learner","Novice Badge",1.1,20,"exp0","+10% Exp per kill.");
         addItem(0,"theif","Scavenger","",1.1,0,"","Kills return 10% ammo.");
         addItem(0,"spawn1","Quick Initiative","Drop Pod",-2,4,"spawn0","Respawn 2 seconds faster.");
         addItem(0,"pickup1","Resourceful","",1.4,0,"pickup0","Health/Ammo pickups give +40% health/ammo.");
         addItem(0,"streak1","Charismatic","",1.2,0,"streak0","Killstreaks are earned 20% quicker.");
         addItem(0,"streak2","Muscle Memory","Headset",0.5,8,"","Killstreaks aren\'t lost on death, but are earned 50% slower.");
         addItem(0,"detect1","Silent","Optic Camo",0.7,0.5,"detect0","Enemies won\'t spot you until they are closer.");
         addItem(0,"tag","Spotter","",1.3,0,"","Your attacks tag enemies, allies will attack them much further away.");
         addItem(0,"length1","Long Lasting","",1.3,0,"length0","Killstreaks last 30% longer.");
         addItem(0,"tired1","Energized","",0.7,0,"tired0","Gets tired 30% slower after battle.");
         addItem(1,"regen1","Healthy","",0.5,5,"regen0","Always slightly healing over time.");
         addItem(1,"regen2","Repair Bots","Nanomachines",4,0,"regen0","When injured, heal 3x faster.");
         addItem(1,"burn1","Burn Resistant","Fire Hat",0.75,3,"burn0","Take -25% damage from fire/poison.");
         addItem(1,"explo1","Bomb Squad","Blast Mask",0.85,3,"explo0","Take -15% damage from explosives.");
         addItem(1,"head1","Hard Headed","Hard Hat",0.85,3,"head0","Take -15% damage from headshots.");
         addItem(1,"self1","Pride","",0.6,0,"self0","Take -40% damage from your own attacks.");
         addItem(1,"damage1","Battle Hardened","E.M. Shield",1.07,7,"damage0","Take -7% damage from all sources.");
         addItem(1,"adren","Adrenaline","Life Support",0.3,9,"","Fatal attacks will reduce you to 1 health instead.");
         addItem(1,"luck1","Lucky","",0.05,0,"luck0","5% chance you will not take any damage.");
         addItem(1,"will","Iron Will","",0.2,0,"","Take up to -20% damage based on how low your life is.");
         addItem(1,"status1","Resistant","",0.15,0,"status0","Higher resistance to status effects. (fire/poison/etc)");
         addItem(2,"aim1","Iron Grip","Diazepam",1,6,"aim0","Accuracy is not reduced by firing.");
         addItem(2,"aim2","Steady Aim","",1,0,"aim0","Accuracy is not reduced by moving or jumping.");
         addItem(2,"aim3","Crouch Master","Tripod",1,5,"","Accuracy is increased more when crouching.");
         addItem(2,"focus","Extreme Focus","",1.3,0,"","After 1.5 seconds of not firing, your next shot does +30% damage.");
         addItem(2,"killsteal","Kill Stealer","Targeting CPU",1.1,13,"","Do +10% damage to enemies not targeting you.");
         addItem(2,"rage","Rage","",1,0,"","Do up to +10% damage based on how low your life is.");
         addItem(2,"sacrifice","Confidence","",1.1,0,"","Always do +10% damage, but reduce health by 10%.");
         addItem(2,"reload","Tactical Reload","Tactical Ammo",1,11,"butter","Gain 25% rate of fire after reloading.");
         addItem(3,"aim0","Nervous","",1.1,0,"","Accuracy is reduced more when moving or jumping.");
         addItem(3,"butter","Butterfingers","",0.07,0,"","7% chance that gun might jam when reloading.");
         addItem(3,"regen0","Unhealthy","",1,0,"","Don\'t auto-regen health when low.");
         addItem(3,"spawn0","Slow Initiative","",2,0,"","Take 2 seconds longer to respawn.");
         addItem(3,"exp0","Slow Learner","",0.9,0,"","-10% Exp per kill.");
         addItem(3,"gold0","Modest","",0.85,0,"","-15% Gold per kill.");
         addItem(3,"burn0","Fair Skin","",1.25,0,"","Take +25% damage from fire/acid.");
         addItem(3,"explo0","Fragile","",1.15,0,"","Take +15% damage from explosives.");
         addItem(3,"head0","Soft Head","",1.15,0,"","Take +15% damage from headshots.");
         addItem(3,"self0","Embarassed","",1.25,0,"","Take +25% damage from your own attacks.");
         addItem(3,"damage0","New Recruit","",1.07,0,"","Take +7% damage from all sources.");
         addItem(3,"pickup0","Squanderer","",0.7,0,"","Health/Ammo pickups give -30% health/ammo.");
         addItem(3,"streak0","Disliked","",0.8,0,"","Killstreaks are earned 20% slower.");
         addItem(3,"luck0","Unlucky","",0.05,0,"","5% chance a shot on you will be a critical hit.");
         addItem(3,"detect0","Loud","",1.5,0,"","Enemies can spot you from further away.");
         addItem(3,"length0","Cut Short","",0.8,0,"","Killstreaks duration are 20% shorter.");
         addItem(3,"status0","Susceptibility","",-0.15,0,"","More easily affected by status effects. (fire/poison/etc)");
         addItem(3,"tired0","Fatigued","",1.2,0,"","Gets tired 20% quicker after battle.");
         addItem(4,"turret1","Guidance System","",0.75,0,"","Killstreak Turrets shoot 25% faster.");
         addItem(4,"turret2","Heavy Deployment","",1.5,0,"","Killstreak Turrets have +50% health and duration");
         addItem(4,"coating","Liquid Coating","",-0.15,0,"","Higher chance to cause status effects. (fire/poison/etc)");
         addItem(4,"energy","Energy Ammo","",1,0,"","Can\'t pick up ammo, but ammo slowly replenishes.");
         addItem(4,"proof","Status Proof","",1,0,"","Status effects expire 2x quicker.");
         addItem(4,"boots","Explosive Temper","",2,0,"","Gain 25% rate of fire while under 40% hp.");
         addItem(4,"gunplay","Gun Play","",1,0,"","Killing an enemy instantly reloads your other weapon.");
         addItem(4,"inspire","Inspire","",0.1,0,"","Increase nearby allies\' critical chance by 10.");
         addItem(4,"magnet","Brain Magnet","",0.1,0,"","10% chance for any shot to count as a headshot.");
         addItem(4,"assist","Aim Assist","",0.5,0,"","Weapon accuracy increased by 50%");
         addItem(4,"deflect","Deflective Armor","",0.08,0,"","8% chance to deflect enemy bullets. (you still take damage)");
         addItem(4,"bomb","Vital Bomb","",1,0,"","Explode on death, damaging enemies.");
         addItem(4,"aura","Healing Aura","",1,0,"","Slightly heal all nearby allies every 3 seconds.");
         addItem(4,"love","Loving Spirit","",1,0,"","Nearby dead allies respawn 3x quicker.");
         addItem(4,"stealth","Chameleon","",1,0,"","Stealthed while not firing or near enemies.");
         addItem(4,"dodge","Matrix Dodge","",0.07,0,"","7% chance to dodge any projectile attack");
         addItem(5,"dmg1","Heavy Load","",1.05,12,"","Increase ranged damage by 5%");
         addItem(5,"radius","Shrapnel","",1.2,8,"","Increase explosion radius by 20%");
         addItem(5,"dmg2","Sharpened Edge","",1.1,14,"","Increase melee damage by 10%");
         addItem(5,"rof1","Hair Trigger","",0.85,16,"","Increase rate of fire by 15%");
         addItem(5,"acc1","Foregrip","",1.5,7,"","Increase accuracy 10%");
         addItem(5,"ammo1","Extended Mag","",1.3,9,"","Increase clip and spare ammo by 30%");
         addItem(5,"ammo2","Ammo Pack","",2,11,"","Hold 2x more spare ammo.");
         addItem(5,"ammo3","Drum Mag","",0.7,13,"","1 giant clip, no reloads. But ammo is reduced by 30%.");
         addItem(5,"range","Advanced Rifling","",1.2,17,"","Increase weapon range by 20%.");
         addItem(5,"auto","Auto Trigger","",0.8,6,"","Primary weapon is auto-fire. -20% damage.");
         addItem(5,"burst","Burst Module","",0.65,5,"","Primary weapon is burst-fire. -35% damage.");
         addItem(5,"headdmg","Ballistic CPU","",0.1,10,"","Increase headshot damage by 10%");
         addItem(5,"critdmg","Laser Sight","",0.15,8,"","Increase critical damage by 15%");
         addItem(5,"bfire","Ignition Rounds","",0.8,18,"","Bullets can ignite enemies. -20%");
         addItem(5,"bice","Nitrogen Rounds","",0.95,15,"","Bullets can freeze enemies. -5%");
         addItem(5,"bacid","Poison Rounds","",0.85,16,"","Bullets can poison enemies. -15%");
         addItem(5,"bzap","Charged Rounds","",0.9,17,"","Bullets can electrocute enemies. -10%");
         addItem(6,"rockettur","Rocket Sentry","",5,0,"","Doploy a powerful sentry with homing rockets.");
         addItem(6,"dualtur","Shotgun Turret","",5,0,"","Deploy a turret with a powerful close range attack.");
         addItem(6,"firebeam","Death Ray","",5,0,"","After 3 seconds, hit and ignite ALL enemies in game");
         addItem(6,"icebeam","Satelite Beam","",5,0,"","After 3 seconds, hit and freeze ALL enemies in game");
         addItem(6,"akimbo","Ghost Weapon","",4,0,"","Weapon fires a second shot for 7 seconds. (uses ammo)");
         addItem(6,"betsy","\"Betsy\"","",4,0,"","Pull out \"Betsy\" until it runs out of ammo.");
         addItem(6,"critboost","Critical Boost","",4,0,"","Increase your squads critical chance by 50% for 8 seconds.");
         addItem(6,"rofboost","RoF Boost","",4,0,"","Increase your squads rate of fire by 50% for 8 seconds.");
         addItem(6,"aimbot","Aim Bot","",4,0,"","Enable Aimbot, most shots are headshots for 6 seconds.");
         addItem(6,"wallhack","Wall Hack","",4,0,"","Enable Wallhack, shoot through walls for 6 seconds.");
         addItem(6,"mirror","\"I\'m the Juggernaut\"","",4,0,"","Gain armor, deflect attacks for 7 seconds. (you still take damage)");
         addItem(6,"element","Flame Armor","",4,0,"","Gain armor, ignite nearby enemies for 7 seconds.");
         addItem(6,"armor","Kevlar Vests","",3,0,"","Equip your whole squad with full armor.");
         addItem(6,"heal","Rapid Regen","",4,0,"","Rapidly regenerate your squads health for 8 seconds.");
         addItem(6,"shuriken","Deadly Shurikens","",3,0,"","Equip 3 poisonous Shirukens.");
         addItem(6,"smoke","Smoke Bomb","",2,0,"","Teleport to a random location and stealth for 2 seconds.");
         addItem(7,"lock0","- ? -","",5,0,"","Requires Lv 5.");
         addItem(7,"lock1","- ? -","",10,0,"","Requires Lv 10.");
         addItem(7,"lock2","- ? -","",15,0,"","Requires Lv 15.");
         addItem(7,"stealth_","","",1,0,"","");
         addItem(7,"streak_","","",2,0,"","");
         addItem(7,"streak__","","",3,0,"","");
         addItem(7,"coating_","","",-1,0,"","");
         addItem(8,"goldbar","Gold Bar","",1,5,"","A bar made of solid gold.");
         addItem(9,"poop","Doodie","",1,0.1,"","Gross... Why is this even in the slot machine?");
         addItem(9,"et","Old Videogame","",1,0.5,"","A videogame? Who plays videogames anyway?");
         addItem(9,"superman","Old Comic","",1,2,"","There\'s a wrinkle in it, so it\'s not worth much.");
      }
      
      public static function addItem(type:uint, id:String, name:String, armorname:String, val:Number, lvlCost:Number, clash:String, desc:String) : void
      {
         var item:Stats_Perks = new Stats_Perks();
         item.type = type;
         item.id = id;
         item.sprite = id;
         item.name = name;
         item.armorname = armorname;
         item.val = val;
         item.lvlCost = lvlCost;
         item.clash = clash;
         item.desc = desc;
         item.cost = UT.getLinearRange(item.lvlCost,Stats_Misc.maxLvl,70,1000);
         itemOb[id] = item;
         item.i = itemAr.length;
         itemAr.push(item);
         if(item.id == "none")
         {
            item.iType = -1;
         }
         switch(type)
         {
            case 0:
               item.iType = perkAr.length;
               perk0Ar.push(item);
               perkAr.push(item);
               break;
            case 1:
               item.iType = perkAr.length;
               perk1Ar.push(item);
               perkAr.push(item);
               break;
            case 2:
               item.iType = perkAr.length;
               perk2Ar.push(item);
               perkAr.push(item);
               break;
            case 3:
               item.iType = flawAr.length;
               flawAr.push(item);
               break;
            case 4:
               item.iType = traitAr.length;
               traitAr.push(item);
               traitOb[id] = item;
               break;
            case 5:
               item.iType = weapAr.length;
               weapAr.push(item);
               break;
            case 6:
               item.iType = streakAr.length;
               streakAr.push(item);
               break;
            case 7:
               lockedAr.push(item);
               break;
            case 9:
               poopAr.push(item);
         }
         if(armorname)
         {
            item.iTypeArmor = armorAr.length;
            armorAr.push(item);
         }
      }
      
      public static function getGunType(id:String) : int
      {
         if(itemOb[id].type == 5)
         {
            return 11;
         }
         if(itemOb[id].type == 9)
         {
            return 13;
         }
         return 12;
      }
      
      public static function setType(txt:TextField, rarity:uint) : void
      {
         switch(rarity)
         {
            case 0:
               txt.text = "UTILITY";
               txt.textColor = 16776960;
               break;
            case 1:
               txt.text = "DEFENSIVE";
               txt.textColor = 10079487;
               break;
            case 2:
               txt.text = "OFFENSIVE";
               txt.textColor = 16724787;
               break;
            case 3:
               txt.text = "FLAW";
               txt.textColor = 13408512;
               break;
            case 4:
               txt.text = "TRAIT";
               txt.textColor = 6750105;
               break;
            case 5:
               txt.text = "ATTACHMENT";
               txt.textColor = 10066431;
               break;
            case 6:
               txt.text = "KILLSTREAK";
               txt.textColor = 16750899;
               break;
            case 7:
               txt.text = "LOCKED";
               txt.textColor = 10066329;
               break;
            case 9:
               txt.text = "POOP";
               txt.textColor = 13408512;
         }
      }
   }
}
