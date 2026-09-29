package net.battleMechsMulti.mobiles
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class BMSoundInstance
   {
      
      private var _type:String;
      
      private var _sound:*;
      
      private var _channel:SoundChannel;
      
      private var _ID:Number;
      
      private var _spawnMusic:String;
      
      private var _removeMeFunction:Function;
      
      private var _targetVolume:Number;
      
      private var _removeWhenReachedVolume:Boolean;
      
      private var _onEnterFrameTriggerActive:Boolean = false;
      
      private var _totalFrames:uint = 0;
      
      private var _soundTransform:SoundTransform;
      
      private var _jumpToPosition:Number;
      
      private var _musicOn:Boolean;
      
      public function BMSoundInstance()
      {
         super();
      }
      
      private function get isAudio() : *
      {
         if(this._type != "music")
         {
            return false;
         }
         return false;
      }
      
      public function initialize(param1:String, param2:*, param3:*, param4:Number, param5:String, param6:Function, param7:Number = 0, param8:Boolean = true) : void
      {
         this._type = param1;
         this._ID = param2;
         this._sound = param3;
         this._spawnMusic = param5;
         this._removeMeFunction = param6;
         this._jumpToPosition = param7;
         this._musicOn = param8;
         this._soundTransform = new SoundTransform();
         this._soundTransform.volume = param4;
         if(!this.isAudio)
         {
            if(this._sound.length == 0)
            {
               this._sound.addEventListener(Event.COMPLETE,this.sound_completeHandler);
               return;
            }
         }
         this.playSound();
      }
      
      private function createChannel(param1:Sound, param2:Number = 0) : SoundChannel
      {
         return this._sound.play(param2);
      }
      
      internal function playSound() : void
      {
         if(this.isAudio)
         {
            this._sound.play();
         }
         else
         {
            this._channel = this.createChannel(this._sound,this._jumpToPosition);
            if(this._channel == null)
            {
               this.removeMe(false);
               return;
            }
            this._channel.soundTransform = this._soundTransform;
            this._channel.addEventListener(Event.SOUND_COMPLETE,this.soundComplete);
         }
         if(this._musicOn && this._jumpToPosition > 0)
         {
            this.setVolume(0,true,false);
            this.setVolume(1,false,false);
         }
      }
      
      internal function sound_completeHandler(param1:Event) : void
      {
         if(!this.isAudio)
         {
            this._sound.removeEventListener(Event.COMPLETE,this.sound_completeHandler);
         }
         this.playSound();
      }
      
      public function stopMe() : void
      {
         if(this.isAudio)
         {
            this._sound.stop();
         }
         else
         {
            this._channel.stop();
         }
      }
      
      public function setVolume(param1:Number, param2:Boolean, param3:Boolean) : void
      {
         if(param2)
         {
            this.setVolumeSub(param1);
         }
         else
         {
            this._targetVolume = param1;
            this._removeWhenReachedVolume = param3;
            if(this._removeWhenReachedVolume)
            {
               this._spawnMusic = "";
            }
            this._onEnterFrameTriggerActive = true;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         ++this._totalFrames;
         if(this.isAudio == false && this._channel == null)
         {
            return;
         }
         if(this._onEnterFrameTriggerActive)
         {
            if(Math.abs(this._soundTransform.volume - this._targetVolume) > 0.05)
            {
               if(this._soundTransform.volume > this._targetVolume)
               {
                  this.setVolumeSub(this._soundTransform.volume - 0.011);
               }
               else
               {
                  this.setVolumeSub(this._soundTransform.volume + 0.011);
               }
            }
            else
            {
               this._onEnterFrameTriggerActive = false;
               this.setVolumeSub(this._targetVolume);
               if(this._removeWhenReachedVolume)
               {
                  this.removeMe();
               }
            }
         }
      }
      
      private function setVolumeSub(param1:Number) : void
      {
         this._soundTransform.volume = param1;
         if(this.isAudio)
         {
            this._sound.setVolume(param1);
         }
         else
         {
            this._channel.soundTransform = this._soundTransform;
         }
      }
      
      private function soundComplete(param1:Event) : void
      {
         this.removeMe();
      }
      
      public function getPosition() : Number
      {
         if(this.isAudio)
         {
            return this._sound.position;
         }
         if(this._channel == null)
         {
            return 0;
         }
         return this._channel.position;
      }
      
      public function getTotalFrames() : Number
      {
         return this._totalFrames;
      }
      
      public function removeMe(param1:Boolean = true) : void
      {
         this._onEnterFrameTriggerActive = false;
         if(this._channel != null)
         {
            this._channel.removeEventListener(Event.SOUND_COMPLETE,this.soundComplete);
         }
         switch(this._type)
         {
            case "sound":
               this._removeMeFunction(this._ID);
               break;
            case "music":
               this._removeMeFunction(this._ID,param1 ? this._spawnMusic : "");
         }
         this._sound = null;
         this._channel = null;
      }
      
      public function get sound() : *
      {
         return this._sound;
      }
   }
}

