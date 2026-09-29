package net.battleMechsMulti.mobiles
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2164")]
   public class BMMechBattleTooltip extends BMBaseClass
   {
      
      public var mcBackground:MovieClip;
      
      public var mcSizer_icon1:Sprite;
      
      public var mcSizer_icon2:Sprite;
      
      public var mcSizer_icon3:Sprite;
      
      public var mcSizer_icon4:Sprite;
      
      public var mcSizer_icon5:Sprite;
      
      public var mcSizer_icon6:Sprite;
      
      public var txtRow1:TextField;
      
      public var txtRow2:TextField;
      
      public var txtRow3:TextField;
      
      public var txtRow4:TextField;
      
      public var txtRow5:TextField;
      
      public var txtRow6:TextField;
      
      public var mcUses1:MovieClip;
      
      public var mcUses2:MovieClip;
      
      public var mcUses3:MovieClip;
      
      public var mcUses4:MovieClip;
      
      public var mcUses5:MovieClip;
      
      private var mcIcon_HP:Sprite;
      
      private var mcIcon_repair:Sprite;
      
      private var mcIcon_heat:Sprite;
      
      private var mcIcon_energy:Sprite;
      
      private var mcIcon_bullets:Sprite;
      
      private var mcIcon_rockets:Sprite;
      
      private var mcIcon_push:Sprite;
      
      private var mcIcon_pull:Sprite;
      
      private var mcIcon_damageHeatBase:Sprite;
      
      private var mcIcon_damageHeatAddon:Sprite;
      
      private var mcIcon_damageEnergyBase:Sprite;
      
      private var mcIcon_damageEnergyAddon:Sprite;
      
      private var mcIcon_damageType_physical:Sprite;
      
      private var mcIcon_damageType_explosive:Sprite;
      
      private var mcIcon_damageType_explosivePlus:Sprite;
      
      private var mcIcon_damageType_electric:Sprite;
      
      private var mcIcon_damageType_electricPlus:Sprite;
      
      private var mcIcon_resist_physical:Sprite;
      
      private var mcIcon_resist_explosive:Sprite;
      
      private var mcIcon_resist_electric:Sprite;
      
      private var mcIcon_damageResist_physical:Sprite;
      
      private var mcIcon_damageResist_explosive:Sprite;
      
      private var mcIcon_damageResist_electric:Sprite;
      
      private var mcIcon_rank1:Sprite;
      
      private var mcIcon_rank2:Sprite;
      
      private var mcIcon_rank3:Sprite;
      
      private var mcIcon_rank4:Sprite;
      
      private var mcIcon_rank5:Sprite;
      
      private var mcIcon_rank6:Sprite;
      
      private var mcIcon_rank7:Sprite;
      
      private var mcIcon_rank8:Sprite;
      
      private var mcIcon_rank9:Sprite;
      
      private var mcIcon_rank10:Sprite;
      
      private var mcIcon_rank11:Sprite;
      
      private var mcIcon_rank12:Sprite;
      
      private var mcIcon_rank13:Sprite;
      
      private var mcIcon_rank14:Sprite;
      
      private var mcIcon_rank15:Sprite;
      
      private var mcIcon_rank16:Sprite;
      
      private var _interfacePlayerID:Number;
      
      private var _showMeCounter:Number;
      
      private var _hideMeCounter:Number;
      
      private var _hideMe:Boolean;
      
      private var _targetXPos:Number;
      
      private var _xDirection:String;
      
      private var _txtRow1YPos:Number;
      
      private var _txtRow2YPos:Number;
      
      private var _txtRow3YPos:Number;
      
      private var _txtRow4YPos:Number;
      
      private var _txtRow5YPos:Number;
      
      private var _txtRow6YPos:Number;
      
      private var _iconsBMD:BitmapData;
      
      private var _iconsBM:Bitmap;
      
      private const ICON_SIZE:Number = 23;
      
      private const SHOW_HIDE_STATIC_FRAMES:Number = 4;
      
      private const SHOW_HIDE_ANIMATION_FRAMES:Number = 7;
      
      private const DISTANCE_FROM_TARGET_X_POS_MAX:Number = 170;
      
      private const TEXT_FONT:String = "AMCAP eternal";
      
      private const TEXT_DEFAULT_COLOR:String = "<FONT COLOR=\'#CCCCCC\'>";
      
      private const TEXT_BAD_COLOR:String = "<FONT COLOR=\'#CC0000\'>";
      
      private const TEXT_ENERGY_COLOR:String = "<FONT COLOR=\'#00CC00\'>";
      
      private const TEXT_REPAIR_COLOR:String = "<FONT COLOR=\'#00CC00\'>";
      
      private const TEXT_HEAT_COLOR:String = "<FONT COLOR=\'#FF6600\'>";
      
      private const TEXT_MULTIPLIER_COLOR:String = "<FONT COLOR=\'#CC3399\'>";
      
      public function BMMechBattleTooltip()
      {
         super();
      }
      
      public function initialize(param1:Number) : void
      {
         generateSingletonClassesPointers("");
         this._interfacePlayerID = param1;
         this._xDirection = "left";
         if(this._interfacePlayerID == 2)
         {
            this._xDirection = "right";
         }
         this.createGeneralIcon("HP");
         this.createGeneralIcon("repair");
         this.createGeneralIcon("heat");
         this.createGeneralIcon("energy");
         this.createGeneralIcon("bullets");
         this.createGeneralIcon("rockets");
         this.createGeneralIcon("push");
         this.createGeneralIcon("pull");
         this.createGeneralIcon("damageEnergyBase");
         this.createGeneralIcon("damageEnergyAddon");
         this.createGeneralIcon("damageHeatBase");
         this.createGeneralIcon("damageHeatAddon");
         this.createGeneralIcon("damageType_physical");
         this.createGeneralIcon("damageType_explosive");
         this.createGeneralIcon("damageType_explosivePlus");
         this.createGeneralIcon("damageType_electric");
         this.createGeneralIcon("damageType_electricPlus");
         this.createGeneralIcon("resist_physical");
         this.createGeneralIcon("resist_explosive");
         this.createGeneralIcon("resist_electric");
         this.createGeneralIcon("damageResist_physical");
         this.createGeneralIcon("damageResist_explosive");
         this.createGeneralIcon("damageResist_electric");
         this.createRankIcon("rank1");
         this.createRankIcon("rank2");
         this.createRankIcon("rank3");
         this.createRankIcon("rank4");
         this.createRankIcon("rank5");
         this.createRankIcon("rank6");
         this.createRankIcon("rank7");
         this.createRankIcon("rank8");
         this.createRankIcon("rank9");
         this.createRankIcon("rank10");
         this.createRankIcon("rank11");
         this.createRankIcon("rank12");
         this.createRankIcon("rank13");
         this.createRankIcon("rank14");
         this.createRankIcon("rank15");
         this.createRankIcon("rank16");
         this._txtRow1YPos = this.txtRow1.y;
         this._txtRow2YPos = this.txtRow2.y;
         this._txtRow3YPos = this.txtRow3.y;
         this._txtRow4YPos = this.txtRow4.y;
         this._txtRow5YPos = this.txtRow5.y;
         this._txtRow6YPos = this.txtRow6.y;
         this._hideMe = true;
         this._targetXPos = 0;
         this.onEnterFrameTrigger();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(visible && this._hideMe)
         {
            if(this._hideMeCounter < this.SHOW_HIDE_ANIMATION_FRAMES + this.SHOW_HIDE_STATIC_FRAMES)
            {
               ++this._hideMeCounter;
            }
            else
            {
               visible = false;
               this.removeAllIcons();
               this.clearAllTexts();
            }
         }
         var _loc1_:Number = this._targetXPos;
         if(this._hideMe)
         {
            if(this._hideMeCounter > this.SHOW_HIDE_STATIC_FRAMES)
            {
               switch(this._xDirection)
               {
                  case "left":
                     _loc1_ = this._targetXPos - (this._hideMeCounter - this.SHOW_HIDE_STATIC_FRAMES) / this.SHOW_HIDE_ANIMATION_FRAMES * this.DISTANCE_FROM_TARGET_X_POS_MAX;
                     break;
                  case "right":
                     _loc1_ = this._targetXPos + (this._hideMeCounter - this.SHOW_HIDE_STATIC_FRAMES) / this.SHOW_HIDE_ANIMATION_FRAMES * this.DISTANCE_FROM_TARGET_X_POS_MAX;
               }
            }
         }
         else
         {
            ++this._showMeCounter;
            if(this._showMeCounter < this.SHOW_HIDE_ANIMATION_FRAMES)
            {
               switch(this._xDirection)
               {
                  case "left":
                     _loc1_ = this._targetXPos - this.DISTANCE_FROM_TARGET_X_POS_MAX + this._showMeCounter / this.SHOW_HIDE_ANIMATION_FRAMES * this.DISTANCE_FROM_TARGET_X_POS_MAX;
                     break;
                  case "right":
                     _loc1_ = this._targetXPos + this.DISTANCE_FROM_TARGET_X_POS_MAX - this._showMeCounter / this.SHOW_HIDE_ANIMATION_FRAMES * this.DISTANCE_FROM_TARGET_X_POS_MAX;
               }
            }
         }
         x = _loc1_;
      }
      
      public function setTargetXPos(param1:Number) : void
      {
         this._targetXPos = param1;
      }
      
      public function getTargetXPos() : Number
      {
         return this._targetXPos;
      }
      
      public function hideToolTip(param1:Boolean) : void
      {
         if(param1)
         {
            switch(this._xDirection)
            {
               case "left":
                  x = -this.DISTANCE_FROM_TARGET_X_POS_MAX;
                  break;
               case "right":
                  x = 800 + this.DISTANCE_FROM_TARGET_X_POS_MAX;
            }
            this._hideMe = true;
            this._hideMeCounter = 0;
         }
         else if(this._hideMe == false)
         {
            this._hideMe = true;
            this._hideMeCounter = 0;
            if(this._showMeCounter < this.SHOW_HIDE_ANIMATION_FRAMES)
            {
               this._hideMeCounter += this.SHOW_HIDE_ANIMATION_FRAMES - this._showMeCounter;
            }
         }
         screensM.screenBattleInterfaceBottom.deactivateActionErrorMessage();
      }
      
      public function displayToolTip(param1:Number, param2:String, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc11_:BMPlayerItemData = null;
         var _loc12_:BMItemData = null;
         var _loc16_:String = null;
         var _loc17_:Number = NaN;
         var _loc18_:String = null;
         var _loc19_:Object = null;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:String = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Boolean = false;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:uint = 0;
         var _loc36_:Number = NaN;
         var _loc37_:String = null;
         var _loc38_:Object = null;
         var _loc39_:Number = NaN;
         var _loc40_:Sprite = null;
         var _loc41_:uint = 0;
         var _loc4_:Array = new Array();
         if(param1 == dataM.player1PlayerID)
         {
            _loc5_ = dataM.player1PlayerID;
            _loc6_ = dataM.player2PlayerID;
            _loc7_ = this._interfacePlayerID;
         }
         else
         {
            _loc5_ = dataM.player2PlayerID;
            _loc6_ = dataM.player1PlayerID;
            switch(this._interfacePlayerID)
            {
               case 1:
                  _loc7_ = 2;
                  break;
               case 2:
                  _loc7_ = 1;
            }
         }
         var _loc8_:BMPlayerData = dataM.playersData[_loc5_];
         var _loc9_:String = screensM.screenBattle.getMechSlot(_loc5_);
         var _loc10_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc9_];
         var _loc13_:BMPlayerData = dataM.playersData[_loc6_];
         var _loc14_:String = screensM.screenBattle.getMechSlot(_loc6_);
         var _loc15_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc14_];
         this.mcUses1.visible = false;
         this.mcUses2.visible = false;
         this.mcUses3.visible = false;
         this.mcUses4.visible = false;
         this.mcUses5.visible = false;
         this.txtRow1.y = this._txtRow1YPos;
         this.txtRow2.y = this._txtRow2YPos;
         this.txtRow3.y = this._txtRow3YPos;
         this.txtRow4.y = this._txtRow4YPos;
         this.txtRow5.y = this._txtRow5YPos;
         this.txtRow6.y = this._txtRow6YPos;
         switch(param2)
         {
            case "shutDown":
               if(_loc7_ == 1)
               {
                  _loc24_ = _loc10_.heatCooling;
                  if(dataM.battle_floorBuffsData != null)
                  {
                     _loc19_ = dataM.battle_floorBuffsData[_loc10_.currentStepCode];
                     if(_loc19_ != null)
                     {
                        if(_loc19_.type == "heatCooling")
                        {
                           _loc24_ = Math.ceil(_loc24_ * (100 + dataM.floorBuff_heatCoolingAddon) / 100);
                        }
                     }
                  }
                  _loc16_ = this.TEXT_HEAT_COLOR + "-" + _loc24_;
                  _loc4_.push({
                     "type":"regular",
                     "icon":"heat",
                     "text":_loc16_
                  });
               }
               break;
            case "sideWeapon":
            case "topWeapon":
            case "charge":
            case "teleport":
            case "harpoon":
            case "leg":
            case "drone":
               _loc22_ = param2;
               switch(param2)
               {
                  case "sideWeapon":
                  case "topWeapon":
                     _loc22_ += param3;
               }
               _loc11_ = dataM.getPlayerItemData(_loc5_,_loc10_.mechStructure[_loc22_]);
               if(_loc7_ == 1 && this._interfacePlayerID == _loc7_)
               {
                  switch(param2)
                  {
                     case "sideWeapon":
                     case "topWeapon":
                     case "leg":
                     case "charge":
                     case "harpoon":
                        if(screensM.screenBattle.isOpponentInWeaponRange(_loc5_,_loc6_,_loc11_.itemID,-1,-1,-1) == false)
                        {
                           screensM.screenBattleInterfaceBottom.activateActionErrorMessage("outOfRange");
                        }
                  }
               }
               _loc12_ = dataM.itemsDB[_loc11_.itemID];
               switch(_loc7_)
               {
                  case 1:
                     switch(param2)
                     {
                        case "torso":
                        case "leg":
                        case "sideWeapon":
                        case "topWeapon":
                           _loc23_ = dataM.getItemCurrentPowerLevel(_loc5_,_loc11_.playerItemID);
                           if(_loc23_ > 1 || _loc12_.specialStatus > 0)
                           {
                              _loc16_ = "";
                              switch(_loc12_.specialStatus)
                              {
                                 case 1:
                                    _loc16_ = "<FONT COLOR=\'#" + dataM.COLOR_RARE_ITEM + "\'>" + getGeneralText("rareCaps") + "</FONT>";
                                    break;
                                 case 2:
                                    _loc16_ = "<FONT COLOR=\'#" + dataM.COLOR_EPIC_ITEM + "\'>" + getGeneralText("epicCaps") + "</FONT>";
                                    break;
                                 case 3:
                                    _loc16_ = "<FONT SIZE=\'18\' COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>" + getGeneralText("legendaryCaps") + "</FONT>";
                                    break;
                                 case 4:
                                    _loc16_ = "<FONT SIZE=\'18\' COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>" + getGeneralText("mythicalCaps") + "</FONT>";
                              }
                              _loc4_.push({
                                 "type":"powerLevelAndRank",
                                 "level":_loc23_,
                                 "text":_loc16_,
                                 "rarity":_loc12_.specialStatus
                              });
                           }
                     }
                     if(_loc12_.HPAddon > 0)
                     {
                        _loc23_ = dataM.getItemCurrentPowerLevel(_loc5_,_loc11_.playerItemID);
                        _loc26_ = dataM.powerLevelsDB_special[_loc12_.level].bonusRepair * (_loc23_ - 1);
                        _loc16_ = this.TEXT_REPAIR_COLOR + "+" + (_loc12_.HPAddon - _loc26_) + " + " + _loc26_;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"repair",
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.costHeat > 0)
                     {
                        _loc16_ = this.TEXT_HEAT_COLOR + "+" + _loc12_.costHeat;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"heat",
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.costEnergy > 0)
                     {
                        _loc16_ = this.TEXT_ENERGY_COLOR + "-" + _loc12_.costEnergy;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"energy",
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.bullets > 0)
                     {
                        _loc16_ = this.TEXT_DEFAULT_COLOR + "-" + _loc12_.bullets;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"bullets",
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.rockets > 0)
                     {
                        _loc16_ = this.TEXT_DEFAULT_COLOR + "-" + _loc12_.rockets;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"rockets",
                           "text":_loc16_
                        });
                     }
                     switch(param2)
                     {
                        case "sideWeapon":
                        case "topWeapon":
                        case "charge":
                        case "teleport":
                        case "harpoon":
                        case "drone":
                           if(_loc12_.uses > 0)
                           {
                              _loc21_ = Number(_loc10_.usesMax[_loc22_]);
                              _loc20_ = Number(_loc10_.uses[_loc22_]);
                              _loc4_.push({
                                 "type":"uses",
                                 "uses":_loc20_,
                                 "usesMax":_loc21_
                              });
                           }
                     }
                     break;
                  case 2:
                     if(_loc12_.resist1 > 0)
                     {
                        _loc16_ = this.TEXT_BAD_COLOR + "-" + _loc12_.resist1;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"damageResist_physical",
                           "text":_loc16_
                        });
                     }
                     else if(_loc12_.resist2 > 0)
                     {
                        _loc16_ = this.TEXT_BAD_COLOR + "-" + _loc12_.resist2;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"damageResist_explosive",
                           "text":_loc16_
                        });
                     }
                     else if(_loc12_.resist3 > 0)
                     {
                        _loc16_ = this.TEXT_BAD_COLOR + "-" + _loc12_.resist3;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"damageResist_electric",
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.damageEnergyBase > 0)
                     {
                        _loc16_ = this.TEXT_BAD_COLOR + "-" + _loc12_.damageEnergyBase;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"damageEnergyBase",
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.damageEnergyAddon > 0)
                     {
                        _loc16_ = this.TEXT_BAD_COLOR + "-" + _loc12_.damageEnergyAddon;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"damageEnergyAddon",
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.damageHeatBase > 0)
                     {
                        _loc16_ = this.TEXT_BAD_COLOR + "-" + _loc12_.damageHeatBase;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"damageHeatBase",
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.damageHeatAddon > 0)
                     {
                        _loc16_ = this.TEXT_BAD_COLOR + "-" + _loc12_.damageHeatAddon;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"damageHeatAddon",
                           "text":_loc16_
                        });
                     }
                     _loc25_ = false;
                     if(_loc12_.damageBase > 0 || _loc12_.damageAddon > 0)
                     {
                        _loc25_ = true;
                     }
                     if(_loc25_)
                     {
                        _loc18_ = this.getDamageTypeIcon(_loc12_.damageType);
                        _loc17_ = Number(_loc15_["resist" + _loc12_.damageType]);
                        if(dataM.battle_floorBuffsData != null)
                        {
                           _loc19_ = dataM.battle_floorBuffsData[_loc15_.currentStepCode];
                           if(_loc19_ != null)
                           {
                              if(_loc19_.type == "ignoreResistance")
                              {
                                 _loc17_ = 0;
                              }
                           }
                        }
                        _loc27_ = _loc10_.generalDamageRatio;
                        if(param2 == "leg")
                        {
                           _loc27_ = _loc10_.stompDamageRatio;
                        }
                        _loc28_ = Math.ceil(_loc12_.damageBase * _loc27_);
                        _loc29_ = Math.ceil(_loc12_.damageAddon * _loc27_);
                        _loc30_ = 0;
                        _loc31_ = 0;
                        if(_loc8_.mechsDestroyed > 0)
                        {
                           _loc30_ = _loc8_.mechsDestroyed * dataM.destroyMechDamageAddon;
                        }
                        if(dataM.battle_floorBuffsData != null)
                        {
                           _loc19_ = dataM.battle_floorBuffsData[_loc10_.currentStepCode];
                           if(_loc19_ != null)
                           {
                              if(_loc19_.type == "damage")
                              {
                                 if(_loc19_.subType == _loc12_.damageType)
                                 {
                                    _loc31_ = dataM.floorBuff_damageAddon;
                                 }
                              }
                           }
                        }
                        if(_loc30_ > 0 || Boolean(_loc31_))
                        {
                           _loc28_ = Math.ceil(_loc28_ * (_loc30_ + _loc31_ + 100) / 100);
                           _loc29_ = Math.ceil(_loc29_ * (_loc30_ + _loc31_ + 100) / 100);
                        }
                        if(_loc28_ > 0 && _loc29_ > 0)
                        {
                           _loc16_ = this.TEXT_BAD_COLOR + _loc28_ + " - " + (_loc28_ + _loc29_);
                        }
                        else if(_loc28_ > 0)
                        {
                           _loc16_ = this.TEXT_BAD_COLOR + _loc28_;
                        }
                        else
                        {
                           _loc16_ = this.TEXT_BAD_COLOR + "0 - " + _loc29_;
                        }
                        _loc4_.push({
                           "type":"regular",
                           "icon":"damageType_" + _loc18_,
                           "text":_loc16_
                        });
                     }
                     if(_loc17_ != 0 && _loc25_)
                     {
                        if(_loc17_ < -99)
                        {
                           _loc17_ = -99;
                        }
                        else if(_loc17_ > 99)
                        {
                           _loc17_ = 99;
                        }
                        _loc16_ = this.TEXT_DEFAULT_COLOR + String(_loc17_);
                        _loc4_.push({
                           "type":"regular",
                           "icon":"resist_" + _loc18_,
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.damageEnergy > 0)
                     {
                        _loc32_ = _loc12_.damageEnergy;
                        if(dataM.battle_floorBuffsData != null)
                        {
                           _loc19_ = dataM.battle_floorBuffsData[_loc10_.currentStepCode];
                           if(_loc19_ != null)
                           {
                              if(_loc19_.type == "damageEnergy")
                              {
                                 _loc32_ = Math.ceil(_loc32_ * (dataM.floorBuff_energyDamageAddon + 100) / 100);
                              }
                           }
                        }
                        if(_loc32_ > _loc15_.energy)
                        {
                           _loc33_ = _loc32_ - _loc15_.energy;
                           _loc16_ = this.TEXT_DEFAULT_COLOR + _loc15_.energy + "  </FONT>" + this.TEXT_BAD_COLOR + "+" + _loc33_;
                        }
                        else
                        {
                           _loc16_ = this.TEXT_DEFAULT_COLOR + _loc32_;
                        }
                        _loc4_.push({
                           "type":"regular",
                           "icon":"damageType_electricPlus",
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.damageHeat > 0)
                     {
                        _loc34_ = _loc12_.damageHeat;
                        if(dataM.battle_floorBuffsData != null)
                        {
                           _loc19_ = dataM.battle_floorBuffsData[_loc10_.currentStepCode];
                           if(_loc19_ != null)
                           {
                              if(_loc19_.type == "damageHeat")
                              {
                                 _loc34_ = Math.ceil(_loc34_ * (dataM.floorBuff_heatDamageAddon + 100) / 100);
                              }
                           }
                        }
                        _loc16_ = this.TEXT_DEFAULT_COLOR + _loc34_;
                        _loc4_.push({
                           "type":"regular",
                           "icon":"damageType_explosivePlus",
                           "text":_loc16_
                        });
                     }
                     if(_loc12_.push != 0)
                     {
                        if(_loc12_.push > 0)
                        {
                           _loc16_ = this.TEXT_DEFAULT_COLOR + _loc12_.push;
                           _loc4_.push({
                              "type":"regular",
                              "icon":"push",
                              "text":_loc16_
                           });
                        }
                        else
                        {
                           _loc16_ = this.TEXT_DEFAULT_COLOR + Math.abs(_loc12_.push);
                           _loc4_.push({
                              "type":"regular",
                              "icon":"pull",
                              "text":_loc16_
                           });
                        }
                     }
               }
               break;
            case "kit":
               if(_loc7_ == 1)
               {
                  _loc11_ = dataM.getPlayerItemData(_loc5_,_loc10_.mechStructure["kit" + param3]);
                  _loc12_ = dataM.itemsDB[_loc11_.itemID];
                  if(_loc12_.HPBase > 0)
                  {
                     _loc16_ = this.TEXT_DEFAULT_COLOR + "+" + _loc12_.HPBase;
                     _loc4_.push({
                        "type":"regular",
                        "icon":"HP",
                        "text":_loc16_
                     });
                  }
                  if(_loc12_.energyBase > 0)
                  {
                     _loc16_ = this.TEXT_ENERGY_COLOR + "+" + _loc12_.energyBase;
                     _loc4_.push({
                        "type":"regular",
                        "icon":"energy",
                        "text":_loc16_
                     });
                  }
                  if(_loc12_.heatBase > 0)
                  {
                     _loc16_ = this.TEXT_HEAT_COLOR + "-" + _loc12_.heatBase;
                     _loc4_.push({
                        "type":"regular",
                        "icon":"heat",
                        "text":_loc16_
                     });
                  }
                  if(_loc12_.bullets > 0)
                  {
                     _loc16_ = this.TEXT_DEFAULT_COLOR + "+" + _loc12_.bullets;
                     _loc4_.push({
                        "type":"regular",
                        "icon":"bullets",
                        "text":_loc16_
                     });
                  }
                  if(_loc12_.rockets > 0)
                  {
                     _loc16_ = this.TEXT_DEFAULT_COLOR + "+" + _loc12_.rockets;
                     _loc4_.push({
                        "type":"regular",
                        "icon":"rockets",
                        "text":_loc16_
                     });
                  }
                  if(_loc12_.resist1 > 0)
                  {
                     _loc16_ = this.TEXT_DEFAULT_COLOR + "+" + _loc12_.resist1;
                     _loc4_.push({
                        "type":"regular",
                        "icon":"resist_physical",
                        "text":_loc16_
                     });
                  }
                  if(_loc12_.resist2 > 0)
                  {
                     _loc16_ = this.TEXT_DEFAULT_COLOR + "+" + _loc12_.resist2;
                     _loc4_.push({
                        "type":"regular",
                        "icon":"resist_explosive",
                        "text":_loc16_
                     });
                  }
                  if(_loc12_.resist3 > 0)
                  {
                     _loc16_ = this.TEXT_DEFAULT_COLOR + "+" + _loc12_.resist3;
                     _loc4_.push({
                        "type":"regular",
                        "icon":"resist_electric",
                        "text":_loc16_
                     });
                  }
               }
         }
         if(_loc4_.length > 0)
         {
            this._hideMe = false;
            this._showMeCounter = 0;
            if(this._hideMeCounter < this.SHOW_HIDE_ANIMATION_FRAMES + this.SHOW_HIDE_STATIC_FRAMES)
            {
               this._showMeCounter += this.SHOW_HIDE_ANIMATION_FRAMES - (this._hideMeCounter - this.SHOW_HIDE_STATIC_FRAMES);
            }
            this.removeAllIcons();
            this.clearAllTexts();
            _loc35_ = 0;
            while(_loc35_ < _loc4_.length)
            {
               _loc38_ = _loc4_[_loc35_];
               _loc39_ = _loc4_.length - _loc35_;
               switch(_loc38_.type)
               {
                  case "regular":
                     _loc40_ = this["mcIcon_" + _loc38_.icon];
                     this.addIcon(_loc40_,_loc39_);
                     this["txtRow" + _loc39_].htmlText = _loc38_.text;
                     break;
                  case "powerLevelAndRank":
                     if(_loc38_.level > 0)
                     {
                        _loc40_ = this[this.getIconNameForItemLevel(_loc38_.level)];
                        this.addIcon(_loc40_,_loc39_);
                     }
                     this["txtRow" + _loc39_].htmlText = _loc38_.text;
                     if(_loc38_.rarity == 3)
                     {
                        this["txtRow" + _loc39_].y += 2;
                     }
                     break;
                  case "uses":
                     _loc20_ = Number(_loc38_.uses);
                     _loc21_ = Number(_loc38_.usesMax);
                     if(_loc21_ > 5)
                     {
                        _loc21_ = 5;
                     }
                     if(_loc20_ > 5)
                     {
                        _loc20_ = 5;
                     }
                     _loc41_ = 1;
                     while(_loc41_ <= 5)
                     {
                        if(_loc41_ <= _loc20_)
                        {
                           this["mcUses" + _loc41_].gotoAndStop("used");
                           this["mcUses" + _loc41_].visible = true;
                        }
                        else if(_loc41_ <= _loc21_)
                        {
                           this["mcUses" + _loc41_].gotoAndStop("available");
                           this["mcUses" + _loc41_].visible = true;
                        }
                        _loc41_++;
                     }
               }
               _loc35_++;
            }
            _loc36_ = _loc4_.length;
            if(_loc36_ < 1)
            {
               _loc36_ = 1;
            }
            else if(_loc36_ > 6)
            {
               _loc36_ = 6;
            }
            if(this._interfacePlayerID == _loc7_)
            {
               if(_loc7_ == 1)
               {
                  _loc37_ = "playerAttacker" + _loc36_;
               }
               else
               {
                  _loc37_ = "playerDefender" + _loc36_;
               }
            }
            else if(_loc7_ == 1)
            {
               _loc37_ = "opponentAttacker" + _loc36_;
            }
            else
            {
               _loc37_ = "opponentDefender" + _loc36_;
            }
            this.mcBackground.gotoAndStop(_loc37_);
            visible = true;
         }
         this.createTextsBitmapForMobile();
         this.createIconsBitmapForMobile();
      }
      
      private function getDamageTypeIcon(param1:Number) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 1:
               _loc2_ = "physical";
               break;
            case 2:
               _loc2_ = "explosive";
               break;
            case 3:
               _loc2_ = "electric";
         }
         return _loc2_;
      }
      
      private function createGeneralIcon(param1:String) : void
      {
         this["mcIcon_" + param1] = externalAssetsM.getAsset("general","icon_" + param1,this.ICON_SIZE,this.ICON_SIZE,false,false);
         this["mcIcon_" + param1].x = this.mcSizer_icon1.x;
      }
      
      private function createRankIcon(param1:String) : void
      {
         this["mcIcon_" + param1] = externalAssetsM.getAsset("general","Grp_" + param1,this.ICON_SIZE,this.ICON_SIZE,false,false);
         this["mcIcon_" + param1].x = this.mcSizer_icon1.x;
      }
      
      private function removeAllIcons() : void
      {
         this.removeIcon(this.mcIcon_HP);
         this.removeIcon(this.mcIcon_repair);
         this.removeIcon(this.mcIcon_heat);
         this.removeIcon(this.mcIcon_energy);
         this.removeIcon(this.mcIcon_bullets);
         this.removeIcon(this.mcIcon_rockets);
         this.removeIcon(this.mcIcon_push);
         this.removeIcon(this.mcIcon_pull);
         this.removeIcon(this.mcIcon_damageEnergyBase);
         this.removeIcon(this.mcIcon_damageEnergyAddon);
         this.removeIcon(this.mcIcon_damageHeatBase);
         this.removeIcon(this.mcIcon_damageHeatAddon);
         this.removeIcon(this.mcIcon_damageType_physical);
         this.removeIcon(this.mcIcon_damageType_explosive);
         this.removeIcon(this.mcIcon_damageType_explosivePlus);
         this.removeIcon(this.mcIcon_damageType_electric);
         this.removeIcon(this.mcIcon_damageType_electricPlus);
         this.removeIcon(this.mcIcon_resist_physical);
         this.removeIcon(this.mcIcon_resist_explosive);
         this.removeIcon(this.mcIcon_resist_electric);
         this.removeIcon(this.mcIcon_damageResist_physical);
         this.removeIcon(this.mcIcon_damageResist_explosive);
         this.removeIcon(this.mcIcon_damageResist_electric);
         this.removeIcon(this.mcIcon_rank1);
         this.removeIcon(this.mcIcon_rank2);
         this.removeIcon(this.mcIcon_rank3);
         this.removeIcon(this.mcIcon_rank4);
         this.removeIcon(this.mcIcon_rank5);
         this.removeIcon(this.mcIcon_rank6);
         this.removeIcon(this.mcIcon_rank7);
         this.removeIcon(this.mcIcon_rank8);
         this.removeIcon(this.mcIcon_rank9);
         this.removeIcon(this.mcIcon_rank10);
         this.removeIcon(this.mcIcon_rank11);
         this.removeIcon(this.mcIcon_rank12);
         this.removeIcon(this.mcIcon_rank13);
         this.removeIcon(this.mcIcon_rank14);
         this.removeIcon(this.mcIcon_rank15);
         this.removeIcon(this.mcIcon_rank16);
      }
      
      private function clearAllTexts() : void
      {
         this.txtRow1.htmlText = "";
         this.txtRow2.htmlText = "";
         this.txtRow3.htmlText = "";
         this.txtRow4.htmlText = "";
         this.txtRow5.htmlText = "";
         this.txtRow6.htmlText = "";
      }
      
      private function createTextsBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("battleTooltip" + this._interfacePlayerID,[this.txtRow1,this.txtRow2,this.txtRow3,this.txtRow4,this.txtRow5,this.txtRow6],"",this);
         }
      }
      
      private function createIconsBitmapForMobile() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Number = NaN;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         if(dataM.runAsMobile)
         {
            _loc1_ = [this.mcIcon_HP,this.mcIcon_repair,this.mcIcon_heat,this.mcIcon_energy,this.mcIcon_bullets,this.mcIcon_rockets,this.mcIcon_push,this.mcIcon_pull,this.mcIcon_damageType_physical,this.mcIcon_damageType_explosive];
            _loc1_.push(this.mcIcon_damageType_explosivePlus,this.mcIcon_damageType_electricPlus);
            _loc1_.push(this.mcIcon_damageType_electric,this.mcIcon_resist_physical,this.mcIcon_resist_explosive,this.mcIcon_resist_electric,this.mcIcon_damageResist_physical,this.mcIcon_damageResist_explosive,this.mcIcon_damageResist_electric);
            _loc1_.push(this.mcIcon_rank1,this.mcIcon_rank2,this.mcIcon_rank3,this.mcIcon_rank4,this.mcIcon_rank5,this.mcIcon_rank6,this.mcIcon_rank7,this.mcIcon_rank8,this.mcIcon_rank9,this.mcIcon_rank10,this.mcIcon_rank11);
            _loc2_ = new Array();
            _loc3_ = 1.7;
            _loc4_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               if(_loc1_[_loc5_].parent != null)
               {
                  _loc2_.push(_loc1_[_loc5_]);
                  _loc4_[_loc5_] = _loc1_[_loc5_].y;
                  _loc1_[_loc5_].y += (_loc1_[_loc5_].y - this.mcSizer_icon1.y) * (_loc3_ - 1);
                  _loc1_[_loc5_].width *= _loc3_;
                  _loc1_[_loc5_].height *= _loc3_;
               }
               _loc5_++;
            }
            _loc6_ = screensM.createAssetsBitmap([],_loc2_,3,3);
            if(this._iconsBMD != null)
            {
               this._iconsBMD.dispose();
               this._iconsBMD = null;
            }
            if(this._iconsBM != null)
            {
               this._iconsBM.parent.removeChild(this._iconsBM);
               this._iconsBM = null;
            }
            this._iconsBMD = _loc6_[0];
            this._iconsBM = _loc6_[1];
            this._iconsBM.width /= _loc3_;
            this._iconsBM.height /= _loc3_;
            if(this.mcUses1.visible)
            {
               this._iconsBM.y -= (this.mcSizer_icon2.y - this.mcSizer_icon1.y) * (_loc3_ - 1);
            }
            addChild(this._iconsBM);
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               if(_loc4_[_loc5_] != null)
               {
                  _loc1_[_loc5_].y = _loc4_[_loc5_];
                  _loc1_[_loc5_].width = this.mcSizer_icon1.width;
                  _loc1_[_loc5_].height = this.mcSizer_icon1.height;
               }
               _loc5_++;
            }
         }
      }
      
      private function removeIcon(param1:Sprite) : void
      {
         if(param1.parent != null)
         {
            param1.parent.removeChild(param1);
         }
      }
      
      private function addIcon(param1:Sprite, param2:Number) : void
      {
         if(param1.parent == null)
         {
            addChild(param1);
         }
         param1.y = this["mcSizer_icon" + param2].y;
      }
      
      private function getIconNameForItemLevel(param1:int) : String
      {
         return "mcIcon_rank" + Math.min(16,int(param1 / 4) + 1);
      }
   }
}

