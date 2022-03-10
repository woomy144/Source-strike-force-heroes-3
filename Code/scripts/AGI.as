package
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.Security;
   
   public class AGI
   {
      
      public static var agi;
      
      public static var enabled:Boolean;
       
      
      public function AGI()
      {
         super();
      }
      
      public static function Init() : void
      {
         enabled = true;
         var agiURL:String = "http://agi.armorgames.com/assets/agi/AGI2.swf";
         Security.allowDomain("agi.armorgames.com");
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(e:IOErrorEvent):void
         {
         });
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e:Event):void
         {
            agi = e.currentTarget.content;
            agi.connect({
               "stage":Main.STAGE,
               "apiKey":"D8231127-4A1C-4725-9DA1-19C687A037D2",
               "callback":function(data:Object):void
               {
                  if(!data.success)
                  {
                     trace(data.error);
                  }
               }
            });
         });
         loader.load(new URLRequest(agiURL));
      }
      
      public static function isConnected() : Boolean
      {
         return agi.isConnected();
      }
      
      public static function getUsername() : String
      {
         return agi.user.getUsername();
      }
      
      public static function save(ob:Object) : void
      {
         agi.storage.user.submit({
            "key":"gamedata",
            "value":ob,
            "callback":function(data:Object):void
            {
               if(!data.success)
               {
                  trace(data.error);
               }
            }
         });
      }
      
      public static function load() : void
      {
         var ob:Object = {};
         agi.storage.user.retrieve({
            "key":"gamedata",
            "callback":function(data:Object):void
            {
               if(data.success)
               {
                  trace("Game Loaded! - Key Value: " + data.keys.gamedata);
                  SD.loadAGIGame(data.keys.gamedata);
               }
               else
               {
                  trace("Game Failed to Load...");
                  SD.loadAGIGame({});
               }
            }
         });
      }
      
      public static function submitQuest(_key:String, _progress:Number = 0) : void
      {
         if(!agi)
         {
            return;
         }
         if(!isConnected())
         {
            return;
         }
         if(!_progress)
         {
            agi.quests.submit({
               "key":_key,
               "callback":function(data:Object):void
               {
                  if(data.success)
                  {
                     trace("Users Current Progress:",data.quest.progress);
                     trace("User Has Earned:",data.quest.status.toLowerCase() == "completed");
                  }
                  else
                  {
                     trace(data.error);
                  }
               }
            });
         }
         else
         {
            agi.quests.submit({
               "key":_key,
               "progress":_progress,
               "callback":function(data:Object):void
               {
                  if(data.success)
                  {
                     trace("Users Current Progress:",data.quest.progress);
                     trace("User Has Earned:",data.quest.status.toLowerCase() == "completed");
                  }
                  else
                  {
                     trace(data.error);
                  }
               }
            });
         }
      }
   }
}
