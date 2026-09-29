package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol816")]
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
      }
      
      public function refreshScreen() : void
      {
         var _loc2_:Function = null;
         if(this._firstRefresh)
         {
            this.txtTitle.text = "OOPS!";
            screensM.createButtonFromSizer("screenLostConnection","btnBack","pictureE");
            screensM.createButtonFromSizer("screenLostConnection","btnRefresh","regular");
            _loc2_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,dataM.runAsMobile);
            this.btnRefresh.initialize("REFRESH","blue",null,null,_loc2_,dataM.runAsMobile);
            this._firstRefresh = false;
         }
         var _loc1_:Boolean = this.updateShowContactSupportMode();
         if(_loc1_)
         {
            this.txtDesc.htmlText = "Something went wrong.<BR>Having trouble? <FONT COLOR=\'#00CCFF\'>CONTACT SUPPORT</FONT>";
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
            this.txtDesc.htmlText = "Network error<BR>Please check your internet connection.";
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
         dataM.trackEvent("Connection","Lost",null,_numNearDisplays);
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
         dataM.emailSupport();
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
         screensM.removeScreen("screenLostConnection");
      }
   }
}

