package net.battleMechsMulti.mobiles
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class BMSoundInstance
   {
      
      private var _type:String;
      
      private var _sound:Sound;
      
      private var _channel:SoundChannel;
      
      private var _ID:Number;
      
      private var _spawnMusic:String;
      
      private var _removeMeFunction:Function;
      
      private var _targetVolume:Number;
      
      private var _removeWhenReachedVolume:Boolean;
      
      private var _onEnterFrameTriggerActive:Boolean = false;
      
      private var _totalFrames:uint = 0;
      
      public function BMSoundInstance()
      {
         super();
      }
      
      public function initialize(param1:String, param2:*, param3:Sound, param4:Number, param5:String, param6:Function, param7:Number = 0, param8:Boolean = true) : void
      {
         this._type = param1;
         this._ID = param2;
         this._sound = param3;
         this._spawnMusic = param5;
         this._removeMeFunction = param6;
         var _loc9_:SoundTransform = new SoundTransform();
         _loc9_.volume = param4;
         this._channel = new SoundChannel();
         this._channel = this._sound.play(param7);
         if(this._channel == null)
         {
            this.removeMe(false);
            return;
         }
         this._channel.soundTransform = _loc9_;
         this._channel.addEventListener(Event.SOUND_COMPLETE,this.soundComplete);
         if(param8 && param7 > 0)
         {
            this.setVolume(0,true,false);
            this.setVolume(1,false,false);
         }
      }
      
      public function stopMe() : void
      {
         this._channel.stop();
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
         if(this._channel == null)
         {
            return;
         }
         if(this._onEnterFrameTriggerActive)
         {
            if(Math.abs(this._channel.soundTransform.volume - this._targetVolume) > 0.05)
            {
               if(this._channel.soundTransform.volume > this._targetVolume)
               {
                  this.setVolumeSub(this._channel.soundTransform.volume - 0.011);
               }
               else
               {
                  this.setVolumeSub(this._channel.soundTransform.volume + 0.011);
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
         var _loc2_:SoundTransform = new SoundTransform();
         _loc2_.volume = param1;
         this._channel.soundTransform = _loc2_;
      }
      
      private function soundComplete(param1:Event) : void
      {
         this.removeMe();
      }
      
      public function getPosition() : Number
      {
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
         this._sound = null;
         this._channel = null;
         switch(this._type)
         {
            case "sound":
               this._removeMeFunction(this._ID);
               break;
            case "music":
               this._removeMeFunction(this._ID,param1 ? this._spawnMusic : "");
         }
      }
   }
}

