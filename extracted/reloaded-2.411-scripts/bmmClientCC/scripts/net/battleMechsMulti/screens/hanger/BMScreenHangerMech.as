package net.battleMechsMulti.screens.hanger
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechEquipment;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_arrowLeft;
   import net.battleMechsMulti.mobiles.buttons.BMButton_arrowRight;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureK;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1362")]
   public class BMScreenHangerMech extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcMechEquipmentHolder:Sprite;
      
      public var mcMechIDTextHolder:Sprite;
      
      public var mcSizer_mechEquipment:Sprite;
      
      public var mcSizer_btnPreviousMech:Sprite;
      
      public var mcSizer_btnNextMech:Sprite;
      
      public var mcSizer_btnRedeemStarterPackMech:Sprite;
      
      public var mcSizer_icon_weight:Sprite;
      
      public var mcSizer_torso:Sprite;
      
      public var mcSizer_leg:Sprite;
      
      public var mcSizer_sideWeapon1:Sprite;
      
      public var mcSizer_sideWeapon2:Sprite;
      
      public var mcSizer_sideWeapon3:Sprite;
      
      public var mcSizer_sideWeapon4:Sprite;
      
      public var mcSizer_topWeapon1:Sprite;
      
      public var mcSizer_topWeapon2:Sprite;
      
      public var mcSizer_drone:Sprite;
      
      public var mcSizer_shield:Sprite;
      
      public var mcSizer_teleport:Sprite;
      
      public var mcSizer_charge:Sprite;
      
      public var mcSizer_harpoon:Sprite;
      
      public var mcSizer_kit1:Sprite;
      
      public var mcSizer_kit2:Sprite;
      
      public var mcSizer_module1:Sprite;
      
      public var mcSizer_module2:Sprite;
      
      public var mcSizer_module3:Sprite;
      
      public var mcSizer_module4:Sprite;
      
      public var mcSizer_module5:Sprite;
      
      public var mcSizer_module6:Sprite;
      
      public var mcSizer_module7:Sprite;
      
      public var mcSizer_perk:Sprite;
      
      public var mc_icon_weight:MovieClip;
      
      public var mc_icon_inspectMech:MovieClip;
      
      public var mcTooltip_weight:MovieClip;
      
      public var mcTooltip_inspectMech:MovieClip;
      
      public var mcMechHologram:MovieClip;
      
      public var mcMechStatsBackground:Sprite;
      
      public var txtWeight:TextField;
      
      public var txtMechID:TextField;
      
      public var mechEquipment:BMMechEquipment;
      
      public var mechGlowHandler:Boolean;
      
      public var mechGlowCounter:Number;
      
      private var _mechAnimationCooldown:Number;
      
      public var draggingItemFromMechEquipment:Boolean;
      
      public var mechRollOverLastEquipmentType:String;
      
      public var mechRollOverLastEquipmentID:Number;
      
      public var mouseOverEquipmentItems:Boolean = false;
      
      public var mcWeightInfo:MovieClip;
      
      private var _targetMechID:uint = 1;
      
      private var _currentPlayerData:BMPlayerData;
      
      private var _currentMechTotalHP:Number = 0;
      
      private var _currentMechTotalEnergy:Number = 0;
      
      private var _currentMechTotalEnergyRegeneration:Number = 0;
      
      private var _currentMechTotalHeat:Number = 0;
      
      private var _currentMechTotalHeatCooling:Number = 0;
      
      private var _currentMechTotalBullets:Number = 0;
      
      private var _currentMechTotalRockets:Number = 0;
      
      private var _currentMechResist1:Number = 0;
      
      private var _currentMechResist2:Number = 0;
      
      private var _currentMechResist3:Number = 0;
      
      public var weaponsYPos:Number;
      
      public var modulesYPos:Number;
      
      public var btnNextMech:BMButton_arrowRight;
      
      public var btnPreviousMech:BMButton_arrowLeft;
      
      public var btnRedeemStarterPackMech:BMButton_pictureK;
      
      public var mcTutorialArrow_unequipShort:MovieClip;
      
      public var mcTutorialArrow_unequipLong:MovieClip;
      
      private var mechStatsBMD:BitmapData;
      
      private var mechStatsBM:Bitmap;
      
      private var _mechStatsInstancesInitialized:Boolean = false;
      
      private const MECH_SIZE_RATIO:Number = 0.85;
      
      private const MECH_ANIMATION_COOLDOWN_MAX:Number = 600;
      
      public function BMScreenHangerMech()
      {
         super();
      }
      
      public function initialize() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("hangerMech");
         screensM.createButtonFromSizer("screenHangerMech","btnNextMech","arrowRight");
         screensM.createButtonFromSizer("screenHangerMech","btnPreviousMech","arrowLeft");
         screensM.createButtonFromSizer("screenHangerMech","btnRedeemStarterPackMech","pictureK");
         this.btnNextMech.initialize("","",null,null,this.nextMechClicked,dataM.runAsMobile);
         this.btnPreviousMech.initialize("","",null,null,this.previousMechClicked,dataM.runAsMobile);
         this.btnRedeemStarterPackMech.initialize("","",externalAssetsM.getAsset("general","interface_gift"),null,this.redeemStarterPackMechClicked,dataM.runAsMobile);
         if(dataM.runAsMobile == false)
         {
            this.btnNextMech.buttonCore.addMouseOverListerner(this.nextMechButtonMouseOver);
            this.btnNextMech.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
            this.btnPreviousMech.buttonCore.addMouseOverListerner(this.previousMechButtonMouseOver);
            this.btnPreviousMech.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
            this.btnRedeemStarterPackMech.buttonCore.addMouseOverListerner(this.redeemStarterPackMechMouseOver);
            this.btnRedeemStarterPackMech.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
         }
         this.btnNextMech.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnPreviousMech.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnRedeemStarterPackMech.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         if(dataM.runAsMobile)
         {
            _loc1_ = 10;
            _loc2_ = 5;
            this.mcSizer_sideWeapon1.x += _loc2_;
            this.mcSizer_sideWeapon2.x += _loc2_;
            this.mcSizer_sideWeapon3.x += _loc2_;
            this.mcSizer_sideWeapon4.x += _loc2_;
            this.mcSizer_topWeapon1.x += _loc2_;
            this.mcSizer_topWeapon2.x += _loc2_;
            this.mcSizer_drone.x += _loc1_;
            this.mcSizer_shield.x += _loc1_;
            this.mcSizer_kit1.x += _loc1_;
            this.mcSizer_kit2.x += _loc1_;
            this.mcSizer_module1.x += _loc2_;
            this.mcSizer_module2.x += _loc2_;
            this.mcSizer_module3.x += _loc2_;
            this.mcSizer_module4.x += _loc2_;
            this.mcSizer_module5.x += _loc2_;
            this.mcSizer_module6.x += _loc2_;
            this.mcSizer_module7.x += _loc2_;
         }
         this.mcTutorialArrow_unequipShort.mouseEnabled = false;
         this.mcTutorialArrow_unequipShort.mouseChildren = false;
         this.mcTutorialArrow_unequipLong.mouseEnabled = false;
         this.mcTutorialArrow_unequipLong.mouseChildren = false;
         this.mechGlowHandler = false;
         this.weaponsYPos = this.mcSizer_sideWeapon1.y;
         this.modulesYPos = this.mcSizer_module1.y;
      }
      
      public function refreshScreen(param1:Boolean) : void
      {
         if(this._mechStatsInstancesInitialized == false)
         {
            this.initializeMechStatsInstances();
            this._mechStatsInstancesInitialized = true;
         }
         this.draggingItemFromMechEquipment = false;
         this.mechRollOverLastEquipmentType = "";
         this.mechRollOverLastEquipmentID = 0;
         this._currentPlayerData = dataM.playersData[dataM.player1PlayerID];
         if(param1)
         {
            this._targetMechID = 1;
         }
         this.addAndRefreshMechEquipment();
         this.refreshMechStats(0);
         this.mechEquipment.refreshEquipemnt(true,true);
         this._mechAnimationCooldown = this.MECH_ANIMATION_COOLDOWN_MAX;
         this.refreshSelectedMech();
         this.showAllAvailableItems();
         this.refreshRedeemStarterPackMechButton();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            this.mechGlowHandlerFunction();
            this.mechTeaserHandler();
            this.mechItemsSelectionHandler();
            this.mechEquipment.onEnterFrameTrigger();
         }
      }
      
      private function addAndRefreshMechEquipment() : void
      {
         if(this.mechEquipment == null)
         {
            if(dataM.runAsMobile)
            {
               this.mcSizer_mechEquipment.x += screensM.screenHangerInventory.TILE_LIST_X_PUSH_MOBILE / 2;
               this.mcMechHologram.x += screensM.screenHangerInventory.TILE_LIST_X_PUSH_MOBILE / 2;
            }
            this.mechEquipment = new BMMechEquipment();
            this.mechEquipment.initialize(screensM.screenHangerInventory.equipmentItemMouseDown,screensM.screenHangerInventory.equipmentItemMouseUp,screensM.screenHangerInventory.equipmentItemMouseOver,screensM.screenHangerInventory.equipmentItemMouseOut,screensM.screenHangerInventory.mouseUpOutsideEquipment,screensM.screenHangerInventory.mouseDownOutsideEquipment,screensM.screenHangerInventory.mouseOverOutsideEquipment,screensM.screenHangerInventory.mouseOutOutsideEquipment,screensM.screenHangerInventory.mechEquipmentBreakApart,this.mcMechHologram,this.mcSizer_mechEquipment);
            this.mechEquipment.x = this.mcSizer_mechEquipment.x + this.mcSizer_mechEquipment.width / 2;
            this.mechEquipment.y = this.mcSizer_mechEquipment.y + this.mcSizer_mechEquipment.height / 2;
            this.mcMechEquipmentHolder.addChild(this.mechEquipment);
         }
         this.mechEquipment.addMechView();
      }
      
      public function equipmentItemClicked(param1:String, param2:Number, param3:Number) : void
      {
         var _loc5_:String = null;
         var _loc6_:BMTileListItem = null;
         var _loc4_:Boolean = false;
         if(param3 > 0)
         {
            _loc5_ = param1;
            if(param2 > 0)
            {
               _loc5_ += param2;
            }
            _loc6_ = this.mechEquipment[_loc5_];
            _loc6_.removeDisabledEffect();
            if(dataM.runAsMobile)
            {
            }
         }
         else
         {
            _loc4_ = true;
         }
         if(_loc4_ == false || _loc4_)
         {
            screensM.screenHangerInventory.itemTypeClickedSub(dataM.shopItemTypesReverseDB[param1],true,false,false,-1,"hangerMech equipmentItemClicked");
         }
      }
      
      private function mechGlowHandlerFunction() : void
      {
         if(this.mechGlowHandler)
         {
            ++this.mechGlowCounter;
            switch(this.mechGlowCounter)
            {
               case 20:
                  screensM.screenHangerMenu.mcMechComplete.visible = true;
                  this.mechEquipment.mechView.activateTease2(null);
                  break;
               case 22:
               case 28:
               case 34:
               case 40:
               case 46:
               case 52:
                  this.mechEquipment.addItemStaticGlow("torso",-1);
                  this.mechEquipment.addItemStaticGlow("leg",-1);
                  this.mechEquipment.addItemStaticGlow("sideWeapon",1);
                  this.mechEquipment.addItemStaticGlow("sideWeapon",2);
                  break;
               case 25:
               case 31:
               case 37:
               case 43:
               case 49:
               case 55:
                  this.mechEquipment.removeAllItemsStaticGlow();
                  break;
               case 58:
                  this.mechGlowHandler = false;
                  screensM.screenHangerMenu.mcMechComplete.visible = false;
                  screensM.screenHangerMenu.updateMech();
            }
         }
      }
      
      private function createMechStatsIconFromSizer(param1:String) : void
      {
         var _loc2_:Sprite = this["mcSizer_" + param1];
         this["mc_" + param1] = externalAssetsM.getAsset("general",param1,_loc2_.width,_loc2_.height,false,false);
         this["mc_" + param1].x = _loc2_.x;
         this["mc_" + param1].y = _loc2_.y;
         this.mcIconsHolder.addChild(this["mc_" + param1]);
      }
      
      private function initializeMechStatsInstances() : void
      {
         this.createMechStatsIconFromSizer("icon_weight");
         this.mcTooltip_weight.type = "weight";
         this.mcTooltip_inspectMech.type = "inspectMech";
         if(dataM.runAsMobile == false)
         {
            this.mcTooltip_weight.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
            this.mcTooltip_weight.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
            this.mcTooltip_inspectMech.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
            this.mcTooltip_inspectMech.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
         }
      }
      
      private function tooltipMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.type;
         if(_loc2_ == "inspectMech")
         {
            tooltip.showToolTip("inspectMech","",this._targetMechID);
         }
         else
         {
            tooltip.showToolTip("regularText",getSpecificText("tooltip_" + _loc2_));
         }
      }
      
      private function tooltipMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      public function hideMechStats() : void
      {
         this.mcMechStatsBackground.visible = false;
         this.mc_icon_inspectMech.visible = false;
         this.mc_icon_weight.visible = false;
         this.mcTooltip_inspectMech.visible = false;
         this.mcTooltip_weight.visible = false;
         this.txtWeight.text = "";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("hangerMechWeight",[this.txtWeight],"",this);
         }
      }
      
      public function showMechStats() : void
      {
         this.refreshMechStats(0);
      }
      
      public function refreshMechStats(param1:uint) : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:BMPlayerData = null;
         var _loc4_:BMMechStructure = null;
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:BMItemData = null;
         var _loc13_:uint = 0;
         var _loc14_:BMPlayerItemData = null;
         if(screensM.isScreenOpened("screenHangerItemComparison") == false)
         {
            _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc3_ = dataM.playersData[dataM.player1PlayerID];
            _loc4_ = _loc3_.mechStructures[this._targetMechID];
            this.hideMechStats();
            if(_loc2_.tutorialLevel > BMTutorialManager.TUTORIAL_LEVEL_MECH1)
            {
               _loc5_ = false;
               if(_loc4_.hasAtLeastOneItem())
               {
                  _loc5_ = true;
               }
               if(_loc5_)
               {
                  _loc6_ = Number(_loc3_.mechStructures[this._targetMechID].mechWeight);
                  _loc7_ = 0;
                  _loc8_ = 0;
                  if(param1 > 0)
                  {
                     _loc11_ = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
                     _loc12_ = dataM.itemsDB[_loc11_.itemID];
                     _loc7_ = uint(_loc12_.weight);
                     switch(_loc12_.type)
                     {
                        case "torso":
                        case "leg":
                        case "drone":
                        case "shield":
                        case "teleport":
                        case "charge":
                        case "harpoon":
                           _loc13_ = uint(_loc4_[_loc12_.type]);
                           if(_loc13_ > 0)
                           {
                              _loc14_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc13_);
                              _loc8_ = _loc14_.weight;
                           }
                     }
                  }
                  _loc9_ = _loc6_ + _loc7_ - _loc8_;
                  if(_loc9_ > dataM.weightMax)
                  {
                     if(_loc6_ > dataM.weightMax)
                     {
                        _loc10_ = dataM.COLOR_BAD;
                     }
                     else
                     {
                        _loc10_ = "FF6600";
                     }
                  }
                  else if(_loc7_ > 0)
                  {
                     _loc10_ = "FFCC00";
                  }
                  else
                  {
                     _loc10_ = "DDDDDD";
                  }
                  this.txtWeight.htmlText = "<FONT COLOR=\'#" + _loc10_ + "\'>" + dataM.getNumberWithComma(_loc9_) + "</FONT> / " + dataM.getNumberWithComma(dataM.weightMax);
                  this.mc_icon_weight.visible = true;
                  this.mc_icon_inspectMech.visible = true;
                  this.mcTooltip_weight.visible = true;
                  this.mcTooltip_inspectMech.visible = true;
                  this.mcMechStatsBackground.visible = true;
               }
            }
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("hangerMechWeight",[this.txtWeight],"",this);
            }
         }
      }
      
      private function mechItemsSelectionHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerData = null;
         var _loc3_:BMMechStructure = null;
         var _loc4_:BMMechView = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:String = null;
         var _loc11_:MovieClip = null;
         var _loc12_:MovieClip = null;
         var _loc13_:Point = null;
         var _loc14_:Point = null;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:String = null;
         var _loc20_:String = null;
         if(dataM.tutorialEnabled == false && dataM.runAsMobile == false)
         {
            if(this.mouseOverEquipmentItems == false)
            {
               _loc1_ = false;
               if(mouseX >= this.mcSizer_mechEquipment.x && mouseX <= this.mcSizer_mechEquipment.x + this.mcSizer_mechEquipment.width)
               {
                  if(mouseY >= this.mcSizer_mechEquipment.y && mouseY <= this.mcSizer_mechEquipment.y + this.mcSizer_mechEquipment.height)
                  {
                     _loc2_ = dataM.playersData[dataM.player1PlayerID];
                     _loc3_ = _loc2_.mechStructures[this._targetMechID];
                     if(_loc3_.torso > 0)
                     {
                        _loc4_ = this.mechEquipment.mechView;
                        _loc5_ = _loc4_.getItemsHolder();
                        _loc6_ = _loc4_.getItemsHoldersNames();
                        _loc7_ = 9999;
                        _loc8_ = -1;
                        _loc9_ = 0;
                        while(_loc9_ < _loc5_.length)
                        {
                           _loc11_ = _loc5_[_loc9_];
                           if(_loc11_.item != null)
                           {
                              _loc12_ = _loc11_.item.itemGrp;
                              _loc13_ = new Point(_loc12_.x + _loc12_.width / 2,_loc12_.y + _loc12_.height / 2);
                              _loc14_ = _loc12_.localToGlobal(_loc13_);
                              _loc15_ = mouseX - _loc14_.x;
                              _loc16_ = mouseY;
                              if(_loc16_ > 400)
                              {
                                 _loc16_ += 200;
                              }
                              _loc17_ = _loc16_ - _loc14_.y;
                              _loc18_ = dataM.getVectorSize(_loc15_,_loc17_);
                              if(_loc7_ > _loc18_)
                              {
                                 _loc7_ = _loc18_;
                                 _loc8_ = _loc9_;
                              }
                           }
                           _loc9_++;
                        }
                        _loc10_ = this.mechRollOverLastEquipmentType;
                        if(this.mechRollOverLastEquipmentID > 0)
                        {
                           _loc10_ = this.mechRollOverLastEquipmentType + this.mechRollOverLastEquipmentID;
                        }
                        if(_loc7_ < 140)
                        {
                           _loc19_ = _loc6_[_loc8_];
                           if(_loc19_ == "leg1" || _loc19_ == "leg2")
                           {
                              _loc19_ = "leg";
                           }
                           if(_loc10_ != _loc19_)
                           {
                              if(this.mechRollOverLastEquipmentType != "")
                              {
                                 _loc4_.removeItemStaticGlow(_loc10_);
                              }
                              this.mechRollOverLastEquipmentID = 0;
                              switch(_loc19_)
                              {
                                 case "leg":
                                 case "torso":
                                    this.mechRollOverLastEquipmentType = _loc19_;
                                    break;
                                 default:
                                    _loc20_ = _loc19_.substr(_loc19_.length - 1,1);
                                    switch(_loc20_)
                                    {
                                       case "1":
                                       case "2":
                                       case "3":
                                       case "4":
                                       case "5":
                                       case "6":
                                          this.mechRollOverLastEquipmentType = _loc19_.substr(0,_loc19_.length - 1);
                                          this.mechRollOverLastEquipmentID = int(_loc20_);
                                          break;
                                       default:
                                          this.mechRollOverLastEquipmentType = _loc19_;
                                    }
                              }
                              _loc4_.addItemStaticGlow(_loc19_,"lightGreen");
                           }
                        }
                        else
                        {
                           _loc1_ = true;
                        }
                     }
                  }
                  else
                  {
                     _loc1_ = true;
                  }
               }
               else
               {
                  _loc1_ = true;
               }
               if(_loc1_)
               {
                  if(this.mechRollOverLastEquipmentType != "")
                  {
                     this.clearItemMechRollOver(false,"mechItemsSelectionHandler");
                  }
               }
            }
         }
      }
      
      public function clearItemMechRollOver(param1:Boolean, param2:String) : void
      {
         var _loc3_:String = null;
         if(screensM.isScreenOpened("screenHangerMech"))
         {
            if(this.mechRollOverLastEquipmentType != "")
            {
               _loc3_ = this.mechRollOverLastEquipmentType;
               if(this.mechRollOverLastEquipmentID > 0)
               {
                  _loc3_ = this.mechRollOverLastEquipmentType + this.mechRollOverLastEquipmentID;
               }
               this.mechEquipment.mechView.removeItemStaticGlowLock();
               this.mechEquipment.mechView.removeItemStaticGlow(_loc3_);
               this.mechRollOverLastEquipmentType = "";
               this.mechRollOverLastEquipmentID = 0;
            }
            if(param1)
            {
               this.draggingItemFromMechEquipment = false;
            }
         }
      }
      
      public function hideAllItemsExceptType(param1:String) : void
      {
         this.mechEquipment.hideAllItemsExceptType(param1);
         this.mechEquipment.mechView.visible = false;
         this.btnNextMech.visible = false;
         this.btnPreviousMech.visible = false;
      }
      
      public function showAllAvailableItems() : void
      {
         this.mechEquipment.showAllAvailableItems();
         this.mechEquipment.mechView.visible = true;
         this.refreshSelectedMech();
      }
      
      private function mechTeaserHandler() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:Number = NaN;
         if(this._mechAnimationCooldown > 0)
         {
            --this._mechAnimationCooldown;
         }
         else
         {
            _loc1_ = dataM.playersData[dataM.player1PlayerID];
            if(dataM.isMechReadyForBattle(true))
            {
               _loc2_ = Math.ceil(Math.random() * 5);
               switch(_loc2_)
               {
                  case 1:
                     this.mechEquipment.mechView.activateTease1(null);
                     break;
                  case 2:
                     this.mechEquipment.mechView.activateTease3(null);
                     break;
                  case 3:
                     this.mechEquipment.mechView.activateTease4(null);
                     break;
                  case 4:
                     this.mechEquipment.mechView.activateTease5(null);
                     break;
                  case 5:
                     this.mechEquipment.mechView.activateTease6(null);
               }
            }
            this._mechAnimationCooldown = this.MECH_ANIMATION_COOLDOWN_MAX;
         }
      }
      
      public function getTargetMechID() : uint
      {
         return this._targetMechID;
      }
      
      public function nextMechClicked() : void
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:uint = 0;
         var _loc5_:BMMechStructure = null;
         var _loc1_:uint = dataM.battleMaxMechs;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc2_.level < dataM.LEVEL_MAX)
         {
            _loc3_ = dataM.playersData[dataM.player1PlayerID];
            if(dataM.inventoryMaxMechs > dataM.battleMaxMechs)
            {
               _loc4_ = dataM.battleMaxMechs + 1;
               while(_loc4_ <= dataM.inventoryMaxMechs)
               {
                  _loc5_ = _loc3_.mechStructures[_loc4_];
                  if(_loc5_.hasAtLeastOneItem())
                  {
                     _loc1_ = dataM.inventoryMaxMechs;
                     _loc4_ = dataM.inventoryMaxMechs;
                  }
                  _loc4_++;
               }
            }
         }
         if(this._targetMechID >= _loc1_)
         {
            this._targetMechID = 1;
         }
         else
         {
            ++this._targetMechID;
         }
         this.refreshScreen(false);
      }
      
      public function previousMechClicked() : void
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:uint = 0;
         var _loc5_:BMMechStructure = null;
         var _loc1_:uint = dataM.battleMaxMechs;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc2_.level < dataM.LEVEL_MAX)
         {
            _loc3_ = dataM.playersData[dataM.player1PlayerID];
            if(dataM.inventoryMaxMechs > dataM.battleMaxMechs)
            {
               _loc4_ = dataM.battleMaxMechs + 1;
               while(_loc4_ <= dataM.inventoryMaxMechs)
               {
                  _loc5_ = _loc3_.mechStructures[_loc4_];
                  TsLogger.log(_loc4_ + " " + _loc5_.hasAtLeastOneItem());
                  if(_loc5_.hasAtLeastOneItem())
                  {
                     _loc1_ = dataM.inventoryMaxMechs;
                     _loc4_ = dataM.inventoryMaxMechs;
                  }
                  _loc4_++;
               }
            }
         }
         if(this._targetMechID <= 1)
         {
            this._targetMechID = _loc1_;
         }
         else
         {
            --this._targetMechID;
         }
         this.refreshScreen(false);
      }
      
      public function nextMechButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("nextMech"),-1,-1);
      }
      
      public function previousMechButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("previousMech"),-1,-1);
      }
      
      public function changeMechsOrderMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("changeMechsOrder"),-1,-1);
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      private function refreshSelectedMech() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.level < dataM.SECOND_MECH_UNLOCK_LEVEL)
         {
            this.btnNextMech.visible = false;
            this.btnPreviousMech.visible = false;
         }
         else
         {
            this.btnNextMech.visible = true;
            this.btnPreviousMech.visible = true;
         }
      }
      
      public function changeMechsOrderClicked() : void
      {
         screensM.addScreen("screenChangeMechsOrder");
         screensM.screenChangeMechsOrder.refreshScreen();
         screensM.screenHangerInventory.changeMechsOrderScreenOpened();
      }
      
      public function redeemStarterPackMechClicked() : void
      {
         remoteM.socketM.lobby_redeemStarterPackMech(this._targetMechID);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      public function redeemStarterPackMechMouseOver() : void
      {
         tooltip.showToolTip("regularText","Unpack new Mech",-1,-1);
      }
      
      public function refreshRedeemStarterPackMechButton() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.pendingStarterPackMech > 0)
         {
            this.btnRedeemStarterPackMech.visible = true;
         }
         else
         {
            this.btnRedeemStarterPackMech.visible = false;
         }
      }
      
      public function resetUnequipPointers() : void
      {
         this.mcTutorialArrow_unequipLong.gotoAndStop("animOff");
         this.mcTutorialArrow_unequipShort.gotoAndStop("animOff");
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened("screenHangerMech"))
         {
            this.resetUnequipPointers();
            screensM.removeScreen("screenHangerMech");
            if(screensM.isScreenOpened("screenHangerItemComparison"))
            {
               screensM.screenHangerItemComparison.removeMe();
            }
            if(screensM.isScreenOpened("screenChangeMechsOrder"))
            {
               screensM.screenChangeMechsOrder.removeMe();
            }
            if(dataM.runAsMobile)
            {
               this.mechEquipment.removeEquipmentMarkers();
            }
         }
      }
      
      public function getCurrentMechTotalBullets() : Number
      {
         return this._currentMechTotalBullets;
      }
      
      public function getCurrentMechTotalRockets() : Number
      {
         return this._currentMechTotalRockets;
      }
   }
}

