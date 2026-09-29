package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureK;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol430")]
   public class BMScreenMorePaymentOptions extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtFreeTokens:TextField;
      
      public var btnBack:BMButton_pictureK;
      
      public var mcHitAreaFortumo:Sprite;
      
      public var mcHitAreaDAO:Sprite;
      
      public var mcHitAreaSuperSonic:Sprite;
      
      public var mcHitAreaPersonaly:Sprite;
      
      public var mcFrameFortumo:MovieClip;
      
      public var mcFrameDAO:MovieClip;
      
      public var mcFrameSuperSonic:MovieClip;
      
      public var mcFramePersonaly:MovieClip;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenMorePaymentOptions()
      {
         super();
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMScreenMorePaymentOptions initializing");
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("buyTokens");
      }
      
      public function refreshScreen() : void
      {
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenMorePaymentOptions","btnBack","pictureK");
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.mcHitAreaFortumo.addEventListener(MouseEvent.CLICK,this.fortumoClicked);
            this.mcHitAreaFortumo.addEventListener(MouseEvent.MOUSE_OVER,this.fortumoMouseOver);
            this.mcHitAreaFortumo.addEventListener(MouseEvent.MOUSE_OUT,this.fortumoMouseOut);
            this.mcHitAreaDAO.addEventListener(MouseEvent.CLICK,this.DAOClicked);
            this.mcHitAreaDAO.addEventListener(MouseEvent.MOUSE_OVER,this.DAOMouseOver);
            this.mcHitAreaDAO.addEventListener(MouseEvent.MOUSE_OUT,this.DAOMouseOut);
            this.mcHitAreaSuperSonic.addEventListener(MouseEvent.CLICK,this.superSonicClicked);
            this.mcHitAreaSuperSonic.addEventListener(MouseEvent.MOUSE_OVER,this.superSonicMouseOver);
            this.mcHitAreaSuperSonic.addEventListener(MouseEvent.MOUSE_OUT,this.superSonicMouseOut);
            this.mcHitAreaPersonaly.addEventListener(MouseEvent.CLICK,this.personalyClicked);
            this.mcHitAreaPersonaly.addEventListener(MouseEvent.MOUSE_OVER,this.personalyMouseOver);
            this.mcHitAreaPersonaly.addEventListener(MouseEvent.MOUSE_OUT,this.personalyMouseOut);
            this.mcHitAreaFortumo.buttonMode = true;
            this.mcHitAreaFortumo.useHandCursor = true;
            this.mcHitAreaDAO.buttonMode = true;
            this.mcHitAreaDAO.useHandCursor = true;
            this.mcHitAreaSuperSonic.buttonMode = true;
            this.mcHitAreaSuperSonic.useHandCursor = true;
            this.mcHitAreaPersonaly.buttonMode = true;
            this.mcHitAreaPersonaly.useHandCursor = true;
            this.txtTitle.text = getSpecificText("buyTokens_moreOptions");
            this.txtFreeTokens.text = getSpecificText("buyTokens_freeTokens");
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         dataM.trackScreenView("morePaymentOptions");
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtFreeTokens,20);
         }
      }
      
      private function fortumoClicked(param1:MouseEvent) : void
      {
         dataM.openBuyTokensPage_fortumo();
      }
      
      private function fortumoMouseOver(param1:MouseEvent) : void
      {
         this.mcFrameFortumo.gotoAndStop("mouseOver");
      }
      
      private function fortumoMouseOut(param1:MouseEvent) : void
      {
         this.mcFrameFortumo.gotoAndStop("mouseOut");
      }
      
      private function DAOClicked(param1:MouseEvent) : void
      {
         dataM.openBuyTokensPage_dao();
      }
      
      private function DAOMouseOver(param1:MouseEvent) : void
      {
         this.mcFrameDAO.gotoAndStop("mouseOver");
      }
      
      private function DAOMouseOut(param1:MouseEvent) : void
      {
         this.mcFrameDAO.gotoAndStop("mouseOut");
      }
      
      private function superSonicClicked(param1:MouseEvent) : void
      {
         dataM.openURL("http://supermechs.com/ssonic.php","_iframe");
      }
      
      private function superSonicMouseOver(param1:MouseEvent) : void
      {
         this.mcFrameSuperSonic.gotoAndStop("mouseOver");
      }
      
      private function superSonicMouseOut(param1:MouseEvent) : void
      {
         this.mcFrameSuperSonic.gotoAndStop("mouseOut");
      }
      
      private function personalyClicked(param1:MouseEvent) : void
      {
         dataM.openURL("https://persona.ly/widget/?appid=18fdc375794b741a94c6cfae23353143&userid=" + dataM.userID,"_iframe");
      }
      
      private function personalyMouseOver(param1:MouseEvent) : void
      {
         this.mcFramePersonaly.gotoAndStop("mouseOver");
      }
      
      private function personalyMouseOut(param1:MouseEvent) : void
      {
         this.mcFramePersonaly.gotoAndStop("mouseOut");
      }
      
      public function backClicked() : void
      {
         this.mcHitAreaFortumo.removeEventListener(MouseEvent.CLICK,this.fortumoClicked);
         this.mcHitAreaFortumo.removeEventListener(MouseEvent.MOUSE_OVER,this.fortumoMouseOver);
         this.mcHitAreaFortumo.removeEventListener(MouseEvent.MOUSE_OUT,this.fortumoMouseOut);
         this.mcHitAreaDAO.removeEventListener(MouseEvent.CLICK,this.DAOClicked);
         this.mcHitAreaDAO.removeEventListener(MouseEvent.MOUSE_OVER,this.DAOMouseOver);
         this.mcHitAreaDAO.removeEventListener(MouseEvent.MOUSE_OUT,this.DAOMouseOut);
         this.mcHitAreaSuperSonic.removeEventListener(MouseEvent.CLICK,this.superSonicClicked);
         this.mcHitAreaSuperSonic.removeEventListener(MouseEvent.MOUSE_OVER,this.superSonicMouseOver);
         this.mcHitAreaSuperSonic.removeEventListener(MouseEvent.MOUSE_OUT,this.superSonicMouseOut);
         this.mcHitAreaPersonaly.removeEventListener(MouseEvent.CLICK,this.personalyClicked);
         this.mcHitAreaPersonaly.removeEventListener(MouseEvent.MOUSE_OVER,this.personalyMouseOver);
         this.mcHitAreaPersonaly.removeEventListener(MouseEvent.MOUSE_OUT,this.personalyMouseOut);
         screensM.removeScreen("screenMorePaymentOptions");
      }
   }
}

