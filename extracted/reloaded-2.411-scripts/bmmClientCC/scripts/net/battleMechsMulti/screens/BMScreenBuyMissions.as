package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureA;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol525")]
   public class BMScreenBuyMissions extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnBuy1:Sprite;
      
      public var mcSizer_btnBuy6:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtBuyMission1:TextField;
      
      public var txtBuyMission6:TextField;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnBuy1:BMButton_pictureA;
      
      public var btnBuy6:BMButton_pictureA;
      
      public var buttonIcons:MovieClip;
      
      public var mcKeyHard1:Sprite;
      
      public var mcKeyHard2:Sprite;
      
      public var mcKeyInsane1:Sprite;
      
      public var mcKeyInsane2:Sprite;
      
      private var _difficulty:uint;
      
      private var _lastCostTokens:uint;
      
      private var _lastAmount:uint;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenBuyMissions()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("buyMissions");
      }
      
      public function refreshScreen(param1:uint) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenBuyMissions","btnBack","pictureE");
            screensM.createButtonFromSizer("screenBuyMissions","btnBuy1","pictureA");
            screensM.createButtonFromSizer("screenBuyMissions","btnBuy6","pictureA");
            _loc2_ = this.backClicked;
            _loc3_ = this.buy1Clicked;
            _loc4_ = this.buy6Clicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,dataM.runAsMobile);
            this.btnBuy1.initialize("","",null,null,_loc3_,dataM.runAsMobile);
            this.btnBuy6.initialize("","",null,null,_loc4_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBuy1.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBuy6.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this.buttonIcons.mouseEnabled = false;
            this.buttonIcons.mouseChildren = false;
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            this.languageUpdate();
         }
         this._difficulty = param1;
         if(this._difficulty == 2)
         {
            this.buttonIcons.txtCost1.text = String(dataM.missionBuy1HardTokensCost);
            this.buttonIcons.txtCost6.text = String(dataM.missionBuy6HardTokensCost);
            this.mcKeyHard1.visible = true;
            this.mcKeyHard2.visible = true;
            this.mcKeyInsane1.visible = false;
            this.mcKeyInsane2.visible = false;
         }
         else
         {
            this.buttonIcons.txtCost1.text = String(dataM.missionBuy1InsaneTokensCost);
            this.buttonIcons.txtCost6.text = String(dataM.missionBuy6InsaneTokensCost);
            this.mcKeyInsane1.visible = true;
            this.mcKeyInsane2.visible = true;
            this.mcKeyHard1.visible = false;
            this.mcKeyHard2.visible = false;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyMissions_prices",[this.buttonIcons.txtCost1,this.buttonIcons.txtCost6],"",this.buttonIcons);
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         this.txtTitle.text = getScreenText("title");
         this.txtBuyMission1.text = "1";
         this.txtBuyMission6.text = "6";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("buyMissions_texts",[this.txtTitle,this.txtBuyMission1,this.txtBuyMission6],"",this);
         }
      }
      
      public function buy1Clicked() : void
      {
         if(this._difficulty == 2)
         {
            this._lastCostTokens = dataM.missionBuy1HardTokensCost;
         }
         else
         {
            this._lastCostTokens = dataM.missionBuy1InsaneTokensCost;
         }
         this._lastAmount = 1;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.tokens >= this._lastCostTokens)
         {
            remoteM.socketM.mission_buyMissions(this._difficulty,1);
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("notEnoughTokens",this._lastCostTokens);
         }
      }
      
      public function buy6Clicked() : void
      {
         if(this._difficulty == 2)
         {
            this._lastCostTokens = dataM.missionBuy6HardTokensCost;
         }
         else
         {
            this._lastCostTokens = dataM.missionBuy6InsaneTokensCost;
         }
         this._lastAmount = 6;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.tokens >= this._lastCostTokens)
         {
            remoteM.socketM.mission_buyMissions(this._difficulty,6);
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("notEnoughTokens",this._lastCostTokens);
         }
      }
      
      public function notEnoughTokens() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("notEnoughTokens",this._lastCostTokens);
         this.backClicked();
      }
      
      public function missionsBought(param1:String) : void
      {
      }
      
      public function backClicked() : void
      {
         screensM.screenMissionWorldMap.unlockMap();
         screensM.removeScreen("screenBuyMissions");
      }
   }
}

