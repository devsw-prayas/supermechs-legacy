package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1262")]
   public class BMScreenHangerFusion extends BMBaseScreen
   {
      
      private const WIP_TEXT_FOR_INTERNAL_TEST:* = false;
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var generalHitArea:MovieClip;
      
      public var targetHitArea:MovieClip;
      
      public var mcTargetItemSlot:MovieClip;
      
      public var mcSizer_target:Sprite;
      
      public var mcSizer_btnActivate:Sprite;
      
      public var mcSizer_btnCraftMythicals:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcBarFrame:Sprite;
      
      public var txtSourceItemsPower:TextField;
      
      public var txtTargetPower:TextField;
      
      public var txtTargetBonus:TextField;
      
      public var txtErrorMessage:TextField;
      
      public var txtTitle:TextField;
      
      public var btnActivate:BMButton;
      
      public var btnCraftMythicals:BMButton;
      
      public var mcTutorialMarker_activateFusion:MovieClip;
      
      public var mcTutorialArrow_activateFusion:MovieClip;
      
      public var mcTargetPowerBar:BMBar;
      
      public var mcLightEffect:MovieClip;
      
      public var mcFingerWheelingHitArea:Sprite;
      
      private var sourceItemsTileList:BMTileList;
      
      private var mcTargetTileListItem:BMTileListItem;
      
      private var _sourcePlayerItemIDs:Array = new Array();
      
      private var _targetPlayerItemID:Number = 0;
      
      private var _targetItemUpgradeData:Object = null;
      
      private var _txtErrorMessageOriginYPos:Number;
      
      private var _sourceItemsPower:Number = 0;
      
      private var _targetXPLevel:uint = 0;
      
      private var _targetPowerLevel:uint = 0;
      
      private var _targetMaxPowerLevel:uint = 0;
      
      private var _targetCurrentPower:Number = 0;
      
      private var _targetMaxPowerForLevel:Number = 0;
      
      private var _targetDestinationPower:Number = 0;
      
      private var _targetPowerType:String = "regular";
      
      private var _maxPowerAddonPerFrame:uint = 0;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private var _btnActivateOriginYPos:Number;
      
      private var _targetPowerInitialYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      private const TILE_LIST_ROWS_12:uint = 6;
      
      private const TILE_LIST_ROWS_27:uint = 9;
      
      private const TILE_LIST_COLUMNS_12:uint = 2;
      
      private const TILE_LIST_COLUMNS_27:uint = 3;
      
      private const TILE_LIST_ITEM_SIZE_12:uint = 70;
      
      private const TILE_LIST_ITEM_SIZE_27:uint = 47;
      
      private const SOURCE_MAX_ITEMS:uint = 27;
      
      private const SOURCE_SIZE_CHANGE_ITEMS:uint = 12;
      
      public function BMScreenHangerFusion()
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
         var _loc3_:Function = null;
         var _loc4_:BMPlayerProfile = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("hanger");
            screensM.createButtonFromSizer("screenHangerFusion","btnActivate","regular");
            screensM.createButtonFromSizer("screenHangerFusion","btnCraftMythicals","regular");
            _loc2_ = this.activateClicked;
            _loc3_ = this.craftMythicalsClicked;
            switch(dataM.languageID)
            {
               case 5:
                  this.btnActivate.changeFontSize(26);
                  this.btnCraftMythicals.changeFontSize(26);
                  break;
               case 7:
                  this.btnActivate.changeFontSize(24);
                  this.btnCraftMythicals.changeFontSize(34);
                  break;
               case 9:
                  this.btnActivate.changeFontSize(34);
                  this.btnCraftMythicals.changeFontSize(17);
                  break;
               case 10:
                  this.btnActivate.changeFontSize(26);
                  this.btnCraftMythicals.changeFontSize(26);
                  break;
               default:
                  this.btnActivate.changeFontSize(34);
                  this.btnCraftMythicals.changeFontSize(34);
            }
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
            }
            this.btnActivate.initialize(getScreenText("fusionActivate"),"orange",null,[],_loc2_,dataM.runAsMobile);
            this.btnCraftMythicals.initialize(getScreenText("craftMythicals"),"orange",null,[],_loc3_,dataM.runAsMobile);
            this.btnActivate.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCraftMythicals.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            if(dataM.runAsMobile)
            {
               this._fingerWheeling = new BMFingerWheeling();
               this._fingerWheeling.initialize("fusion",this.sourceItemsTileList,this.mcFingerWheelingHitArea,this.tileListItemMouseUp,this.tileListItemMouseDown,true);
               addChild(this._fingerWheeling);
            }
            else
            {
               this.mcFingerWheelingHitArea.parent.removeChild(this.mcFingerWheelingHitArea);
               this.targetHitArea.addEventListener(MouseEvent.CLICK,this.targetHitAreaClick);
               this.targetHitArea.addEventListener(MouseEvent.MOUSE_UP,this.targetHitAreaMouseUp);
               this.targetHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.targetHitAreaMouseOver);
               this.targetHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.targetHitAreaMouseOut);
               this.generalHitArea.addEventListener(MouseEvent.MOUSE_UP,this.generalHitAreaMouseUp);
               this.generalHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.generalHitAreaMouseOver);
               this.generalHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.generalHitAreaMouseOut);
            }
            this.mcTargetPowerBar.initialize("blue","right");
            this.mcTargetPowerBar.addSeparateorLines(6);
            this.mcTutorialMarker_activateFusion.mouseEnabled = false;
            this.mcTutorialMarker_activateFusion.mouseChildren = false;
            this.mcTutorialArrow_activateFusion.mouseEnabled = false;
            this.mcTutorialArrow_activateFusion.mouseChildren = false;
            this._txtErrorMessageOriginYPos = this.txtErrorMessage.y;
            this._btnActivateOriginYPos = this.btnActivate.y;
            this._targetPowerInitialYPos = this.txtTargetPower.y;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         this._sourcePlayerItemIDs = new Array();
         this.setTargetPlayerItemID(0);
         this.setErrorMessageText("");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("hangerFusion_txtErrorMessage",[this.txtErrorMessage],"",this);
            this._fingerWheeling.addMouseListeners();
         }
         var _loc1_:Boolean = false;
         if(dataM.useCraftMythicals)
         {
            _loc4_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc4_.level >= dataM.craftMythicals_level)
            {
               _loc1_ = true;
            }
         }
         if(_loc1_)
         {
            this.btnActivate.y = this._btnActivateOriginYPos;
            this.mcTutorialMarker_activateFusion.y = this._btnActivateOriginYPos;
            this.mcTutorialArrow_activateFusion.y = this._btnActivateOriginYPos + 25;
            this.btnCraftMythicals.visible = true;
         }
         else
         {
            this.btnActivate.y = this._btnActivateOriginYPos + 30;
            this.mcTutorialMarker_activateFusion.y = this._btnActivateOriginYPos + 30;
            this.mcTutorialArrow_activateFusion.y = this._btnActivateOriginYPos + 30 + 25;
            this.btnCraftMythicals.visible = false;
         }
         this.addAndRefreshSourceItemsTileList();
         this.refreshTargetItemPowerData();
         this.refreshSourceItemsPower();
         this.refreshTargetBonusText();
         this.refreshActivateButton();
         this.refreshCraftMythicalsButton();
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            _loc2_ = 14;
            _loc3_ = 16;
            _loc4_ = 16;
            _loc5_ = 20;
            switch(dataM.languageID)
            {
               case 3:
                  _loc2_ = 16;
                  break;
               case 7:
                  _loc5_ = 17;
            }
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtErrorMessage,16);
            TextUtils.updateTextFormat(this.txtSourceItemsPower,_loc4_);
            TextUtils.updateTextFormat(this.txtTargetBonus,_loc3_);
            TextUtils.updateTextFormat(this.txtTargetPower,_loc2_);
            TextUtils.updateTextFormat(this.txtTitle,_loc5_);
            TextUtils.updateTextFormat(this.btnActivate.txtButtonName);
            TextUtils.updateTextFormat(this.btnCraftMythicals.txtButtonName);
            param1 = true;
         }
         if(param1)
         {
            switch(dataM.languageID)
            {
               case 5:
                  this.btnActivate.changeFontSize(26);
                  this.btnCraftMythicals.changeFontSize(26);
                  break;
               case 7:
                  this.btnActivate.changeFontSize(24);
                  this.btnCraftMythicals.changeFontSize(34);
                  break;
               case 9:
                  this.btnActivate.changeFontSize(34);
                  this.btnCraftMythicals.changeFontSize(17);
                  break;
               case 10:
                  this.btnActivate.changeFontSize(26);
                  this.btnCraftMythicals.changeFontSize(26);
                  break;
               default:
                  this.btnActivate.changeFontSize(33);
                  this.btnCraftMythicals.changeFontSize(34);
            }
            this.btnActivate.setButtonName(getScreenText("fusionActivate"));
            this.btnCraftMythicals.setButtonName(getScreenText("craftMythicals"));
         }
         this.txtTargetPower.y = this._targetPowerInitialYPos;
         switch(dataM.languageID)
         {
            case 3:
               this.txtTargetPower.y = this._targetPowerInitialYPos - 2;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.refreshTargetPowerBar();
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.onEnterFrameTrigger();
            }
         }
      }
      
      private function stopPowerAnimation() : void
      {
         if(this.hasTargetItem())
         {
            if(this._targetCurrentPower < this._targetDestinationPower)
            {
               this._targetXPLevel = 0;
               this._targetPowerLevel = 0;
               this._targetMaxPowerLevel = 0;
               this._targetCurrentPower = 0;
               this._targetMaxPowerForLevel = 0;
               this._targetDestinationPower = 0;
               this._targetPowerType = "regular";
               this.txtTargetPower.text = "";
               if(dataM.runAsMobile)
               {
                  screensM.createMultipleTextsBitmap("hangerFusion_targetPower",[this.txtTargetPower],"",this);
               }
            }
         }
      }
      
      private function refreshTargetPowerBar() : void
      {
         var _loc1_:BMPlayerItemData = null;
         var _loc2_:BMItemData = null;
         var _loc3_:Object = null;
         var _loc4_:BMItemData = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:BMPlayerItemData = null;
         if(!this.hasTargetItem())
         {
            if(this.mcTargetPowerBar.visible)
            {
               this.mcTargetPowerBar.visible = false;
               this.txtTargetPower.text = "";
               this.txtSourceItemsPower.text = "";
            }
         }
         else
         {
            if(this.mcTargetPowerBar.visible == false)
            {
               this.mcTargetPowerBar.visible = true;
            }
            _loc1_ = this.getTargetPlayerItem();
            _loc2_ = this.getTargetItemData();
            _loc3_ = this._targetItemUpgradeData;
            _loc4_ = _loc3_.itemData;
            _loc5_ = Number(_loc3_.cost);
            if(this._targetCurrentPower < this._targetDestinationPower)
            {
               _loc6_ = Math.ceil((this._targetDestinationPower - this._targetCurrentPower) * 0.2);
               if(_loc6_ < 2)
               {
                  _loc6_ = 2;
               }
               else if(_loc6_ > this._maxPowerAddonPerFrame)
               {
                  _loc6_ = this._maxPowerAddonPerFrame;
               }
               _loc7_ = _loc2_.displayLevel;
               _loc8_ = _loc4_.displayLevel;
               this._targetCurrentPower += _loc6_;
               if(this._targetCurrentPower > this._targetDestinationPower)
               {
                  this._targetCurrentPower = this._targetDestinationPower;
               }
               _loc9_ = _loc2_.minPowerToHave;
               _loc10_ = _loc2_.powerToUpgrade;
               if(_loc8_ < this._targetMaxPowerLevel)
               {
                  _loc11_ = (this._targetCurrentPower - _loc9_) / (_loc10_ - _loc9_);
               }
               else
               {
                  _loc11_ = 1;
               }
               this.mcTargetPowerBar.setFill(_loc11_,false);
               if(_loc8_ > _loc7_)
               {
                  this.mcTargetItemSlot.mcLightEffect.gotoAndPlay("animOn");
                  _loc12_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._targetPlayerItemID);
                  _loc12_.power = this._targetCurrentPower;
                  this.createTargetItem();
                  _loc12_.power = this._targetDestinationPower;
                  this._targetPowerLevel = _loc8_;
                  this.refreshTargetBonusText();
               }
            }
            this.updatePowerBarText(_loc5_);
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("hangerFusion_targetPower",[this.txtTargetPower],"",this);
         }
      }
      
      private function updatePowerBarText(param1:Number) : void
      {
         var _loc2_:String = null;
         var _loc3_:BMItemData = this.getTargetItemData();
         if(param1 > 0)
         {
            _loc2_ = "Cost: " + param1;
         }
         else if(_loc3_ != null && _loc3_.canEvolve())
         {
            _loc2_ = "EVOLVING";
         }
         else if(this._targetCurrentPower > this._targetMaxPowerForLevel)
         {
            _loc2_ = getScreenText("fusionPower");
            _loc2_ = dataM.replaceStringInText(_loc2_,"%POWER%",dataM.getNumberWithComma(this._targetCurrentPower));
         }
         else if(this._targetCurrentPower > 5000)
         {
            _loc2_ = dataM.getNumberWithComma(this._targetCurrentPower) + " / " + dataM.getNumberWithComma(this._targetMaxPowerForLevel);
         }
         else
         {
            _loc2_ = getScreenText("fusionPower");
            _loc2_ = dataM.replaceStringInText(_loc2_,"%POWER%",dataM.getNumberWithComma(this._targetCurrentPower) + " / " + dataM.getNumberWithComma(this._targetMaxPowerForLevel));
         }
         this.txtTargetPower.text = _loc2_;
      }
      
      private function refreshTargetBonusText() : void
      {
         var _loc1_:BMPlayerItemData = null;
         var _loc2_:BMItemData = null;
         var _loc3_:String = null;
         this.txtTargetBonus.text = "";
         if(this.WIP_TEXT_FOR_INTERNAL_TEST)
         {
            return;
         }
         if(this.hasTargetItem())
         {
            if(this._targetPowerLevel > 1)
            {
               _loc1_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._targetPlayerItemID);
               _loc2_ = dataM.itemsDB[_loc1_.itemID];
               switch(_loc2_.type)
               {
                  case "torso":
                     _loc3_ = getScreenText("fusionHPBonus");
                     _loc3_ = dataM.replaceStringInText(_loc3_,"%HP%",String(dataM.getGeneralPowerHPBonus(_loc2_.level,this._targetPowerLevel,this._targetPowerType)));
                     this.txtTargetBonus.text = _loc3_;
                     break;
                  case "leg":
                  case "sideWeapon":
                  case "topWeapon":
                     _loc3_ = getScreenText("fusionDamageBonus");
                     _loc3_ = dataM.replaceStringInText(_loc3_,"%DAMAGE%",String(dataM.getGeneralPowerDamageBonus(_loc2_.level,this._targetPowerLevel,this._targetPowerType)));
                     this.txtTargetBonus.text = _loc3_;
                     break;
                  case "drone":
                  case "teleport":
                  case "charge":
                  case "harpoon":
                     if(_loc2_.HPAddon > 0)
                     {
                        _loc3_ = getScreenText("fusionRepairBonus");
                        _loc3_ = dataM.replaceStringInText(_loc3_,"%REPAIR%",String(dataM.getGeneralPowerRepairBonus(_loc2_.level,this._targetPowerLevel)));
                     }
                     else
                     {
                        _loc3_ = getScreenText("fusionDamageBonus");
                        _loc3_ = dataM.replaceStringInText(_loc3_,"%DAMAGE%",String(dataM.getGeneralPowerDamageBonus(_loc2_.level,this._targetPowerLevel)));
                     }
                     this.txtTargetBonus.text = _loc3_;
               }
            }
         }
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      private function addAndRefreshSourceItemsTileList(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Function = null;
         var _loc9_:Function = null;
         var _loc10_:Function = null;
         var _loc11_:Function = null;
         var _loc12_:Function = null;
         var _loc13_:BMTileListItem = null;
         var _loc3_:Array = new Array();
         if(param1 || param2)
         {
            this.sourceItemsTileList.removeMe();
            this.sourceItemsTileList = null;
         }
         if(this.sourceItemsTileList == null)
         {
            _loc4_ = this.TILE_LIST_ROWS_12;
            _loc5_ = this.TILE_LIST_COLUMNS_12;
            _loc6_ = this.TILE_LIST_ITEM_SIZE_12;
            if(param1 || param2)
            {
               _loc7_ = 0;
               while(_loc7_ < this._sourcePlayerItemIDs.length)
               {
                  _loc8_ = this.tileListItemClicked;
                  _loc9_ = this.tileListItemMouseDown;
                  _loc10_ = this.tileListItemMouseUp;
                  _loc11_ = this.tileListItemMouseOver;
                  _loc12_ = this.tileListItemMouseOut;
                  if(dataM.runAsMobile)
                  {
                     _loc8_ = null;
                     _loc9_ = null;
                     _loc10_ = null;
                     _loc11_ = null;
                     _loc12_ = null;
                  }
                  _loc13_ = dataM.createInventoryTileListItem(this._sourcePlayerItemIDs[_loc7_],false,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,true);
                  if(param2)
                  {
                     _loc13_.width = this.TILE_LIST_ITEM_SIZE_12;
                     _loc13_.height = this.TILE_LIST_ITEM_SIZE_12;
                  }
                  else
                  {
                     _loc13_.width = this.TILE_LIST_ITEM_SIZE_27;
                     _loc13_.height = this.TILE_LIST_ITEM_SIZE_27;
                  }
                  _loc3_.push(_loc13_);
                  _loc7_++;
               }
               if(param1)
               {
                  _loc4_ = this.TILE_LIST_ROWS_27;
                  _loc5_ = this.TILE_LIST_COLUMNS_27;
                  _loc6_ = this.TILE_LIST_ITEM_SIZE_27;
               }
            }
            this.sourceItemsTileList = new BMTileList();
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.resetTileList(this.sourceItemsTileList);
            }
            this.sourceItemsTileList.initialize(screensM.stagePointer,_loc3_,_loc4_,_loc5_,_loc6_,_loc6_,this.tileListMouseUp,true,null,null,null,false,0,0,true,false,dataM.runAsMobile);
            this.sourceItemsTileList.x = this.mcSizer_tileList.x;
            this.sourceItemsTileList.y = this.mcSizer_tileList.y;
            this.mcButtonsHolder.addChild(this.sourceItemsTileList);
         }
      }
      
      public function tryToAddItem(param1:Boolean, param2:Boolean) : void
      {
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:BMItemData = null;
         var _loc11_:Boolean = false;
         var _loc12_:BMPlayerItemData = null;
         var _loc13_:BMItemData = null;
         var _loc14_:Function = null;
         var _loc15_:Function = null;
         var _loc16_:Function = null;
         var _loc17_:Function = null;
         var _loc18_:Function = null;
         var _loc19_:BMTileListItem = null;
         var _loc20_:uint = 0;
         var _loc3_:String = "";
         if(draggingM.item == null)
         {
            this.setErrorMessageText(_loc3_);
            return;
         }
         var _loc4_:Number = draggingM.item.ID;
         if(_loc4_ <= 0)
         {
            this.setErrorMessageText(_loc3_);
            return;
         }
         var _loc5_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,_loc4_);
         if(_loc5_.durability > 0)
         {
            _loc3_ = getScreenText("fusionCannotEquipItemsWithDurability");
            this.setErrorMessageText(_loc3_);
            return;
         }
         var _loc6_:BMItemData = dataM.itemsDB[_loc5_.itemID];
         var _loc7_:Boolean = false;
         if(param1 == false)
         {
            _loc8_ = false;
            _loc9_ = false;
            switch(_loc6_.type)
            {
               case "torso":
               case "leg":
               case "sideWeapon":
               case "topWeapon":
               case "drone":
               case "teleport":
               case "charge":
               case "harpoon":
                  break;
               default:
                  _loc8_ = true;
                  if(param2)
                  {
                     _loc9_ = true;
                  }
            }
            if(_loc8_)
            {
               if(_loc9_)
               {
                  _loc3_ = getScreenText("fusionWrongItemTypeNew");
               }
            }
            else
            {
               if(this.hasTargetItem())
               {
                  if(param2)
                  {
                     this.setTargetPlayerItemID(0);
                  }
               }
               if(!this.hasTargetItem())
               {
                  this.stopPowerAnimation();
                  this.setTargetPlayerItemID(_loc4_);
                  this.createTargetItem();
                  this.refreshInventory();
                  this.refreshTargetItemPowerData();
                  this.refreshSourceItemsPower();
                  this.refreshTargetBonusText();
                  this.mcTargetItemSlot.gotoAndStop("itemEquipped");
                  _loc7_ = true;
               }
            }
         }
         if(this.hasTargetItem())
         {
            _loc10_ = this.getTargetItemData();
            if(_loc10_.isMaxLevel())
            {
               if(_loc10_.canEvolve())
               {
                  if(_loc7_)
                  {
                     this.removeAllSourcesThatCantBeUsedForTargetEvolve();
                  }
                  else if(!this.canItemBeUsedAsSourceOfEvolve(_loc6_))
                  {
                     _loc3_ = "Unable to evolve with items less than tier " + (_loc10_.specialStatus + 1);
                     this.setErrorMessageText(_loc3_);
                     return;
                  }
               }
            }
         }
         if(_loc7_ == false)
         {
            if(_loc5_.equipped == 0)
            {
               if(param2 == false)
               {
                  _loc11_ = false;
                  if(this.hasTargetItem())
                  {
                     _loc12_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._targetPlayerItemID);
                     _loc13_ = dataM.itemsDB[_loc12_.itemID];
                     switch(_loc13_.type)
                     {
                        case "torso":
                           break;
                        case "leg":
                        case "sideWeapon":
                        case "topWeapon":
                           if(_loc13_.damageBase == 0 && _loc13_.damageAddon == 0 && _loc13_.HPAddon == 0)
                           {
                              _loc11_ = true;
                           }
                           break;
                        case "drone":
                        case "teleport":
                        case "charge":
                        case "harpoon":
                           if(_loc13_.damageBase == 0 && _loc13_.damageAddon == 0 && _loc13_.HPAddon == 0)
                           {
                              _loc11_ = true;
                           }
                     }
                  }
                  if(_loc11_ && dataM.isColorKit(_loc6_.itemID) == false)
                  {
                     _loc3_ = getScreenText("fusionItemDealsNoDamage");
                  }
                  else if(this._sourcePlayerItemIDs.length < this.SOURCE_MAX_ITEMS)
                  {
                     _loc14_ = this.tileListItemClicked;
                     _loc15_ = this.tileListItemMouseDown;
                     _loc16_ = this.tileListItemMouseUp;
                     _loc17_ = this.tileListItemMouseOver;
                     _loc18_ = this.tileListItemMouseOut;
                     if(dataM.runAsMobile)
                     {
                        _loc14_ = null;
                        _loc15_ = null;
                        _loc16_ = null;
                        _loc17_ = null;
                        _loc18_ = null;
                     }
                     _loc19_ = dataM.createInventoryTileListItem(_loc4_,false,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,true);
                     _loc20_ = this.sourceItemsTileList.getItemsAmount();
                     if(_loc20_ < this.SOURCE_SIZE_CHANGE_ITEMS - 1)
                     {
                        _loc19_.width = this.TILE_LIST_ITEM_SIZE_12;
                        _loc19_.height = this.TILE_LIST_ITEM_SIZE_12;
                     }
                     else
                     {
                        _loc19_.width = this.TILE_LIST_ITEM_SIZE_27;
                        _loc19_.height = this.TILE_LIST_ITEM_SIZE_27;
                     }
                     if(_loc20_ == this.SOURCE_SIZE_CHANGE_ITEMS - 1)
                     {
                        this.addAndRefreshSourceItemsTileList(true);
                     }
                     this.sourceItemsTileList.addItems(this.sourceItemsTileList.highestTileID + 1,[_loc19_],true);
                     this._sourcePlayerItemIDs.push(_loc4_);
                     this.refreshInventory();
                     if(this.hasTargetItem())
                     {
                        this.createTargetItem();
                     }
                  }
               }
            }
            else
            {
               _loc3_ = getScreenText("fusionCannotDestroyEquippedItems");
            }
         }
         this.setErrorMessageText(_loc3_);
         this.refreshSourceItemsPower();
         this.updateItemDataForUpgrade();
         this.updateItemsPowerText();
         this.refreshActivateButton();
         this.refreshCraftMythicalsButton();
      }
      
      private function createTargetItem() : void
      {
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         this.removeTargetItemGrp();
         var _loc1_:Number = -1;
         var _loc2_:uint = 0;
         while(_loc2_ < this._sourcePlayerItemIDs.length)
         {
            _loc5_ = uint(this._sourcePlayerItemIDs[_loc2_]);
            _loc6_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc5_);
            if(dataM.isColorKit(_loc6_.itemID))
            {
               _loc7_ = dataM.itemsDB[_loc6_.itemID];
               _loc1_ = int(_loc7_.animation);
            }
            _loc2_++;
         }
         var _loc3_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,this._targetPlayerItemID);
         var _loc4_:uint = _loc3_.colorID;
         if(_loc1_ > -1)
         {
            _loc3_.colorID = _loc1_;
         }
         this.mcTargetTileListItem = dataM.createInventoryTileListItem(this._targetPlayerItemID,false,null,null,null,null,null,true);
         _loc3_.colorID = _loc4_;
         this.mcTargetTileListItem.x = this.mcSizer_target.x;
         this.mcTargetTileListItem.y = this.mcSizer_target.y;
         this.mcTargetTileListItem.width = this.mcSizer_target.width;
         this.mcTargetTileListItem.height = this.mcSizer_target.height;
         this.mcIconsHolder.addChild(this.mcTargetTileListItem);
      }
      
      private function removeSourceItem(param1:uint) : void
      {
         this._sourcePlayerItemIDs.splice(param1,1);
         if(this.sourceItemsTileList.getItemsAmount() == this.SOURCE_SIZE_CHANGE_ITEMS)
         {
            this.addAndRefreshSourceItemsTileList(false,true);
         }
         else
         {
            this.sourceItemsTileList.removeItems([param1],"tileID");
         }
         this.refreshSourceItemsPower();
         this.updateItemDataForUpgrade();
         this.updateItemsPowerText();
         this.refreshInventory();
         tooltip.hideToolTip();
         this.refreshActivateButton();
         this.refreshCraftMythicalsButton();
      }
      
      private function refreshInventory() : void
      {
         screensM.screenHangerInventory.addAndRefreshInventoryTileList("screenHangerFusion equipItem",true);
         screensM.screenHangerInventory.refreshItemTypesButtonsAndAmount();
      }
      
      private function tileListMouseUp() : void
      {
         this.tryToAddItem(true,false);
      }
      
      private function tileListItemClicked(param1:Number, param2:Number) : void
      {
      }
      
      private function tileListItemMouseDown(param1:Number, param2:Number) : void
      {
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc3_.tutorialLevel > BMDataManager.TUTORIAL_LEVEL_FUSION)
         {
            this.removeSourceItem(param1);
         }
      }
      
      private function tileListItemMouseUp(param1:Number, param2:Number) : void
      {
         this.tryToAddItem(true,false);
      }
      
      private function tileListItemMouseOver(param1:Number, param2:Number) : void
      {
         tooltip.showToolTip("inventory","",param2);
      }
      
      private function tileListItemMouseOut(param1:Number, param2:Number) : void
      {
         tooltip.hideToolTip();
      }
      
      public function equipItem() : void
      {
         this.tryToAddItem(false,false);
      }
      
      public function itemDraggedOnInventory() : void
      {
         var _loc1_:Number = draggingM.item.ID;
      }
      
      public function fusionCancelled() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.tutorialLevel <= BMDataManager.TUTORIAL_LEVEL_FUSION)
         {
            this.activateTutorialFusionMarker();
         }
      }
      
      private function refreshTargetItemPowerData() : void
      {
         var _loc1_:BMPlayerItemData = null;
         var _loc2_:BMItemData = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         var _loc8_:Object = null;
         var _loc9_:BMItemData = null;
         var _loc10_:Number = NaN;
         if(!this.hasTargetItem())
         {
            this._targetXPLevel = 0;
            this._targetPowerLevel = 0;
            this._targetMaxPowerLevel = 0;
            this._targetCurrentPower = 0;
            this._targetMaxPowerForLevel = 0;
            this._targetDestinationPower = 0;
            this._targetPowerType = "regular";
            this.txtTargetPower.text = "";
         }
         else
         {
            _loc1_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._targetPlayerItemID);
            _loc2_ = dataM.itemsDB[_loc1_.itemID];
            this._targetCurrentPower = _loc1_.power;
            this._targetDestinationPower = _loc1_.power;
            _loc3_ = _loc2_.minPowerToHave;
            _loc4_ = _loc2_.powerToUpgrade;
            this._targetMaxPowerForLevel = _loc2_.powerToUpgrade;
            this._maxPowerAddonPerFrame = 100;
            this._targetPowerLevel = _loc2_.displayLevel;
            this._targetMaxPowerLevel = _loc2_.upgradeToItemID == -1 ? this._targetPowerLevel : uint(this._targetPowerLevel + 1);
            if(this._targetPowerLevel < this._targetMaxPowerLevel)
            {
               _loc5_ = (this._targetCurrentPower - _loc3_) / (_loc4_ - _loc3_);
            }
            else
            {
               _loc5_ = 1;
            }
            this.mcTargetPowerBar.setFill(_loc5_,false);
            _loc6_ = this.getTargetPlayerItem();
            _loc7_ = this.getTargetItemData();
            _loc8_ = this._targetItemUpgradeData;
            _loc9_ = _loc8_.itemData;
            _loc10_ = Number(_loc8_.cost);
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("hangerFusion_targetPower",[this.txtTargetPower],"",this);
         }
      }
      
      private function targetHitAreaClick(param1:MouseEvent) : void
      {
         this.targetHitAreaClickSub();
      }
      
      public function targetHitAreaClickSub() : void
      {
         var _loc1_:BMPlayerProfile = null;
         if(draggingM.item == null)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc1_.tutorialLevel > BMDataManager.TUTORIAL_LEVEL_FUSION)
            {
               if(this.hasTargetItem())
               {
                  this.stopPowerAnimation();
                  this.setTargetPlayerItemID(0);
                  this.removeTargetItemGrp();
                  this.refreshInventory();
                  this.refreshTargetBonusText();
                  this.refreshTargetItemPowerData();
                  this.refreshTargetPowerBar();
                  this.refreshActivateButton();
                  this.refreshCraftMythicalsButton();
                  tooltip.hideToolTip();
               }
            }
         }
      }
      
      private function targetHitAreaMouseUp(param1:MouseEvent) : void
      {
         this.targetHitAreaMouseUpSub();
      }
      
      public function targetHitAreaMouseUpSub() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.tutorialLevel > BMDataManager.TUTORIAL_LEVEL_FUSION)
         {
            this.tryToAddItem(false,true);
         }
         else
         {
            this.tryToAddItem(false,false);
         }
      }
      
      private function targetHitAreaMouseOver(param1:MouseEvent) : void
      {
         if(this.hasTargetItem())
         {
            tooltip.showToolTip("inventory","",this._targetPlayerItemID);
         }
      }
      
      private function targetHitAreaMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      private function generalHitAreaMouseUp(param1:MouseEvent) : void
      {
         this.generalHitAreaMouseUpSub();
      }
      
      public function generalHitAreaMouseUpSub() : void
      {
         if(draggingM.item != null)
         {
            if(draggingM.item.ID > 0)
            {
               this.tryToAddItem(false,false);
            }
         }
      }
      
      private function generalHitAreaMouseOver(param1:MouseEvent) : void
      {
      }
      
      private function generalHitAreaMouseOut(param1:MouseEvent) : void
      {
      }
      
      private function refreshSourceItemsPower() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         this._sourceItemsPower = 0;
         var _loc1_:Boolean = this._sourcePlayerItemIDs.length > 0;
         if(_loc1_)
         {
            _loc2_ = 0;
            while(_loc2_ < this._sourcePlayerItemIDs.length)
            {
               _loc3_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._sourcePlayerItemIDs[_loc2_]);
               _loc4_ = dataM.itemsDB[_loc3_.itemID];
               this._sourceItemsPower += _loc4_.materialPowerContribution;
               _loc2_++;
            }
         }
         this.updateItemsPowerText();
      }
      
      private function updateItemsPowerText() : void
      {
         var _loc3_:BMItemData = null;
         var _loc4_:Object = null;
         var _loc5_:BMItemData = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc1_:Boolean = this._sourcePlayerItemIDs.length > 0;
         var _loc2_:BMPlayerItemData = this.getTargetPlayerItem();
         if(_loc2_ != null)
         {
            _loc3_ = this.getTargetItemData();
            _loc4_ = this._targetItemUpgradeData;
            _loc5_ = _loc4_.itemData;
            _loc6_ = Number(_loc4_.powerRemain);
            _loc7_ = Number(_loc4_.cost);
            if(_loc3_.isMaxLevel() && !_loc3_.canEvolve())
            {
               this.txtSourceItemsPower.text = "MAXED OUT";
            }
            else if(_loc3_.canEvolve())
            {
               _loc8_ = _loc3_.specialStatus + 1;
               if(!_loc1_)
               {
                  this.txtSourceItemsPower.text = "EVOLVING";
               }
               else
               {
                  _loc9_ = _loc8_ - this._sourcePlayerItemIDs.length;
                  if(_loc9_ > 0)
                  {
                     this.txtSourceItemsPower.text = "Need " + _loc9_ + " more " + (_loc9_ == 1 ? "item" : "items");
                  }
                  else
                  {
                     this.txtSourceItemsPower.text = "READY TO EVOLVE";
                  }
               }
            }
            else if(this._sourcePlayerItemIDs.length > 0)
            {
               if(!this.WIP_TEXT_FOR_INTERNAL_TEST || _loc5_.itemID == _loc3_.itemID)
               {
                  this.txtSourceItemsPower.text = "Power: +" + dataM.getNumberWithComma(this._sourceItemsPower);
               }
               else
               {
                  this.txtSourceItemsPower.text = "LVL: " + _loc5_.displayLevel + ". ";
                  if(_loc5_.isMaxLevel())
                  {
                     this.txtSourceItemsPower.appendText("Max");
                  }
                  else
                  {
                     this.txtSourceItemsPower.appendText("Next: " + _loc6_ + "P");
                  }
               }
               this.updatePowerBarText(_loc7_);
            }
            else
            {
               this.txtSourceItemsPower.text = "";
            }
         }
         else
         {
            this.txtSourceItemsPower.text = "";
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("hangerFusion_sourceItemsPower",[this.txtSourceItemsPower],"",this);
         }
      }
      
      private function getItemDataForUpgrade(param1:BMItemData, param2:Number, param3:* = true) : Object
      {
         var _loc5_:Number = NaN;
         var _loc4_:Number = 0;
         if(param1.canEvolve())
         {
            TsLogger.log("Checking evolve for " + param1.itemID);
            _loc4_ = param1.evolutionGoldCost;
            param1 = dataM.itemsDB[param1.upgradeToItemID];
         }
         else
         {
            TsLogger.log("Checking upgrade for " + param1.itemID);
            _loc5_ = param1.powerToUpgrade;
            while(param1.powerToUpgrade > 0 && param2 >= _loc5_)
            {
               _loc4_ += param1.upgradeGoldCost;
               param1 = dataM.itemsDB[param1.upgradeToItemID];
               _loc5_ = param1.powerToUpgrade;
            }
         }
         TsLogger.log("Will cost " + _loc4_ + " and change to " + param1.itemID + " with power: " + param2 + " up to " + param1.powerToUpgrade + " max level: " + param1.isMaxLevel() + " can evolve: " + param1.canEvolve());
         return {
            "itemData":param1,
            "powerRemain":param1.powerToUpgrade - param2,
            "cost":_loc4_
         };
      }
      
      private function isColorKitEquipped() : Boolean
      {
         var _loc3_:BMPlayerItemData = null;
         var _loc1_:Boolean = false;
         var _loc2_:uint = 0;
         while(_loc2_ < this._sourcePlayerItemIDs.length)
         {
            _loc3_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._sourcePlayerItemIDs[_loc2_]);
            if(dataM.isColorKit(_loc3_.itemID))
            {
               _loc1_ = true;
               _loc2_ = this._sourcePlayerItemIDs.length;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getEquippedPlayerItemIDs() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < this._sourcePlayerItemIDs.length)
         {
            _loc1_.push(this._sourcePlayerItemIDs[_loc2_]);
            _loc2_++;
         }
         if(this.hasTargetItem())
         {
            _loc1_.push(this._targetPlayerItemID);
         }
         return _loc1_;
      }
      
      public function getSourcePlayerItemIDs() : Array
      {
         return this._sourcePlayerItemIDs;
      }
      
      public function getTargetPlayerItemID() : Number
      {
         return this._targetPlayerItemID;
      }
      
      private function getTargetPlayerItem() : BMPlayerItemData
      {
         var _loc1_:Number = this.getTargetPlayerItemID();
         if(_loc1_ <= 0)
         {
            return null;
         }
         return dataM.getPlayerItemData(dataM.player1PlayerID,_loc1_);
      }
      
      private function getTargetItemData() : BMItemData
      {
         var _loc1_:BMPlayerItemData = this.getTargetPlayerItem();
         if(_loc1_ == null)
         {
            return null;
         }
         return dataM.itemsDB[_loc1_.itemID];
      }
      
      public function activateTutorialFusionMarker() : void
      {
         this.mcTutorialMarker_activateFusion.gotoAndStop("animOn");
         this.mcTutorialArrow_activateFusion.gotoAndStop("animOn");
      }
      
      public function deactivateTutorialFusionMarker() : void
      {
         this.mcTutorialMarker_activateFusion.gotoAndStop("animOff");
         this.mcTutorialArrow_activateFusion.gotoAndStop("animOff");
      }
      
      public function activateClicked() : void
      {
         var _loc8_:uint = 0;
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:BMItemData = null;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         var _loc4_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,this._targetPlayerItemID);
         var _loc5_:BMItemData = dataM.itemsDB[_loc4_.itemID];
         switch(_loc5_.type)
         {
            case "sideWeapon":
            case "topWeapon":
            case "drone":
            case "teleport":
            case "charge":
            case "harpoon":
               if(_loc5_.damageBase == 0 && _loc5_.damageAddon == 0 && _loc5_.HPAddon == 0)
               {
                  _loc3_ = true;
               }
         }
         var _loc6_:uint = 0;
         while(_loc6_ < this._sourcePlayerItemIDs.length)
         {
            _loc8_ = uint(this._sourcePlayerItemIDs[_loc6_]);
            _loc9_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc8_);
            _loc10_ = dataM.itemsDB[_loc9_.itemID];
            if(_loc10_.specialStatus == 4)
            {
               _loc2_ = _loc8_;
            }
            else if(dataM.isColorKit(_loc10_.itemID))
            {
               _loc1_++;
            }
            _loc6_++;
         }
         var _loc7_:Boolean = false;
         if(_loc3_)
         {
            if(_loc1_ < this._sourcePlayerItemIDs.length)
            {
               _loc7_ = true;
            }
         }
         if(_loc7_)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("cannotUpgradeItemWithNoDamage");
         }
         else if(_loc2_ > 0)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("destroyingMythicalItem_fusion",_loc2_);
         }
         else if(_loc1_ == this._sourcePlayerItemIDs.length)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("activateFusionColor",this._targetPlayerItemID);
         }
         else
         {
            screensM.screenConfirmation.displayQuestionOrNotification("activateFusionPower",this._targetPlayerItemID,this._sourcePlayerItemIDs.length);
         }
         this.deactivateTutorialFusionMarker();
      }
      
      public function mythicalWarningAccepted() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("activateFusionPower",this._targetPlayerItemID,this._sourcePlayerItemIDs.length);
      }
      
      public function fusionAccepted() : void
      {
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            remoteM.socketM.lobby_fusionMultipleItems(this.getFinalSourcePlayerItemIDs(),this._targetPlayerItemID);
         }
         else
         {
            this.activateFusionLocally();
         }
      }
      
      public function getFinalSourcePlayerItemIDs() : Array
      {
         var _loc4_:uint = 0;
         var _loc1_:Array = new Array();
         var _loc2_:Object = new Object();
         var _loc3_:uint = 0;
         while(_loc3_ < this._sourcePlayerItemIDs.length)
         {
            _loc4_ = uint(this._sourcePlayerItemIDs[_loc3_]);
            if(_loc2_[_loc4_] == null)
            {
               _loc2_[_loc4_] = true;
               _loc1_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function activateFusionLocally() : void
      {
         this.activateFusionSuccess();
      }
      
      public function activateFusionSuccess() : void
      {
         var _loc10_:uint = 0;
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:BMItemData = null;
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            dataM.trackEvent("Fusion","activate");
         }
         screensM.removeScreen("screenConfirmation");
         var _loc1_:Number = -1;
         var _loc2_:uint = 0;
         while(_loc2_ < this._sourcePlayerItemIDs.length)
         {
            _loc10_ = uint(this._sourcePlayerItemIDs[_loc2_]);
            _loc11_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc10_);
            if(dataM.isColorKit(_loc11_.itemID))
            {
               _loc12_ = dataM.itemsDB[_loc11_.itemID];
               _loc1_ = int(_loc12_.animation);
            }
            dataM.removePlayerItemData(dataM.player1PlayerID,_loc10_);
            _loc2_++;
         }
         var _loc3_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,this._targetPlayerItemID);
         var _loc4_:BMItemData = this.getTargetItemData();
         var _loc5_:Object = this._targetItemUpgradeData;
         var _loc6_:BMItemData = _loc5_.itemData;
         var _loc7_:Number = Number(_loc5_.powerRemain);
         var _loc8_:Number = Number(_loc5_.cost);
         if(_loc4_.canEvolve())
         {
            _loc3_.power = 0;
         }
         else
         {
            _loc3_.power += this._sourceItemsPower;
         }
         _loc3_.itemID = _loc6_.itemID;
         if(_loc1_ > -1)
         {
            _loc3_.colorID = _loc1_;
         }
         this._targetDestinationPower = _loc3_.power;
         var _loc9_:uint = this._targetDestinationPower - this._targetCurrentPower;
         if(_loc9_ < 1000)
         {
            this._maxPowerAddonPerFrame = Math.ceil(_loc9_ * 0.025);
         }
         else if(_loc9_ < 2500)
         {
            this._maxPowerAddonPerFrame = Math.ceil(_loc9_ * 0.15);
         }
         else
         {
            this._maxPowerAddonPerFrame = Math.ceil(_loc9_ * 0.01);
         }
         dataM.mechEquipment_playerItemIDsUpgraded[this._targetPlayerItemID] = true;
         dataM.myProfile.gold -= int(_loc8_);
         this._sourcePlayerItemIDs = new Array();
         this.sourceItemsTileList.removeAllItems();
         this.refreshSourceList();
         screensM.screenHangerMenu.refreshTutorial();
         soundM.createSound("kitUsed",1);
         this.refreshTargetItemPowerData();
         this.createTargetItem();
         this.updateItemDataForUpgrade();
         this.refreshTargetBonusText();
      }
      
      private function refreshSourceList() : void
      {
         this.addAndRefreshSourceItemsTileList(false,true);
         this.refreshSourceItemsPower();
         this.refreshActivateButton();
         this.refreshCraftMythicalsButton();
         this.refreshInventory();
      }
      
      private function canItemBeUsedAsSourceOfEvolve(param1:BMItemData) : *
      {
         var _loc2_:Number = this.getTargetItemData().specialStatus;
         return param1.specialStatus >= _loc2_;
      }
      
      private function removeAllSourcesThatCantBeUsedForTargetEvolve() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         var _loc1_:* = int(this._sourcePlayerItemIDs.length - 1);
         while(_loc1_ >= 0)
         {
            _loc2_ = uint(this._sourcePlayerItemIDs[_loc1_]);
            _loc3_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc2_);
            _loc4_ = dataM.itemsDB[_loc3_.itemID];
            if(!this.canItemBeUsedAsSourceOfEvolve(_loc4_))
            {
               this.removeSourceItem(_loc1_);
            }
            _loc1_--;
         }
      }
      
      public function craftMythicalSuccess() : void
      {
         var _loc2_:uint = 0;
         screensM.removeScreen("screenConfirmation");
         var _loc1_:uint = 0;
         while(_loc1_ < this._sourcePlayerItemIDs.length)
         {
            _loc2_ = uint(this._sourcePlayerItemIDs[_loc1_]);
            dataM.removePlayerItemData(dataM.player1PlayerID,_loc2_);
            _loc1_++;
         }
         this._sourcePlayerItemIDs = new Array();
         this.sourceItemsTileList.removeAllItems();
         this.addAndRefreshSourceItemsTileList(false,true);
         this.refreshSourceItemsPower();
         this.refreshActivateButton();
         this.refreshCraftMythicalsButton();
         this.refreshInventory();
         screensM.screenHangerMenu.refreshTutorial();
         soundM.createSound("kitUsed",1);
      }
      
      public function getSourceItemsPower() : Number
      {
         return this._sourceItemsPower;
      }
      
      public function craftMythicalsClicked() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("mustRegister",-1,-1);
         }
         else
         {
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < this._sourcePlayerItemIDs.length)
            {
               _loc3_ = uint(this._sourcePlayerItemIDs[_loc2_]);
               _loc4_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc3_);
               _loc5_ = dataM.itemsDB[_loc4_.itemID];
               if(_loc5_.specialStatus == 4)
               {
                  _loc1_ = _loc3_;
               }
               _loc2_++;
            }
            if(_loc1_ == 0)
            {
               this.craftingAccepted();
            }
            else
            {
               screensM.screenConfirmation.displayQuestionOrNotification("destroyingMythicalItem_craft",_loc1_);
            }
         }
      }
      
      public function craftingCancelled() : void
      {
      }
      
      public function craftingAccepted() : void
      {
         screensM.addScreen("screenCraftMythicals");
         screensM.screenCraftMythicals.refreshScreen();
      }
      
      private function setTargetPlayerItemID(param1:Number) : void
      {
         this._targetPlayerItemID = param1;
         this.updateItemDataForUpgrade();
      }
      
      private function updateItemDataForUpgrade() : void
      {
         var _loc1_:BMPlayerItemData = null;
         var _loc2_:BMItemData = null;
         if(this._targetPlayerItemID <= 0)
         {
            this._targetItemUpgradeData = null;
         }
         else
         {
            _loc1_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._targetPlayerItemID);
            _loc2_ = this.getTargetItemData();
            this._targetItemUpgradeData = this.getItemDataForUpgrade(_loc2_,_loc1_.power + this._sourceItemsPower);
         }
      }
      
      private function hasTargetItem() : Boolean
      {
         return this._targetPlayerItemID > 0;
      }
      
      private function setErrorMessageText(param1:String) : void
      {
         this.txtErrorMessage.text = param1;
         if(this.txtErrorMessage.numLines == 1)
         {
            this.txtErrorMessage.y = this._txtErrorMessageOriginYPos + 10;
         }
         else
         {
            this.txtErrorMessage.y = this._txtErrorMessageOriginYPos;
         }
         if(param1 == "")
         {
            this.txtTitle.text = getSpecificText("hanger_fusionTitle");
         }
         else
         {
            this.txtTitle.text = "";
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("hangerFusion_titleAndError",[this.txtTitle,this.txtErrorMessage],"",this);
         }
      }
      
      public function refreshActivateButton() : void
      {
         if(!this.hasTargetItem() || this._sourcePlayerItemIDs.length == 0)
         {
            this.btnActivate.disableMe();
            return;
         }
         var _loc1_:BMItemData = this.getTargetItemData();
         if(_loc1_.canEvolve())
         {
            if(this._sourcePlayerItemIDs.length > _loc1_.specialStatus)
            {
               this.btnActivate.enableMe();
            }
            else
            {
               this.btnActivate.disableMe();
            }
         }
         else if(dataM.isTutorialActive())
         {
            if(this._sourcePlayerItemIDs.length >= 3)
            {
               this.btnActivate.enableMe();
            }
            else
            {
               this.btnActivate.disableMe();
            }
         }
         else
         {
            this.btnActivate.enableMe();
         }
      }
      
      public function refreshCraftMythicalsButton() : void
      {
         if(dataM.useCraftMythicals)
         {
            if(!this.hasTargetItem() && this._sourcePlayerItemIDs.length > 0)
            {
               this.btnCraftMythicals.enableMe();
            }
            else
            {
               this.btnCraftMythicals.disableMe();
            }
         }
         else
         {
            this.btnCraftMythicals.disableMe();
         }
      }
      
      private function removeTargetItemGrp() : void
      {
         if(this.mcTargetTileListItem != null)
         {
            this.mcTargetTileListItem.removeMe();
            this.mcTargetTileListItem = null;
         }
         this.mcTargetItemSlot.gotoAndStop("itemEmpty");
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened("screenHangerFusion"))
         {
            this._sourcePlayerItemIDs = new Array();
            this.setTargetPlayerItemID(0);
            this.removeTargetItemGrp();
            screensM.removeScreen("screenHangerFusion");
            this.sourceItemsTileList.removeMe();
            this.sourceItemsTileList = null;
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.removeMouseListeners();
            }
         }
      }
      
      override public function notifyClientDataReloaded() : *
      {
      }
   }
}

