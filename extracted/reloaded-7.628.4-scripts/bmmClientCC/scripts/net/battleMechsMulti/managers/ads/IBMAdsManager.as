package net.battleMechsMulti.managers.ads
{
   import flash.display.MovieClip;
   import flash.events.IEventDispatcher;
   
   public interface IBMAdsManager extends IEventDispatcher
   {
      
      function init(param1:MovieClip, param2:String) : void;
      
      function setTest(param1:Boolean) : void;
      
      function isInterstitialAvailable() : Boolean;
      
      function loadInterstitial() : void;
      
      function showInterstitial() : void;
      
      function isRewardedVideoAvailable(param1:String) : Boolean;
      
      function showRewardedVideo(param1:String) : void;
   }
}

