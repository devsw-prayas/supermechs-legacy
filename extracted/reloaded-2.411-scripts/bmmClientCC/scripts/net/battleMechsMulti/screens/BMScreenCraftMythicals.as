package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1525")]
   public class BMScreenCraftMythicals extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtResult:TextField;
      
      public var txtPower:TextField;
      
      public var txtDurability:TextField;
      
      public var txtNotEnoughPower:TextField;
      
      public var txtGuide:TextField;
      
      public var mcMarker:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnCraft:Sprite;
      
      public var mcSizer_btnType_torso:Sprite;
      
      public var mcSizer_btnType_leg:Sprite;
      
      public var mcSizer_btnType_sideWeapon:Sprite;
      
      public var mcSizer_btnType_topWeapon:Sprite;
      
      public var mcSizer_btnType_special:Sprite;
      
      public var mcSizer_btnType_module:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnCraft:BMButton;
      
      public var btnType_torso:BMButton_pictureE;
      
      public var btnType_leg:BMButton_pictureE;
      
      public var btnType_sideWeapon:BMButton_pictureE;
      
      public var btnType_topWeapon:BMButton_pictureE;
      
      public var btnType_special:BMButton_pictureE;
      
      public var btnType_module:BMButton_pictureE;
      
      private var _resultTextOriginYPos:Number;
      
      private var _guideTextOriginYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      private var _selectedType:String;
      
      public function BMScreenCraftMythicals()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("craftMythicals");
            screensM.createButtonFromSizer("screenCraftMythicals","btnBack","pictureE");
            screensM.createButtonFromSizer("screenCraftMythicals","btnCraft","regular");
            screensM.createButtonFromSizer("screenCraftMythicals","btnType_torso","pictureE");
            screensM.createButtonFromSizer("screenCraftMythicals","btnType_leg","pictureE");
            screensM.createButtonFromSizer("screenCraftMythicals","btnType_sideWeapon","pictureE");
            screensM.createButtonFromSizer("screenCraftMythicals","btnType_topWeapon","pictureE");
            screensM.createButtonFromSizer("screenCraftMythicals","btnType_special","pictureE");
            screensM.createButtonFromSizer("screenCraftMythicals","btnType_module","pictureE");
            _loc1_ = 33;
            switch(dataM.languageID)
            {
               case 9:
                  _loc1_ = 17;
                  break;
               case 10:
                  _loc1_ = 26;
            }
            this.btnCraft.changeFontSize(_loc1_);
            _loc2_ = this.backClicked;
            _loc3_ = this.craftClicked;
            _loc4_ = this.typeClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,dataM.runAsMobile);
            this.btnCraft.initialize(getScreenText("craft"),"orange",null,null,_loc3_,dataM.runAsMobile);
            this.btnType_torso.initialize("","",externalAssetsM.getAsset("general","subType_inventory_torso"),["torso"],_loc4_,dataM.runAsMobile);
            this.btnType_leg.initialize("","",externalAssetsM.getAsset("general","subType_inventory_leg"),["leg"],_loc4_,dataM.runAsMobile);
            this.btnType_sideWeapon.initialize("","",externalAssetsM.getAsset("general","subType_inventory_sideWeapon"),["sideWeapon"],_loc4_,dataM.runAsMobile);
            this.btnType_topWeapon.initialize("","",externalAssetsM.getAsset("general","subType_inventory_topWeapon"),["topWeapon"],_loc4_,dataM.runAsMobile);
            this.btnType_special.initialize("","",externalAssetsM.getAsset("general","subType_inventory_special"),["special"],_loc4_,dataM.runAsMobile);
            this.btnType_module.initialize("","",externalAssetsM.getAsset("general","subType_inventory_module"),["module"],_loc4_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCraft.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnType_torso.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnType_leg.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnType_sideWeapon.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnType_topWeapon.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnType_special.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnType_module.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._resultTextOriginYPos = this.txtResult.y;
            this._guideTextOriginYPos = this.txtGuide.y;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this.typeClicked("torso");
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc4_:uint = 0;
         var _loc2_:uint = 16;
         this.txtGuide.y = this._guideTextOriginYPos;
         switch(dataM.languageID)
         {
            case 3:
               _loc2_ = 14;
               this.txtGuide.y = this._guideTextOriginYPos - 5;
               break;
            case 5:
               _loc2_ = 13;
               this.txtGuide.y = this._guideTextOriginYPos + 3;
               break;
            case 9:
               _loc2_ = 15;
               break;
            case 10:
               _loc2_ = 14;
               this.txtGuide.y = this._guideTextOriginYPos - 4;
         }
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtDurability,20);
            TextUtils.updateTextFormat(this.txtGuide,_loc2_);
            TextUtils.updateTextFormat(this.txtNotEnoughPower,20);
            TextUtils.updateTextFormat(this.txtPower,20);
            TextUtils.updateTextFormat(this.txtResult,16);
            TextUtils.updateTextFormat(this.txtTitle,20);
            param1 = true;
         }
         if(param1)
         {
            _loc4_ = 33;
            switch(dataM.languageID)
            {
               case 9:
                  _loc4_ = 17;
                  break;
               case 10:
                  _loc4_ = 26;
            }
            TextUtils.updateTextFormat(this.btnCraft.txtButtonName,_loc4_);
            this.btnCraft.changeFontSize(_loc4_);
            this.btnCraft.setButtonName(getScreenText("craft"));
         }
         this.txtTitle.htmlText = TextUtils.getTextFont() + getScreenText("title");
         var _loc3_:String = getScreenText("guide");
         _loc3_ = dataM.replaceStringInText(_loc3_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
         _loc3_ = dataM.replaceStringInText(_loc3_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
         _loc3_ = dataM.replaceStringInText(_loc3_,"%COLOR3%","<FONT COLOR=\'#" + dataM.COLOR_BAD + "\'>");
         this.txtGuide.htmlText = TextUtils.getTextFont(_loc2_) + _loc3_;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("craftMythicals_title",[this.txtTitle,this.txtGuide],"",this);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
      }
      
      public function typeClicked(param1:String) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         this._selectedType = param1;
         this.mcMarker.x = this["mcSizer_btnType_" + this._selectedType].x;
         this.mcMarker.y = this["mcSizer_btnType_" + this._selectedType].y;
         var _loc2_:Number = screensM.screenHangerFusion.getSourceItemsPower();
         if(_loc2_ > 99999)
         {
            this.txtPower.htmlText = TextUtils.getTextFont() + "<FONT COLOR=\'#" + dataM.COLOR_RARE_ITEM + "\'>" + dataM.getNumberWithComma(_loc2_) + "</FONT>";
         }
         else
         {
            this.txtPower.htmlText = TextUtils.getTextFont() + "<FONT COLOR=\'#" + dataM.COLOR_RARE_ITEM + "\'>" + dataM.getNumberWithComma(_loc2_) + "</FONT>  " + getGeneralText("power");
         }
         var _loc3_:Number = Number(dataM["craftPower_" + this._selectedType]);
         if(_loc2_ >= _loc3_)
         {
            _loc4_ = Math.floor(_loc2_ / _loc3_);
            _loc5_ = getScreenText("craft_" + this._selectedType);
            _loc5_ = dataM.replaceStringInText(_loc5_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
            _loc5_ = dataM.replaceStringInText(_loc5_,"%DURABILITY%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + _loc4_ + "</FONT>");
            this.txtResult.htmlText = TextUtils.getTextFont() + _loc5_;
            this.btnCraft.visible = true;
            this.txtDurability.htmlText = TextUtils.getTextFont() + "<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + _loc4_ + "</FONT>  " + getSpecificText("tooltip_durability");
            this.txtNotEnoughPower.text = "";
         }
         else
         {
            this.txtResult.htmlText = TextUtils.getTextFont() + "Minimum of <FONT COLOR=\'#" + dataM.COLOR_RARE_ITEM + "\'>" + _loc3_ + "</FONT> Power required";
            this.txtNotEnoughPower.text = getScreenText("notEnoughPower");
            this.txtDurability.htmlText = TextUtils.getTextFont() + "<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>0</FONT>";
            this.btnCraft.visible = false;
         }
         switch(this.txtResult.numLines)
         {
            case 1:
               this.txtResult.y = this._resultTextOriginYPos + 13;
               break;
            default:
               this.txtResult.y = this._resultTextOriginYPos;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("craftMythicals_result",[this.txtResult,this.txtPower,this.txtDurability,this.txtNotEnoughPower],"",this);
         }
      }
      
      public function craftClicked() : void
      {
         remoteM.lobby_craftMythical(screensM.screenHangerFusion.getFinalSourcePlayerItemIDs(),this._selectedType);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      public function craftMythicalSuccess(param1:Number, param2:Number, param3:uint, param4:Number, param5:uint) : void
      {
         dataM.addPlayerItemDataToInventory(dataM.player1PlayerID,param2,param1,0,0,param4);
         var _loc6_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
         _loc6_.colorID = param3;
         _loc6_.durability = param5;
         screensM.addScreen("screenMythicalCrafted");
         screensM.screenMythicalCrafted.refreshScreen(param1);
         this.removeMe();
      }
      
      public function craftingFailed() : void
      {
         this.removeMe();
         screensM.screenConfirmation.displayQuestionOrNotification("craftingFailed");
      }
      
      public function backClicked() : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen("screenCraftMythicals");
      }
   }
}

