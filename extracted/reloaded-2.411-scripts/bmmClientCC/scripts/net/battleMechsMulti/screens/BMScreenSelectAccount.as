package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.tacticsoft.responders.events.ExternalLoginConflictUser;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol742")]
   public class BMScreenSelectAccount extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnUser1:Sprite;
      
      public var mcSizer_btnUser2:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnUser1:BMButton;
      
      public var btnUser2:BMButton;
      
      public var txtTitle:TextField;
      
      public var txtDesc:TextField;
      
      public var txtUsername1:TextField;
      
      public var txtUsername2:TextField;
      
      public var txtLevel1:TextField;
      
      public var txtLevel2:TextField;
      
      private var _firstRefresh:Boolean = true;
      
      private var _selectedPlayerID:Number;
      
      private var _currentPlayer:ExternalLoginConflictUser;
      
      private var _newPlayer:ExternalLoginConflictUser;
      
      public function BMScreenSelectAccount()
      {
         super();
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMScreenSelectAccount :: initialized");
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("selectAccount");
         screensM.createButtonFromSizer("screenSelectAccount","btnBack","pictureE");
         screensM.createButtonFromSizer("screenSelectAccount","btnUser1","regular");
         screensM.createButtonFromSizer("screenSelectAccount","btnUser2","regular");
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,false);
         this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.txtTitle.text = getScreenText("title");
         var _loc1_:String = getScreenText("desc");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR%","<FONT COLOR=\'#ff0000\'>");
         this.txtDesc.htmlText = _loc1_;
      }
      
      public function setData(param1:ExternalLoginConflictUser, param2:ExternalLoginConflictUser) : *
      {
         TsLogger.log("BMScreenSelectAccount :: setData");
         this._currentPlayer = param1;
         this._newPlayer = param2;
         this.txtUsername1.text = param1.name;
         this.txtUsername2.text = param2.name;
         var _loc3_:String = getScreenText("level");
         _loc3_ = dataM.replaceStringInText(_loc3_,"%LEVEL%",String(param1.level));
         this.txtLevel1.text = _loc3_;
         var _loc4_:String = getScreenText("level");
         _loc4_ = dataM.replaceStringInText(_loc4_,"%LEVEL%",String(param2.level));
         this.txtLevel2.text = _loc4_;
         this.btnUser1.initialize(getScreenText("select"),"green",null,[param1.playerID],this.userClicked,false);
         this.btnUser2.initialize(getScreenText("select"),"green",null,[param2.playerID],this.userClicked,false);
      }
      
      private function userClicked(param1:Number) : void
      {
         var _loc2_:ExternalLoginConflictUser = null;
         var _loc3_:ExternalLoginConflictUser = null;
         TsLogger.log("BMScreenSelectAccount :: userClicked USER " + param1 + " SELECTED");
         this._selectedPlayerID = param1;
         if(this._selectedPlayerID == this._currentPlayer.playerID)
         {
            _loc2_ = this._currentPlayer;
            _loc3_ = this._newPlayer;
         }
         else
         {
            _loc2_ = this._newPlayer;
            _loc3_ = this._currentPlayer;
         }
         var _loc4_:String = getScreenText("selectConfirmation");
         _loc4_ = dataM.replaceStringInText(_loc4_,"%NAME1%",_loc2_.name);
         _loc4_ = dataM.replaceStringInText(_loc4_,"%LEVEL1%",String(_loc2_.level));
         _loc4_ = dataM.replaceStringInText(_loc4_,"%NAME2%",_loc3_.name);
         _loc4_ = dataM.replaceStringInText(_loc4_,"%LEVEL2%",String(_loc3_.level));
         screensM.screenConfirmation.displayCustomYesNoQuestion(_loc4_,this.onConfirm);
      }
      
      private function onConfirm(param1:Boolean) : void
      {
         if(param1)
         {
            BMLoginManager.gi().externalLoginResolveConflict(this._selectedPlayerID);
            screensM.removeScreen("screenSelectAccount");
         }
      }
      
      public function backClicked() : void
      {
         TsLogger.log("BMScreenSelectAccount :: backClicked");
         BMLoginManager.gi().externalLoginCancelConflict();
         screensM.removeScreen("screenSelectAccount");
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.backClicked();
      }
   }
}

