package net.battleMechsMulti.managers
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMLoadingTimer extends BMBaseClass
   {
      
      private static var _inst:BMLoadingTimer;
      
      private var _refreshClientTimer:Timer;
      
      private var _refreshClientSecondsCounter:Number;
      
      private var _firstLoading:Boolean = true;
      
      private var _isLoading:* = false;
      
      private var _title:String;
      
      private var _progress:int = -1;
      
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
         this._title = param1;
         this.updateTitle();
         if(param2)
         {
            this.activateRefreshClientTimer();
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_WELCOME_NEW_EXISITNG))
         {
            screensM.screenWelcomeNewExisting.removeMechs();
            screensM.removeScreen(BMScreensManager.SCR_WELCOME_NEW_EXISITNG);
         }
      }
      
      private function updateTitle() : void
      {
         var _loc1_:String = this._title;
         if(this._progress > -1)
         {
            _loc1_ = this._title + " (" + this._progress + "%)";
         }
         switch(BMLoginManager.gi().loginState)
         {
            case BMLoginManager.STATE_SETTINGS_UPDATE:
            case BMLoginManager.STATE_SWITCH_SERVER:
               screensM.screenBlack.text = _loc1_;
               break;
            case BMLoginManager.STATE_SILENT_LOGGING_IN:
               screensM.addIfNotOpened(BMScreensManager.SCR_RECONNECTING);
               screensM.screenReconnecting.refreshScreen();
               break;
            default:
               screensM.screenConfirmation.displayCustomLoading(TextUtils.getTextFont(17) + _loc1_);
         }
      }
      
      public function updateProgress(param1:int, param2:int) : void
      {
         if(!this._isLoading)
         {
            return;
         }
         this._progress = -1;
         if(param2 > 10000)
         {
            this._progress = param1 / param2 * 100;
         }
         this.updateTitle();
         if(this._refreshClientTimer != null)
         {
            this.activateRefreshClientTimer();
         }
      }
      
      public function hideLoading() : void
      {
         if(!this._isLoading)
         {
            return;
         }
         screensM.removeScreen(BMScreensManager.SCR_RECONNECTING);
         if(screensM.screenConfirmation.getQuestionOrNotificationType() == "customLoading")
         {
            screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
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
            screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         }
         this.deactivateRefreshClientTimer();
         this._firstLoading = false;
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
         this._progress = -1;
         this._title = "";
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
         if(screensM.isScreenOpened(BMScreensManager.SCR_LOST_CONNECTION))
         {
            screensM.removeScreen(BMScreensManager.SCR_LOST_CONNECTION);
         }
      }
      
      public function updateConnectingToServerMessage(param1:String) : void
      {
         screensM.screenConfirmation.displayCustomLoading(getScreenText(param1));
      }
   }
}

