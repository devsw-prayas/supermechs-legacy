package net.battleMechsMulti.screens
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1182")]
   public class BMScreenHangerItemComparison extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcSizer_btnClose:Sprite;
      
      public var btnClose:BMButton_pictureE;
      
      public var mcSizer_item1:Sprite;
      
      public var mcSizer_item2:Sprite;
      
      public var mcSizer_icon:Sprite;
      
      public var txtItem_statA1:TextField;
      
      public var txtItem_statA2:TextField;
      
      public var txtItem_statA3:TextField;
      
      public var txtItem_statA4:TextField;
      
      public var txtItem_statA5:TextField;
      
      public var txtItem_statA6:TextField;
      
      public var txtItem_statA7:TextField;
      
      public var txtItem_statA8:TextField;
      
      public var txtItem_statA9:TextField;
      
      public var txtItem_statA10:TextField;
      
      public var txtItem_statA11:TextField;
      
      public var txtItem_statA12:TextField;
      
      public var txtItem_statB1:TextField;
      
      public var txtItem_statB2:TextField;
      
      public var txtItem_statB3:TextField;
      
      public var txtItem_statB4:TextField;
      
      public var txtItem_statB5:TextField;
      
      public var txtItem_statB6:TextField;
      
      public var txtItem_statB7:TextField;
      
      public var txtItem_statB8:TextField;
      
      public var txtItem_statB9:TextField;
      
      public var txtItem_statB10:TextField;
      
      public var txtItem_statB11:TextField;
      
      public var txtItem_statB12:TextField;
      
      public var txtItem_statC1:TextField;
      
      public var txtItem_statC2:TextField;
      
      public var txtItem_statC3:TextField;
      
      public var txtItem_statC4:TextField;
      
      public var txtItem_statC5:TextField;
      
      public var txtItem_statC6:TextField;
      
      public var txtItem_statC7:TextField;
      
      public var txtItem_statC8:TextField;
      
      public var txtItem_statC9:TextField;
      
      public var txtItem_statC10:TextField;
      
      public var txtItem_statC11:TextField;
      
      public var txtItem_statC12:TextField;
      
      private var mcMechItem:BMTileListItem;
      
      private var mcInventoryItem:BMTileListItem;
      
      private var mcIcon_weight:Sprite;
      
      private var mcIcon_hp:Sprite;
      
      private var mcIcon_energy:Sprite;
      
      private var mcIcon_energyRegeneration:Sprite;
      
      private var mcIcon_heat:Sprite;
      
      private var mcIcon_heatCooling:Sprite;
      
      private var mcIcon_bullets:Sprite;
      
      private var mcIcon_rockets:Sprite;
      
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
      
      private var _mechPlayerItemID:Number = 0;
      
      private var _inventoryPlayerItemID:Number = 0;
      
      private var _mechItemID:Number;
      
      private var _inventoryItemID:Number;
      
      private var _mechItemDB:BMItemData;
      
      private var _inventoryItemDB:BMItemData;
      
      private var _equipmentType:String;
      
      private var _totalAttributes:uint;
      
      private var _currnetRow:uint;
      
      private var _iconsBM:Bitmap;
      
      private var _iconsBMD:BitmapData;
      
      private const ROW_Y_JUMP:uint = 25;
      
      private const MAX_ROWS:uint = 12;
      
      public function BMScreenHangerItemComparison()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:Number, param2:Number) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Function = null;
         var _loc5_:Number = NaN;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:Number = NaN;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         var _loc13_:uint = 0;
         var _loc14_:Array = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenHangerItemComparison","btnClose","pictureE");
            _loc4_ = this.closeClicked;
            this.btnClose.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc4_,dataM.runAsMobile);
            this.btnClose.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            _loc5_ = this.mcSizer_icon.width;
            this.mcIcon_weight = externalAssetsM.getAsset("general","icon_weight",_loc5_,_loc5_);
            this.mcIcon_hp = externalAssetsM.getAsset("general","icon_HP",_loc5_,_loc5_);
            this.mcIcon_uses = externalAssetsM.getAsset("general","icon_uses",_loc5_,_loc5_);
            this.mcIcon_damage = externalAssetsM.getAsset("general","icon_damage",_loc5_,_loc5_);
            this.mcIcon_damageType_physical = externalAssetsM.getAsset("general","icon_damageType_physical",_loc5_,_loc5_);
            this.mcIcon_damageType_explosive = externalAssetsM.getAsset("general","icon_damageType_explosive",_loc5_,_loc5_);
            this.mcIcon_damageType_explosivePlus = externalAssetsM.getAsset("general","icon_damageType_explosivePlus",_loc5_,_loc5_);
            this.mcIcon_damageType_electric = externalAssetsM.getAsset("general","icon_damageType_electric",_loc5_,_loc5_);
            this.mcIcon_damageType_electricPlus = externalAssetsM.getAsset("general","icon_damageType_electricPlus",_loc5_,_loc5_);
            this.mcIcon_resist_physical = externalAssetsM.getAsset("general","icon_resist_physical",_loc5_,_loc5_);
            this.mcIcon_resist_explosive = externalAssetsM.getAsset("general","icon_resist_explosive",_loc5_,_loc5_);
            this.mcIcon_resist_electric = externalAssetsM.getAsset("general","icon_resist_electric",_loc5_,_loc5_);
            this.mcIcon_damageResist_physical = externalAssetsM.getAsset("general","icon_damageResist_physical",_loc5_,_loc5_);
            this.mcIcon_damageResist_explosive = externalAssetsM.getAsset("general","icon_damageResist_explosive",_loc5_,_loc5_);
            this.mcIcon_damageResist_electric = externalAssetsM.getAsset("general","icon_damageResist_electric",_loc5_,_loc5_);
            this.mcIcon_range = externalAssetsM.getAsset("general","icon_range",_loc5_,_loc5_);
            this.mcIcon_rangeInfinit1 = externalAssetsM.getAsset("general","icon_rangeInfinit",36,_loc5_,false,false);
            this.mcIcon_rangeInfinit2 = externalAssetsM.getAsset("general","icon_rangeInfinit",36,_loc5_,false,false);
            this.mcIcon_heat = externalAssetsM.getAsset("general","icon_heat",_loc5_,_loc5_);
            this.mcIcon_heatCooling = externalAssetsM.getAsset("general","icon_heatCooling",_loc5_,_loc5_);
            this.mcIcon_energy = externalAssetsM.getAsset("general","icon_energy",_loc5_,_loc5_);
            this.mcIcon_energyRegeneration = externalAssetsM.getAsset("general","icon_energyRegeneration",_loc5_,_loc5_);
            this.mcIcon_bullets = externalAssetsM.getAsset("general","icon_bullets",_loc5_,_loc5_);
            this.mcIcon_rockets = externalAssetsM.getAsset("general","icon_rockets",_loc5_,_loc5_);
            this.mcIcon_shieldEnergy = externalAssetsM.getAsset("general","icon_shieldBlock",_loc5_,_loc5_);
            this.mcIcon_shieldHeat = externalAssetsM.getAsset("general","icon_shieldBlockHeat",_loc5_,_loc5_);
            this.mcIcon_push = externalAssetsM.getAsset("general","icon_push",_loc5_,_loc5_);
            this.mcIcon_pull = externalAssetsM.getAsset("general","icon_pull",_loc5_,_loc5_);
            this.mcIcon_stepsPerWalk = externalAssetsM.getAsset("general","icon_movement_walk",_loc5_,_loc5_);
            this.mcIcon_stepsPerJump = externalAssetsM.getAsset("general","icon_movement_jump",_loc5_,_loc5_);
            this._icons = [this.mcIcon_weight,this.mcIcon_hp,this.mcIcon_energy,this.mcIcon_energyRegeneration,this.mcIcon_heat,this.mcIcon_heatCooling,this.mcIcon_bullets,this.mcIcon_rockets,this.mcIcon_resist1,this.mcIcon_shieldEnergy,this.mcIcon_shieldHeat];
            this._icons.push(this.mcIcon_resist2,this.mcIcon_resist3,this.mcIcon_push,this.mcIcon_pull,this.mcIcon_stepsPerWalk,this.mcIcon_stepsPerJump,this.mcIcon_range,this.mcIcon_rangeInfinit1,this.mcIcon_rangeInfinit2,this.mcIcon_uses);
            this._icons.push(this.mcIcon_damage,this.mcIcon_damageType_physical,this.mcIcon_damageType_explosive,this.mcIcon_damageType_explosivePlus,this.mcIcon_damageType_electric,this.mcIcon_damageType_electricPlus);
            this._icons.push(this.mcIcon_damageResist_physical,this.mcIcon_damageResist_explosive,this.mcIcon_damageResist_electric,this.mcIcon_resist_physical,this.mcIcon_resist_explosive,this.mcIcon_resist_electric);
            this._texts = new Array();
            _loc3_ = 1;
            while(_loc3_ <= this.MAX_ROWS)
            {
               this._texts.push(this["txtItem_statA" + _loc3_],this["txtItem_statB" + _loc3_],this["txtItem_statC" + _loc3_]);
               _loc3_++;
            }
            this._firstRefresh = false;
         }
         if(param1 != this._mechPlayerItemID || param2 != this._inventoryPlayerItemID)
         {
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
            this._inventoryPlayerItemID = param2;
            this._inventoryItemID = dataM.getPlayerItemData(dataM.player1PlayerID,this._inventoryPlayerItemID).itemID;
            this._inventoryItemDB = dataM.itemsDB[this._inventoryItemID];
            this._mechPlayerItemID = param1;
            if(this._mechPlayerItemID == 0)
            {
               this._mechItemID = 0;
               this._mechItemDB = new BMItemData();
               this._mechItemDB.initialize();
            }
            else
            {
               this._mechItemID = dataM.getPlayerItemData(dataM.player1PlayerID,this._mechPlayerItemID).itemID;
               this._mechItemDB = dataM.itemsDB[this._mechItemID];
            }
            this._equipmentType = this._inventoryItemDB.type;
            if(this._mechItemID > 0)
            {
               this.mcMechItem = dataM.createInventoryTileListItem(this._mechPlayerItemID,false,null,null,null,null,null,true);
               this.mcMechItem.width = this.mcSizer_item1.width;
               this.mcMechItem.height = this.mcSizer_item1.height;
               this.mcMechItem.removeAllListeners();
               this.mcMechItem.x = this.mcSizer_item1.x;
               this.mcMechItem.y = this.mcSizer_item1.y;
               this.mcIconsHolder.addChild(this.mcMechItem);
            }
            this.mcInventoryItem = dataM.createInventoryTileListItem(this._inventoryPlayerItemID,false,null,null,null,null,null,true);
            this.mcInventoryItem.width = this.mcSizer_item2.width;
            this.mcInventoryItem.height = this.mcSizer_item2.height;
            this.mcInventoryItem.removeAllListeners();
            this.mcInventoryItem.x = this.mcSizer_item2.x;
            this.mcInventoryItem.y = this.mcSizer_item2.y;
            this.mcIconsHolder.addChild(this.mcInventoryItem);
            this._totalAttributes = 0;
            this._currnetRow = 0;
            this.checkAttribute("weight");
            this.checkAttribute("hp");
            this.checkAttribute("uses");
            this.checkAttribute("damage");
            this.checkAttribute("damageHeat");
            this.checkAttribute("damageEnergy");
            this.checkAttribute("push");
            this.checkAttribute("pull");
            this.checkAttribute("range");
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
            this.checkAttribute("bullets");
            this.checkAttribute("rockets");
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
               _loc3_ = this._currnetRow + 1;
               while(_loc3_ <= this.MAX_ROWS)
               {
                  this["txtItem_statA" + _loc3_].text = "";
                  this["txtItem_statB" + _loc3_].text = "";
                  this["txtItem_statC" + _loc3_].text = "";
                  _loc3_++;
               }
            }
            if(dataM.runAsMobile == false)
            {
               _loc6_ = ["A","B","C"];
               _loc3_ = 1;
               while(_loc3_ <= this.MAX_ROWS)
               {
                  _loc7_ = 0;
                  while(_loc7_ <= 2)
                  {
                     _loc8_ = "txtItem_stat" + _loc6_[_loc7_] + _loc3_;
                     if(this[_loc8_].text == "")
                     {
                        if(this[_loc8_].parent != null)
                        {
                           this[_loc8_].parent.removeChild(this[_loc8_]);
                        }
                     }
                     else if(this[_loc8_].parent == null)
                     {
                        addChild(this[_loc8_]);
                     }
                     _loc7_++;
                  }
                  _loc3_++;
               }
            }
            if(dataM.runAsMobile)
            {
               _loc9_ = new Array();
               _loc3_ = 0;
               while(_loc3_ < this._texts.length)
               {
                  if(this._texts[_loc3_].parent != null)
                  {
                     _loc9_.push(this._texts[_loc3_]);
                  }
                  _loc3_++;
               }
               screensM.createMultipleTextsBitmap("hangerItemComparisonTexts",_loc9_,"",this);
               _loc10_ = 1.7;
               _loc11_ = new Array();
               _loc12_ = new Array();
               _loc13_ = 0;
               _loc3_ = 0;
               while(_loc3_ < this._icons.length)
               {
                  if(this._icons[_loc3_] != null)
                  {
                     if(this._icons[_loc3_].parent != null)
                     {
                        _loc11_.push(this._icons[_loc3_]);
                        _loc12_[_loc3_] = this._icons[_loc3_].y;
                        this._icons[_loc3_].width *= _loc10_;
                        this._icons[_loc3_].height *= _loc10_;
                        this._icons[_loc3_].y += (this._icons[_loc3_].y - this.mcSizer_icon.y) * (_loc10_ - 1);
                        _loc13_++;
                     }
                  }
                  _loc3_++;
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
               _loc14_ = screensM.createAssetsBitmap([],_loc11_,0,0);
               this._iconsBMD = _loc14_[0];
               this._iconsBM = _loc14_[1];
               this._iconsBM.width /= _loc10_;
               this._iconsBM.height /= _loc10_;
               addChild(this._iconsBM);
               _loc3_ = 0;
               while(_loc3_ < this._icons.length)
               {
                  if(_loc12_[_loc3_] != null)
                  {
                     this._icons[_loc3_].width = this.mcSizer_icon.width;
                     this._icons[_loc3_].height = this.mcSizer_icon.height;
                     this._icons[_loc3_].y = _loc12_[_loc3_];
                  }
                  _loc3_++;
               }
            }
            this.mcBackground.gotoAndStop(this._currnetRow);
         }
      }
      
      public function changeMechPlayerItemIDOnly(param1:Number) : void
      {
         this.refreshScreen(param1,this._inventoryPlayerItemID);
      }
      
      private function checkAttribute(param1:String) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Sprite = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:Boolean = false;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Number = NaN;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         if(this._currnetRow < this.MAX_ROWS)
         {
            _loc2_ = false;
            _loc4_ = 0;
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = 0;
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = false;
            _loc11_ = 0;
            _loc12_ = 0;
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
                        _loc4_ = this._mechItemDB.weight;
                        _loc5_ = this._inventoryItemDB.weight;
                        _loc10_ = true;
                  }
                  break;
               case "hp":
                  _loc4_ = this._mechItemDB.HPBase;
                  _loc5_ = this._inventoryItemDB.HPBase;
                  if(this._equipmentType == "torso")
                  {
                     if(this._mechPlayerItemID > 0)
                     {
                        _loc6_ = dataM.getItemPowerHPBonus(dataM.player1PlayerID,this._mechPlayerItemID);
                     }
                     _loc7_ = dataM.getItemPowerHPBonus(dataM.player1PlayerID,this._inventoryPlayerItemID);
                     _loc4_ += _loc6_;
                     _loc5_ += _loc7_;
                  }
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
                     _loc4_ = Number(this._mechItemDB[param1]);
                     _loc5_ = Number(this._inventoryItemDB[param1]);
                  }
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     switch(param1)
                     {
                        case "absorbRatio":
                           if(this._inventoryItemDB.energyPerBlock > 0)
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
                           _loc10_ = true;
                           break;
                        case "heatPerBlock":
                           _loc3_ = this.mcIcon_heat;
                           _loc10_ = true;
                     }
                  }
                  break;
               case "damage":
                  _loc11_ = this._mechItemDB.damageBase;
                  if(this._mechPlayerItemID > 0)
                  {
                     _loc8_ = dataM.getItemPowerDamageBonus(dataM.player1PlayerID,this._mechPlayerItemID);
                     _loc11_ -= _loc8_;
                  }
                  _loc12_ = this._inventoryItemDB.damageBase;
                  _loc9_ = dataM.getItemPowerDamageBonus(dataM.player1PlayerID,this._inventoryPlayerItemID);
                  _loc12_ -= _loc9_;
                  _loc4_ = _loc11_ + Math.ceil(this._mechItemDB.damageAddon / 2) + _loc8_;
                  _loc5_ = _loc12_ + Math.ceil(this._inventoryItemDB.damageAddon / 2) + _loc9_;
                  if(_loc11_ + this._mechItemDB.damageAddon > 0 || _loc12_ + this._inventoryItemDB.damageAddon > 0)
                  {
                     _loc2_ = true;
                     if(this._mechItemDB.damageType == this._inventoryItemDB.damageType)
                     {
                        switch(this._mechItemDB.damageType)
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
               case "damageHeat":
                  _loc4_ = this._mechItemDB.damageHeat;
                  _loc5_ = this._inventoryItemDB.damageHeat;
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this.mcIcon_damageType_explosivePlus;
                  }
                  break;
               case "damageEnergy":
                  _loc4_ = this._mechItemDB.damageEnergy;
                  _loc5_ = this._inventoryItemDB.damageEnergy;
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this.mcIcon_damageType_electricPlus;
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
                           _loc4_ = this._mechItemDB.rangeAddon;
                           _loc5_ = this._inventoryItemDB.rangeAddon;
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
                        _loc4_ = this._mechItemDB.energyBase;
                        _loc5_ = this._inventoryItemDB.energyBase;
                        break;
                     case "energyRegeneration":
                        _loc4_ = this._mechItemDB.energyAddon;
                        _loc5_ = this._inventoryItemDB.energyAddon;
                        break;
                     case "heat":
                        _loc4_ = this._mechItemDB.heatBase;
                        _loc5_ = this._inventoryItemDB.heatBase;
                        break;
                     case "heatCooling":
                        _loc4_ = this._mechItemDB.heatAddon;
                        _loc5_ = this._inventoryItemDB.heatAddon;
                  }
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this["mcIcon_" + param1];
                  }
                  break;
               case "pull":
                  if(this._mechItemDB.push < 0)
                  {
                     _loc4_ = Math.abs(this._mechItemDB.push);
                  }
                  if(this._inventoryItemDB.push < 0)
                  {
                     _loc5_ = Math.abs(this._inventoryItemDB.push);
                  }
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this.mcIcon_pull;
                  }
                  break;
               case "push":
                  if(this._mechItemDB.push > 0)
                  {
                     _loc4_ = this._mechItemDB.push;
                  }
                  if(this._inventoryItemDB.push > 0)
                  {
                     _loc5_ = this._inventoryItemDB.push;
                  }
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this.mcIcon_push;
                  }
                  break;
               case "bullets":
               case "rockets":
               case "stepsPerWalk":
               case "stepsPerJump":
                  _loc4_ = Number(this._mechItemDB[param1]);
                  _loc5_ = Number(this._inventoryItemDB[param1]);
                  if(_loc4_ > 0 || _loc5_ > 0)
                  {
                     _loc2_ = true;
                     _loc3_ = this["mcIcon_" + param1];
                     switch(this._equipmentType)
                     {
                        case "sideWeapon":
                        case "topWeapon":
                        case "drone":
                           _loc10_ = true;
                     }
                  }
                  break;
               case "costEnergy":
               case "costHeat":
                  _loc4_ = Number(this._mechItemDB[param1]);
                  _loc5_ = Number(this._inventoryItemDB[param1]);
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
                     _loc10_ = true;
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
                              _loc4_ = this._mechItemDB.resist1;
                              _loc5_ = this._inventoryItemDB.resist1;
                              break;
                           case "resist_explosive":
                              _loc4_ = this._mechItemDB.resist2;
                              _loc5_ = this._inventoryItemDB.resist2;
                              break;
                           case "resist_electric":
                              _loc4_ = this._mechItemDB.resist3;
                              _loc5_ = this._inventoryItemDB.resist3;
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
                              _loc4_ = this._mechItemDB.resist1;
                              _loc5_ = this._inventoryItemDB.resist1;
                              break;
                           case "damageResist_explosive":
                              _loc4_ = this._mechItemDB.resist2;
                              _loc5_ = this._inventoryItemDB.resist2;
                              break;
                           case "damageResist_electric":
                              _loc4_ = this._mechItemDB.resist3;
                              _loc5_ = this._inventoryItemDB.resist3;
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
               _loc13_ = _loc5_ - _loc4_;
               _loc14_ = dataM.COLOR_TEXT;
               _loc15_ = "";
               _loc16_ = String(_loc13_);
               if(param1 == "damage")
               {
                  if(_loc11_ <= 0 && this._mechItemDB.damageAddon <= 0)
                  {
                     _loc16_ = "";
                  }
                  else
                  {
                     if(_loc11_ > 0 && this._mechItemDB.damageAddon == 0)
                     {
                        _loc16_ = String(_loc11_);
                     }
                     else if(_loc8_ > 0)
                     {
                        _loc16_ = _loc11_ + "-" + (_loc11_ + this._mechItemDB.damageAddon);
                     }
                     else
                     {
                        _loc16_ = _loc11_ + " - " + (_loc11_ + this._mechItemDB.damageAddon);
                     }
                     if(_loc8_ > 0)
                     {
                        _loc16_ = _loc16_ + " +" + _loc8_;
                     }
                  }
               }
               else if(param1 == "hp")
               {
                  if(this._mechPlayerItemID == 0)
                  {
                     _loc16_ = "";
                  }
                  else if(this._mechItemDB.HPBase > 0)
                  {
                     _loc16_ = String(this._mechItemDB.HPBase - _loc6_);
                     if(_loc6_ > 0)
                     {
                        _loc16_ = _loc16_ + " + " + _loc6_;
                     }
                  }
                  else
                  {
                     _loc16_ = "";
                  }
               }
               else if(param1 == "absorbRatio")
               {
                  _loc16_ = _loc4_ + "%";
               }
               else if(_loc4_ > 0)
               {
                  _loc16_ = String(_loc4_);
               }
               else
               {
                  _loc16_ = "";
               }
               this["txtItem_statA" + this._currnetRow].text = _loc16_;
               if(_loc16_ != "")
               {
                  this.mcIconsHolder.addChild(this["txtItem_statA" + this._currnetRow]);
               }
               if(param1 == "damage")
               {
                  if(_loc12_ <= 0 && this._inventoryItemDB.damageAddon <= 0)
                  {
                     _loc16_ = "";
                  }
                  else
                  {
                     if(_loc12_ > 0 && this._inventoryItemDB.damageAddon == 0)
                     {
                        _loc16_ = String(_loc12_);
                     }
                     else if(_loc9_ > 0)
                     {
                        _loc16_ = _loc12_ + "-" + (_loc12_ + this._inventoryItemDB.damageAddon);
                     }
                     else
                     {
                        _loc16_ = _loc12_ + " - " + (_loc12_ + this._inventoryItemDB.damageAddon);
                     }
                     if(_loc9_ > 0)
                     {
                        _loc16_ = _loc16_ + " +" + _loc9_;
                     }
                  }
               }
               else if(param1 == "hp")
               {
                  if(this._inventoryItemDB.HPBase > 0)
                  {
                     _loc16_ = String(this._inventoryItemDB.HPBase - _loc7_);
                     if(_loc7_ > 0)
                     {
                        _loc16_ = _loc16_ + " + " + _loc7_;
                     }
                  }
                  else
                  {
                     _loc16_ = "";
                  }
               }
               else if(param1 == "absorbRatio")
               {
                  _loc16_ = _loc5_ + "%";
               }
               else if(_loc5_ > 0)
               {
                  _loc16_ = String(_loc5_);
               }
               else
               {
                  _loc16_ = "";
               }
               this["txtItem_statB" + this._currnetRow].text = _loc16_;
               if(_loc16_ != "")
               {
                  this.mcIconsHolder.addChild(this["txtItem_statB" + this._currnetRow]);
               }
               _loc16_ = "";
               if(_loc13_ != 0)
               {
                  if(param1 == "absorbRatio")
                  {
                     _loc16_ = _loc13_ + "%";
                  }
                  else
                  {
                     _loc16_ = String(_loc13_);
                  }
                  if(_loc13_ > 0)
                  {
                     _loc15_ = "+";
                     if(_loc10_)
                     {
                        _loc14_ = dataM.COLOR_BAD;
                     }
                     else
                     {
                        _loc14_ = dataM.COLOR_GOOD;
                     }
                  }
                  else if(_loc10_)
                  {
                     _loc14_ = dataM.COLOR_GOOD;
                  }
                  else
                  {
                     _loc14_ = dataM.COLOR_BAD;
                  }
                  this["txtItem_statC" + this._currnetRow].htmlText = "<FONT COLOR=\'#" + _loc14_ + "\'>" + _loc15_ + _loc16_ + "</FONT>";
                  this.mcIconsHolder.addChild(this["txtItem_statC" + this._currnetRow]);
               }
               else
               {
                  this["txtItem_statC" + this._currnetRow].htmlText = "";
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
      
      public function getInventoryPlayerItemID() : Number
      {
         return this._inventoryPlayerItemID;
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
         if(this.mcMechItem != null)
         {
            this.mcMechItem.removeMe();
         }
         if(this.mcInventoryItem != null)
         {
            this.mcInventoryItem.removeMe();
         }
      }
      
      public function closeClicked() : void
      {
         this.removeMe();
         screensM.screenHangerMech.showAllAvailableItems();
         screensM.screenHangerMech.mechEquipment.removeEquipmentMarkers();
         screensM.screenHangerMech.showMechStats();
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened("screenHangerItemComparison"))
         {
            this._mechPlayerItemID = 0;
            this._inventoryPlayerItemID = 0;
            this._mechItemDB = null;
            this._inventoryItemDB = null;
            this.removeAllIcons();
            this.removeItems();
            screensM.removeScreen("screenHangerItemComparison");
         }
      }
   }
}

