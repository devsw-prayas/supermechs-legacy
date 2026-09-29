package net.battleMechsMulti.managers
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.utils.TextUtils;
   import net.tacticsoft.remoting.RemotingManager;
   
   public class BMLoadingTimer extends BMBaseClass
   {
      
      private static var _inst:BMLoadingTimer;
      
      private var _refreshClientTimer:Timer;
      
      private var _refreshClientSecondsCounter:Number;
      
      private var _firstLoading:Boolean = true;
      
      private var _isLoading:* = false;
      
      public function BMLoadingTimer()
      {
         super();
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("welcome");
      }
      
      public static function getInstance() : BMLoadingTimer
      {
         if(_inst == null)
         {
            _inst = new BMLoadingTimer();
         }
         return _inst;
      }
      
      public static function gi() : BMLoadingTimer
      {
         return getInstance();
      }
      
      public function showLoading(param1:String = null, param2:Boolean = true) : void
      {
         this._isLoading = true;
         if(param1 == null)
         {
            param1 = getScreenText("connecting");
         }
         switch(BMLoginManager.gi().loginState)
         {
            case BMLoginManager.STATE_SWITCH_SERVER:
               screensM.screenBlack.text = param1;
               break;
            case BMLoginManager.STATE_SILENT_LOGGING_IN:
               screensM.addIfNotOpened("screenReconnecting");
               break;
            default:
               screensM.screenConfirmation.displayCustomLoading(TextUtils.getTextFont(17) + param1);
         }
         if(param2)
         {
            this.activateRefreshClientTimer();
         }
         if(screensM.isScreenOpened("screenWelcomeNewExisting"))
         {
            screensM.screenWelcomeNewExisting.removeMechs();
            screensM.removeScreen("screenWelcomeNewExisting");
         }
      }
      
      public function hideLoading() : void
      {
         if(!this._isLoading)
         {
            return;
         }
         screensM.removeScreen("screenReconnecting");
         if(screensM.screenConfirmation.getQuestionOrNotificationType() == "customLoading")
         {
            screensM.removeScreen("screenConfirmation");
         }
         this.deactivateRefreshClientTimer();
      }
      
      public function activateRefreshClientTimer() : void
      {
         if(this._refreshClientTimer != null)
         {
            this._refreshClientTimer.removeEventListener(TimerEvent.TIMER,this.refreshClientTimerTrigger);
            this._refreshClientTimer.stop();
         }
         if(dataM.runAsMobile && this._firstLoading)
         {
            this._refreshClientTimer = new Timer(10000,1);
         }
         else
         {
            this._refreshClientTimer = new Timer(40000,1);
         }
         this._refreshClientTimer.addEventListener(TimerEvent.TIMER,this.refreshClientTimerTrigger);
         this._refreshClientTimer.start();
      }
      
      private function refreshClientTimerTrigger(param1:TimerEvent) : void
      {
         if(screensM.screenConfirmation.getQuestionOrNotificationType() == "customLoading")
         {
            screensM.removeScreen("screenConfirmation");
         }
         this.deactivateRefreshClientTimer();
         this._firstLoading = false;
         dataM.trackError("TimerOut",JSON.stringify(RemotingManager.gi().debugLastMsgData));
         this.hideLoading();
         BMLoginManager.gi().doDisconnectFlow();
      }
      
      private function refreshClientFinalTimerTrigger(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         --this._refreshClientSecondsCounter;
         if(this._refreshClientSecondsCounter == 0)
         {
            this.deactivateRefreshClientTimer();
            screensM.screenConfirmation.displayCustomLoading(getScreenText("connectionFailedRefreshingNow"));
            if(dataM.clientRunningLocally == false)
            {
               dataM.refreshClient();
            }
         }
         else
         {
            _loc2_ = getScreenText("connectionFailedRefreshingSeconds");
            _loc2_ = dataM.replaceStringInText(_loc2_,"%SECONDS%",String(this._refreshClientSecondsCounter));
            screensM.screenConfirmation.displayCustomLoading(_loc2_);
         }
      }
      
      public function deactivateRefreshClientTimer() : void
      {
         this._isLoading = false;
         if(this._refreshClientTimer != null)
         {
            this._refreshClientTimer.stop();
            this._refreshClientTimer.removeEventListener(TimerEvent.TIMER,this.refreshClientTimerTrigger);
            this._refreshClientTimer.removeEventListener(TimerEvent.TIMER,this.refreshClientFinalTimerTrigger);
            this._refreshClientTimer = null;
         }
      }
      
      public function removeLostConnectionMessage() : void
      {
         if(screensM.isScreenOpened("screenLostConnection"))
         {
            screensM.removeScreen("screenLostConnection");
         }
      }
      
      public function updateConnectingToServerMessage(param1:String) : void
      {
         screensM.screenConfirmation.displayCustomLoading(getScreenText(param1));
      }
   }
}

