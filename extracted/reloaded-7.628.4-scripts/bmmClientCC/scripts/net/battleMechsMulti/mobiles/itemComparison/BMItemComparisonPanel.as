package net.battleMechsMulti.mobiles.itemComparison
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol208")]
   public class BMItemComparisonPanel extends BMBaseScreen
   {
      
      private static const NEGATIVE_COLOR:String = "FF3300";
      
      public var mcIconsHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var btnClose:BMBasicButton;
      
      public var mcSizer_item1:Sprite;
      
      public var mcSizer_item2:Sprite;
      
      public var mcSizer_icon:Sprite;
      
      public var txtStatA1:TextField;
      
      public var txtStatA2:TextField;
      
      public var txtStatA3:TextField;
      
      public var txtStatA4:TextField;
      
      public var txtStatA5:TextField;
      
      public var txtStatA6:TextField;
      
      public var txtStatA7:TextField;
      
      public var txtStatA8:TextField;
      
      public var txtStatA9:TextField;
      
      public var txtStatA10:TextField;
      
      public var txtStatA11:TextField;
      
      public var txtStatA12:TextField;
      
      public var txtStatA13:TextField;
      
      public var txtStatA14:TextField;
      
      public var txtStatA15:TextField;
      
      public var txtStatB1:TextField;
      
      public var txtStatB2:TextField;
      
      public var txtStatB3:TextField;
      
      public var txtStatB4:TextField;
      
      public var txtStatB5:TextField;
      
      public var txtStatB6:TextField;
      
      public var txtStatB7:TextField;
      
      public var txtStatB8:TextField;
      
      public var txtStatB9:TextField;
      
      public var txtStatB10:TextField;
      
      public var txtStatB11:TextField;
      
      public var txtStatB12:TextField;
      
      public var txtStatB13:TextField;
      
      public var txtStatB14:TextField;
      
      public var txtStatB15:TextField;
      
      public var txtStatC1:TextField;
      
      public var txtStatC2:TextField;
      
      public var txtStatC3:TextField;
      
      public var txtStatC4:TextField;
      
      public var txtStatC5:TextField;
      
      public var txtStatC6:TextField;
      
      public var txtStatC7:TextField;
      
      public var txtStatC8:TextField;
      
      public var txtStatC9:TextField;
      
      public var txtStatC10:TextField;
      
      public var txtStatC11:TextField;
      
      public var txtStatC12:TextField;
      
      public var txtStatC13:TextField;
      
      public var txtStatC14:TextField;
      
      public var txtStatC15:TextField;
      
      private var mcLeftItem:BMTileListItem;
      
      private var mcRightItem:BMTileListItem;
      
      private var mcIcon_weight:Sprite;
      
      private var mcIcon_hp:Sprite;
      
      private var mcIcon_energy:Sprite;
      
      private var mcIcon_energyRegeneration:Sprite;
      
      private var mcIcon_heat:Sprite;
      
      private var mcIcon_heatCooling:Sprite;
      
      private var mcIcon_resist1:Sprite;
      
      private var mcIcon_resist2:Sprite;
      
      private var mcIcon_resist3:Sprite;
      
      private var mcIcon_push:Sprite;
      
      private var mcIcon_pull:Sprite;
      
      private var mcIcon_stepsPerWalk:Sprite;
      
      private var mcIcon_stepsPerJump:Sprite;
      
      private var mcIcon_range:Sprite;
      
      private var mcIcon_rangeInfinit1:Sprite;
      
      private var mcIcon_rangeInfinit2:Sprite;
      
      private var mcIcon_uses:Sprite;
      
      private var mcIcon_damage:Sprite;
      
      private var mcIcon_damageEnergyBase:Sprite;
      
      private var mcIcon_damageEnergyAddon:Sprite;
      
      private var mcIcon_damageHeatBase:Sprite;
      
      private var mcIcon_damageHeatAddon:Sprite;
      
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
      
      private var mcIcon_shieldEnergy:Sprite;
      
      private var mcIcon_shieldHeat:Sprite;
      
      private var _icons:Array;
      
      private var _texts:Array;
      
      private var _firstRefresh:Boolean = true;
      
      private var _leftPlayerItemID:Number = 0;
      
      private var _rightPlayerItemID:Number = 0;
      
      private var _leftItemID:Number;
      
      private var _rightItemID:Number;
      
      private var _leftItemDB:BMItemData;
      
      private var _rightItemDB:BMItemData;
      
      private var _equipmentType:String;
      
      private var _totalAttributes:uint;
      
      private var _currnetRow:uint;
      
      private var _iconsBM:Bitmap;
      
      private var _iconsBMD:BitmapData;
      
      private var _lastHolder:Sprite;
      
      private var _lastIgnoreWeight:Boolean;
      
      private const ROW_Y_JUMP:uint = 25;
      
      private const MAX_ROWS:uint = 15;
      
      public function BMItemComparisonPanel()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:Number, param2:Number, param3:Boolean, param4:Sprite = null) : Boolean
      {
         var _loc5_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:Number = NaN;
         var _loc14_:Array = null;
         var _loc15_:Array = null;
         var _loc16_:uint = 0;
         var _loc17_:Array = null;
         if(this._firstRefresh)
         {
            this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
            _loc8_ = this.mcSizer_icon.width;
            this.mcIcon_weight = externalAssetsM.getAsset("general","icon_weight",_loc8_,_loc8_);
            this.mcIcon_hp = externalAssetsM.getAsset("general","icon_HP",_loc8_,_loc8_);
            this.mcIcon_uses = externalAssetsM.getAsset("general","icon_uses",_loc8_,_loc8_);
            this.mcIcon_damage = externalAssetsM.getAsset("general","icon_damage",_loc8_,_loc8_);
            this.mcIcon_damageEnergyBase = externalAssetsM.getAsset("general","icon_damageEnergyBase",_loc8_,_loc8_);
            this.mcIcon_damageEnergyAddon = externalAssetsM.getAsset("general","icon_damageEnergyAddon",_loc8_,_loc8_);
            this.mcIcon_damageHeatBase = externalAssetsM.getAsset("general","icon_damageHeatBase",_loc8_,_loc8_);
            this.mcIcon_damageHeatAddon = externalAssetsM.getAsset("general","icon_damageHeatAddon",_loc8_,_loc8_);
            this.mcIcon_damageType_physical = externalAssetsM.getAsset("general","icon_damageType_physical",_loc8_,_loc8_);
            this.mcIcon_damageType_explosive = externalAssetsM.getAsset("general","icon_damageType_explosive",_loc8_,_loc8_);
            this.mcIcon_damageType_explosivePlus = externalAssetsM.getAsset("general","icon_damageType_explosivePlus",_loc8_,_loc8_);
            this.mcIcon_damageType_electric = externalAssetsM.getAsset("general","icon_damageType_electric",_loc8_,_loc8_);
            this.mcIcon_damageType_electricPlus = externalAssetsM.getAsset("general","icon_damageType_electricPlus",_loc8_,_loc8_);
            this.mcIcon_resist_physical = externalAssetsM.getAsset("general","icon_resist_physical",_loc8_,_loc8_);
            this.mcIcon_resist_explosive = externalAssetsM.getAsset("general","icon_resist_explosive",_loc8_,_loc8_);
            this.mcIcon_resist_electric = externalAssetsM.getAsset("general","icon_resist_electric",_loc8_,_loc8_);
            this.mcIcon_damageResist_physical = externalAssetsM.getAsset("general","icon_damageResist_physical",_loc8_,_loc8_);
            this.mcIcon_damageResist_explosive = externalAssetsM.getAsset("general","icon_damageResist_explosive",_loc8_,_loc8_);
            this.mcIcon_damageResist_electric = externalAssetsM.getAsset("general","icon_damageResist_electric",_loc8_,_loc8_);
            this.mcIcon_range = externalAssetsM.getAsset("general","icon_range",_loc8_,_loc8_);
            this.mcIcon_rangeInfinit1 = externalAssetsM.getAsset("general","icon_rangeInfinit",36,_loc8_,false,false);
            this.mcIcon_rangeInfinit2 = externalAssetsM.getAsset("general","icon_rangeInfinit",36,_loc8_,false,false);
            this.mcIcon_heat = externalAssetsM.getAsset("general","icon_heat",_loc8_,_loc8_);
            this.mcIcon_heatCooling = externalAssetsM.getAsset("general","icon_heatCooling",_loc8_,_loc8_);
            this.mcIcon_energy = externalAssetsM.getAsset("general","icon_energy",_loc8_,_loc8_);
            this.mcIcon_energyRegeneration = externalAssetsM.getAsset("general","icon_energyRegeneration",_loc8_,_loc8_);
            this.mcIcon_shieldEnergy = externalAssetsM.getAsset("general","icon_shieldBlock",_loc8_,_loc8_);
            this.mcIcon_shieldHeat = externalAssetsM.getAsset("general","icon_shieldBlockHeat",_loc8_,_loc8_);
            this.mcIcon_push = externalAssetsM.getAsset("general","icon_push",_loc8_,_loc8_);
            this.mcIcon_pull = externalAssetsM.getAsset("general","icon_pull",_loc8_,_loc8_);
            this.mcIcon_stepsPerWalk = externalAssetsM.getAsset("general","icon_movement_walk",_loc8_,_loc8_);
            this.mcIcon_stepsPerJump = externalAssetsM.getAsset("general","icon_movement_jump",_loc8_,_loc8_);
            this._icons = [this.mcIcon_weight,this.mcIcon_hp,this.mcIcon_energy,this.mcIcon_energyRegeneration,this.mcIcon_heat,this.mcIcon_heatCooling,this.mcIcon_resist1,this.mcIcon_shieldEnergy,this.mcIcon_shieldHeat];
            this._icons.push(this.mcIcon_resist2,this.mcIcon_resist3,this.mcIcon_push,this.mcIcon_pull,this.mcIcon_stepsPerWalk,this.mcIcon_stepsPerJump,this.mcIcon_range,this.mcIcon_rangeInfinit1,this.mcIcon_rangeInfinit2,this.mcIcon_uses);
            this._icons.push(this.mcIcon_damageEnergyBase,this.mcIcon_damageEnergyAddon,this.mcIcon_damageHeatBase,this.mcIcon_damageHeatAddon);
            this._icons.push(this.mcIcon_damage,this.mcIcon_damageType_physical,this.mcIcon_damageType_explosive,this.mcIcon_damageType_explosivePlus,this.mcIcon_damageType_electric,this.mcIcon_damageType_electricPlus);
            this._icons.push(this.mcIcon_damageResist_physical,this.mcIcon_damageResist_explosive,this.mcIcon_damageResist_electric,this.mcIcon_resist_physical,this.mcIcon_resist_explosive,this.mcIcon_resist_electric);
            this._texts = new Array();
            _loc5_ = 1;
            while(_loc5_ <= this.MAX_ROWS)
            {
               this._texts.push(this["txtStatA" + _loc5_],this["txtStatB" + _loc5_],this["txtStatC" + _loc5_]);
               _loc5_++;
            }
            this._firstRefresh = false;
         }
         if(param1 == param2)
         {
            return false;
         }
         if(param1 == this._leftPlayerItemID && param2 == this._rightPlayerItemID)
         {
            return true;
         }
         if(param1 == 0 || param2 == 0)
         {
            return false;
         }
         this._lastIgnoreWeight = param3;
         this._rightPlayerItemID = param2;
         this._rightItemID = dataM.getPlayerItemData(dataM.player1PlayerID,this._rightPlayerItemID).itemID;
         this._rightItemDB = dataM.itemsDB[this._rightItemID];
         this._leftPlayerItemID = param1;
         this._leftItemID = dataM.getPlayerItemData(dataM.player1PlayerID,this._leftPlayerItemID).itemID;
         this._leftItemDB = dataM.itemsDB[this._leftItemID];
         if(this._leftItemDB.type != this._rightItemDB.type)
         {
            return false;
         }
         if(this._leftItemDB.type == "perk")
         {
            return false;
         }
         if(param4 != null)
         {
            this._lastHolder = param4;
         }
         this._lastHolder.addChild(this);
         if(dataM.useItemComparisonOnInventoryItemClick)
         {
            this.btnClose.visible = true;
         }
         else
         {
            this.btnClose.visible = false;
         }
         this.removeAllIcons();
         this.removeAllTexts();
         this.removeItems();
         this._equipmentType = this._rightItemDB.type;
         this.mcLeftItem = dataM.createInventoryTileListItem2(this._leftPlayerItemID,null,this.mcSizer_item1.width);
         this.mcLeftItem.x = this.mcSizer_item1.x;
         this.mcLeftItem.y = this.mcSizer_item1.y;
         this.mcIconsHolder.addChild(this.mcLeftItem);
         this.mcRightItem = dataM.createInventoryTileListItem2(this._rightPlayerItemID,null,this.mcSizer_item2.width);
         this.mcRightItem.x = this.mcSizer_item2.x;
         this.mcRightItem.y = this.mcSizer_item2.y;
         this.mcIconsHolder.addChild(this.mcRightItem);
         this._totalAttributes = 0;
         this._currnetRow = 0;
         if(this._lastIgnoreWeight == false)
         {
            this.checkAttribute("weight");
         }
         this.checkAttribute("hp");
         this.checkAttribute("uses");
         this.checkAttribute("damage");
         this.checkAttribute("damageEnergy");
         this.checkAttribute("damageEnergyBase");
         this.checkAttribute("damageEnergyAddon");
         this.checkAttribute("damageHeat");
         this.checkAttribute("damageHeatBase");
         this.checkAttribute("damageHeatAddon");
         this.checkAttribute("push");
         this.checkAttribute("pull");
         switch(this._leftItemDB.type)
         {
            case "charge":
            case "harpoon":
            case "drone":
               break;
            default:
               this.checkAttribute("range");
         }
         this.checkAttribute("energy");
         this.checkAttribute("energyRegeneration");
         this.checkAttribute("heat");
         this.checkAttribute("heatCooling");
         this.checkAttribute("absorbRatio");
         this.checkAttribute("HPPerBlock");
         this.checkAttribute("energyPerBlock");
         this.checkAttribute("heatPerBlock");
         this.checkAttribute("costEnergy");
         this.checkAttribute("costHeat");
         this.checkAttribute("resist_physical");
         this.checkAttribute("resist_explosive");
         this.checkAttribute("resist_electric");
         this.checkAttribute("damageResist_physical");
         this.checkAttribute("damageResist_explosive");
         this.checkAttribute("damageResist_electric");
         this.checkAttribute("stepsPerWalk");
         this.checkAttribute("stepsPerJump");
         if(this._currnetRow < this.MAX_ROWS)
         {
            _loc5_ = this._currnetRow + 1;
            while(_loc5_ <= this.MAX_ROWS)
            {
               this["txtStatA" + _loc5_].text = "";
               this["txtStatB" + _loc5_].text = "";
               this["txtStatC" + _loc5_].text = "";
               _loc5_++;
            }
         }
         if(dataM.runAsMobile == false)
         {
            _loc9_ = ["A","B","C"];
            _loc5_ = 1;
            while(_loc5_ <= this.MAX_ROWS)
            {
               _loc10_ = 0;
               while(_loc10_ <= 2)
               {
                  _loc11_ = "txtStat" + _loc9_[_loc10_] + _loc5_;
                  if(this[_loc11_].text == "")
                  {
                     if(this[_loc11_].parent != null)
                     {
                        this[_loc11_].parent.removeChild(this[_loc11_]);
                     }
                  }
                  else if(this[_loc11_].parent == null)
                  {
                     addChild(this[_loc11_]);
                  }
                  _loc10_++;
               }
               _loc5_++;
            }
         }
         if(dataM.runAsMobile)
         {
            _loc12_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < this._texts.length)
            {
               if(this._texts[_loc5_].parent != null)
               {
                  _loc12_.push(this._texts[_loc5_]);
               }
               _loc5_++;
            }
            screensM.createMultipleTextsBitmap("hangerItemComparisonTexts",_loc12_,"",this);
            _loc13_ = 1.7;
            _loc14_ = new Array();
            _loc15_ = new Array();
            _loc16_ = 0;
            _loc5_ = 0;
            while(_loc5_ < this._icons.length)
            {
               if(this._icons[_loc5_] != null)
               {
                  if(this._icons[_loc5_].parent != null)
                  {
                     _loc14_.push(this._icons[_loc5_]);
                     _loc15_[_loc5_] = this._icons[_loc5_].y;
                     this._icons[_loc5_].width *= _loc13_;
                     this._icons[_loc5_].height *= _loc13_;
                     this._icons[_loc5_].y += (this._icons[_loc5_].y - this.mcSizer_icon.y) * (_loc13_ - 1);
                     _loc16_++;
                  }
               }
               _loc5_++;
            }
            if(this._iconsBMD != null)
            {
               this._iconsBMD.dispose();
            }
            if(this._iconsBM != null)
            {
               if(this._iconsBM.parent != null)
               {
                  this._iconsBM.parent.removeChild(this._iconsBM);
               }
               this._iconsBM = null;
            }
            _loc17_ = screensM.createAssetsBitmap([],_loc14_,0,0);
            this._iconsBMD = _loc17_[0];
            this._iconsBM = _loc17_[1];
            this._iconsBM.width /= _loc13_;
            this._iconsBM.height /= _loc13_;
            addChild(this._iconsBM);
            _loc5_ = 0;
            while(_loc5_ < this._icons.length)
            {
               if(_loc15_[_loc5_] != null)
               {
                  this._icons[_loc5_].width = this.mcSizer_icon.width;
                  this._icons[_loc5_].height = this.mcSizer_icon.height;
                  this._icons[_loc5_].y = _loc15_[_loc5_];
               }
               _loc5_++;
            }
         }
         this.mcBackground.gotoAndStop(this._currnetRow);
         var _loc6_:Number = 160;
         var _loc7_:Number = 115 + this._currnetRow * 25;
         y = 175;
         if(_loc7_ > _loc6_)
         {
            y -= _loc7_ - _loc6_;
            if(y < 2)
            {
               y = 2;
            }
         }
         return true;
      }
      
      public function changeLeftPlayerItemIDOnly(param1:Number) : void
      {
         this.refreshScreen(param1,this._rightPlayerItemID,this._lastIgnoreWeight);
      }
      
      private function checkAttribute(param1:String) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Sprite = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         if(this._currnetRow < this.MAX_ROWS)
         {
            _loc2_ = false;
            _loc4_ = 0;
            _loc5_ = 0;
            _loc6_ = false;
            _loc7_ = 0;
            _loc8_ = 0;
            switch(param1)
            {
               case "weight":
                  switch(this._equipmentType)
                  {
                     case "kit":
                        break;
                     default:
                        _loc2_ = true;
                        _loc3_ = this.mcIcon_weight;
                        _loc4_ = this._leftItemDB.weight;
                        _loc5_ = this._rightItemDB.weight;
                        _loc6_ = true;
                  }
                  break;
               case "hp":
                  _loc4_ = this._leftItemDB.HPBase;
                  _loc5_ = this._rightItemDB.HPBase;
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this.mcIcon_hp;
                  }
                  break;
               case "uses":
                  break;
               case "absorbRatio":
               case "HPPerBlock":
               case "energyPerBlock":
               case "heatPerBlock":
                  if(this._equipmentType == "shield")
                  {
                     _loc4_ = Number(this._leftItemDB[param1]);
                     _loc5_ = Number(this._rightItemDB[param1]);
                  }
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     switch(param1)
                     {
                        case "absorbRatio":
                           if(this._rightItemDB.energyPerBlock > 0)
                           {
                              _loc3_ = this.mcIcon_shieldEnergy;
                           }
                           else
                           {
                              _loc3_ = this.mcIcon_shieldHeat;
                           }
                           break;
                        case "HPPerBlock":
                           _loc3_ = this.mcIcon_hp;
                           break;
                        case "energyPerBlock":
                           _loc3_ = this.mcIcon_energy;
                           _loc6_ = true;
                           break;
                        case "heatPerBlock":
                           _loc3_ = this.mcIcon_heat;
                           _loc6_ = true;
                     }
                  }
                  break;
               case "damage":
                  _loc7_ = this._leftItemDB.damageBase;
                  _loc8_ = this._rightItemDB.damageBase;
                  _loc4_ = _loc7_ + Math.ceil(this._leftItemDB.damageAddon / 2);
                  _loc5_ = _loc8_ + Math.ceil(this._rightItemDB.damageAddon / 2);
                  if(_loc7_ + this._leftItemDB.damageAddon > 0 || _loc8_ + this._rightItemDB.damageAddon > 0)
                  {
                     _loc2_ = true;
                     if(this._leftItemDB.damageType == this._rightItemDB.damageType)
                     {
                        switch(this._leftItemDB.damageType)
                        {
                           case 1:
                              _loc3_ = this.mcIcon_damageType_physical;
                              break;
                           case 2:
                              _loc3_ = this.mcIcon_damageType_explosive;
                              break;
                           case 3:
                              _loc3_ = this.mcIcon_damageType_electric;
                        }
                     }
                     else
                     {
                        _loc3_ = this.mcIcon_damage;
                     }
                  }
                  break;
               case "damageEnergy":
                  _loc4_ = this._leftItemDB.damageEnergy;
                  _loc5_ = this._rightItemDB.damageEnergy;
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this.mcIcon_damageType_electricPlus;
                  }
                  break;
               case "damageHeat":
                  _loc4_ = this._leftItemDB.damageHeat;
                  _loc5_ = this._rightItemDB.damageHeat;
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this.mcIcon_damageType_explosivePlus;
                  }
                  break;
               case "damageEnergyBase":
               case "damageEnergyAddon":
               case "damageHeatBase":
               case "damageHeatAddon":
                  _loc4_ = Number(this._leftItemDB[param1]);
                  _loc5_ = Number(this._rightItemDB[param1]);
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this["mcIcon_" + param1];
                  }
                  break;
               case "range":
                  switch(this._equipmentType)
                  {
                     case "drone":
                     case "charge":
                        break;
                     default:
                        if(this._equipmentType != "drone")
                        {
                           _loc4_ = this._leftItemDB.rangeAddon;
                           _loc5_ = this._rightItemDB.rangeAddon;
                           if(_loc4_ > 0 || _loc5_ > 0)
                           {
                              _loc2_ = true;
                              _loc3_ = this.mcIcon_range;
                           }
                        }
                  }
                  break;
               case "energy":
               case "energyRegeneration":
               case "heat":
               case "heatCooling":
                  switch(param1)
                  {
                     case "energy":
                        _loc4_ = this._leftItemDB.energyBase;
                        _loc5_ = this._rightItemDB.energyBase;
                        break;
                     case "energyRegeneration":
                        _loc4_ = this._leftItemDB.energyAddon;
                        _loc5_ = this._rightItemDB.energyAddon;
                        break;
                     case "heat":
                        _loc4_ = this._leftItemDB.heatBase;
                        _loc5_ = this._rightItemDB.heatBase;
                        break;
                     case "heatCooling":
                        _loc4_ = this._leftItemDB.heatAddon;
                        _loc5_ = this._rightItemDB.heatAddon;
                  }
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this["mcIcon_" + param1];
                  }
                  break;
               case "pull":
                  if(this._leftItemDB.push < 0)
                  {
                     _loc4_ = Math.abs(this._leftItemDB.push);
                  }
                  if(this._rightItemDB.push < 0)
                  {
                     _loc5_ = Math.abs(this._rightItemDB.push);
                  }
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this.mcIcon_pull;
                  }
                  break;
               case "push":
                  if(this._leftItemDB.push > 0)
                  {
                     _loc4_ = this._leftItemDB.push;
                  }
                  if(this._rightItemDB.push > 0)
                  {
                     _loc5_ = this._rightItemDB.push;
                  }
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this.mcIcon_push;
                  }
                  break;
               case "stepsPerWalk":
               case "stepsPerJump":
                  _loc4_ = Number(this._leftItemDB[param1]);
                  _loc5_ = Number(this._rightItemDB[param1]);
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this["mcIcon_" + param1];
                     switch(this._equipmentType)
                     {
                        case "sideWeapon":
                        case "topWeapon":
                        case "drone":
                           _loc6_ = true;
                     }
                  }
                  break;
               case "costEnergy":
               case "costHeat":
                  _loc4_ = Number(this._leftItemDB[param1]);
                  _loc5_ = Number(this._rightItemDB[param1]);
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     switch(param1)
                     {
                        case "costEnergy":
                           _loc3_ = this.mcIcon_energy;
                           break;
                        case "costHeat":
                           _loc3_ = this.mcIcon_heat;
                     }
                     _loc6_ = true;
                  }
                  break;
               case "resist_physical":
               case "resist_explosive":
               case "resist_electric":
                  switch(this._equipmentType)
                  {
                     case "torso":
                     case "module":
                     case "kit":
                        switch(param1)
                        {
                           case "resist_physical":
                              _loc4_ = this._leftItemDB.resist1;
                              _loc5_ = this._rightItemDB.resist1;
                              break;
                           case "resist_explosive":
                              _loc4_ = this._leftItemDB.resist2;
                              _loc5_ = this._rightItemDB.resist2;
                              break;
                           case "resist_electric":
                              _loc4_ = this._leftItemDB.resist3;
                              _loc5_ = this._rightItemDB.resist3;
                        }
                        if(_loc4_ > 0 || _loc5_ > 0)
                        {
                           _loc2_ = true;
                           _loc3_ = this["mcIcon_" + param1];
                        }
                  }
                  break;
               case "damageResist_physical":
               case "damageResist_explosive":
               case "damageResist_electric":
                  switch(this._equipmentType)
                  {
                     case "leg":
                     case "sideWeapon":
                     case "topWeapon":
                     case "drone":
                     case "teleport":
                     case "charge":
                     case "harpoon":
                        switch(param1)
                        {
                           case "damageResist_physical":
                              _loc4_ = this._leftItemDB.resist1;
                              _loc5_ = this._rightItemDB.resist1;
                              break;
                           case "damageResist_explosive":
                              _loc4_ = this._leftItemDB.resist2;
                              _loc5_ = this._rightItemDB.resist2;
                              break;
                           case "damageResist_electric":
                              _loc4_ = this._leftItemDB.resist3;
                              _loc5_ = this._rightItemDB.resist3;
                        }
                        if(_loc4_ > 0 || _loc5_ > 0)
                        {
                           _loc2_ = true;
                           _loc3_ = this["mcIcon_" + param1];
                        }
                  }
            }
            if(_loc2_)
            {
               ++this._currnetRow;
               ++this._totalAttributes;
               _loc9_ = _loc5_ - _loc4_;
               _loc10_ = ItemRarityResolver.COLOR_COMMON_ITEM;
               _loc11_ = "";
               _loc12_ = String(_loc9_);
               if(param1 == "damage")
               {
                  if(_loc7_ <= 0 && this._leftItemDB.damageAddon <= 0)
                  {
                     _loc12_ = "";
                  }
                  else if(_loc7_ > 0 && this._leftItemDB.damageAddon == 0)
                  {
                     _loc12_ = String(_loc7_);
                  }
                  else
                  {
                     _loc12_ = _loc7_ + " - " + (_loc7_ + this._leftItemDB.damageAddon);
                  }
               }
               else if(param1 == "hp")
               {
                  if(this._leftPlayerItemID == 0)
                  {
                     _loc12_ = "";
                  }
                  else if(this._leftItemDB.HPBase > 0)
                  {
                     _loc12_ = String(this._leftItemDB.HPBase);
                  }
                  else
                  {
                     _loc12_ = "";
                  }
               }
               else if(param1 == "absorbRatio")
               {
                  _loc12_ = _loc4_ + "%";
               }
               else if(_loc4_ > 0)
               {
                  _loc12_ = String(_loc4_);
               }
               else
               {
                  _loc12_ = "";
               }
               this["txtStatA" + this._currnetRow].text = _loc12_;
               if(_loc12_ != "")
               {
                  this.mcIconsHolder.addChild(this["txtStatA" + this._currnetRow]);
               }
               if(param1 == "damage")
               {
                  if(_loc8_ <= 0 && this._rightItemDB.damageAddon <= 0)
                  {
                     _loc12_ = "";
                  }
                  else if(_loc8_ > 0 && this._rightItemDB.damageAddon == 0)
                  {
                     _loc12_ = String(_loc8_);
                  }
                  else
                  {
                     _loc12_ = _loc8_ + " - " + (_loc8_ + this._rightItemDB.damageAddon);
                  }
               }
               else if(param1 == "hp")
               {
                  if(this._rightItemDB.HPBase > 0)
                  {
                     _loc12_ = String(this._rightItemDB.HPBase);
                  }
                  else
                  {
                     _loc12_ = "";
                  }
               }
               else if(param1 == "absorbRatio")
               {
                  _loc12_ = _loc5_ + "%";
               }
               else if(_loc5_ > 0)
               {
                  _loc12_ = String(_loc5_);
               }
               else
               {
                  _loc12_ = "";
               }
               this["txtStatB" + this._currnetRow].text = _loc12_;
               if(_loc12_ != "")
               {
                  this.mcIconsHolder.addChild(this["txtStatB" + this._currnetRow]);
               }
               _loc12_ = "";
               if(_loc9_ != 0)
               {
                  if(param1 == "absorbRatio")
                  {
                     _loc12_ = _loc9_ + "%";
                  }
                  else
                  {
                     _loc12_ = String(_loc9_);
                  }
                  if(_loc9_ > 0)
                  {
                     _loc11_ = "+";
                     if(_loc6_)
                     {
                        _loc10_ = NEGATIVE_COLOR;
                     }
                     else
                     {
                        _loc10_ = dataM.COLOR_GOOD;
                     }
                  }
                  else if(_loc6_)
                  {
                     _loc10_ = dataM.COLOR_GOOD;
                  }
                  else
                  {
                     _loc10_ = NEGATIVE_COLOR;
                  }
                  this["txtStatC" + this._currnetRow].htmlText = "<FONT COLOR=\'#" + _loc10_ + "\'>" + _loc11_ + _loc12_ + "</FONT>";
                  this.mcIconsHolder.addChild(this["txtStatC" + this._currnetRow]);
               }
               else
               {
                  this["txtStatC" + this._currnetRow].htmlText = "";
               }
               this.addIcon(_loc3_);
            }
         }
      }
      
      private function addIcon(param1:Sprite) : void
      {
         param1.x = this.mcSizer_icon.x;
         param1.y = this.mcSizer_icon.y + (this._currnetRow - 1) * this.ROW_Y_JUMP;
         this.mcIconsHolder.addChild(param1);
      }
      
      public function getScreenHeight() : Number
      {
         return 75 + this._totalAttributes * this.ROW_Y_JUMP;
      }
      
      public function getRightPlayerItemID() : Number
      {
         return this._rightPlayerItemID;
      }
      
      private function removeAllIcons() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._icons.length)
         {
            if(this._icons[_loc1_] != null)
            {
               if(this._icons[_loc1_].parent != null)
               {
                  this._icons[_loc1_].parent.removeChild(this._icons[_loc1_]);
               }
            }
            _loc1_++;
         }
      }
      
      private function removeAllTexts() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._texts.length)
         {
            if(this._texts[_loc1_] != null)
            {
               if(this._texts[_loc1_].parent != null)
               {
                  this._texts[_loc1_].parent.removeChild(this._texts[_loc1_]);
               }
            }
            _loc1_++;
         }
      }
      
      private function removeItems() : void
      {
         if(this.mcLeftItem != null)
         {
            this.mcLeftItem.removeMe();
         }
         if(this.mcRightItem != null)
         {
            this.mcRightItem.removeMe();
         }
      }
      
      public function closeClicked() : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         if(parent == null)
         {
            return;
         }
         this._leftPlayerItemID = 0;
         this._rightPlayerItemID = 0;
         this._leftItemDB = null;
         this._rightItemDB = null;
         this.removeAllIcons();
         this.removeItems();
         parent.removeChild(this);
      }
   }
}

