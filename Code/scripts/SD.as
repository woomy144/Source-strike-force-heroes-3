package
{
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class SD
   {
      
      public static var sound:Boolean;
      
      public static var music:Boolean;
      
      public static var voices:Boolean;
      
      public static var graphQual:uint;
      
      public static var graphPart:uint;
      
      public static var graphLights:Boolean;
      
      public static var graphGlow:Boolean;
      
      public static var screenShake:Boolean;
      
      public static var screenBlood:Boolean;
      
      public static var blood:uint;
      
      public static var rightclick:uint;
      
      public static var achOb:Object;
      
      public static var achievements:Array;
      
      public static var stages:Array;
      
      public static var uniqueClasses:Array;
      
      public static var bpClasses:Array;
      
      public static var bpOwned:Array;
      
      public static var bpBuilt:Array;
      
      public static var heroes:Vector.<UnitInfo>;
      
      public static var squad:Array;
      
      public static var items:Vector.<Array>;
      
      public static var funds:int;
      
      public static var day:int;
      
      public static var storeItems:Array;
      
      public static var storeOrder:Array;
      
      public static var justHired:Boolean;
      
      public static var lastDaily:String;
      
      public static var gotAkq:Boolean;
      
      public static var mapItem:Array;
      
      public static var storeItem;
      
      public static var heroItem;
      
      public static var workshopItem;
      
      public static var bpOther:Array;
      
      public static var curStage:int;
      
      public static var curDiff:int;
      
      public static var saveLocation:String;
      
      public static var saveList:Array;
      
      public static var randRarity:Array;
      
      public static var randAiRarity:Array;
      
      public static var randStoreRarity:Array;
      
      public static var randHighRarity:Array;
      
      public static var squadCode:String;
      
      public static var squadCodeTot:int;
      
      public static var selHero:int = 0;
      
      public static var autoShowAd:Boolean;
      
      public static var soloTired:Number;
       
      
      public function SD()
      {
         super();
      }
      
      public static function Init() : void
      {
         var _loc1_:uint = 0;
         saveList = [];
         mapItem = [];
         saveList.push("sound","music","voices","graphQual","graphLights","graphGlow","graphPart","screenShake","screenBlood","blood","rightclick");
         saveList.push("funds","stages","achievements","achOb");
         saveList.push("bpClasses","bpOwned","bpBuilt","uniqueClasses","gotAkq");
         saveList.push("mapItem","storeItem","workshopItem");
         saveList.push("heroes","squad","items","funds","day","storeItems","storeOrder","justHired","lastDaily");
         randRarity = [];
         for(_loc1_ = 0; _loc1_ < 13; randRarity.push(4),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 30; randRarity.push(0),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 10; randRarity.push(1),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 5; randRarity.push(2),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 1; randRarity.push(3),_loc1_++)
         {
         }
         randAiRarity = [];
         for(_loc1_ = 0; _loc1_ < 16; randAiRarity.push(0),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 8; randAiRarity.push(1),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 4; randAiRarity.push(2),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 2; randAiRarity.push(3),_loc1_++)
         {
         }
         randStoreRarity = [];
         for(_loc1_ = 0; _loc1_ < 9; randStoreRarity.push(4),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 25; randStoreRarity.push(0),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 12; randStoreRarity.push(1),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 7; randStoreRarity.push(2),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 2; randStoreRarity.push(3),_loc1_++)
         {
         }
         randHighRarity = [];
         for(_loc1_ = 0; _loc1_ < 8; randHighRarity.push(1),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 4; randHighRarity.push(2),_loc1_++)
         {
         }
         for(_loc1_ = 0; _loc1_ < 1; randHighRarity.push(3),_loc1_++)
         {
         }
         saveLocation = "SFH3_SO_RFJJj3545jhH";
         newGame();
         loadGame();
      }
      
      public static function newGame() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         trace("=== New Game ===");
         mapItem = [];
         sound = true;
         music = true;
         voices = true;
         graphQual = 1;
         graphLights = false;
         graphGlow = true;
         graphPart = 2;
         screenShake = true;
         screenBlood = false;
         blood = 2;
         rightclick = 0;
         gotAkq = false;
         achievements = [];
         achOb = {};
         uniqueClasses = [];
         justHired = false;
         bpClasses = [0];
         achOb.classes = bpClasses.length;
         curDiff = 1;
         curStage = 0;
         stages = [0];
         squad = [0];
         heroes = new Vector.<UnitInfo>();
         items = new Vector.<Array>();
         heroes.push(Stats_Classes.newHero("","starter1"));
         for(_loc1_ = 0; _loc1_ < 11; _loc1_++)
         {
            items.push([]);
            if(Main.DEBUGMODE)
            {
               for(_loc2_ = 0; _loc2_ < 24; _loc2_++)
               {
                  items[_loc1_].push(new GunInfo(UT.randEl(Stats_Guns.typeAr[_loc1_]).id,UT.irand(1,1)));
               }
            }
         }
         items.push([]);
         if(Main.DEBUGMODE)
         {
            for(_loc2_ = 0; _loc2_ < 20; _loc2_++)
            {
               items[11].push(UT.randEl(Stats_Perks.weapAr).id);
            }
         }
         items.push([]);
         if(Main.DEBUGMODE)
         {
            for(_loc2_ = 0; _loc2_ < 20; _loc2_++)
            {
               items[12].push(UT.randEl(Stats_Perks.armorAr).id);
            }
         }
         bpOwned = [];
         bpBuilt = [];
         bpOther = [];
         for(_loc1_ = 0; _loc1_ < Stats_Guns.itemAr.length; _loc1_++)
         {
            if(Stats_Guns.itemAr[_loc1_].type <= 10)
            {
               if(Stats_Guns.itemAr[_loc1_].extra.bp)
               {
                  bpBuilt.push(_loc1_);
               }
               else
               {
                  bpOther.push(_loc1_);
               }
            }
         }
         storeOrder = [0,1,2,3,4,5,6,7,8,9,10,11,12];
         UT.shuffle(storeOrder);
         createStore();
         day = 1;
         funds = 400;
      }
      
      public static function checkDaily() : Boolean
      {
         var date:Date = new Date();
         return lastDaily == date.getUTCDate() + "-" + date.getUTCMonth();
      }
      
      public static function saveDaily() : void
      {
         var date:Date = new Date();
         lastDaily = date.getUTCDate() + "-" + date.getUTCMonth();
      }
      
      public static function saveGame() : void
      {
         var i:* = undefined;
         trace("-- Saving game");
         var data:Object = convertToObject();
         if(AGI.enabled && AGI.isConnected())
         {
            AGI.save(data);
         }
         var so:SharedObject = SharedObject.getLocal(saveLocation,"/");
         for(i in data)
         {
            so.data[i] = data[i];
         }
         so.flush();
         so.close();
      }
      
      public static function loadGame() : void
      {
         trace("-- Preparing to Load");
         var so:SharedObject = SharedObject.getLocal(saveLocation,"/");
         var data:Object = so.data;
         so.flush();
         so.close();
         if(data.savedBefore)
         {
            loadFromObject(data);
         }
         if(AGI.enabled && AGI.isConnected())
         {
            AGI.load();
         }
         curStage = stages.length - 1;
      }
      
      public static function loadAGIGame(data:Object) : void
      {
         if(!data.savedBefore)
         {
            newGame();
         }
         else
         {
            loadFromObject(data);
         }
      }
      
      public static function convertToObject() : Object
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Object = {};
         for(var _loc2_:uint = 0; _loc2_ < saveList.length; _loc2_++)
         {
            switch(saveList[_loc2_])
            {
               case "mapItem":
                  _loc1_.mapItem = [];
                  if(!mapItem)
                  {
                     mapItem = [];
                  }
                  for(_loc3_ = 0; _loc3_ < mapItem.length; _loc3_++)
                  {
                     if(mapItem[_loc3_] is GunInfo)
                     {
                        _loc1_.mapItem.push(mapItem[_loc3_].createObject());
                     }
                     else
                     {
                        _loc1_.mapItem.push(mapItem[_loc3_]);
                     }
                  }
                  break;
               case "storeItem":
               case "workshopItem":
                  if(SD[saveList[_loc2_]] is GunInfo)
                  {
                     _loc1_[saveList[_loc2_]] = SD[saveList[_loc2_]].createObject();
                  }
                  else
                  {
                     _loc1_[saveList[_loc2_]] = SD[saveList[_loc2_]];
                  }
                  break;
               case "heroes":
                  _loc1_.heroes = [];
                  for(_loc3_ = 0; _loc3_ < heroes.length; _loc3_++)
                  {
                     _loc1_.heroes.push(heroes[_loc3_].createObject());
                  }
                  break;
               case "items":
                  _loc1_.items = [];
                  for(_loc3_ = 0; _loc3_ < items.length; _loc3_++)
                  {
                     _loc1_.items.push([]);
                     for(_loc4_ = 0; _loc4_ < items[_loc3_].length; _loc4_++)
                     {
                        if(_loc3_ <= 10)
                        {
                           _loc1_.items[_loc3_].push(items[_loc3_][_loc4_].createObject());
                        }
                        else
                        {
                           _loc1_.items[_loc3_].push(items[_loc3_][_loc4_]);
                        }
                     }
                  }
                  break;
               case "storeItems":
                  _loc1_.storeItems = [];
                  for(_loc3_ = 0; _loc3_ < storeItems.length; _loc3_++)
                  {
                     if(storeItems[_loc3_] is GunInfo)
                     {
                        _loc1_.storeItems.push(storeItems[_loc3_].createObject());
                     }
                     else
                     {
                        _loc1_.storeItems.push(storeItems[_loc3_]);
                     }
                  }
                  break;
               default:
                  _loc1_[saveList[_loc2_]] = SD[saveList[_loc2_]];
                  break;
            }
         }
         _loc1_.savedBefore = true;
         return _loc1_;
      }
      
      public static function loadFromObject(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         for(var _loc2_:uint = 0; _loc2_ < saveList.length; _loc2_++)
         {
            trace("Loading:",saveList[_loc2_],"=",param1[saveList[_loc2_]]);
            switch(saveList[_loc2_])
            {
               case "mapItem":
                  mapItem = [];
                  for(_loc3_ = 0; _loc3_ < param1.mapItem.length; _loc3_++)
                  {
                     if(!(param1.mapItem[_loc3_] is String) && !(param1.mapItem[_loc3_] is Number))
                     {
                        mapItem.push(GunInfo.loadObject(param1.mapItem[_loc3_]));
                     }
                     else
                     {
                        mapItem.push(param1.mapItem[_loc3_]);
                     }
                  }
                  break;
               case "storeItem":
               case "workshopItem":
                  if(SD[saveList[_loc2_]] is GunInfo)
                  {
                     param1[saveList[_loc2_]] = SD[saveList[_loc2_]].createObject();
                  }
                  else
                  {
                     param1[saveList[_loc2_]] = SD[saveList[_loc2_]];
                  }
                  break;
               case "heroes":
                  heroes = new Vector.<UnitInfo>();
                  for(_loc3_ = 0; _loc3_ < param1.heroes.length; _loc3_++)
                  {
                     heroes.push(UnitInfo.loadObject(param1.heroes[_loc3_]));
                  }
                  break;
               case "items":
                  items = new Vector.<Array>();
                  for(_loc3_ = 0; _loc3_ < param1.items.length; _loc3_++)
                  {
                     items.push([]);
                     for(_loc4_ = 0; _loc4_ < param1.items[_loc3_].length; _loc4_++)
                     {
                        if(_loc3_ <= 10)
                        {
                           items[_loc3_].push(GunInfo.loadObject(param1.items[_loc3_][_loc4_]));
                        }
                        else
                        {
                           items[_loc3_].push(param1.items[_loc3_][_loc4_]);
                        }
                     }
                  }
                  break;
               case "storeItems":
                  storeItems = [];
                  for(_loc3_ = 0; _loc3_ < param1.storeItems.length; _loc3_++)
                  {
                     if(!(param1.storeItems[_loc3_] is String))
                     {
                        storeItems.push(GunInfo.loadObject(param1.storeItems[_loc3_]));
                     }
                     else
                     {
                        storeItems.push(param1.storeItems[_loc3_]);
                     }
                  }
                  break;
               default:
                  SD[saveList[_loc2_]] = param1[saveList[_loc2_]];
                  break;
            }
         }
      }
      
      public static function createStore() : void
      {
         storeItems = [];
         createStoreRow(12);
      }
      
      public static function createStoreRow(amt:int) : void
      {
         var idNum:int = 0;
         var item:* = undefined;
         var lvl:int = 0;
         var highestLvL:int = getHighestLevel();
         for(var i:uint = 0; i < amt; i++)
         {
            idNum = storeOrder.pop();
            if(!storeOrder.length)
            {
               storeOrder = [0,1,2,3,4,5,6,7,8,9,10,11,12];
               UT.shuffle(storeOrder);
               trace("--- New Order ---");
            }
            if(idNum <= 10)
            {
               lvl = UT.irand(highestLvL - 4,highestLvL);
               if(lvl < 1)
               {
                  lvl = 1;
               }
               item = new GunInfo(Stats_Guns.getRandomGunId(idNum),lvl,UT.randEl(randStoreRarity));
            }
            else if(idNum == 11)
            {
               item = UT.randEl(Stats_Perks.weapAr).id;
            }
            else if(idNum == 12)
            {
               item = UT.randEl(Stats_Perks.armorAr).id;
            }
            storeItems.unshift(item);
         }
      }
      
      public static function nextStoreRow() : void
      {
         if(storeItems.length < 12)
         {
            createStoreRow(12 - storeItems.length);
         }
         else
         {
            storeItems.pop();
            storeItems.pop();
            createStoreRow(2);
         }
      }
      
      public static function getHighestLevel() : int
      {
         var lvl:int = 0;
         for(var i:int = 0; i < heroes.length; i++)
         {
            if(heroes[i].level > lvl)
            {
               lvl = heroes[i].level;
            }
         }
         return lvl;
      }
      
      public static function createSquadCode() : void
      {
         var _loc2_:uint = 0;
         var _loc7_:UnitInfo = null;
         var _loc8_:String = null;
         var _loc9_:GunInfo = null;
         var _loc10_:String = null;
         squadCodeTot = 0;
         var _loc1_:String = "";
         for(_loc2_ = 0; _loc2_ < SD.squad.length; _loc2_++)
         {
            if(squad[_loc2_] >= 0)
            {
               _loc7_ = heroes[squad[_loc2_]];
               _loc8_ = "";
               trace(_loc2_,1);
               _loc8_ += cc(Stats_Classes.itemOb[_loc7_.cls].i);
               _loc8_ += cc(_loc7_.level);
               trace(_loc2_,2);
               _loc8_ += cc(Stats_Perks.itemOb[_loc7_.flaw].iType);
               _loc8_ += cc(Stats_Perks.itemOb[_loc7_.streak].iType);
               trace(_loc2_,3);
               _loc8_ += cc(_loc7_.getEquippedPerk(0).iType);
               _loc8_ += cc(_loc7_.getEquippedPerk(1).iType);
               _loc8_ += cc(_loc7_.getEquippedPerk(2).iType);
               trace(_loc2_,4);
               if(_loc7_.primary)
               {
                  _loc9_ = _loc7_.primary;
               }
               else
               {
                  _loc9_ = Stats_Classes.getDefaultWeapon(_loc7_.cls,"primary");
               }
               _loc8_ += cc(_loc9_.stats.i);
               _loc8_ += cc(_loc9_.olevel);
               _loc8_ += cc(_loc9_.rarity);
               trace(_loc2_,5);
               if(_loc7_.secondary)
               {
                  _loc9_ = _loc7_.secondary;
               }
               else
               {
                  _loc9_ = Stats_Classes.getDefaultWeapon(_loc7_.cls,"secondary");
               }
               _loc8_ += cc(_loc9_.stats.i);
               _loc8_ += cc(_loc9_.olevel);
               _loc8_ += cc(_loc9_.rarity);
               trace(_loc2_,6);
               _loc10_ = !!_loc7_.weaponMod ? _loc7_.weaponMod : "none";
               _loc8_ += cc(Stats_Perks.itemOb[_loc10_].iType);
               _loc10_ = !!_loc7_.armorMod ? _loc7_.armorMod : "none";
               _loc8_ += cc(Stats_Perks.itemOb[_loc10_].iTypeArmor);
               trace(_loc2_,7);
               _loc8_ += cc(_loc7_.face);
               _loc8_ += cc(_loc7_.skin);
               _loc8_ += cc(_loc7_.hair);
               _loc8_ += cc(_loc7_.color);
               _loc8_ += cc(int(_loc7_.head / 10));
               _loc8_ += cc(_loc7_.head % 10);
               _loc8_ += cc(int(_loc7_.body / 10));
               _loc8_ += cc(_loc7_.body % 10);
               _loc1_ += _loc8_;
            }
         }
         var _loc3_:* = 10000 - squadCodeTot;
         var _loc4_:String = "" + _loc3_;
         if(_loc3_ < 100)
         {
            _loc4_ = "00" + _loc3_;
         }
         if(_loc3_ < 1000)
         {
            _loc4_ = "0" + _loc3_;
         }
         var _loc5_:String = "";
         for(_loc2_ = 0; _loc2_ < 4; _loc2_++)
         {
            _loc5_ += cc(parseInt(_loc4_.charAt(_loc2_)),false);
         }
         trace("Total",squadCodeTot,_loc3_,_loc4_,_loc5_);
         var _loc6_:int = 0;
         for(_loc2_ = 0; _loc2_ < SD.squad.length; _loc2_++)
         {
            if(SD.squad[_loc2_] >= 0)
            {
               _loc6_++;
            }
         }
         squadCode = "SFH3[" + cc(_loc6_,false) + _loc5_ + _loc1_ + "]";
         squadCode = UT.replaceString(squadCode,"<","!");
         trace("== Squadcode",squadCode);
      }
      
      public static function readSquadCode(param1:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:UnitInfo = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         param1 = UT.replaceString(param1,"!","<");
         trace("Reading",param1);
         if(param1.length < 10)
         {
            trace("Reading failed","code too small");
            return false;
         }
         param1 = param1.substring(5,param1.length - 1);
         trace("Stripped Code",param1);
         var _loc2_:int = cc2(param1,0,false);
         trace("squadAmt",_loc2_);
         if(!UT.between(_loc2_,1,5))
         {
            trace("Reading failed","Squad amount is not 1-5");
            return false;
         }
         var _loc4_:String = "";
         for(_loc5_ = 0; _loc5_ < 4; _loc5_++)
         {
            _loc4_ += cc2(param1,1 + _loc5_,false);
         }
         _loc3_ = 10000 - parseInt(_loc4_);
         trace("flippedCode",parseInt(_loc4_),10000 - parseInt(_loc4_),_loc3_);
         if((param1.length - 5) / _loc2_ != 23)
         {
            trace("Reading failed","Hero code size",(param1.length - 5) / _loc2_,"is not 23.","(" + param1.length + " - 5) / " + _loc2_);
            return false;
         }
         squadCodeTot = 0;
         MatchSettings.qmSquadCodeBots = [];
         for(_loc5_ = 0; _loc5_ < _loc2_; _loc5_++)
         {
            _loc4_ = param1.substr(5 + 23 * _loc5_,23);
            _loc7_ = new UnitInfo();
            _loc7_.cls = Stats_Classes.itemAr[cc2(_loc4_,0)].id;
            _loc7_.level = cc2(_loc4_,1);
            _loc7_.flaw = Stats_Perks.flawAr[cc2(_loc4_,2)].id;
            _loc7_.streak = Stats_Perks.streakAr[cc2(_loc4_,3)].id;
            _loc7_.perks = [];
            _loc6_ = cc2(_loc4_,4);
            _loc7_.perks.push([_loc6_ >= 0 ? Stats_Perks.perkAr[_loc6_].id : "none","none",1]);
            _loc6_ = cc2(_loc4_,5);
            _loc7_.perks.push([_loc6_ >= 0 ? Stats_Perks.perkAr[_loc6_].id : "none","none",1]);
            _loc6_ = cc2(_loc4_,6);
            _loc7_.perks.push([_loc6_ >= 0 ? Stats_Perks.perkAr[_loc6_].id : "none","none",1]);
            _loc7_.primary = new GunInfo(Stats_Guns.itemAr[cc2(_loc4_,7)].id,cc2(_loc4_,8),cc2(_loc4_,9),true);
            _loc7_.secondary = new GunInfo(Stats_Guns.itemAr[cc2(_loc4_,10)].id,cc2(_loc4_,11),cc2(_loc4_,12),true);
            _loc6_ = cc2(_loc4_,13);
            _loc7_.weaponMod = _loc6_ >= 0 ? Stats_Perks.weapAr[_loc6_].id : null;
            _loc6_ = cc2(_loc4_,14);
            _loc7_.armorMod = _loc6_ >= 0 ? Stats_Perks.armorAr[_loc6_].id : null;
            _loc7_.face = cc2(_loc4_,15);
            _loc7_.skin = cc2(_loc4_,16);
            _loc7_.hair = cc2(_loc4_,17);
            _loc7_.color = cc2(_loc4_,18);
            _loc8_ = cc2(_loc4_,19);
            _loc9_ = cc2(_loc4_,20);
            _loc7_.head = _loc8_ * 10 + _loc9_;
            _loc8_ = cc2(_loc4_,21);
            _loc9_ = cc2(_loc4_,22);
            _loc7_.body = _loc8_ * 10 + _loc9_;
            _loc7_.InitStats();
            trace("SQUAD",_loc7_.level,_loc7_.health,_loc7_.primary.level);
            MatchSettings.qmSquadCodeBots.push(_loc7_);
         }
         trace("== Squadcode after reading",_loc3_,squadCodeTot);
         if(_loc3_ != squadCodeTot)
         {
            trace("Reading failed",_loc3_,squadCodeTot,"do not match");
            return false;
         }
         return true;
      }
      
      private static function cc(num:int, add:Boolean = true) : String
      {
         if(add)
         {
            squadCodeTot += num;
         }
         return String.fromCharCode(num + 36);
      }
      
      private static function cc2(code:String, spot:int, add:Boolean = true) : int
      {
         var num:int = code.charCodeAt(spot) - 36;
         if(add)
         {
            squadCodeTot += num;
            trace("CC2:",spot,num,squadCodeTot);
         }
         return num;
      }
      
      public static function playSFH1() : void
      {
         var useArmor:Boolean = false;
         if(Main.SPONSORSITE)
         {
            useArmor = Main.ARMORFIRST;
         }
         else
         {
            useArmor = UT.coinFlip(true,false);
         }
         if(useArmor)
         {
            navigateToURL(new URLRequest("http://armorgames.com/play/13367/strike-force-heroes"));
         }
         else
         {
            navigateToURL(new URLRequest("http://www.notdoppler.com/strikeforceheroes.php?ref=sfh2"));
         }
      }
      
      public static function urlSky9Games(_intro:Boolean = false) : void
      {
         if(new Date().getTime() < new Date(2016,4,1).getTime())
         {
            navigateToURL(new URLRequest("http://knightsquestgame.com/"),"_blank");
         }
         else
         {
            navigateToURL(new URLRequest("http://www.sky9games.com"),"_blank");
         }
      }
      
      public static function urlArmor(_intro:Boolean = false) : void
      {
         navigateToURL(new URLRequest("http://armor.ag/MoreGames"),"_blank");
      }
      
      public static function urlNotDoppler(_intro:Boolean = false) : void
      {
         navigateToURL(new URLRequest("http://www.notdoppler.com/?ref=strikeforceheroes3"),"_blank");
      }
      
      public static function urlTwitter() : void
      {
         navigateToURL(new URLRequest("https://twitter.com/sky9games"),"_blank");
      }
      
      public static function urlYoutube() : void
      {
         navigateToURL(new URLRequest("https://www.youtube.com/user/JouceTin"),"_blank");
      }
      
      public static function urlFacebook() : void
      {
         if(new Date().getTime() < new Date(2016,4,1).getTime())
         {
            navigateToURL(new URLRequest("https://www.facebook.com/knightsquestgame"),"_blank");
         }
         else
         {
            navigateToURL(new URLRequest("https://www.facebook.com/pages/Sky9Games/501553356589353"),"_blank");
         }
      }
      
      public static function urlAkq() : void
      {
         if(new Date().getTime() < new Date(2015,9,1).getTime())
         {
            navigateToURL(new URLRequest("https://www.youtube.com/watch?v=l68IslwRe34"),"_blank");
         }
         else
         {
            navigateToURL(new URLRequest("http://knightsquestgame.com/"),"_blank");
         }
      }
      
      public static function urlPhone() : void
      {
         navigateToURL(new URLRequest("http://goo.gl/odr2a0"),"_blank");
      }
      
      public static function urlPad() : void
      {
         navigateToURL(new URLRequest("http://goo.gl/VH8Kcm"),"_blank");
      }
   }
}
