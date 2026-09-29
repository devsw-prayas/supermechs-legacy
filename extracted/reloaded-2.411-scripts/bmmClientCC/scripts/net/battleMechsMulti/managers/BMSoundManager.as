package net.battleMechsMulti.managers
{
   import flash.desktop.NativeApplication;
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMSoundInstance;
   
   public class BMSoundManager extends BMBaseClass
   {
      
      private static var _instance:BMSoundManager;
      
      private static var _allowInstantiation:Boolean;
      
      private var _music:Boolean = true;
      
      private var _sound:Boolean = true;
      
      private var _soundsData:Array = new Array();
      
      private var _musicData:Array = new Array();
      
      private var _lastMusicTotalFrames:uint = 0;
      
      private var _lastMusicPosition:Number = 0;
      
      private var _lastMusicInitialMusic:String = "";
      
      private var _lastMusicSpawnMusic:String = "";
      
      private var _lastMusicRepeatTimes:uint = 0;
      
      private var _respawningNextTrack:Boolean = false;
      
      private var _preMuteVolume:Number = 1;
      
      private const MUSIC_VOLUME_MAX:Number = 0.6;
      
      public function BMSoundManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMSoundManager.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : BMSoundManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMSoundManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("soundManager");
         if(dataM.clientRunningLocally)
         {
         }
         NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,this.onAppActivate);
         NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE,this.onAppDeactivate);
      }
      
      internal function onAppActivate(param1:Event) : void
      {
         TsLogger.log("BMSoundManager :: onAppActivate");
         this.unmute();
      }
      
      internal function onAppDeactivate(param1:Event) : void
      {
         TsLogger.log("BMSoundManager :: onAppDeactivate");
         this.mute();
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc2_:BMSoundInstance = null;
         var _loc1_:uint = 0;
         for each(_loc2_ in this._musicData)
         {
            if(_loc2_ != null)
            {
               _loc2_.onEnterFrameTrigger();
               _loc1_++;
            }
         }
      }
      
      public function createSound(param1:String, param2:Number) : void
      {
         var _loc3_:Sound = null;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         var _loc6_:BMSoundInstance = null;
         var _loc7_:Number = NaN;
         if(this._sound)
         {
            _loc3_ = this.getNewSound(param1);
            if(_loc3_ != null)
            {
               _loc4_ = false;
               _loc5_ = 0;
               while(_loc5_ < this._soundsData.length)
               {
                  if(this._soundsData[_loc5_] != null)
                  {
                     _loc4_ = true;
                     _loc5_ = this._soundsData.length;
                  }
                  _loc5_++;
               }
               if(_loc4_ == false)
               {
                  this._soundsData = new Array();
               }
               _loc6_ = new BMSoundInstance();
               _loc7_ = 0.4 * param2;
               _loc6_.initialize("sound",this._soundsData.length,_loc3_,_loc7_,"",this.removeSound);
               this._soundsData.push(_loc6_);
            }
            else
            {
               trace("SOUND NOT FOUND: " + param1);
            }
         }
      }
      
      private function removeSound(param1:Number) : void
      {
         this._soundsData[param1] = null;
      }
      
      private function getNewSound(param1:String) : Sound
      {
         var newSound:Sound = null;
         var $sound:String = param1;
         try
         {
            newSound = externalAssetsM.getSound($sound);
         }
         catch(err:Error)
         {
            TsLogger.log("ERROR: sound \'" + $sound + "\' doesn\'t exist");
         }
         return newSound;
      }
      
      public function createMusic(param1:String, param2:String) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         var _loc6_:Sound = null;
         var _loc7_:String = null;
         var _loc8_:SoundChannel = null;
         var _loc9_:BMSoundInstance = null;
         var _loc10_:Number = NaN;
         var _loc3_:Boolean = false;
         if(this._music)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc4_ = false;
            _loc5_ = 0;
            while(_loc5_ < this._musicData.length)
            {
               if(this._musicData[_loc5_] != null)
               {
                  _loc4_ = true;
                  _loc5_ = this._musicData.length;
               }
               _loc5_++;
            }
            if(_loc4_ == false)
            {
               this._musicData = new Array();
            }
            _loc6_ = new Sound();
            _loc7_ = "resources/sounds/music_optimized/";
            if(dataM.runAsMobile)
            {
               _loc7_ = "";
            }
            if(this._lastMusicInitialMusic != "" && this._lastMusicTotalFrames < 1500 && this._lastMusicRepeatTimes < 1)
            {
               param1 = this._lastMusicInitialMusic;
               param2 = this._lastMusicSpawnMusic;
               ++this._lastMusicRepeatTimes;
            }
            else
            {
               this._lastMusicPosition = 0;
               this._lastMusicRepeatTimes = 0;
               if(this._respawningNextTrack == false)
               {
                  screensM.screenBattle.increaseMusicTrack();
               }
            }
            this._respawningNextTrack = false;
            _loc6_.load(new URLRequest(_loc7_ + param1 + ".mp3"));
            _loc8_ = new SoundChannel();
            _loc9_ = new BMSoundInstance();
            _loc10_ = 1;
            if(this._music == false)
            {
               _loc10_ = 0;
            }
            _loc9_.initialize("music",this._musicData.length,_loc6_,_loc10_,param2,this.removeMusic,this._lastMusicPosition,this._music);
            this._musicData.push(_loc9_);
            this._lastMusicPosition = 0;
            this._lastMusicInitialMusic = param1;
            this._lastMusicSpawnMusic = param2;
         }
      }
      
      private function removeMusic(param1:Number, param2:String) : void
      {
         this._musicData[param1] = null;
         if(param2 != "")
         {
            this._lastMusicTotalFrames = 99999999;
            this._respawningNextTrack = true;
            this.createMusic(param2,param2);
         }
      }
      
      private function getNewMusicSound(param1:String) : Sound
      {
         var _loc2_:Sound = null;
         if(param1 == "menuMusic")
         {
            _loc2_ = externalAssetsM.getSound(param1);
         }
         else
         {
            _loc2_ = externalAssetsM.getMusic(param1);
         }
         return _loc2_;
      }
      
      public function resetMusicTrackParameters() : void
      {
         this._lastMusicTotalFrames = 0;
         this._lastMusicPosition = 0;
         this._lastMusicInitialMusic = "";
         this._lastMusicSpawnMusic = "";
         this._respawningNextTrack = false;
         this._lastMusicRepeatTimes = 0;
      }
      
      public function get sound() : Boolean
      {
         return this._sound;
      }
      
      public function setSound(param1:Boolean) : void
      {
         this._sound = param1;
      }
      
      public function get music() : Boolean
      {
         return this._music;
      }
      
      public function setMusic(param1:Boolean, param2:Boolean = false) : void
      {
         this._music = param1;
         if(param2)
         {
            if(this._music == false)
            {
               this.turnMusicOff();
            }
            else
            {
               this.turnMusicOn();
            }
         }
      }
      
      private function turnMusicOff() : void
      {
         this.removeAllMusic();
      }
      
      private function turnMusicOn() : void
      {
         screensM.screenBattle.playLevelMusic();
      }
      
      public function removeAllMusic() : void
      {
         var _loc1_:BMSoundInstance = null;
         for each(_loc1_ in this._musicData)
         {
            if(_loc1_ != null)
            {
               this._lastMusicTotalFrames = _loc1_.getTotalFrames();
               this._lastMusicPosition = Math.round(_loc1_.getPosition());
               _loc1_.setVolume(0,false,true);
            }
         }
      }
      
      private function mute() : void
      {
         this._preMuteVolume = SoundMixer.soundTransform.volume;
         var _loc1_:SoundTransform = new SoundTransform(0);
         SoundMixer.soundTransform = _loc1_;
      }
      
      private function unmute() : void
      {
         var _loc1_:SoundTransform = new SoundTransform(this._preMuteVolume);
         SoundMixer.soundTransform = _loc1_;
      }
   }
}

