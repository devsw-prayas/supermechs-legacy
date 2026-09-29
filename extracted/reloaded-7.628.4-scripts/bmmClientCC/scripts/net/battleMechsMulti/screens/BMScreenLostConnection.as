package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2128")]
   public class BMScreenLostConnection extends BMBaseScreen
   {
      
      private static var _lastDisplayTime:int = 0;
      
      private static var _numNearDisplays:int = 0;
      
      private static const MAX_SECONDS_BETWEEN_NEAR_DISPLAYS:* = 120;
      
      private static const NUM_NEAR_DISPLAYS_TO_SHOW_SUPPORT:* = 3;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnRefresh:Sprite;
      
      public var mcContactSupportHitArea:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtDesc:TextField;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnRefresh:BMButton;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenLostConnection()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("connectionLost");
      }
      
      public function refreshScreen() : void
      {
         var _loc3_:Function = null;
         if(this._firstRefresh)
         {
            this.txtTitle.text = getScreenText("oops");
            screensM.createButtonFromSizer(BMScreensManager.SCR_LOST_CONNECTION,"btnBack","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_LOST_CONNECTION,"btnRefresh","regular");
            _loc3_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc3_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc3_,dataM.runAsMobile);
            this.btnRefresh.initialize(getScreenText("refresh"),"blue",null,null,_loc3_,dataM.runAsMobile);
            this._firstRefresh = false;
         }
         var _loc1_:Boolean = this.updateShowContactSupportMode();
         var _loc2_:String = BMLoginManager.gi().consumeNextDisconnectDescriptionMessage();
         if(_loc1_)
         {
            updateTextAndFormat(this.txtDesc,getScreenText("somethingWentWrong"));
            if(this.mcContactSupportHitArea.parent == null)
            {
               addChild(this.mcContactSupportHitArea);
            }
            if(dataM.runAsMobile == false)
            {
               this.mcContactSupportHitArea.addEventListener(MouseEvent.CLICK,this.contactSupportClicked);
               this.mcContactSupportHitArea.buttonMode = true;
               this.mcContactSupportHitArea.useHandCursor = true;
            }
         }
         else
         {
            if(_loc2_ != null)
            {
               this.txtDesc.htmlText = _loc2_;
            }
            else
            {
               updateTextAndFormat(this.txtDesc,getScreenText("networkError"));
            }
            if(this.mcContactSupportHitArea.parent != null)
            {
               this.mcContactSupportHitArea.parent.removeChild(this.mcContactSupportHitArea);
            }
            if(dataM.runAsMobile == false)
            {
               this.mcContactSupportHitArea.removeEventListener(MouseEvent.CLICK,this.contactSupportClicked);
            }
         }
         this.btnBack.visible = false;
         dataM.trackEvent(2,"Connection","Lost",null,_numNearDisplays);
         trace("Showing lost connection screen with " + _numNearDisplays.toString() + " recent instances");
         BMLoginManager.gi().disconnect();
      }
      
      private function updateShowContactSupportMode() : Boolean
      {
         var _loc3_:int = 0;
         var _loc1_:Boolean = false;
         var _loc2_:int = getTimer();
         if(_lastDisplayTime != 0)
         {
            _loc3_ = (_loc2_ - _lastDisplayTime) / 1000;
            if(_loc3_ < MAX_SECONDS_BETWEEN_NEAR_DISPLAYS)
            {
               _loc1_ = true;
            }
         }
         _lastDisplayTime = _loc2_;
         if(_loc1_)
         {
            _numNearDisplays += 1;
         }
         else
         {
            _numNearDisplays = 1;
         }
         return _numNearDisplays >= NUM_NEAR_DISPLAYS_TO_SHOW_SUPPORT;
      }
      
      private function contactSupportClicked(param1:MouseEvent) : void
      {
         this.contactSupportClickedSub();
      }
      
      public function contactSupportClickedSub() : void
      {
         dataM.openSupportForm("Lost Connection Support");
      }
      
      public function backClicked() : void
      {
         this.removeMe();
         screensM.forceBackToLoginScreenSub();
      }
      
      public function removeMe() : void
      {
         if(dataM.runAsMobile == false)
         {
            this.mcContactSupportHitArea.removeEventListener(MouseEvent.CLICK,this.contactSupportClicked);
         }
         screensM.removeScreen(BMScreensManager.SCR_LOST_CONNECTION);
      }
   }
}

