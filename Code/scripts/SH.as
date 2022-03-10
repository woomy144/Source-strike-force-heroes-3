package
{
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class SH
   {
      
      public static var chan:SoundChannel;
      
      public static var sound;
      
      public static var replayAt:Number;
      
      private static var voiceChan:SoundChannel;
      
      private static var soundChan:SoundChannel;
      
      private static var soundVolLow:SoundTransform;
      
      private static var soundVol:SoundTransform;
      
      private static var soundVolLoud:SoundTransform;
      
      private static var noVol:SoundTransform;
      
      private static var musicClass;
      
      private static var musicChan:SoundChannel;
      
      private static var musicVol:SoundTransform;
      
      private static var fadeClass;
      
      private static var fadeChan:SoundChannel;
      
      private static var fadeVol:SoundTransform;
      
      public static var songList:Array;
      
      public static var songNames:Array;
      
      private static const maxVolume:Number = 0.8;
      
      private static var useLowVol:Boolean;
       
      
      public function SH()
      {
         super();
      }
      
      public static function Init() : void
      {
         soundVolLow = new SoundTransform();
         soundVolLow.volume = 0.15;
         soundVol = new SoundTransform();
         soundVol.volume = 0.4;
         soundVolLoud = new SoundTransform();
         soundVolLoud.volume = 0.9;
         noVol = new SoundTransform();
         noVol.volume = 0;
         musicVol = new SoundTransform();
         musicVol.volume = maxVolume;
         fadeVol = new SoundTransform();
         fadeVol.volume = 0;
         songList = [M_Rush,M_Rocket,M_Rage,M_Action,M_Epic,M_Speed];
         songNames = ["Rush","Rocket Race","Relentless Rage","CTP v1","CTP v2","CTP v3"];
      }
      
      public static function playSound(_cls:*, _louder:Boolean = false) : SoundChannel
      {
         if(!SD.sound)
         {
            return null;
         }
         soundChan = new _cls().play();
         if(useLowVol)
         {
            soundChan.soundTransform = !!_louder ? soundVol : soundVolLow;
         }
         else
         {
            soundChan.soundTransform = !!_louder ? soundVolLoud : soundVol;
         }
         return soundChan;
      }
      
      public static function playVoice(_cls:*) : Number
      {
         if(!SD.voices)
         {
            return 0;
         }
         if(voiceChan)
         {
            voiceChan.stop();
         }
         var voiceSound:* = new _cls();
         voiceChan = voiceSound.play();
         voiceChan.soundTransform = soundVolLoud;
         return voiceSound.length / 1000;
      }
      
      public static function playMusic(_musicClass:*, _instant:Boolean = false, _time:int = 0) : void
      {
         if(musicClass == _musicClass)
         {
            return;
         }
         if(musicClass)
         {
            if(fadeClass)
            {
               fadeChan.stop();
            }
            fadeVol.volume = !SD.music || _instant ? Number(0) : Number(maxVolume);
            fadeClass = musicClass;
            fadeChan = musicChan;
            fadeChan.soundTransform = fadeVol;
         }
         else
         {
            _instant = true;
         }
         musicVol.volume = _instant && SD.music ? Number(maxVolume) : Number(0);
         musicClass = _musicClass;
         musicChan = new musicClass().play(_time,1000);
         musicChan.soundTransform = musicVol;
      }
      
      public static function EnterFrame() : void
      {
         var mMax:Number = NaN;
         useLowVol = false;
         if(fadeClass)
         {
            if(fadeVol.volume > 0)
            {
               fadeVol.volume -= 0.025;
               fadeChan.soundTransform = fadeVol;
            }
            else
            {
               fadeClass = null;
               fadeChan.stop();
            }
         }
         if(musicClass)
         {
            if(SD.music)
            {
               mMax = maxVolume;
               if(Main.curClass is Game && MatchSettings.matchType == 0 && Main.curClass.hud.msgTimer && SD.voices)
               {
                  useLowVol = true;
               }
               if(useLowVol)
               {
                  mMax = 0.4;
               }
               if(musicVol.volume < mMax + 0.05)
               {
                  musicVol.volume += 0.05;
               }
               if(musicVol.volume > mMax - 0.025)
               {
                  musicVol.volume -= 0.025;
               }
            }
            else if(musicVol.volume > 0)
            {
               musicVol.volume -= 0.025;
            }
         }
         if(musicChan)
         {
            musicChan.soundTransform = musicVol;
         }
      }
      
      public static function updateMusicVolume() : void
      {
         if(SD.music)
         {
            fadeVol.volume = 0;
            musicVol.volume = 0;
         }
         else
         {
            fadeVol.volume = 0;
            musicVol.volume = maxVolume;
         }
      }
   }
}
