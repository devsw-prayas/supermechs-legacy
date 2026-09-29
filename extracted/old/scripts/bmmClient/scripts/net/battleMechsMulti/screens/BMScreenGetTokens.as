package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol860")]
   public class BMScreenGetTokens extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnFreeTokens:Sprite;
      
      public var mcSizer_btnBuyTokens:Sprite;
      
      public var mcSizer_sparks1:Sprite;
      
      public var mcSizer_sparks2:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnFreeTokens:BMButton;
      
      public var btnBuyTokens:BMButton;
      
      public var txtTitle:TextField;
      
      public var txtNotEnoughTokens:TextField;
      
      public var mcTokenPiles:Sprite;
      
      private var _tokenPilesOriginYPos:Number;
      
      private var _sparks:Array = new Array();
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenGetTokens()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:Number, param2:Number = 0, param3:String = "package") : void
      {
         var _loc5_:String = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         var _loc9_:BMBoostData = null;
         var _loc10_:uint = 0;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("getTokens");
            screensM.createButtonFromSizer("screenGetTokens","btnFreeTokens","regular");
            screensM.createButtonFromSizer("screenGetTokens","btnBuyTokens","regular");
            screensM.createButtonFromSizer("screenGetTokens","btnBack","pictureE");
            _loc6_ = this.freeTokensClicked;
            _loc7_ = this.buyTokensClicked;
            _loc8_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc6_ = null;
               _loc7_ = null;
               _loc8_ = null;
            }
            switch(dataM.languageID)
            {
               case 3:
                  this.btnFreeTokens.changeFontSize(20);
                  this.btnBuyTokens.changeFontSize(20);
                  break;
               case 5:
                  this.btnFreeTokens.changeFontSize(24);
                  this.btnBuyTokens.changeFontSize(24);
                  break;
               case 6:
                  this.btnFreeTokens.changeFontSize(20);
                  this.btnBuyTokens.changeFontSize(20);
                  break;
               case 7:
                  this.btnFreeTokens.changeFontSize(20);
                  this.btnBuyTokens.changeFontSize(20);
                  break;
               case 9:
                  this.btnFreeTokens.changeFontSize(26);
                  this.btnBuyTokens.changeFontSize(22);
                  break;
               case 10:
                  this.btnFreeTokens.changeFontSize(19);
                  this.btnBuyTokens.changeFontSize(17);
                  break;
               default:
                  this.btnFreeTokens.changeFontSize(26);
                  this.btnBuyTokens.changeFontSize(26);
            }
            this.btnFreeTokens.initialize(getScreenText("freeTokens"),"orange",null,null,_loc6_,dataM.runAsMobile);
            this.btnBuyTokens.initialize(getScreenText("buyTokens"),"orange",null,null,_loc7_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,dataM.runAsMobile);
            this.btnFreeTokens.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBuyTokens.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this._tokenPilesOriginYPos = this.mcTokenPiles.y;
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         var _loc4_:uint = 0;
         if(param2 > 0)
         {
            _loc4_ = param2;
         }
         else if(param1 > 0)
         {
            _loc9_ = dataM.boostsDB[param1];
            _loc4_ = _loc9_.costTokens;
         }
         switch(param3)
         {
            case "package":
               _loc5_ = getSpecificText("confirmation_notEnoughTokens");
               _loc5_ = dataM.replaceStringInText(_loc5_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>");
               _loc5_ = dataM.replaceStringInText(_loc5_,"%TOKENS%",String(_loc4_));
               break;
            case "shopItem":
               _loc5_ = getSpecificText("confirmation_notEnoughTokens_shopItem");
               _loc5_ = dataM.replaceStringInText(_loc5_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_TOKENS + "\'>");
               _loc5_ = dataM.replaceStringInText(_loc5_,"%TOKENS%",String(_loc4_));
               break;
            case "topBarClicked":
            case "autoDisplay":
               _loc5_ = "";
         }
         this.txtNotEnoughTokens.htmlText = _loc5_;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("getTokens_notEnoughTokens",[this.txtNotEnoughTokens],"",this);
         }
         if(_loc5_ == "")
         {
            _loc10_ = 21;
            this.mcTokenPiles.y = this._tokenPilesOriginYPos - _loc10_;
            this.btnBuyTokens.y = this.mcSizer_btnBuyTokens.y - _loc10_;
            this.btnFreeTokens.y = this.mcSizer_btnFreeTokens.y - _loc10_;
         }
         else
         {
            this.mcTokenPiles.y = this._tokenPilesOriginYPos;
            this.btnBuyTokens.y = this.mcSizer_btnBuyTokens.y;
            this.btnFreeTokens.y = this.mcSizer_btnFreeTokens.y;
         }
         dataM.trackScreenView("getTokens");
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtNotEnoughTokens,20);
            TextUtils.updateTextFormat(this.btnBuyTokens.txtButtonName);
            TextUtils.updateTextFormat(this.btnFreeTokens.txtButtonName);
            param1 = true;
         }
         if(param1)
         {
            switch(dataM.languageID)
            {
               case 3:
                  this.btnFreeTokens.changeFontSize(20);
                  this.btnBuyTokens.changeFontSize(20);
                  break;
               case 5:
                  this.btnFreeTokens.changeFontSize(24);
                  this.btnBuyTokens.changeFontSize(24);
                  break;
               case 6:
                  this.btnFreeTokens.changeFontSize(20);
                  this.btnBuyTokens.changeFontSize(20);
                  break;
               case 7:
                  this.btnFreeTokens.changeFontSize(20);
                  this.btnBuyTokens.changeFontSize(20);
                  break;
               case 9:
                  this.btnFreeTokens.changeFontSize(26);
                  this.btnBuyTokens.changeFontSize(22);
                  break;
               case 10:
                  this.btnFreeTokens.changeFontSize(19);
                  this.btnBuyTokens.changeFontSize(17);
                  break;
               default:
                  this.btnFreeTokens.changeFontSize(26);
                  this.btnBuyTokens.changeFontSize(26);
            }
            this.btnFreeTokens.setButtonName(getScreenText("freeTokens"));
            this.btnBuyTokens.setButtonName(getScreenText("buyTokens"));
         }
         this.txtTitle.text = getScreenText("title");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("getTokens_title",[this.txtTitle],"",this);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.sparksHandler();
         }
      }
      
      private function sparksHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Sprite = null;
         var _loc4_:Sprite = null;
         var _loc5_:Sprite = null;
         _loc1_ = 1;
         while(_loc1_ <= 2)
         {
            _loc2_ = Math.ceil(Math.random() * 15);
            if(_loc2_ == 1)
            {
               _loc3_ = externalAssetsM.getAsset("general","Grp_itemCardSpark4");
               _loc4_ = this["mcSizer_sparks" + _loc1_];
               _loc3_.x = _loc4_.x + Math.random() * _loc4_.width;
               _loc3_.y = _loc4_.y + Math.random() * _loc4_.height;
               this.mcButtonsHolder.addChild(_loc3_);
               this._sparks.push(_loc3_);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._sparks.length)
         {
            _loc5_ = this._sparks[_loc1_];
            if(_loc5_.scaleX > 0.075)
            {
               _loc5_.scaleX -= 0.075;
               _loc5_.scaleY -= 0.075;
            }
            else
            {
               this._sparks[_loc1_].parent.removeChild(this._sparks[_loc1_]);
               this._sparks[_loc1_] = null;
               this._sparks.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      public function freeTokensClicked() : void
      {
         dataM.openBuyTokensPage("ScreenGetTokensFreeTokens");
         this.backClicked();
      }
      
      public function buyTokensClicked() : void
      {
         dataM.openBuyTokensPage("ScreenGetTokensBuyTokens");
         this.backClicked();
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen("screenGetTokens");
      }
   }
}

