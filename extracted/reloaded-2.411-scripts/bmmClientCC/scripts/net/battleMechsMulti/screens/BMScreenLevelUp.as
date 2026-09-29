package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol996")]
   public class BMScreenLevelUp extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackground:Sprite;
      
      public var mcSizer_btnOK:Sprite;
      
      public var mcBarLevel:BMBar;
      
      public var mcTutorialArrow_button:MovieClip;
      
      public var mcTutorialMarker_button:MovieClip;
      
      public var mcBlock:Sprite;
      
      public var btnOK:BMButton;
      
      public var mcPin1:Sprite;
      
      public var mcPin13:Sprite;
      
      public var mcLevel13Cover:Sprite;
      
      public var mcMythical1:Sprite;
      
      public var mcMythical2:Sprite;
      
      public var mcLegendary1:Sprite;
      
      public var mcLegendary2A:Sprite;
      
      public var mcLegendary2B:Sprite;
      
      public var mcV15:Sprite;
      
      public var mcV20:Sprite;
      
      public var mcV25:Sprite;
      
      public var mcV30:Sprite;
      
      public var mcSizer_tooltip15:Sprite;
      
      public var mcSizer_tooltip20:Sprite;
      
      public var mcSizer_tooltip25:Sprite;
      
      public var mcSizer_tooltip30:Sprite;
      
      public var mcSizer_barEquipment:Sprite;
      
      private var _barEquipmentIcons:Array = new Array();
      
      private var _barEquipmentVs:Array = new Array();
      
      public var mcItemsUnlockedCenter:Sprite;
      
      private var _btnOKBlockCooldown:Number = 0;
      
      private var _frameCounter:Number;
      
      private var _sparks:Array = new Array();
      
      private var _firstRefresh:Boolean = true;
      
      private var _equipmentIconNames:Object;
      
      private var _pinsList:Array = new Array();
      
      private var _usingWheels:Boolean;
      
      private var mechView:BMMechView;
      
      private const EQUIPMENT_ICON_SIZE:uint = 27;
      
      private const EQUIPMENT_ICON_JUMP:uint = 6;
      
      public function BMScreenLevelUp()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("popUp");
         this.mcBarLevel.initialize("blue","right");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenLevelUp","btnOK","regular");
            _loc1_ = this.OKClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
            }
            this.btnOK.initialize(getGeneralText("OK"),"blue",null,[],_loc1_,dataM.runAsMobile);
            this.btnOK.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.mcTutorialArrow_button.mouseEnabled = false;
            this.mcTutorialArrow_button.mouseChildren = false;
            this.mcTutorialMarker_button.mouseEnabled = false;
            this.mcTutorialMarker_button.mouseChildren = false;
            this._pinsList[1] = true;
            this._pinsList[2] = true;
            this._pinsList[3] = true;
            this._pinsList[4] = true;
            this._pinsList[5] = true;
            this._pinsList[6] = true;
            this._pinsList[7] = true;
            this._pinsList[8] = true;
            this._pinsList[9] = true;
            this._pinsList[10] = true;
            this._pinsList[11] = true;
            this._pinsList[12] = true;
            this._pinsList[13] = true;
            this._pinsList[15] = true;
            this._pinsList[20] = true;
            this._pinsList[25] = true;
            this._pinsList[30] = true;
            this._equipmentIconNames = new Object();
            this._equipmentIconNames["sideWeapon"] = "subType_inventory_sideWeapon";
            this._equipmentIconNames["topWeapon"] = "subType_inventory_topWeapon";
            this._equipmentIconNames["drone"] = "subType_inventory_drone";
            this._equipmentIconNames["shield"] = "subType_inventory_shield";
            this._equipmentIconNames["teleport"] = "emptyItem_teleport2";
            this._equipmentIconNames["charge"] = "emptyItem_charge2";
            this._equipmentIconNames["harpoon"] = "emptyItem_harpoon2";
            this._equipmentIconNames["module"] = "subType_inventory_module";
            this._equipmentIconNames["kit"] = "subType_inventory_kit";
            this._equipmentIconNames["mech1"] = "subType_inventory_all";
            this._equipmentIconNames["mech2"] = "subType_inventory_all";
            this.createEquipmentIcons();
            if(!dataM.runAsMobile)
            {
               this.mcSizer_tooltip15.addEventListener(MouseEvent.MOUSE_OVER,this.cardTooltipMouseOver);
               this.mcSizer_tooltip20.addEventListener(MouseEvent.MOUSE_OVER,this.cardTooltipMouseOver);
               this.mcSizer_tooltip25.addEventListener(MouseEvent.MOUSE_OVER,this.cardTooltipMouseOver);
               this.mcSizer_tooltip30.addEventListener(MouseEvent.MOUSE_OVER,this.cardTooltipMouseOver);
               this.mcSizer_tooltip15.addEventListener(MouseEvent.MOUSE_OUT,this.cardTooltipMouseOut);
               this.mcSizer_tooltip20.addEventListener(MouseEvent.MOUSE_OUT,this.cardTooltipMouseOut);
               this.mcSizer_tooltip25.addEventListener(MouseEvent.MOUSE_OUT,this.cardTooltipMouseOut);
               this.mcSizer_tooltip30.addEventListener(MouseEvent.MOUSE_OUT,this.cardTooltipMouseOut);
            }
            this.mcBarLevel.addSeparateorLines(5);
            this.mcBlock.mouseEnabled = false;
            this.mcBlock.mouseChildren = false;
            this._firstRefresh = false;
         }
         this._frameCounter = 0;
         this.refreshEquipmentIcons();
         if(screensM.isScreenOpened("screenTopBar"))
         {
            screensM.screenTopBar.disableButtons();
         }
         this.btnOK.visible = false;
         this.mcBackground.visible = true;
         this.setLevelBarInitialFill();
         this.createMech();
         this.mcBlock.alpha = 1;
         this.mcBlock.visible = true;
         if(dataM.modulesMax == 7)
         {
            this.mcPin13.visible = true;
            this.mcLevel13Cover.visible = false;
         }
         else
         {
            this.mcPin13.visible = false;
            this.mcLevel13Cover.visible = true;
         }
         if(BMGameShortcutsHelper.levelUpShortcut())
         {
            this.OKClicked();
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:uint = 0;
         var _loc3_:BMMechStructure = null;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMPlayerProfile = null;
         var _loc6_:Array = null;
         var _loc7_:Object = null;
         if(parent != null)
         {
            ++this._frameCounter;
            switch(this._frameCounter)
            {
               case 25:
                  this.setLevelBarNewFill();
                  _loc1_ = dataM.playersData[dataM.player1PlayerID];
                  _loc2_ = 1;
                  _loc3_ = _loc1_.mechStructures[_loc2_];
                  _loc4_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc3_.leg);
                  if(dataM.wheelsDB[_loc4_.itemID] == null)
                  {
                     this.mechView.setWalkingParameters(10,20,null,1.5);
                     this.mechView.walkForward(1,true,this.walkingEnded);
                     this._usingWheels = false;
                  }
                  else
                  {
                     this.mechView.setBumpParameters(6,10);
                     this.mechView.activateWheelsAnimation();
                     this._usingWheels = true;
                  }
                  break;
               case 45:
                  if(this._usingWheels)
                  {
                     this.mechView.deactivateWheelsAnimation();
                     this.walkingEnded();
                  }
                  break;
               case 90:
                  _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
                  screensM.addScreen("screenPopUp");
                  _loc6_ = new Array();
                  for each(_loc7_ in dataM.equipmentUnlockDB)
                  {
                     if(_loc7_.level == _loc5_.level)
                     {
                        _loc6_.push(_loc7_.name);
                     }
                  }
                  screensM.screenPopUp.refreshScreen("levelUp",_loc5_.lastGoldFromLevelUp,_loc5_.lastTokensFromLevelUp,_loc6_);
                  _loc5_.lastGoldFromLevelUp = 0;
                  _loc5_.lastTokensFromLevelUp = 0;
                  this.mcBackground.visible = false;
            }
            if(this.mcBlock.alpha > 0)
            {
               this.mcBlock.alpha -= 0.2;
               if(this.mcBlock.alpha <= 0)
               {
                  this.mcBlock.alpha = 0;
                  this.mcBlock.visible = false;
               }
            }
            if(this._frameCounter >= 25 && this._frameCounter <= 45)
            {
               this.mechView.x += 1;
               if(this._frameCounter == 45)
               {
               }
            }
            this.sparksHandler();
            if(this.mechView != null)
            {
               this.mechView.onEnterFrameTrigger();
            }
         }
      }
      
      private function walkingEnded() : void
      {
         this.refreshEquipmentIcons(true);
         this.mechView.activateTease2(null);
      }
      
      private function createEquipmentIcons() : void
      {
         var _loc1_:Object = null;
         if(this._barEquipmentIcons.length == 0)
         {
            for each(_loc1_ in dataM.equipmentUnlockDB)
            {
               if(_loc1_.level >= 2 && _loc1_.level < dataM.LEVEL_MAX)
               {
                  this.createEquipmentIcon(_loc1_.level,this._equipmentIconNames[_loc1_.name]);
               }
            }
         }
      }
      
      private function createEquipmentIcon(param1:uint, param2:String) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Sprite = null;
         if(this._barEquipmentIcons[param1] == null)
         {
            this._barEquipmentIcons[param1] = new Array();
         }
         if(this._barEquipmentVs[param1] == null)
         {
            this._barEquipmentVs[param1] = new Array();
         }
         if(this._barEquipmentIcons[param1].length < 2)
         {
            _loc3_ = externalAssetsM.getAsset("general",param2,this.EQUIPMENT_ICON_SIZE,this.EQUIPMENT_ICON_SIZE,false,false);
            this._barEquipmentIcons[param1].push(_loc3_);
            _loc3_.x = this.mcSizer_barEquipment.x + (param1 - 2) * (this.EQUIPMENT_ICON_SIZE + this.EQUIPMENT_ICON_JUMP);
            _loc3_.y = this.mcSizer_barEquipment.y + (this._barEquipmentIcons[param1].length - 1) * (this.EQUIPMENT_ICON_SIZE + this.EQUIPMENT_ICON_JUMP);
            this.mcIconsHolder.addChild(_loc3_);
            _loc4_ = new mcLevelUpV();
            this._barEquipmentVs[param1].push(_loc4_);
            _loc4_.x = _loc3_.x;
            _loc4_.y = _loc3_.y;
            this.mcIconsHolder.addChild(_loc4_);
         }
      }
      
      private function refreshEquipmentIcons(param1:Boolean = false) : void
      {
         var _loc5_:uint = 0;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:uint = _loc2_.level - 1;
         if(param1)
         {
            _loc3_ += 1;
         }
         var _loc4_:uint = 1;
         while(_loc4_ <= 15)
         {
            if(this._barEquipmentVs[_loc4_] != null)
            {
               if(_loc4_ > _loc3_)
               {
                  if(this._barEquipmentVs[_loc4_] != null)
                  {
                     _loc5_ = 0;
                     while(_loc5_ < this._barEquipmentVs[_loc4_].length)
                     {
                        if(this._barEquipmentVs[_loc4_][_loc5_].parent != null)
                        {
                           this._barEquipmentVs[_loc4_][_loc5_].parent.removeChild(this._barEquipmentVs[_loc4_][_loc5_]);
                        }
                        _loc5_++;
                     }
                  }
               }
               else if(this._barEquipmentVs[_loc4_] != null)
               {
                  _loc5_ = 0;
                  while(_loc5_ < this._barEquipmentVs[_loc4_].length)
                  {
                     if(this._barEquipmentVs[_loc4_][_loc5_].parent == null)
                     {
                        this.mcIconsHolder.addChild(this._barEquipmentVs[_loc4_][_loc5_]);
                     }
                     _loc5_++;
                  }
               }
            }
            _loc4_++;
         }
         this.mcV15.visible = false;
         this.mcV20.visible = false;
         this.mcV25.visible = false;
         this.mcV30.visible = false;
         if(dataM.runAsMobile == false)
         {
            this.mcSizer_tooltip15.visible = true;
            this.mcSizer_tooltip20.visible = true;
            this.mcSizer_tooltip25.visible = true;
         }
         if(_loc3_ >= 15)
         {
            this.mcV15.visible = true;
            if(dataM.runAsMobile == false)
            {
               this.mcSizer_tooltip15.visible = false;
            }
            if(_loc3_ >= 20)
            {
               this.mcV20.visible = true;
               if(dataM.runAsMobile == false)
               {
                  this.mcSizer_tooltip20.visible = false;
               }
               if(_loc3_ >= 25)
               {
                  this.mcV25.visible = true;
                  if(dataM.runAsMobile == false)
                  {
                     this.mcSizer_tooltip25.visible = false;
                  }
                  if(_loc3_ == 30)
                  {
                     this.mcV30.visible = true;
                     if(dataM.runAsMobile == false)
                     {
                        this.mcSizer_tooltip30.visible = false;
                     }
                  }
               }
            }
         }
      }
      
      public function itemCardsScreenClosed() : void
      {
         this.btnOK.visible = true;
      }
      
      public function screenPopUpClosed() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc3_:uint = 0;
         _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Boolean = true;
         if(_loc1_.randomItemsFromLevelUp != null)
         {
            if(_loc1_.randomItemsFromLevelUp.length > 0)
            {
               screensM.addScreen("screenItemCards");
               _loc3_ = 20;
               switch(_loc1_.level)
               {
                  case 20:
                  case 25:
                     _loc3_ = 25;
               }
               screensM.screenItemCards.refreshScreen(_loc1_.randomItemsFromLevelUp,_loc3_);
               _loc1_.randomItemsFromLevelUp = new Array();
               _loc2_ = false;
            }
         }
         if(_loc2_)
         {
            this.btnOK.visible = true;
            if(_loc1_.level <= 3)
            {
               this.mcTutorialArrow_button.gotoAndStop("animOn");
               this.mcTutorialMarker_button.gotoAndStop("animOn");
            }
         }
         this.mcBackground.visible = true;
      }
      
      private function setLevelBarInitialFill() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = _loc1_.level;
         if(_loc2_ < 2)
         {
            _loc2_ = 2;
         }
         else if(_loc2_ > 30)
         {
            _loc2_ = 30;
         }
         var _loc3_:uint = _loc2_ - 1;
         var _loc4_:Number = 0;
         var _loc5_:Number = 466 / 678;
         var _loc6_:Number = 212 / 678;
         if(_loc3_ < 16)
         {
            _loc4_ = _loc5_ * (_loc3_ - 1) / 14;
         }
         else
         {
            _loc4_ = _loc5_ + _loc6_ * (_loc3_ - 15) / 15;
         }
         this.mcBarLevel.setFill(_loc4_,false);
         this._frameCounter = 0;
      }
      
      private function setLevelBarNewFill() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = _loc1_.level;
         if(_loc2_ < 2)
         {
            _loc2_ = 2;
         }
         else if(_loc2_ > 30)
         {
            _loc2_ = 30;
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = 466 / 678;
         var _loc5_:Number = 212 / 678;
         if(_loc2_ <= 15)
         {
            _loc3_ = _loc4_ * (_loc2_ - 1) / 14;
         }
         else
         {
            _loc3_ = _loc4_ + _loc5_ * (_loc2_ - 15) / 15;
         }
         this.mcBarLevel.setFill(_loc3_,true);
      }
      
      private function sparksHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:Sprite = null;
         var _loc5_:uint = 0;
         var _loc6_:Sprite = null;
         var _loc7_:Sprite = null;
         if(this.mcBlock.visible == false)
         {
            if(screensM.isScreenOpened("screenItemCards") == false)
            {
               _loc2_ = new Array();
               if(this.mcMythical1.visible)
               {
                  _loc2_.push({
                     "name":"mcMythical1",
                     "rarity":4
                  });
               }
               if(this.mcLegendary1.visible)
               {
                  _loc2_.push({
                     "name":"mcLegendary1",
                     "rarity":3
                  });
               }
               if(this.mcLegendary2A.visible)
               {
                  _loc2_.push({
                     "name":"mcLegendary2A",
                     "rarity":3
                  });
                  _loc2_.push({
                     "name":"mcLegendary2B",
                     "rarity":3
                  });
               }
               _loc2_.push({
                  "name":"mcMythical2",
                  "rarity":4
               });
               _loc1_ = 0;
               while(_loc1_ < _loc2_.length)
               {
                  _loc3_ = Math.ceil(Math.random() * 15);
                  if(_loc3_ == 1)
                  {
                     _loc4_ = this[_loc2_[_loc1_].name];
                     _loc5_ = uint(_loc2_[_loc1_].rarity);
                     _loc6_ = externalAssetsM.getAsset("general","Grp_itemCardSpark" + _loc5_,40,40,false,false);
                     _loc6_.x = _loc4_.x + 20 + Math.random() * (_loc4_.width - 4) - _loc4_.width / 2;
                     _loc6_.y = _loc4_.y + Math.random() * (_loc4_.height - 3);
                     this.mcIconsHolder.addChild(_loc6_);
                     this._sparks.push(_loc6_);
                  }
                  _loc1_++;
               }
            }
            _loc1_ = 0;
            while(_loc1_ < this._sparks.length)
            {
               _loc7_ = this._sparks[_loc1_];
               if(_loc7_.scaleX > 0.075)
               {
                  _loc7_.scaleX -= 0.075;
                  _loc7_.scaleY -= 0.075;
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
      }
      
      private function createMech() : void
      {
         this.removeMech();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc3_:uint = 1;
         var _loc4_:BMMechStructure = _loc2_.mechStructures[_loc3_];
         this.mechView = new BMMechView();
         this.mechView.initialize(dataM.player1PlayerID,"hanger","playerItemID",0.3,false);
         this.mechView.buildMech(_loc4_,"levelUp");
         var _loc5_:Number = 0;
         var _loc6_:Number = 466 / 678;
         var _loc7_:Number = 212 / 678;
         if(_loc1_.level <= 15)
         {
            _loc5_ = (_loc1_.level - 2) / 14 * 466;
         }
         else
         {
            _loc5_ = 466 + (_loc1_.level - 16) / 15 * 212 - 25;
         }
         this.mechView.x = this.mcPin1.x + _loc5_;
         this.mechView.y = this.mcPin1.y - 35 - (this.mechView.mechSizer.height + this.mechView.mechSizer.y);
         addChild(this.mechView);
      }
      
      private function removeMech() : void
      {
         if(this.mechView != null)
         {
            this.mechView.removeMe();
            this.mechView = null;
         }
      }
      
      private function cardTooltipMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:Number = int(param1.target.name.substr(15,2));
         this.cardTooltipMouseOverSub(_loc2_);
      }
      
      public function cardTooltipMouseOverSub(param1:uint) : void
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 15:
               tooltip.showToolTip("regularText",getSpecificText("tooltip_oneMythicalItem"));
               break;
            case 20:
               tooltip.showToolTip("regularText",getSpecificText("tooltip_oneLegendaryItem"));
               break;
            case 25:
               _loc2_ = getSpecificText("tooltip_severalLegendaryItems");
               _loc2_ = dataM.replaceStringInText(_loc2_,"%AMOUNT%","2");
               tooltip.showToolTip("regularText",_loc2_);
               break;
            case 30:
               tooltip.showToolTip("regularText",getSpecificText("tooltip_oneMythicalItem"));
         }
      }
      
      private function cardTooltipMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      public function OKClicked() : void
      {
         this.removeMech();
         this.mcTutorialArrow_button.gotoAndStop("animOff");
         this.mcTutorialMarker_button.gotoAndStop("animOff");
         if(screensM.isScreenOpened("screenTopBar"))
         {
            if(screensM.isScreenOpened("screenMissionCompleted") == false)
            {
               screensM.screenTopBar.enableButtons("screenTopBar screenLevelUpClosed");
            }
         }
         if(screensM.isScreenOpened("screenHangerMenu"))
         {
            screensM.screenHangerMenu.refreshTutorial();
         }
         screensM.addScreen("screenLevelUpEntry");
         screensM.screenLevelUpEntry.refreshScreen(false);
         screensM.removeScreen("screenLevelUp");
      }
   }
}

