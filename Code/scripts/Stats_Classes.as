package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class Stats_Classes
   {
      
      public static var itemOb:Object;
      
      public static var itemAr:Array;
      
      public static var classesBasic:Array;
      
      public static var classesAll:Array;
       
      
      public var id:String;
      
      public var name:String;
      
      public var size:Number;
      
      public var health:Array;
      
      public var crit:Array;
      
      public var aim:Array;
      
      public var mobile:Array;
      
      public var aggro:Array;
      
      public var traits:Array;
      
      public var streaks:Array;
      
      public var frames:Array;
      
      public var perks:Array;
      
      public var primary:Array;
      
      public var secondary:Array;
      
      public var desc:String;
      
      public var i:int;
      
      public function Stats_Classes()
      {
         super();
      }
      
      public static function Init() : void
      {
         itemOb = {};
         itemAr = [];
         if(Main.DEBUGMODE)
         {
            addItem("eng","Engineer",1,[85,185],[5,18],[4,8],[3,7],[2,6],["turret1","turret2"],["rockettur","dualtur"],[81,91],[0,1,2],[0,1,2,3,4,5,6,7,8,9,10],[0,1,2,3,4,5,6,7,8,9,10],"Engineers are balanced fighters that rely on their turret killstreaks.");
         }
         else
         {
            addItem("eng","Engineer",1,[85,185],[5,18],[4,8],[3,7],[2,6],["turret1","turret2"],["rockettur","dualtur"],[81,91],[0,1,2],[3,8],[0,1,2],"Engineers are balanced fighters that rely on their turret killstreaks.");
         }
         addItem("eli","Elite",0.95,[90,205],[6,20],[3,7],[2,6],[3,7],["coating","energy"],["firebeam","icebeam"],[21,31],[2,0,1],[10,9],[2,0,1],"Elites are high tech soldiers that use advanced elemental weaponry.");
         addItem("jug","Juggernaut",1.1,[130,300],[2,10],[1,5],[2,6],[2,6],["deflect","bomb"],["mirror","element"],[121,131],[1,0,1],[9,6],[1,2],"Juggernauts prefer close range and can take the most damage before going down.");
         addItem("mer","Mercenary",1.05,[105,230],[4,15],[2,6],[3,7],[5,9],["proof","bomb"],["akimbo","betsy"],[141,151],[1,2,1],[8,7],[1,2],"Mercenaries will stop at nothing to kill. They work best solo.");
         addItem("sni","Sniper",1,[70,140],[8,30],[5,9],[1,4],[1,5],["magnet","assist"],["aimbot","wallhack"],[101,111],[2,0,2],[5,10],[0,2],"Snipers prefer long range, but are vulnerable up close.");
         addItem("nin","Ninja",0.95,[75,150],[13,40],[2,6],[5,9],[3,7],["stealth","dodge"],["shuriken","smoke"],[61,71],[2,1,2],[6,4],[2,0],"Ninjas move quickly and take out singled enemies with ease.");
         addItem("med","Medic",0.95,[90,195],[3,12],[4,8],[1,5],[1,4],["aura","love"],["armor","heal"],[1,11],[0,1,0],[7,3],[1,0],"Medics keep their team alive through heals and buffs.");
         addItem("gun","Gunslinger",0.95,[80,160],[18,50],[1,4],[4,8],[4,8],["gunplay","inspire"],["critboost","rofboost"],[41,51],[0,2,0],[4,5],[0,1],"Gunslingers are pistol enthusiasts that boost team effectiveness.");
         addItem("akq","Knight",0.9,[115,255],[0,0],[1,1],[5,10],[5,10],["gunplay","inspire"],["critboost","rofboost"],[41,51],[0,2,0],[2],[2],"The Knight is an excellent melee specialist. However he doesn\'t know how to use ranged weapons...");
         classesBasic = ["eng","jug","med","gun"];
         classesAll = ["eng","jug","med","gun","eli","mer","sni","nin"];
      }
      
      public static function addItem(id:String, name:String, size:Number, health:Array, crit:Array, aim:Array, mobile:Array, aggro:Array, traits:Array, streaks:Array, frames:Array, perks:Array, primary:Array, secondary:Array, desc:String) : void
      {
         var item:Stats_Classes = new Stats_Classes();
         item.id = id;
         item.name = name;
         item.health = health;
         item.size = size;
         item.crit = crit;
         item.aim = aim;
         item.mobile = mobile;
         item.aggro = aggro;
         item.traits = traits;
         item.streaks = streaks;
         item.frames = frames;
         item.perks = perks;
         item.primary = primary;
         item.secondary = secondary;
         item.desc = desc;
         itemOb[id] = item;
         item.i = itemAr.length;
         itemAr.push(item);
      }
      
      public static function newHero(cls:String = "", specific:String = "", name:String = "") : UnitInfo
      {
         var randEquips:Boolean = false;
         var num:int = 0;
         var unitInfo:UnitInfo = new UnitInfo();
         unitInfo.cls = cls;
         if(!unitInfo.cls)
         {
            unitInfo.cls = "eng";
         }
         if(classesAll.indexOf(specific) != -1)
         {
            unitInfo.cls = specific;
         }
         unitInfo.name = UT.randEl(MatchSettings.heroNames);
         if(name)
         {
            unitInfo.name = name;
         }
         unitInfo.trait = UT.randEl(Stats_Classes.itemOb[unitInfo.cls].traits);
         unitInfo.flaw = UT.randEl(Stats_Perks.flawAr).id;
         unitInfo.streak = UT.randEl(Stats_Classes.itemOb[unitInfo.cls].streaks);
         unitInfo.level = 1;
         unitInfo.primary = null;
         unitInfo.secondary = null;
         unitInfo.weaponMod = null;
         unitInfo.armorMod = null;
         unitInfo.exp = 0;
         unitInfo.status = 400;
         unitInfo.color = UT.irand(1,6);
         unitInfo.face = UT.irand(1,3);
         unitInfo.skin = UT.irand(1,8);
         unitInfo.hair = UT.irand(1,12);
         unitInfo.head = UT.randEl(Stats_Classes.itemOb[unitInfo.cls].frames);
         unitInfo.body = UT.randEl(Stats_Classes.itemOb[unitInfo.cls].frames);
         switch(specific)
         {
            case "justin":
               unitInfo.name = "Justin";
               unitInfo.cls = "nin";
               unitInfo.color = 1;
               unitInfo.trait = "bomb";
               unitInfo.streak = "dualtur";
               unitInfo.head = unitInfo.body = 242;
               unitInfo.primary = new GunInfo("Intervention",1,3);
               unitInfo.secondary = new GunInfo("Desert Eagle",1,3);
               unitInfo.weaponMod = UT.randEl(Stats_Perks.weapAr).id;
               unitInfo.armorMod = UT.randEl(Stats_Perks.armorAr).id;
               unitInfo.RandomPerks();
               break;
            case "mike":
               unitInfo.name = "Mike";
               unitInfo.cls = "mer";
               unitInfo.color = 1;
               unitInfo.trait = "bomb";
               unitInfo.streak = "rockettur";
               unitInfo.head = unitInfo.body = 241;
               unitInfo.primary = new GunInfo("R870",1,3);
               unitInfo.secondary = new GunInfo("Katana",1,3);
               unitInfo.weaponMod = UT.randEl(Stats_Perks.weapAr).id;
               unitInfo.armorMod = UT.randEl(Stats_Perks.armorAr).id;
               unitInfo.RandomPerks();
               break;
            case "eNin":
               unitInfo.name = UT.randEl(MatchSettings.evilNames);
               unitInfo.cls = "nin";
               unitInfo.color = 4;
               unitInfo.trait = "stealth_";
               unitInfo.streak = "smoke";
               unitInfo.head = unitInfo.body = Stats_Classes.itemOb[unitInfo.cls].frames[0];
               randEquips = true;
               unitInfo.RandomPerks();
               break;
            case "eMer":
               unitInfo.name = UT.randEl(MatchSettings.evilNames);
               unitInfo.cls = "mer";
               unitInfo.trait = "boots";
               unitInfo.streak = "akimbo";
               unitInfo.head = unitInfo.body = Stats_Classes.itemOb[unitInfo.cls].frames[1];
               randEquips = true;
               unitInfo.RandomPerks();
               break;
            case "eMed":
               unitInfo.name = UT.randEl(MatchSettings.evilNames);
               unitInfo.cls = "med";
               unitInfo.color = 6;
               unitInfo.trait = "aura";
               unitInfo.streak = "armor";
               unitInfo.head = Stats_Classes.itemOb[unitInfo.cls].frames[0];
               unitInfo.body = Stats_Classes.itemOb[unitInfo.cls].frames[1];
               unitInfo.extra.skills = {
                  "regen1":1,
                  "regen2":1,
                  "streak_":1
               };
               randEquips = true;
               unitInfo.RandomPerks();
               break;
            case "eEli0":
            case "eEli1":
            case "eEli2":
            case "eEli3":
            case "eEli4":
               unitInfo.name = UT.randEl(MatchSettings.evilNames);
               num = parseInt(specific.charAt(4));
               unitInfo.cls = "eli";
               unitInfo.color = [2,6,5,1,3][num];
               unitInfo.trait = "coating_";
               unitInfo.streak = UT.randEl(Stats_Classes.itemOb[unitInfo.cls].streaks);
               unitInfo.head = unitInfo.body = Stats_Classes.itemOb[unitInfo.cls].frames[1];
               unitInfo.primary = new GunInfo(Stats_Guns.typeAr[10][num].id,1,0);
               unitInfo.secondary = Stats_Classes.getRandomWeapon(unitInfo.cls,"secondary");
               unitInfo.weaponMod = UT.randEl(Stats_Perks.weapAr).id;
               unitInfo.armorMod = UT.randEl(Stats_Perks.armorAr).id;
               unitInfo.RandomPerks();
               break;
            case "eSni":
               unitInfo.name = UT.randEl(MatchSettings.evilNames);
               unitInfo.cls = "sni";
               unitInfo.color = 4;
               unitInfo.trait = "magnet";
               unitInfo.streak = UT.randEl(Stats_Classes.itemOb[unitInfo.cls].streaks);
               unitInfo.head = unitInfo.body = Stats_Classes.itemOb[unitInfo.cls].frames[0];
               unitInfo.primary = new GunInfo("Intervention",1,3);
               unitInfo.secondary = new GunInfo("Desert Eagle",1,3);
               unitInfo.weaponMod = UT.randEl(Stats_Perks.weapAr).id;
               unitInfo.armorMod = UT.randEl(Stats_Perks.armorAr).id;
               unitInfo.RandomPerks();
               break;
            case "enemy":
               unitInfo.name = UT.randEl(MatchSettings.evilNames);
               randEquips = true;
               unitInfo.RandomPerks();
               break;
            case "$eng":
               unitInfo.name = "Nathan";
               unitInfo.cls = "eng";
               unitInfo.trait = "turret2";
               unitInfo.flaw = "status0";
               unitInfo.streak = "rockettur";
               unitInfo.color = 2;
               unitInfo.head = unitInfo.body = 161;
               unitInfo.perks = [];
               unitInfo.perks.push(["aim1","regen1",0]);
               unitInfo.perks.push(["aim2","regen2",0]);
               unitInfo.perks.push(["aim3","luck1",0]);
               unitInfo.unique = true;
               break;
            case "$sni":
               unitInfo.name = "Jyn";
               unitInfo.cls = "sni";
               unitInfo.trait = "magnet";
               unitInfo.flaw = "detect0";
               unitInfo.streak = "wallhack";
               unitInfo.color = 4;
               unitInfo.head = unitInfo.body = 171;
               unitInfo.perks = [];
               unitInfo.perks.push(["focus","length1",0]);
               unitInfo.perks.push(["killsteal","streak1",0]);
               unitInfo.perks.push(["sacrifice","streak2",0]);
               unitInfo.unique = true;
               break;
            case "$jug":
               unitInfo.name = "Tower";
               unitInfo.cls = "jug";
               unitInfo.trait = "deflect";
               unitInfo.flaw = "tired0";
               unitInfo.streak = "element";
               unitInfo.color = 4;
               unitInfo.head = unitInfo.body = 181;
               unitInfo.perks = [];
               unitInfo.perks.push(["burn1","status1",0]);
               unitInfo.perks.push(["explo1","will",0]);
               unitInfo.perks.push(["head1","adren",0]);
               unitInfo.unique = true;
               break;
            case "$mer":
               unitInfo.name = "Dex";
               unitInfo.cls = "mer";
               unitInfo.trait = "boots";
               unitInfo.flaw = "streak0";
               unitInfo.streak = "akimbo";
               unitInfo.color = 1;
               unitInfo.head = unitInfo.body = 191;
               unitInfo.perks = [];
               unitInfo.perks.push(["pickup1","theif",0]);
               unitInfo.perks.push(["rage","will",0]);
               unitInfo.perks.push(["sacrifice","self1",0]);
               unitInfo.unique = true;
               break;
            case "$med":
               unitInfo.name = "Mayday";
               unitInfo.cls = "med";
               unitInfo.trait = "aura";
               unitInfo.flaw = "head0";
               unitInfo.streak = "heal";
               unitInfo.color = 5;
               unitInfo.head = unitInfo.body = 201;
               unitInfo.perks = [];
               unitInfo.perks.push(["regen1","detect1",0]);
               unitInfo.perks.push(["regen2","exp1",0]);
               unitInfo.perks.push(["adren","gold1",0]);
               unitInfo.unique = true;
               break;
            case "$gun":
               unitInfo.name = "Calamity";
               unitInfo.cls = "gun";
               unitInfo.trait = "gunplay";
               unitInfo.flaw = "detect0";
               unitInfo.streak = "rofboost";
               unitInfo.color = 6;
               unitInfo.head = unitInfo.body = 211;
               unitInfo.perks = [];
               unitInfo.perks.push(["streak2","spawn1",0]);
               unitInfo.perks.push(["focus","gold1",0]);
               unitInfo.perks.push(["sacrifice","length1",0]);
               unitInfo.unique = true;
               break;
            case "$eli":
               unitInfo.name = "Fatale";
               unitInfo.cls = "eli";
               unitInfo.trait = "energy";
               unitInfo.flaw = "pickup0";
               unitInfo.streak = "firebeam";
               unitInfo.color = 2;
               unitInfo.head = unitInfo.body = 221;
               unitInfo.perks = [];
               unitInfo.perks.push(["self1","will",0]);
               unitInfo.perks.push(["status1","explo1",0]);
               unitInfo.perks.push(["burn1","head1",0]);
               unitInfo.unique = true;
               break;
            case "$nin":
               unitInfo.name = "Evelynn";
               unitInfo.cls = "nin";
               unitInfo.trait = "stealth";
               unitInfo.flaw = "aim0";
               unitInfo.streak = "shuriken";
               unitInfo.color = 4;
               unitInfo.head = unitInfo.body = 231;
               unitInfo.perks = [];
               unitInfo.perks.push(["damage1","killsteal",0]);
               unitInfo.perks.push(["luck1","rage",0]);
               unitInfo.perks.push(["adren","sacrifice",0]);
               unitInfo.unique = true;
               break;
            case "$akq":
               unitInfo.name = "Rusty";
               unitInfo.cls = "akq";
               unitInfo.trait = "tired1";
               unitInfo.flaw = "luck0";
               unitInfo.streak = "mirror";
               unitInfo.color = 5;
               unitInfo.head = unitInfo.body = 251;
               unitInfo.perks = [];
               unitInfo.perks.push(["proof","boots",0]);
               unitInfo.perks.push(["dodge","deflect",0]);
               unitInfo.perks.push(["stealth","bomb",0]);
               unitInfo.unique = true;
               break;
            case "starter1":
               unitInfo.name = "Wesley";
               unitInfo.cls = "eng";
               unitInfo.trait = "tired1";
               unitInfo.flaw = "detect0";
               unitInfo.streak = "dualtur";
               unitInfo.streak = "aimbot";
               unitInfo.color = 3;
               unitInfo.face = 3;
               unitInfo.skin = 2;
               unitInfo.hair = 13;
               unitInfo.head = unitInfo.body = Stats_Classes.itemOb[unitInfo.cls].frames[0];
               unitInfo.perks = [];
               unitInfo.perks.push(["gold1","exp1",0]);
               unitInfo.perks.push(["regen1","regen2",0]);
               unitInfo.perks.push(["aim1","aim3",0]);
               break;
            case "starter2":
               unitInfo.name = "Sanchez";
               unitInfo.cls = "gun";
               unitInfo.trait = "inspire";
               unitInfo.flaw = "regen0";
               unitInfo.streak = "critboost";
               unitInfo.color = 1;
               unitInfo.face = 1;
               unitInfo.skin = 4;
               unitInfo.hair = 1;
               unitInfo.head = unitInfo.body = Stats_Classes.itemOb[unitInfo.cls].frames[1];
               unitInfo.perks = [];
               unitInfo.perks.push(["exp1","tired1",0]);
               unitInfo.perks.push(["status1","luck1",0]);
               unitInfo.perks.push(["tired1","length1",0]);
               break;
            default:
               unitInfo.RandomPerks();
         }
         if(randEquips)
         {
            unitInfo.primary = Stats_Classes.getRandomWeapon(unitInfo.cls,"primary");
            unitInfo.secondary = Stats_Classes.getRandomWeapon(unitInfo.cls,"secondary");
            unitInfo.weaponMod = UT.randEl(Stats_Perks.weapAr).id;
            unitInfo.armorMod = UT.randEl(Stats_Perks.armorAr).id;
         }
         unitInfo.InitStats();
         return unitInfo;
      }
      
      public static function getHirePrice() : int
      {
         if(SD.heroes.length == 1)
         {
            return 0;
         }
         return 150 + SD.heroes.length * 50;
      }
      
      public static function setSkin(mc:*, unitInfo:UnitInfo, headOnly:Boolean = false, inGame:Boolean = false, noGuns:Boolean = false) : void
      {
         var usePrimary:GunInfo = null;
         var useSecondary:GunInfo = null;
         var frame:int = 0;
         var unequip:String = null;
         if(inGame)
         {
            setPart(mc.head,unitInfo,"head");
            setPart(mc.head.hair,unitInfo,"hair");
            setPart(mc.headhold,unitInfo,"head");
            setPart(mc.headhold.hair,unitInfo,"hair");
            setPart(mc.arm1hold.armup1,unitInfo,"body");
            setPart(mc.arm1hold.armlow1,unitInfo,"body");
            setPart(mc.arm1hold.hand1,unitInfo,"body");
            setPart(mc.arm1hold.hand2,unitInfo,"body");
            setPart(mc.head,unitInfo,"head");
            setPart(mc.body,unitInfo,"body");
            setPart(mc.waist,unitInfo,"body");
            setPart(mc.arm2.armup2,unitInfo,"body");
            setPart(mc.arm2.armlow2,unitInfo,"body");
            setPart(mc.arm2.hand2,unitInfo,"body");
            setPart(mc.arm1.armup1,unitInfo,"body");
            setPart(mc.arm1.armlow1,unitInfo,"body");
            setPart(mc.arm1.hand1,unitInfo,"body");
            setPart(mc.legup1,unitInfo,"body");
            setPart(mc.legup2,unitInfo,"body");
            setPart(mc.leglow1,unitInfo,"body");
            setPart(mc.leglow2,unitInfo,"body");
            setPart(mc.foot1,unitInfo,"body");
            setPart(mc.foot2,unitInfo,"body");
         }
         else
         {
            setPart(mc.head,unitInfo,"head");
            setPart(mc.head.hair,unitInfo,"hair");
            if(headOnly)
            {
               return;
            }
            setPart(mc.body,unitInfo,"body");
            setPart(mc.waist,unitInfo,"body");
            setPart(mc.frontArm,unitInfo,"body");
            setPart(mc.frontForearm,unitInfo,"body");
            setPart(mc.frontHand,unitInfo,"body");
            setPart(mc.backArm,unitInfo,"body");
            setPart(mc.backForearm,unitInfo,"body");
            setPart(mc.backHand,unitInfo,"body");
            setPart(mc.frontLeg,unitInfo,"body");
            setPart(mc.frontShin,unitInfo,"body");
            setPart(mc.frontFoot,unitInfo,"body");
            setPart(mc.backLeg,unitInfo,"body");
            setPart(mc.backShin,unitInfo,"body");
            setPart(mc.backFoot,unitInfo,"body");
            setPart(mc.backFoot,unitInfo,"body");
            mc.body.gun.visible = false;
            mc.frontLeg.gun.visible = false;
            mc.backLeg.gun.visible = false;
            if(noGuns)
            {
               mc.gun.visible = false;
               return;
            }
            usePrimary = unitInfo.primary;
            useSecondary = unitInfo.secondary;
            if(!usePrimary)
            {
               usePrimary = getDefaultWeapon(unitInfo.cls,"primary");
            }
            if(!useSecondary)
            {
               useSecondary = getDefaultWeapon(unitInfo.cls,"secondary");
            }
            if(mc.gun)
            {
               mc.gun.gotoAndStop(usePrimary.stats.sprite);
               frame = mc.gun.currentFrame;
               if(usePrimary.rarity <= 3)
               {
                  frame += usePrimary.rarity;
                  mc.gun.gotoAndStop(frame);
               }
               if(mc.gun.clip)
               {
                  mc.gun.clip.gotoAndStop(frame);
               }
               if(mc.gun.part)
               {
                  mc.gun.part.gotoAndStop(frame);
               }
            }
            if(mc.gun2)
            {
               mc.gun2.gotoAndStop(usePrimary.stats.sprite);
               frame = mc.gun2.currentFrame;
               if(usePrimary.rarity <= 3)
               {
                  frame += usePrimary.rarity;
                  mc.gun2.gotoAndStop(frame);
               }
               if(mc.gun2.clip)
               {
                  mc.gun2.clip.gotoAndStop(frame);
               }
               if(mc.gun2.part)
               {
                  mc.gun2.part.gotoAndStop(frame);
               }
            }
            unequip = useSecondary.stats.unequip;
            if(unequip == "legup1")
            {
               unequip = "frontLeg";
            }
            mc[unequip].gun.visible = true;
            mc[unequip].gun.gotoAndStop(useSecondary.stats.sprite);
            frame = mc[unequip].gun.currentFrame;
            if(useSecondary.rarity <= 3)
            {
               frame += useSecondary.rarity;
               mc[unequip].gun.gotoAndStop(frame);
            }
            if(mc[unequip].gun.clip)
            {
               mc[unequip].gun.clip.gotoAndStop(frame);
            }
            if(mc[unequip].gun.part)
            {
               mc[unequip].gun.part.gotoAndStop(frame);
            }
         }
      }
      
      public static function getDefaultWeapon(cls:String, type:String) : GunInfo
      {
         var weapNum:String = Stats_Classes.itemOb[cls][type][0];
         return new GunInfo(Stats_Guns.typeAr[weapNum][0].id,1,0);
      }
      
      public static function getRandomWeapon(cls:String, type:String) : GunInfo
      {
         var weapNum:String = UT.randEl(Stats_Classes.itemOb[cls][type]);
         return new GunInfo(UT.randEl(Stats_Guns.typeAr[weapNum]).id,1,UT.randEl(SD.randAiRarity));
      }
      
      public static function setPart(_mc:MovieClip, unitInfo:UnitInfo, type:String) : void
      {
         if(_mc)
         {
            if(type == "head" || type == "body")
            {
               _mc.gotoAndStop(unitInfo[type] + unitInfo.color - 1);
            }
            else
            {
               _mc.gotoAndStop(unitInfo[type]);
            }
            if(_mc.skin)
            {
               _mc.skin.gotoAndStop(unitInfo.skin);
            }
            if(_mc.face)
            {
               _mc.face.gotoAndStop(unitInfo.face);
               _mc.face.skin.gotoAndStop(unitInfo.skin);
            }
            if(_mc.robot)
            {
               if(_mc.name == "backArm" || _mc.name == "backForearm" || _mc.name == "backHand")
               {
                  _mc.robot.gotoAndStop(2);
               }
               else
               {
                  _mc.robot.gotoAndStop(1);
               }
            }
         }
      }
      
      public static function setActiveStatus(txt_status:TextField, unitInfo:UnitInfo, txt_info:TextField = null, mc:MovieClip = null) : void
      {
         var anim:String = null;
         var primary:Stats_Guns = null;
         if(unitInfo.status > 300)
         {
            txt_status.textColor = 65382;
            txt_status.text = "";
            if(txt_info)
            {
               txt_info.textColor = 65382;
            }
            if(unitInfo.primary)
            {
               primary = unitInfo.primary.stats;
            }
            else
            {
               primary = Stats_Classes.getDefaultWeapon(unitInfo.cls,"primary").stats;
            }
            anim = primary.frameMenu;
         }
         else if(unitInfo.status > 200)
         {
            txt_status.textColor = 16763955;
            txt_status.text = "Tired";
            if(txt_info)
            {
               txt_info.text = "Tired: -20% Stats";
               txt_info.textColor = 16763955;
            }
            anim = "injured";
         }
         else if(unitInfo.status > 100)
         {
            txt_status.textColor = 16737792;
            txt_status.text = "Injured";
            if(txt_info)
            {
               txt_info.text = "Injured: -50% Stats";
               txt_info.textColor = 16737792;
            }
            anim = "tired";
         }
         else
         {
            txt_status.textColor = 16724736;
            txt_status.text = "Critical";
            if(txt_info)
            {
               txt_info.text = "Critical: -99% Stats";
               txt_info.textColor = 16724736;
            }
            anim = "critical";
         }
         if(mc && mc.currentLabel != anim)
         {
            mc.gotoAndPlay(anim);
         }
      }
      
      public static function getStat(lvl:int, cls:String, val:String) : Number
      {
         return UT.getLinearRange(lvl,Stats_Misc.maxLvl,itemOb[cls][val][0],itemOb[cls][val][1]);
      }
      
      public static function getArmor(lvl:int) : Number
      {
         return UT.getLinearRange(lvl,Stats_Misc.maxLvl,75,150);
      }
      
      public static function getNextExp(_level:uint) : uint
      {
         return _level * _level * 4.5 + 40;
      }
      
      public static function getUnitExp(_level:uint) : uint
      {
         return 4 + _level * 1.4;
      }
      
      public static function getAiLevel(_diff:int) : int
      {
         var lvl:int = Math.round(_diff * 3.5) + UT.irand(-3,4);
         if(lvl > 50 || _diff == 15)
         {
            lvl = 50;
         }
         return lvl > 0 ? int(lvl) : 1;
      }
      
      public static function getReccLevel(_diff:int) : String
      {
         if(_diff == 15)
         {
            return "50";
         }
         var min:int = Math.round(_diff - 1) * 3.5;
         if(min < 1)
         {
            min = 1;
         }
         var max:int = Math.round((_diff + 1) * 3.5);
         if(max > 50)
         {
            max = 50;
         }
         return min + " - " + max;
      }
   }
}
