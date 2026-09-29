package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1613")]
   public class BMScreenAdminTools extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var txtGiftsInfo:TextField;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcSizer_item1:Sprite;
      
      public var mcSizer_item2:Sprite;
      
      public var mcSizer_btnSendBoosts:Sprite;
      
      public var mcSizer_btnSendItem:Sprite;
      
      public var mcSizer_btnOldShop:Sprite;
      
      public var mcSizer_btnMechGenerator:Sprite;
      
      public var mcSizer_btnAlertServerRestart:Sprite;
      
      public var mcSizer_btnForceItemsUpdate:Sprite;
      
      public var txtSelectedPackageName:TextField;
      
      public var txtInputTokensCost:TextField;
      
      public var txtInputRare:TextField;
      
      public var txtInputEpic:TextField;
      
      public var txtInputLegendary:TextField;
      
      public var txtInputMythical:TextField;
      
      public var txtInputNewMythical:TextField;
      
      public var txtInputResetTime:TextField;
      
      public var txtInputItemID:TextField;
      
      public var txtInputPlayerID:TextField;
      
      public var txtInputSendBoostID:TextField;
      
      public var txtInputSendBoostAmount:TextField;
      
      public var txtInputSendItemID:TextField;
      
      public var txtInputSendItemPower:TextField;
      
      public var txtInputAlertServerRestart:TextField;
      
      public var txtTextItemID:TextField;
      
      public var txtTextRare:TextField;
      
      public var txtTextEpic:TextField;
      
      public var txtTextLegendary:TextField;
      
      public var txtTextMythical:TextField;
      
      public var txtTextNewMythical:TextField;
      
      public var txtDefault_tokens:TextField;
      
      public var txtDefault_rare:TextField;
      
      public var txtDefault_epic:TextField;
      
      public var txtDefault_legendary:TextField;
      
      public var txtDefault_mythical:TextField;
      
      public var txtDefault_newMythical:TextField;
      
      public var mcBlock_all:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnUpdateBoost:Sprite;
      
      public var mcSizer_btnActivateReset:Sprite;
      
      public var mcSizer_btnResetRateBox:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnUpdateBoost:BMButton;
      
      public var btnActivateReset:BMButton;
      
      public var btnResetRateBox:BMButton_pictureE;
      
      public var btnSendBoosts:BMButton_pictureE;
      
      public var btnSendItem:BMButton_pictureE;
      
      public var btnOldShop:BMButton_pictureE;
      
      public var btnMechGenerator:BMButton_pictureE;
      
      public var btnAlertServerRestart:BMButton;
      
      public var btnForceItemsUpdate:BMButton;
      
      public var boostResetTime:Number;
      
      private var _giftsData:Object;
      
      private var _selectedBoostID:uint;
      
      private var _targetBoostIDs:Array;
      
      private var _packagesNames:Array;
      
      private var _firstRefresh:Boolean = true;
      
      private var _itemID:Number = 0;
      
      private var _sendItemLastItemID:Number = 0;
      
      private var boostsTileList:BMTileList;
      
      private var itemTileListItem1:BMTileListItem;
      
      private var itemTileListItem2:BMTileListItem;
      
      private const TILE_LIST_ROW_WIDTH:uint = 400;
      
      private const TILE_LIST_ROW_HEIGHT:uint = 25;
      
      private const TOKENS_MIN_DISCOUNT:Number = 0.5;
      
      private const LEGENDARY_MAX:Number = 100;
      
      private const MYTHICAL_MAX:Number = 70;
      
      private const NEW_MYTHICAL_MAX:Number = 70;
      
      public function BMScreenAdminTools()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenAdminTools","btnBack","pictureE");
            screensM.createButtonFromSizer("screenAdminTools","btnUpdateBoost","regular");
            screensM.createButtonFromSizer("screenAdminTools","btnActivateReset","regular");
            screensM.createButtonFromSizer("screenAdminTools","btnResetRateBox","pictureE");
            screensM.createButtonFromSizer("screenAdminTools","btnSendBoosts","pictureE");
            screensM.createButtonFromSizer("screenAdminTools","btnSendItem","pictureE");
            screensM.createButtonFromSizer("screenAdminTools","btnOldShop","pictureE");
            screensM.createButtonFromSizer("screenAdminTools","btnMechGenerator","pictureE");
            screensM.createButtonFromSizer("screenAdminTools","btnAlertServerRestart","regular");
            screensM.createButtonFromSizer("screenAdminTools","btnForceItemsUpdate","regular");
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,dataM.runAsMobile);
            this.btnUpdateBoost.initialize("UPDATE","green",null,null,this.updateBoostClicked,dataM.runAsMobile);
            this.btnActivateReset.initialize("SET RESET","green",null,null,this.activateResetClicked,dataM.runAsMobile);
            this.btnResetRateBox.initialize("","",null,null,this.resetRateBoxClicked,dataM.runAsMobile);
            this.btnSendBoosts.initialize("","",null,null,this.sendBoostsClicked,dataM.runAsMobile);
            this.btnSendItem.initialize("","",null,null,this.sendItemClicked,dataM.runAsMobile);
            this.btnOldShop.initialize("","",externalAssetsM.getAsset("general","interface_shop"),null,this.oldShopClicked,dataM.runAsMobile);
            this.btnMechGenerator.initialize("","",externalAssetsM.getAsset("general","interface_mech"),null,this.mechGeneratorClicked,dataM.runAsMobile);
            this.btnAlertServerRestart.initialize("ALERT","green",null,null,this.alertServerRestartClicked,dataM.runAsMobile);
            this.btnForceItemsUpdate.initialize("UPDATE","green",null,null,this.forceItemsUpdateClicked,dataM.runAsMobile);
            this.txtInputTokensCost.restrict = "0123456789";
            this.txtInputRare.restrict = "0123456789";
            this.txtInputEpic.restrict = "0123456789";
            this.txtInputLegendary.restrict = "0123456789";
            this.txtInputMythical.restrict = "0123456789";
            this.txtInputNewMythical.restrict = "0123456789";
            this.txtInputResetTime.restrict = "0123456789";
            this.txtInputItemID.restrict = "0123456789";
            this.txtInputPlayerID.restrict = "0123456789";
            this.txtInputSendBoostID.restrict = "0123456789";
            this.txtInputSendBoostAmount.restrict = "0123456789";
            this.txtInputSendItemID.restrict = "0123456789";
            this.txtInputSendItemPower.restrict = "0123456789";
            this.txtInputAlertServerRestart.restrict = "0123456789";
            this._targetBoostIDs = [5,6,19,20,1,10];
            this._packagesNames = new Array();
            this._packagesNames[5] = "<FONT COLOR=\'#999999\'>Silver Box</FONT>";
            this._packagesNames[6] = "<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>Gold Box</FONT>";
            this._packagesNames[19] = "<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>Mythical Box</FONT>";
            this._packagesNames[20] = "<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>Mythicals Box</FONT>";
            this._packagesNames[2] = "Resources 1";
            this._packagesNames[3] = "Resources 2";
            this._packagesNames[4] = "Resources 3";
            this._packagesNames[1] = "<FONT COLOR=\'#" + dataM.COLOR_GIFT_KEY + "\'>Premium 30</FONT>";
            this._packagesNames[10] = "<FONT COLOR=\'#" + dataM.COLOR_GIFT_KEY + "\'>Premium 7</FONT>";
            this._packagesNames[14] = "Specific Item 1";
            this._packagesNames[15] = "Specific Item 2";
            this._firstRefresh = false;
            this.txtInputTokensCost.addEventListener(Event.CHANGE,this.textInputChanged1);
            this.txtInputRare.addEventListener(Event.CHANGE,this.textInputChanged1);
            this.txtInputEpic.addEventListener(Event.CHANGE,this.textInputChanged1);
            this.txtInputLegendary.addEventListener(Event.CHANGE,this.textInputChanged1);
            this.txtInputMythical.addEventListener(Event.CHANGE,this.textInputChanged1);
            this.txtInputNewMythical.addEventListener(Event.CHANGE,this.textInputChanged1);
            this.txtInputItemID.addEventListener(Event.CHANGE,this.textInputChanged1);
            this.txtInputPlayerID.addEventListener(Event.CHANGE,this.textInputChanged2);
            this.txtInputSendBoostID.addEventListener(Event.CHANGE,this.textInputChanged2);
            this.txtInputSendBoostAmount.addEventListener(Event.CHANGE,this.textInputChanged2);
            this.txtInputSendItemID.addEventListener(Event.CHANGE,this.textInputChanged2);
            this.txtInputSendItemPower.addEventListener(Event.CHANGE,this.textInputChanged2);
         }
         this._sendItemLastItemID = 0;
         this._selectedBoostID = 0;
         this._itemID = 0;
         this.txtSelectedPackageName.text = "";
         if(this.itemTileListItem1 != null)
         {
            this.itemTileListItem1.removeMe();
         }
         if(this.itemTileListItem2 != null)
         {
            this.itemTileListItem2.removeMe();
         }
         this.mcBlock_all.visible = true;
         this.btnSendBoosts.enableMe();
         this.refreshDefaultTexts2();
         remoteM.socketM.admin_getGeneralInfo();
      }
      
      public function gotGeneralData(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc13_:BMBoostData = null;
         var _loc14_:MovieClip = null;
         var _loc15_:BMItem = null;
         var _loc16_:BMTileListItem = null;
         this._giftsData = new Object();
         for each(_loc2_ in param1)
         {
            this._giftsData[_loc2_.settingName] = _loc2_.settingValue;
         }
         _loc3_ = Number(this._giftsData["giftKeysUsed"]);
         _loc4_ = Number(this._giftsData["giftKeysBonus1Claimed"]);
         _loc5_ = Number(this._giftsData["giftKeysBonus2Claimed"]);
         _loc6_ = Number(this._giftsData["giftKeysBonus3Claimed"]);
         _loc7_ = Math.ceil(_loc4_ / _loc3_ * 100);
         _loc8_ = Math.ceil(_loc5_ / _loc3_ * 100);
         _loc9_ = Math.ceil(_loc6_ / _loc3_ * 100);
         _loc10_ = "Gift keys used : " + dataM.getNumberWithComma(_loc3_) + "<BR>Bonus 1 claimed : " + dataM.getNumberWithComma(_loc4_) + " (" + _loc7_ + "%)";
         _loc10_ = _loc10_ + "<BR>Bonus 2 claimed : " + dataM.getNumberWithComma(_loc5_) + " (" + _loc8_ + "%)<BR>Bonus 3 claimed : " + dataM.getNumberWithComma(_loc6_) + " (" + _loc9_ + "%)";
         this.txtGiftsInfo.htmlText = _loc10_;
         if(this.boostsTileList != null)
         {
            this.boostsTileList.removeMe();
            this.boostsTileList = null;
         }
         var _loc11_:Array = new Array();
         var _loc12_:uint = 0;
         while(_loc12_ < this._targetBoostIDs.length)
         {
            _loc13_ = dataM.boostsDB[this._targetBoostIDs[_loc12_]];
            _loc14_ = new mcBoostsListRow();
            _loc14_.txtName.htmlText = this._packagesNames[_loc13_.boostID];
            _loc14_.txtCost.text = String(_loc13_.costTokens);
            _loc14_.txtCostDefault.text = String(_loc13_.costTokensDefault);
            _loc14_.txtBought.text = dataM.getNumberWithComma(_loc13_.bought);
            _loc15_ = new BMItem();
            _loc15_.initialize(_loc13_.boostID,this.TILE_LIST_ROW_WIDTH,this.TILE_LIST_ROW_HEIGHT,_loc14_,0,0,false,null,false);
            _loc16_ = new BMTileListItem();
            _loc16_.initialize(this.TILE_LIST_ROW_WIDTH,this.TILE_LIST_ROW_HEIGHT,_loc15_,"","","",0,this.tileListClicked,null,null,null,null,false);
            _loc11_.push(_loc16_);
            _loc12_++;
         }
         this.boostsTileList = new BMTileList();
         this.boostsTileList.initialize(screensM.stagePointer,_loc11_,6,1,this.TILE_LIST_ROW_WIDTH,this.TILE_LIST_ROW_HEIGHT,null,false,null,null,new mcBoostsListHeader(),false,0,0,false,false,false);
         this.boostsTileList.x = this.mcSizer_tileList.x;
         this.boostsTileList.y = this.mcSizer_tileList.y;
         addChild(this.boostsTileList);
      }
      
      public function tileListClicked(param1:uint, param2:Number) : void
      {
         this._selectedBoostID = param2;
         var _loc3_:BMBoostData = dataM.boostsDB[this._selectedBoostID];
         this.txtSelectedPackageName.text = _loc3_.boostName;
         this.txtInputTokensCost.text = String(_loc3_.costTokens);
         this.mcBlock_all.visible = false;
         if(_loc3_.type == "randomItems")
         {
            this.txtTextItemID.visible = false;
            this.txtInputItemID.visible = false;
            this.txtTextRare.visible = true;
            this.txtTextEpic.visible = true;
            this.txtTextLegendary.visible = true;
            this.txtTextMythical.visible = true;
            this.txtTextNewMythical.visible = true;
            this.txtInputRare.visible = true;
            this.txtInputEpic.visible = true;
            this.txtInputLegendary.visible = true;
            this.txtInputMythical.visible = true;
            this.txtInputNewMythical.visible = true;
            this.txtDefault_rare.visible = true;
            this.txtDefault_epic.visible = true;
            this.txtDefault_legendary.visible = true;
            this.txtDefault_mythical.visible = true;
            this.txtDefault_newMythical.visible = true;
            this.txtInputRare.text = String(_loc3_.ratioRare);
            this.txtInputEpic.text = String(_loc3_.ratioEpic);
            this.txtInputLegendary.text = String(_loc3_.ratioLegendary);
            this.txtInputMythical.text = String(_loc3_.ratioMythical);
            this.txtInputNewMythical.text = String(_loc3_.ratioNewMythical);
            this.txtDefault_rare.text = String(_loc3_.ratioRareDefault);
            this.txtDefault_epic.text = String(_loc3_.ratioEpicDefault);
            this.txtDefault_legendary.text = String(_loc3_.ratioLegendaryDefault);
            this.txtDefault_mythical.text = String(_loc3_.ratioMythicalDefault);
            this.txtDefault_newMythical.text = String(_loc3_.ratioNewMythicalDefault);
         }
         else
         {
            if(_loc3_.type == "specificItem")
            {
               this.txtTextItemID.visible = true;
               this.txtInputItemID.visible = true;
               this.txtInputItemID.text = String(_loc3_.itemID);
            }
            else
            {
               this.txtTextItemID.visible = false;
               this.txtInputItemID.visible = false;
            }
            this.txtTextRare.visible = false;
            this.txtTextEpic.visible = false;
            this.txtTextLegendary.visible = false;
            this.txtTextMythical.visible = false;
            this.txtTextNewMythical.visible = false;
            this.txtInputRare.visible = false;
            this.txtInputEpic.visible = false;
            this.txtInputLegendary.visible = false;
            this.txtInputMythical.visible = false;
            this.txtInputNewMythical.visible = false;
            this.txtDefault_rare.visible = false;
            this.txtDefault_epic.visible = false;
            this.txtDefault_legendary.visible = false;
            this.txtDefault_mythical.visible = false;
            this.txtDefault_newMythical.visible = false;
         }
         this.refreshDefaultTexts1();
      }
      
      private function textInputChanged1(param1:Event) : void
      {
         this.refreshDefaultTexts1();
      }
      
      private function textInputChanged2(param1:Event) : void
      {
         this.refreshDefaultTexts2();
      }
      
      private function refreshDefaultTexts1() : void
      {
         var _loc1_:BMBoostData = null;
         var _loc2_:Number = NaN;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         _loc1_ = dataM.boostsDB[this._selectedBoostID];
         this.txtDefault_tokens.text = String(_loc1_.costTokensDefault);
         var _loc3_:String = String(_loc1_.costTokensDefault);
         if(int(this.txtInputTokensCost.text) != _loc1_.costTokensDefault)
         {
            _loc2_ = Math.floor(100 - int(this.txtInputTokensCost.text) / _loc1_.costTokensDefault * 100);
            _loc3_ = _loc3_ + " (-" + _loc2_ + "%)";
         }
         this.txtDefault_tokens.text = _loc3_;
         this.btnUpdateBoost.visible = true;
         if(this.itemTileListItem1 != null)
         {
            this.itemTileListItem1.removeMe();
         }
         this._itemID = 0;
         switch(_loc1_.type)
         {
            case "randomItems":
               _loc4_ = String(_loc1_.ratioRareDefault);
               _loc5_ = int(this.txtInputRare.text) - _loc1_.ratioRareDefault;
               if(_loc5_ > 0)
               {
                  _loc4_ = _loc4_ + " +" + _loc5_;
               }
               else if(_loc5_ < 0)
               {
                  _loc4_ = _loc4_ + " " + _loc5_;
               }
               _loc6_ = String(_loc1_.ratioEpicDefault);
               _loc5_ = int(this.txtInputEpic.text) - _loc1_.ratioEpicDefault;
               if(_loc5_ > 0)
               {
                  _loc6_ = _loc6_ + " +" + _loc5_;
               }
               else if(_loc5_ < 0)
               {
                  _loc6_ = _loc6_ + " " + _loc5_;
               }
               _loc7_ = String(_loc1_.ratioLegendaryDefault);
               _loc5_ = int(this.txtInputLegendary.text) - _loc1_.ratioLegendaryDefault;
               if(_loc5_ > 0)
               {
                  _loc7_ = _loc7_ + " +" + _loc5_;
               }
               else if(_loc5_ < 0)
               {
                  _loc7_ = _loc7_ + " " + _loc5_;
               }
               _loc8_ = String(_loc1_.ratioMythicalDefault);
               _loc5_ = int(this.txtInputMythical.text) - _loc1_.ratioMythicalDefault;
               if(_loc5_ > 0)
               {
                  _loc8_ = _loc8_ + " +" + _loc5_;
               }
               else if(_loc5_ < 0)
               {
                  _loc8_ = _loc8_ + " " + _loc5_;
               }
               _loc9_ = String(_loc1_.ratioNewMythicalDefault);
               _loc5_ = int(this.txtInputNewMythical.text) - _loc1_.ratioNewMythicalDefault;
               if(_loc5_ > 0)
               {
                  _loc9_ = _loc9_ + " +" + _loc5_;
               }
               else if(_loc5_ < 0)
               {
                  _loc9_ = _loc9_ + " " + _loc5_;
               }
               this.txtDefault_rare.text = _loc4_;
               this.txtDefault_epic.text = _loc6_;
               this.txtDefault_legendary.text = _loc7_;
               this.txtDefault_mythical.text = _loc8_;
               this.txtDefault_newMythical.text = _loc9_;
               break;
            case "specificItem":
               this.txtDefault_tokens.text = "";
               if(dataM.itemsDB[int(this.txtInputItemID.text)] != null)
               {
                  this._itemID = int(this.txtInputItemID.text);
                  this.itemTileListItem1 = dataM.createShopTileListItem_basedOnItemID(this._itemID,"packageItem",null,null,null,null,null,true);
                  this.itemTileListItem1.width = this.mcSizer_item1.width;
                  this.itemTileListItem1.height = this.mcSizer_item1.height;
                  this.itemTileListItem1.x = this.mcSizer_item1.x;
                  this.itemTileListItem1.y = this.mcSizer_item1.y;
                  addChild(this.itemTileListItem1);
               }
               else
               {
                  this.btnUpdateBoost.visible = false;
               }
               break;
            default:
               this.txtDefault_rare.text = "";
               this.txtDefault_epic.text = "";
               this.txtDefault_legendary.text = "";
               this.txtDefault_mythical.text = "";
               this.txtDefault_newMythical.text = "";
         }
      }
      
      private function refreshDefaultTexts2() : void
      {
         if(this.txtInputPlayerID.text.length > 8)
         {
            this.txtInputPlayerID.text = this.txtInputPlayerID.text.substr(0,8);
         }
         if(this.txtInputSendBoostID.text.length > 2)
         {
            this.txtInputSendBoostID.text = this.txtInputSendBoostID.text.substr(0,2);
         }
         if(this.txtInputSendBoostAmount.text.length > 1)
         {
            this.txtInputSendBoostAmount.text = this.txtInputSendBoostAmount.text.substr(0,1);
         }
         if(this.txtInputSendItemID.text.length > 4)
         {
            this.txtInputSendItemID.text = this.txtInputSendItemID.text.substr(0,4);
         }
         TsLogger.log("_sendItemLastItemID:" + this._sendItemLastItemID + " " + this.txtInputSendItemID.text);
         if(this._sendItemLastItemID != int(this.txtInputSendItemID.text))
         {
            this._sendItemLastItemID = int(this.txtInputSendItemID.text);
            this.btnSendItem.visible = false;
            if(dataM.itemsDB[this._sendItemLastItemID] != null)
            {
               this.itemTileListItem2 = dataM.createShopTileListItem_basedOnItemID(this._sendItemLastItemID,"packageItem",null,null,null,null,null,true);
               this.itemTileListItem2.width = this.mcSizer_item2.width;
               this.itemTileListItem2.height = this.mcSizer_item2.height;
               this.itemTileListItem2.x = this.mcSizer_item2.x;
               this.itemTileListItem2.y = this.mcSizer_item2.y;
               addChild(this.itemTileListItem2);
               this.btnSendItem.visible = true;
            }
            else if(this.itemTileListItem2 != null)
            {
               this.itemTileListItem2.removeMe();
            }
         }
         if(this.txtInputSendItemPower.text.length > 6)
         {
            this.txtInputSendItemPower.text = this.txtInputSendItemPower.text.substr(0,6);
         }
      }
      
      public function updateBoostClicked() : void
      {
         var _loc1_:BMBoostData = dataM.boostsDB[this._selectedBoostID];
         var _loc2_:Number = int(this.txtInputTokensCost.text);
         if(_loc2_ < _loc1_.costTokens * this.TOKENS_MIN_DISCOUNT)
         {
            _loc2_ = Math.ceil(_loc1_.costTokens * this.TOKENS_MIN_DISCOUNT);
         }
         else if(_loc2_ > _loc1_.costTokens)
         {
            _loc2_ > _loc1_.costTokens;
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         if(_loc1_.type == "randomItems")
         {
            _loc3_ = int(this.txtInputRare.text);
            _loc4_ = int(this.txtInputEpic.text);
            _loc5_ = int(this.txtInputLegendary.text);
            _loc6_ = int(this.txtInputMythical.text);
            _loc7_ = int(this.txtInputNewMythical.text);
            switch(this._selectedBoostID)
            {
               case 5:
               case 6:
                  if(_loc5_ > this.LEGENDARY_MAX)
                  {
                     _loc5_ = this.LEGENDARY_MAX;
                  }
                  if(_loc6_ > this.MYTHICAL_MAX)
                  {
                     _loc6_ = this.MYTHICAL_MAX;
                  }
                  if(_loc7_ > this.NEW_MYTHICAL_MAX)
                  {
                     _loc7_ = this.NEW_MYTHICAL_MAX;
                  }
            }
         }
         remoteM.socketM.admin_updateBoostData(this._selectedBoostID,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,this._itemID);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
      }
      
      public function activateResetClicked() : void
      {
         var _loc1_:Number = int(this.txtInputResetTime.text);
         if(_loc1_ > 0)
         {
            this.boostResetTime = dataM.currentTime + _loc1_;
            remoteM.socketM.admin_setBoostsResetTime(_loc1_);
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         }
         this.txtInputResetTime.text = "0";
      }
      
      public function resetRateBoxClicked() : void
      {
      }
      
      private function sendBoostsClicked() : void
      {
         var _loc1_:Number = int(this.txtInputPlayerID.text);
         var _loc2_:Number = int(this.txtInputSendBoostID.text);
         var _loc3_:Number = int(this.txtInputSendBoostAmount.text);
         if(_loc1_ > 0 && _loc2_ > 0 && _loc3_ > 0)
         {
            remoteM.socketM.admin_sendFreeBoosts(_loc1_,_loc2_,_loc3_);
            this.btnSendBoosts.disableMe();
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
      }
      
      private function sendItemClicked() : void
      {
         var _loc1_:Number = int(this.txtInputPlayerID.text);
         var _loc2_:Number = int(this.txtInputSendItemID.text);
         var _loc3_:Number = int(this.txtInputSendItemPower.text);
         if(_loc1_ > 0 && _loc2_ > 0 && _loc3_ > 0)
         {
            remoteM.socketM.admin_sendItem(_loc1_,_loc2_,_loc3_);
            this.btnSendItem.disableMe();
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
      }
      
      public function freeBoostsSent() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("admin_sendFreeBoostsSuccess");
         this.btnSendBoosts.enableMe();
      }
      
      public function sendingFreeBoostsFailed() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("admin_sendFreeBoostsFailed");
         this.btnSendItem.enableMe();
      }
      
      public function itemSent() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("admin_sendItemSuccess");
         this.btnSendItem.enableMe();
      }
      
      public function sendingItemFailed() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("admin_sendItemFailed");
         this.btnSendItem.enableMe();
      }
      
      public function oldShopClicked() : void
      {
      }
      
      public function mechGeneratorClicked() : void
      {
         screensM.addScreen("screenMechGenerator");
         screensM.screenMechGenerator.refreshScreen();
      }
      
      public function alertServerRestartClicked() : void
      {
         var _loc1_:Number = int(this.txtInputAlertServerRestart.text);
         remoteM.socketM.admin_alertServerRestart(_loc1_);
         screensM.screenConfirmation.displayQuestionOrNotification("admin_alertServerRestartSent");
      }
      
      public function forceItemsUpdateClicked() : void
      {
         remoteM.socketM.admin_updateItemsTable();
         screensM.screenConfirmation.displayQuestionOrNotification("admin_forceItemsUpdateSent");
      }
      
      public function backClicked() : void
      {
         if(this.boostsTileList != null)
         {
            this.boostsTileList.removeMe();
            this.boostsTileList = null;
         }
         screensM.screenNewMenu.profileInfoClicked();
         screensM.removeScreen("screenAdminTools");
      }
   }
}

