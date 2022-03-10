package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class Stats_Achievements extends MovieClip
   {
      
      public static var achOrder:Array;
      
      public static var ach:Stats_Achievements;
       
      
      public var icon:MovieClip;
      
      public var txt_desc:TextField;
      
      public var txt_name:TextField;
      
      public var txt_unlock:TextField;
      
      public function Stats_Achievements()
      {
         super();
         addFrameScript(0,this.frame1);
         stop();
         Stats_Achievements.ach = this;
      }
      
      public static function Init() : void
      {
         achOrder = [];
         achOrder.push("campaign","challenges","levelmax","hard","insane","upgrade");
         achOrder.push("buy","sell","enemies","eng","mer","gun","sni","jug","eli","med","nin","classes");
         achOrder.push("secret1","secret2","secret3");
      }
      
      public static function getAchievementNum(_num:*) : Object
      {
         return getAchievement(achOrder[_num]);
      }
      
      public static function getAchievement(_id:String) : Object
      {
         var ob:Object = {};
         ob.id = _id;
         ob.sprite = _id;
         switch(_id)
         {
            case "campaign":
               ob.name = "The End?";
               ob.desc = "Beat the game.";
               break;
            case "challenges":
               ob.name = "Strike Force Hero";
               ob.desc = "Complete all Challenges.";
               break;
            case "levelmax":
               ob.name = "Maxed Out";
               ob.desc = "Reach level 30 with any Soldier.";
               break;
            case "hard":
               ob.name = "Battle Hero";
               ob.desc = "Complete all Stages on Hard.";
               break;
            case "insane":
               ob.name = "Veteran";
               ob.desc = "Complete all Stages on Insane.";
               break;
            case "upgrade":
               ob.name = "Heavily Equipped";
               ob.desc = "Upgrade a weapon to 5 stars.";
               break;
            case "buy":
               ob.name = "Big Spender";
               ob.desc = "Spend $750,000 funds.";
               ob.max = 750000;
               ob.progress = "$@ spent";
               break;
            case "sell":
               ob.name = "Entrepreneur";
               ob.desc = "Sell $100,000 worth of items.";
               ob.max = 100000;
               ob.progress = "$@ sold";
               break;
            case "enemies":
               ob.name = "Take out the Trash";
               ob.desc = "Defeat 500 enemies.";
               ob.max = 500;
               ob.progress = "@ defeated";
               break;
            case "eng":
               ob.name = "Turret Master";
               ob.desc = "Get 150 kills with Turrets as an Engineer.";
               ob.max = 150;
               ob.progress = "@ kills";
               break;
            case "mer":
               ob.name = "Unfair Advantage";
               ob.desc = "Get 200 killstreak kills as a Mercenary.";
               ob.max = 200;
               ob.progress = "@ kills";
               break;
            case "gun":
               ob.name = "Going Streaking";
               ob.desc = "Activate 75 killstreaks as a Gunslinger.";
               ob.max = 75;
               ob.progress = "@ activated";
               break;
            case "sni":
               ob.name = "Boom, Headshot!";
               ob.desc = "Get 175 headshot kills as a Sniper.";
               ob.max = 175;
               ob.progress = "@ kills";
               break;
            case "jug":
               ob.name = "Iron Man";
               ob.desc = "Take 100,000 damage as a Juggernaut.";
               ob.max = 100000;
               ob.progress = "@ damage";
               break;
            case "eli":
               ob.name = "Elementalist";
               ob.desc = "Kill 250 status afflicted enemies as an Elite.";
               ob.max = 250;
               ob.progress = "@ kills";
               break;
            case "med":
               ob.name = "Close Call";
               ob.desc = "Activate 75 killstreaks as a Medic.";
               ob.max = 75;
               ob.progress = "@ activated";
               break;
            case "nin":
               ob.name = "Assassin";
               ob.desc = "Kill 175 unaware enemies as a Ninja.";
               ob.max = 175;
               ob.progress = "@ kills";
               break;
            case "classes":
               ob.name = "Diversity";
               ob.desc = "Unlock all Classes.";
               ob.max = 8;
               ob.progress = "@ unlocked";
               ob.useMax = true;
               break;
            case "secret1":
               ob.name = "Heads Up!";
               ob.desc = "Found a Future Soldier!";
               ob.unlock = "Tin Man";
               break;
            case "secret2":
               ob.name = "Thumbs Up!";
               ob.desc = "High Five the Future Soldier!";
               ob.unlock = "Wizardry";
               break;
            case "secret3":
               ob.name = "Cold Feet!";
               ob.desc = "Thaw the Future Soldier!";
               ob.unlock = "Fiesta";
         }
         return ob;
      }
      
      private static function idToNum(_id:String) : uint
      {
         return achOrder.indexOf(_id);
      }
      
      public static function checkAchVariable(_ach:String, _addAmt:uint) : void
      {
         if(isNaN(SD.achOb[_ach]) || SD.achOb[_ach] == null)
         {
            SD.achOb[_ach] = 0;
         }
         SD.achOb[_ach] += _addAmt;
         if(SD.achOb[_ach] >= getAchievement(_ach).max)
         {
            setAchievement(_ach);
            if(getAchievement(_ach).useMax)
            {
               SD.achOb[_ach] == getAchievement(_ach).max;
            }
         }
      }
      
      public static function setAchievement(_id:*) : void
      {
         var num:uint = idToNum(_id);
         if(SD.achievements.indexOf(num) != -1)
         {
            return;
         }
         var gotAch:Object = getAchievement(_id);
         SD.achievements.push(num);
         SD.saveGame();
         trace("Got achievement",gotAch.name);
         ach.icon.gotoAndStop(gotAch.sprite);
         ach.txt_name.text = gotAch.name;
         ach.txt_desc.text = gotAch.desc;
         ach.txt_unlock.text = !!gotAch.unlock ? gotAch.unlock + " mod unlocked!" : "";
         ach.gotoAndPlay(2);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
