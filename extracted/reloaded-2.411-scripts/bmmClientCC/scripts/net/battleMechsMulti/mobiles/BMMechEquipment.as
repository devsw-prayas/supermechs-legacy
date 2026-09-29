package net.battleMechsMulti.mobiles
{
   import fl.motion.Color;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BMMechEquipment extends BMBaseClass
   {
      
      public var equipmentItems:Array;
      
      private var _equipmentItemMouseDown:Function;
      
      private var _equipmentItemMouseUp:Function;
      
      private var _equipmentItemMouseOver:Function;
      
      private var _equipmentItemMouseOut:Function;
      
      private var _mouseUpOutsideEquipment:Function;
      
      private var _mouseDownOutsideEquipment:Function;
      
      private var _mouseOverOutsideEquipment:Function;
      
      private var _mouseOutOutsideEquipment:Function;
      
      private var _breakApart:Function;
      
      public var mouseHitArea:Sprite = new Sprite();
      
      private var mechViewHolder:Sprite = new Sprite();
      
      public var leg:BMTileListItem = new BMTileListItem();
      
      public var torso:BMTileListItem = new BMTileListItem();
      
      public var sideWeapon1:BMTileListItem = new BMTileListItem();
      
      public var sideWeapon2:BMTileListItem = new BMTileListItem();
      
      public var sideWeapon3:BMTileListItem = new BMTileListItem();
      
      public var sideWeapon4:BMTileListItem = new BMTileListItem();
      
      public var topWeapon1:BMTileListItem = new BMTileListItem();
      
      public var topWeapon2:BMTileListItem = new BMTileListItem();
      
      public var sideWeapon1NotEnoughAmmo:MovieClip;
      
      public var sideWeapon2NotEnoughAmmo:MovieClip;
      
      public var sideWeapon3NotEnoughAmmo:MovieClip;
      
      public var sideWeapon4NotEnoughAmmo:MovieClip;
      
      public var topWeapon1NotEnoughAmmo:MovieClip;
      
      public var topWeapon2NotEnoughAmmo:MovieClip;
      
      public var droneNotEnoughAmmo:MovieClip;
      
      public var drone:BMTileListItem = new BMTileListItem();
      
      public var shield:BMTileListItem = new BMTileListItem();
      
      public var teleport:BMTileListItem = new BMTileListItem();
      
      public var charge:BMTileListItem = new BMTileListItem();
      
      public var harpoon:BMTileListItem = new BMTileListItem();
      
      public var module1:BMTileListItem = new BMTileListItem();
      
      public var module2:BMTileListItem = new BMTileListItem();
      
      public var module3:BMTileListItem = new BMTileListItem();
      
      public var module4:BMTileListItem = new BMTileListItem();
      
      public var module5:BMTileListItem = new BMTileListItem();
      
      public var module6:BMTileListItem = new BMTileListItem();
      
      public var module7:BMTileListItem = new BMTileListItem();
      
      public var perk:BMTileListItem = new BMTileListItem();
      
      private var marker_torso:Sprite;
      
      private var marker_leg:Sprite;
      
      private var marker_sideWeapon1:Sprite;
      
      private var marker_sideWeapon2:Sprite;
      
      private var marker_sideWeapon3:Sprite;
      
      private var marker_sideWeapon4:Sprite;
      
      private var marker_topWeapon1:Sprite;
      
      private var marker_topWeapon2:Sprite;
      
      private var marker_drone:Sprite;
      
      private var marker_shield:Sprite;
      
      private var marker_teleport:Sprite;
      
      private var marker_charge:Sprite;
      
      private var marker_harpoon:Sprite;
      
      private var marker_module1:Sprite;
      
      private var marker_module2:Sprite;
      
      private var marker_module3:Sprite;
      
      private var marker_module4:Sprite;
      
      private var marker_module5:Sprite;
      
      private var marker_module6:Sprite;
      
      private var marker_module7:Sprite;
      
      private var marker_perk:Sprite;
      
      public var mechView:BMMechView;
      
      private var mechViewMask:Sprite;
      
      private var _firstLevel_drone:Number = 0;
      
      private var _firstLevel_shield:Number = 0;
      
      private var _firstLevel_teleport:Number = 0;
      
      private var _firstLevel_charge:Number = 0;
      
      private var _firstLevel_harpoon:Number = 0;
      
      private var _notEnoughAmmoItemIDs:Array;
      
      private var _notEnoughAmmoItems_old:Object = new Object();
      
      private var _notEnoughAmmoItems_new:Object = new Object();
      
      private var _lastMechStructure:BMMechStructure;
      
      private var _equipmentSlotsInitialXPos:Number;
      
      private var _equipmentSlotsInitialYPos:Number;
      
      private var mechHologramPointer:MovieClip;
      
      private const MECH_SIZE_RATIO:Number = 0.85;
      
      private const MECH_TOOLTIP_BUTTON_SIZE:Number = 30;
      
      private const MECH_TOOLTIP_BUTTON_JUMP:Number = 6;
      
      public function BMMechEquipment()
      {
         super();
      }
      
      public function initialize(param1:Function, param2:Function, param3:Function, param4:Function, param5:Function, param6:Function, param7:Function, param8:Function, param9:Function, param10:MovieClip, param11:Sprite) : void
      {
         generateSingletonClassesPointers("");
         this._equipmentItemMouseDown = param1;
         this._equipmentItemMouseUp = param2;
         this._equipmentItemMouseOver = param3;
         this._equipmentItemMouseOut = param4;
         this._mouseUpOutsideEquipment = param5;
         this._mouseDownOutsideEquipment = param6;
         this._mouseOverOutsideEquipment = param7;
         this._mouseOutOutsideEquipment = param8;
         this._breakApart = param9;
         this.mechHologramPointer = param10;
         this.mouseHitArea.graphics.beginFill(16777215,0);
         this.mouseHitArea.graphics.drawRect(0,0,param11.width,param11.height);
         this.mouseHitArea.graphics.endFill();
         this.mouseHitArea.x = -this.mouseHitArea.width / 2;
         this.mouseHitArea.y = -this.mouseHitArea.height / 2;
         if(dataM.runAsMobile == false)
         {
            this.mouseHitArea.addEventListener(MouseEvent.MOUSE_UP,this.mouseHitAreaMouseUp);
            this.mouseHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseHitAreaMouseDown);
            this.mouseHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.mouseHitAreaMouseOver);
            this.mouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.mouseHitAreaMouseOut);
         }
         this.mechViewHolder = new Sprite();
         this.mechViewMask = new Sprite();
         this.mechViewMask.graphics.beginFill(16777215,0);
         this.mechViewMask.graphics.drawRect(-(param11.width - 10) / 2,-(param11.height - 10) / 2,param11.width - 10,param11.height - 10);
         this.mechViewMask.graphics.endFill();
         this.sideWeapon1NotEnoughAmmo = new mcMechEquipmentNotEnoughAmmo();
         this.sideWeapon2NotEnoughAmmo = new mcMechEquipmentNotEnoughAmmo();
         this.sideWeapon3NotEnoughAmmo = new mcMechEquipmentNotEnoughAmmo();
         this.sideWeapon4NotEnoughAmmo = new mcMechEquipmentNotEnoughAmmo();
         this.topWeapon1NotEnoughAmmo = new mcMechEquipmentNotEnoughAmmo();
         this.topWeapon2NotEnoughAmmo = new mcMechEquipmentNotEnoughAmmo();
         this.droneNotEnoughAmmo = new mcMechEquipmentNotEnoughAmmo();
         this.sideWeapon1NotEnoughAmmo.mouseEnabled = false;
         this.sideWeapon1NotEnoughAmmo.mouseChildren = false;
         this.sideWeapon2NotEnoughAmmo.mouseEnabled = false;
         this.sideWeapon2NotEnoughAmmo.mouseChildren = false;
         this.sideWeapon3NotEnoughAmmo.mouseEnabled = false;
         this.sideWeapon3NotEnoughAmmo.mouseChildren = false;
         this.sideWeapon4NotEnoughAmmo.mouseEnabled = false;
         this.sideWeapon4NotEnoughAmmo.mouseChildren = false;
         this.topWeapon1NotEnoughAmmo.mouseEnabled = false;
         this.topWeapon1NotEnoughAmmo.mouseChildren = false;
         this.topWeapon2NotEnoughAmmo.mouseEnabled = false;
         this.topWeapon2NotEnoughAmmo.mouseChildren = false;
         this.droneNotEnoughAmmo.mouseEnabled = false;
         this.droneNotEnoughAmmo.mouseChildren = false;
         addChild(this.mechViewMask);
         addChild(this.mechViewHolder);
         addChild(this.mouseHitArea);
         this.addEquipment();
         this._lastMechStructure = new BMMechStructure();
         this._lastMechStructure.initialize(0,0);
         this._lastMechStructure.resetStructure();
      }
      
      private function addEquipment() : void
      {
         this._equipmentSlotsInitialXPos = -(screensM.screenHangerMech.mcSizer_mechEquipment.width / 2 + screensM.screenHangerMech.mcSizer_mechEquipment.x);
         this._equipmentSlotsInitialYPos = -(screensM.screenHangerMech.mcSizer_mechEquipment.height / 2 + screensM.screenHangerMech.mcSizer_mechEquipment.y);
         this.equipmentItems = new Array();
         this.initializeSpecificEquipment(this.leg,"leg",0);
         this.initializeSpecificEquipment(this.torso,"torso",0);
         this.initializeSpecificEquipment(this.sideWeapon1,"sideWeapon",1);
         this.initializeSpecificEquipment(this.sideWeapon2,"sideWeapon",2);
         this.initializeSpecificEquipment(this.sideWeapon3,"sideWeapon",3);
         this.initializeSpecificEquipment(this.sideWeapon4,"sideWeapon",4);
         this.initializeSpecificEquipment(this.topWeapon1,"topWeapon",1);
         this.initializeSpecificEquipment(this.topWeapon2,"topWeapon",2);
         this.initializeSpecificEquipment(this.drone,"drone",0);
         this.initializeSpecificEquipment(this.shield,"shield",0);
         this.initializeSpecificEquipment(this.charge,"charge",0);
         this.initializeSpecificEquipment(this.teleport,"teleport",0);
         this.initializeSpecificEquipment(this.harpoon,"harpoon",0);
         this.initializeSpecificEquipment(this.module1,"module",1);
         this.initializeSpecificEquipment(this.module2,"module",2);
         this.initializeSpecificEquipment(this.module3,"module",3);
         this.initializeSpecificEquipment(this.module4,"module",4);
         this.initializeSpecificEquipment(this.module5,"module",5);
         this.initializeSpecificEquipment(this.module6,"module",6);
         this.initializeSpecificEquipment(this.module7,"module",7);
         this.initializeSpecificEquipment(this.perk,"perk",0);
         var _loc1_:uint = 30;
         this.sideWeapon1NotEnoughAmmo.x = this.sideWeapon1.x + this.sideWeapon1.width - _loc1_;
         this.sideWeapon2NotEnoughAmmo.x = this.sideWeapon2.x + this.sideWeapon2.width - _loc1_;
         this.sideWeapon3NotEnoughAmmo.x = this.sideWeapon3.x + this.sideWeapon3.width - _loc1_;
         this.sideWeapon4NotEnoughAmmo.x = this.sideWeapon4.x + this.sideWeapon4.width - _loc1_;
         this.topWeapon1NotEnoughAmmo.x = this.topWeapon1.x + this.topWeapon1.width - _loc1_;
         this.topWeapon2NotEnoughAmmo.x = this.topWeapon2.x + this.topWeapon2.width - _loc1_;
         this.droneNotEnoughAmmo.x = this.drone.x + this.drone.width - _loc1_;
         this.sideWeapon1NotEnoughAmmo.y = this.sideWeapon1.y + this.sideWeapon1.height - _loc1_;
         this.sideWeapon2NotEnoughAmmo.y = this.sideWeapon2.y + this.sideWeapon2.height - _loc1_;
         this.sideWeapon3NotEnoughAmmo.y = this.sideWeapon3.y + this.sideWeapon3.height - _loc1_;
         this.sideWeapon4NotEnoughAmmo.y = this.sideWeapon4.y + this.sideWeapon4.height - _loc1_;
         this.topWeapon1NotEnoughAmmo.y = this.topWeapon1.y + this.topWeapon1.height - _loc1_;
         this.topWeapon2NotEnoughAmmo.y = this.topWeapon2.y + this.topWeapon2.height - _loc1_;
         this.droneNotEnoughAmmo.y = this.drone.y + this.drone.height - _loc1_;
         addChild(this.sideWeapon1NotEnoughAmmo);
         addChild(this.sideWeapon2NotEnoughAmmo);
         addChild(this.sideWeapon3NotEnoughAmmo);
         addChild(this.sideWeapon4NotEnoughAmmo);
         addChild(this.topWeapon1NotEnoughAmmo);
         addChild(this.topWeapon2NotEnoughAmmo);
         addChild(this.droneNotEnoughAmmo);
      }
      
      private function initializeSpecificEquipment(param1:BMTileListItem, param2:String, param3:Number) : void
      {
         var _loc4_:Number = dataM.EQUIPMENT_TILE_LIST_ITEM_SIZE;
         var _loc5_:Function = this.equipmentItemMouseOver;
         var _loc6_:Function = this.equipmentItemMouseOut;
         if(dataM.runAsMobile)
         {
            _loc5_ = null;
            _loc6_ = null;
         }
         var _loc7_:Function = this.equipmentItemMouseDown;
         var _loc8_:Function = this.equipmentItemMouseUp;
         var _loc9_:Function = _loc5_;
         var _loc10_:Function = _loc6_;
         if(dataM.runAsMobile)
         {
            _loc7_ = null;
            _loc8_ = null;
            _loc9_ = null;
            _loc10_ = null;
         }
         param1.initialize(_loc4_,_loc4_,this.getEmptyItem(param2,param3),"","","",0,null,_loc7_,_loc8_,_loc9_,_loc10_,dataM.runAsMobile);
         param1.tileID = this.equipmentItems.length;
         param1.disableMe(true);
         var _loc11_:String = param2;
         if(param3 > 0)
         {
            _loc11_ = param2 + param3;
         }
         param1.x = screensM.screenHangerMech["mcSizer_" + _loc11_].x + this._equipmentSlotsInitialXPos;
         param1.y = screensM.screenHangerMech["mcSizer_" + _loc11_].y + this._equipmentSlotsInitialYPos;
         screensM.screenHangerMech["mcSizer_" + _loc11_].parent.removeChild(screensM.screenHangerMech["mcSizer_" + _loc11_]);
         var _loc12_:BMMechEquipmentItem = new BMMechEquipmentItem();
         _loc12_.tileListItem = param1;
         _loc12_.equipmentType = param2;
         _loc12_.equipmentID = param3;
         this.equipmentItems.push(_loc12_);
         addChild(param1);
         var _loc13_:String = param2;
         if(param3 > 0)
         {
            _loc13_ = param2 + param3;
         }
         this["marker_" + _loc13_] = new mcMechEquipmentMarker();
         var _loc14_:Sprite = this["marker_" + _loc13_];
         _loc14_.x = param1.x;
         _loc14_.y = param1.y;
         _loc14_.width = _loc4_;
         _loc14_.height = _loc4_;
         _loc14_.mouseEnabled = false;
         _loc14_.mouseChildren = false;
      }
      
      private function getEmptyItem(param1:String, param2:Number) : BMItem
      {
         var _loc4_:String = null;
         var _loc7_:Color = null;
         var _loc3_:BMItem = new BMItem();
         switch(param1)
         {
            case "sideWeapon":
            case "topWeapon":
               switch(param2)
               {
                  case 1:
                  case 3:
                     _loc4_ = "emptyItem_" + param1 + "Left";
                     break;
                  default:
                     _loc4_ = "emptyItem_" + param1 + "Right";
               }
               break;
            default:
               _loc4_ = "emptyItem_" + param1;
         }
         var _loc5_:MovieClip = externalAssetsM.getAsset("general",_loc4_,0,0,true,false);
         var _loc6_:Sprite = new mcEquipmentSlotSocket();
         _loc6_.width = _loc5_.width + 1;
         _loc6_.height = _loc5_.height + 1;
         switch(param1)
         {
            case "torso":
            case "sideWeapon":
            case "topWeapon":
            case "leg":
               _loc7_ = new Color();
               _loc7_.setTint(0,0.4);
               _loc5_.transform.colorTransform = _loc7_;
               break;
            default:
               _loc7_ = new Color();
               _loc7_.setTint(0,0.4);
               _loc6_.transform.colorTransform = _loc7_;
         }
         _loc5_.addChild(_loc6_);
         var _loc8_:Number = dataM.EQUIPMENT_TILE_LIST_ITEM_SIZE;
         _loc3_.initialize(0,_loc8_,_loc8_,_loc5_,0,0,false,null,dataM.runAsMobile);
         if(dataM.runAsMobile)
         {
            _loc3_.convertMeIntoBitmap(true);
         }
         return _loc3_;
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this.mechView != null)
         {
            this.mechView.onEnterFrameTrigger();
         }
      }
      
      public function addMechView() : void
      {
         if(this.mechView != null)
         {
            if(this.mechView.parent != null)
            {
               this.mechView.parent.removeChild(this.mechView);
            }
            this.mechView.removeMe();
         }
         this.mechView = new BMMechView();
         this.mechView.scaleX = 0.75;
         this.mechView.scaleY = 0.75;
         this.mechView.y = -5;
         this.mechView.initialize(dataM.player1PlayerID,"hanger","playerItemID",this.MECH_SIZE_RATIO,true);
         this.mechView.centerMech = true;
         this.mechView.mask = this.mechViewMask;
         this.mechViewHolder.addChild(this.mechView);
      }
      
      public function refreshEquipemnt(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:BMPlayerData = null;
         var _loc5_:BMPlayerProfile = null;
         var _loc6_:uint = 0;
         var _loc7_:BMMechStructure = null;
         var _loc8_:BMTileListItem = null;
         var _loc9_:BMMechEquipmentItem = null;
         var _loc10_:Number = NaN;
         var _loc11_:uint = 0;
         var _loc12_:Object = null;
         var _loc13_:Boolean = false;
         var _loc14_:BMItem = null;
         var _loc15_:String = null;
         var _loc16_:BMPlayerItemData = null;
         var _loc17_:BMItemData = null;
         var _loc18_:Boolean = false;
         var _loc19_:String = null;
         var _loc20_:String = null;
         if(this.module1.x != screensM.screenHangerMech.mcSizer_module1.x + this._equipmentSlotsInitialXPos)
         {
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["module"])
            {
               if(this.hasOwnProperty("module" + _loc3_))
               {
                  this["module" + _loc3_].x = screensM.screenHangerMech["mcSizer_module" + _loc3_].x + this._equipmentSlotsInitialXPos;
                  this["marker_module" + _loc3_].x = screensM.screenHangerMech["mcSizer_module" + _loc3_].x + this._equipmentSlotsInitialXPos;
               }
               _loc3_++;
            }
         }
         if(this.mechView == null)
         {
            TsLogger.log("BMMechEquipment error - mechView was not added. please use addMechView()");
         }
         else
         {
            this.refreshNotEnoughAmmoAlerts();
            _loc4_ = dataM.playersData[dataM.player1PlayerID];
            _loc5_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc6_ = screensM.screenHangerMech.getTargetMechID();
            _loc7_ = _loc4_.mechStructures[_loc6_];
            _loc12_ = new Object();
            if(param2 == false)
            {
               if(this._lastMechStructure.torso != _loc7_.torso || dataM.mechEquipment_playerItemIDsUpgraded[_loc7_.torso] != null)
               {
                  _loc12_["torso"] = true;
               }
               else if(this._lastMechStructure.perk != _loc7_.perk)
               {
                  _loc18_ = false;
                  if(this._lastMechStructure.perk > 0)
                  {
                     _loc16_ = dataM.getPlayerItemData(dataM.player1PlayerID,this._lastMechStructure.perk);
                     _loc17_ = dataM.itemsDB[_loc16_.itemID];
                     if(_loc17_.grp == "perk_torso1" || _loc17_.grp == "perk_hat1")
                     {
                        _loc18_ = true;
                     }
                  }
                  if(_loc18_ == false && _loc7_.perk > 0)
                  {
                     _loc16_ = dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_.perk);
                     _loc17_ = dataM.itemsDB[_loc16_.itemID];
                     if(_loc17_.grp == "perk_torso1" || _loc17_.grp == "perk_hat1")
                     {
                        _loc18_ = true;
                     }
                  }
                  if(_loc18_)
                  {
                     param1 = true;
                     screensM.screenHangerMech.mechEquipment.mechView.forceRebuildingTorso = true;
                  }
               }
               if(this._lastMechStructure.leg != _loc7_.leg || dataM.mechEquipment_playerItemIDsUpgraded[_loc7_.leg] != null)
               {
                  _loc12_["leg"] = true;
               }
               _loc3_ = 1;
               while(_loc3_ <= dataM.maxEquipment["sideWeapon"])
               {
                  if(this._lastMechStructure["sideWeapon" + _loc3_] != _loc7_["sideWeapon" + _loc3_] || this._notEnoughAmmoItems_old["sideWeapon" + _loc3_] != null || this._notEnoughAmmoItems_new["sideWeapon" + _loc3_] != null || dataM.mechEquipment_playerItemIDsUpgraded[_loc7_["sideWeapon" + _loc3_]] != null)
                  {
                     _loc12_["sideWeapon" + _loc3_] = true;
                  }
                  _loc3_++;
               }
               _loc3_ = 1;
               while(_loc3_ <= dataM.maxEquipment["topWeapon"])
               {
                  if(this._lastMechStructure["topWeapon" + _loc3_] != _loc7_["topWeapon" + _loc3_] || this._notEnoughAmmoItems_old["topWeapon" + _loc3_] != null || this._notEnoughAmmoItems_new["topWeapon" + _loc3_] != null || dataM.mechEquipment_playerItemIDsUpgraded[_loc7_["topWeapon" + _loc3_]] != null)
                  {
                     _loc12_["topWeapon" + _loc3_] = true;
                  }
                  _loc3_++;
               }
            }
            if(this._lastMechStructure.drone != _loc7_.drone || this._notEnoughAmmoItems_old["drone"] != null || this._notEnoughAmmoItems_new["drone"] != null || dataM.mechEquipment_playerItemIDsUpgraded[_loc7_.drone] != null)
            {
               _loc12_["drone"] = true;
            }
            if(this._lastMechStructure.shield != _loc7_.shield)
            {
               _loc12_["shield"] = true;
            }
            if(this._lastMechStructure.teleport != _loc7_.teleport || dataM.mechEquipment_playerItemIDsUpgraded[_loc7_.teleport] != null)
            {
               _loc12_["teleport"] = true;
            }
            if(this._lastMechStructure.charge != _loc7_.charge || dataM.mechEquipment_playerItemIDsUpgraded[_loc7_.charge] != null)
            {
               _loc12_["charge"] = true;
            }
            if(this._lastMechStructure.harpoon != _loc7_.harpoon || dataM.mechEquipment_playerItemIDsUpgraded[_loc7_.harpoon] != null)
            {
               _loc12_["harpoon"] = true;
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["module"])
            {
               if(this._lastMechStructure["module" + _loc3_] != _loc7_["module" + _loc3_])
               {
                  _loc12_["module" + _loc3_] = true;
               }
               _loc3_++;
            }
            if(this._lastMechStructure.perk != _loc7_.perk || dataM.mechEquipment_playerItemIDsUpgraded[_loc7_.perk] != null)
            {
               _loc12_["perk"] = true;
            }
            dataM.mechEquipment_playerItemIDsUpgraded = new Object();
            _loc11_ = 0;
            while(_loc11_ < this.equipmentItems.length)
            {
               _loc9_ = this.equipmentItems[_loc11_];
               _loc19_ = _loc9_.equipmentType;
               if(_loc9_.equipmentID > 0)
               {
                  _loc19_ += _loc9_.equipmentID;
               }
               if(_loc12_[_loc19_] != null || param2)
               {
                  if(_loc7_[_loc19_] == 0)
                  {
                     _loc9_.tileListItem.changeItem(this.getEmptyItem(_loc9_.equipmentType,_loc9_.equipmentID));
                  }
               }
               _loc11_++;
            }
            _loc13_ = false;
            if(_loc7_.torso > 0)
            {
               if(_loc12_["torso"] != null || param2)
               {
                  _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc7_.torso,"equipment",true);
                  this.torso.changeItem(_loc14_);
                  this.refreshItemRarityColor(this.torso,_loc7_.torso);
               }
            }
            else
            {
               _loc13_ = true;
            }
            if(_loc7_.leg > 0)
            {
               if(_loc12_["leg"] != null || param2)
               {
                  _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc7_.leg,"equipment",true);
                  this.leg.changeItem(_loc14_);
                  this.refreshItemRarityColor(this.leg,_loc7_.leg);
               }
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["sideWeapon"])
            {
               _loc10_ = Number(_loc7_["sideWeapon" + _loc3_]);
               if(_loc10_ > 0)
               {
                  if(_loc12_["sideWeapon" + _loc3_] != null || param2)
                  {
                     _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc10_,"equipment",true);
                     _loc8_ = this["sideWeapon" + _loc3_];
                     _loc8_.changeItem(_loc14_);
                     this.refreshItemRarityColor(this["sideWeapon" + _loc3_],_loc7_["sideWeapon" + _loc3_]);
                  }
               }
               _loc3_++;
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["topWeapon"])
            {
               _loc10_ = Number(_loc7_["topWeapon" + _loc3_]);
               if(_loc10_ > 0)
               {
                  if(_loc12_["topWeapon" + _loc3_] != null || param2)
                  {
                     _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc10_,"equipment",true);
                     _loc8_ = this["topWeapon" + _loc3_];
                     _loc8_.changeItem(_loc14_);
                     this.refreshItemRarityColor(this["topWeapon" + _loc3_],_loc7_["topWeapon" + _loc3_]);
                  }
               }
               _loc3_++;
            }
            if(_loc7_.drone > 0)
            {
               if(_loc12_["drone"] != null)
               {
                  _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc7_.drone,"equipment",true);
                  this.drone.changeItem(_loc14_);
                  this.refreshItemRarityColor(this.drone,_loc7_.drone);
               }
            }
            if(_loc7_.shield > 0)
            {
               if(_loc12_["shield"] != null)
               {
                  _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc7_.shield,"equipment",true);
                  this.shield.changeItem(_loc14_);
                  this.refreshItemRarityColor(this.shield,_loc7_.shield);
               }
            }
            if(_loc7_.teleport > 0)
            {
               if(_loc12_["teleport"] != null)
               {
                  _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc7_.teleport,"equipment",true);
                  this.teleport.changeItem(_loc14_);
                  this.refreshItemRarityColor(this.teleport,_loc7_.teleport);
               }
            }
            if(_loc7_.charge > 0)
            {
               if(_loc12_["charge"] != null)
               {
                  _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc7_.charge,"equipment",true);
                  this.charge.changeItem(_loc14_);
                  this.refreshItemRarityColor(this.charge,_loc7_.charge);
               }
            }
            if(_loc7_.harpoon > 0)
            {
               if(_loc12_["harpoon"] != null)
               {
                  _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc7_.harpoon,"equipment",true);
                  this.harpoon.changeItem(_loc14_);
                  this.refreshItemRarityColor(this.harpoon,_loc7_.harpoon);
               }
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["module"])
            {
               _loc10_ = Number(_loc7_["module" + _loc3_]);
               if(_loc10_ > 0)
               {
                  if(_loc12_["module" + _loc3_] != null && this.hasOwnProperty("module" + _loc3_))
                  {
                     _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc10_,"equipment",true);
                     _loc8_ = this["module" + _loc3_];
                     _loc8_.changeItem(_loc14_);
                     this.refreshItemRarityColor(this["module" + _loc3_],_loc7_["module" + _loc3_]);
                  }
               }
               _loc3_++;
            }
            if(_loc7_.perk > 0)
            {
               if(_loc12_["perk"] != null)
               {
                  _loc14_ = dataM.createItem_basedOnPlayerItemID(dataM.player1PlayerID,_loc7_.perk,"equipment",true);
                  this.perk.changeItem(_loc14_);
                  this.refreshItemRarityColor(this.perk,_loc7_.perk);
               }
            }
            _loc15_ = "equipment7Modules";
            if(dataM.runAsMobile)
            {
               _loc15_ += "_mobile";
            }
            this.mechHologramPointer.gotoAndStop(_loc15_);
            screensM.screenHangerMech.txtMechID.text = "";
            if(_loc13_)
            {
               this.mechHologramPointer.gotoAndStop("mech");
               screensM.screenHangerMech.txtMechID.text = "";
               if(_loc7_.hasAtLeastOneItem() == false)
               {
                  if(_loc5_.level >= dataM.SECOND_MECH_UNLOCK_LEVEL)
                  {
                     _loc20_ = getSpecificText("hanger_mechID");
                     _loc20_ = dataM.replaceStringInText(_loc20_,"%ID%",String(_loc6_));
                     screensM.screenHangerMech.txtMechID.text = _loc20_;
                  }
               }
            }
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("mechEquipment_mechID",[screensM.screenHangerMech.txtMechID],"",screensM.screenHangerMech.mcMechIDTextHolder);
            }
            _loc11_ = 0;
            while(_loc11_ < this.equipmentItems.length)
            {
               _loc9_ = this.equipmentItems[_loc11_];
               _loc9_.tileListItem.disableMe(true);
               _loc9_.tileListItem.hideMe();
               _loc11_++;
            }
            this.torso.showMe();
            this.torso.enableMe();
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["sideWeapon"])
            {
               if(_loc5_.level >= dataM.equipmentUnlockDB["sideWeapon" + _loc3_].level)
               {
                  this["sideWeapon" + _loc3_].showMe();
                  this["sideWeapon" + _loc3_].enableMe();
               }
               _loc3_++;
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["topWeapon"])
            {
               if(_loc5_.level >= dataM.equipmentUnlockDB["topWeapon" + _loc3_].level)
               {
                  this["topWeapon" + _loc3_].showMe();
                  this["topWeapon" + _loc3_].enableMe();
               }
               _loc3_++;
            }
            this.leg.showMe();
            this.leg.enableMe();
            if(_loc5_.level >= dataM.equipmentUnlockDB["drone"].level)
            {
               this.drone.showMe();
               this.drone.enableMe();
            }
            if(_loc5_.level >= dataM.equipmentUnlockDB["shield"].level)
            {
               this.shield.showMe();
               this.shield.enableMe();
            }
            if(_loc5_.level >= dataM.equipmentUnlockDB["teleport"].level)
            {
               this.teleport.showMe();
               this.teleport.enableMe();
            }
            if(_loc5_.level >= dataM.equipmentUnlockDB["charge"].level)
            {
               this.charge.showMe();
               this.charge.enableMe();
            }
            if(_loc5_.level >= dataM.equipmentUnlockDB["harpoon"].level)
            {
               this.harpoon.showMe();
               this.harpoon.enableMe();
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["module"])
            {
               if(_loc5_.level >= dataM.equipmentUnlockDB["module" + _loc3_].level && this.hasOwnProperty("module" + _loc3_))
               {
                  this["module" + _loc3_].showMe();
                  this["module" + _loc3_].enableMe();
               }
               _loc3_++;
            }
            if(_loc5_.hasPerks)
            {
               this.perk.showMe();
               this.perk.enableMe();
            }
            _loc11_ = 0;
            while(_loc11_ < this.equipmentItems.length)
            {
               _loc9_ = this.equipmentItems[_loc11_];
               if(_loc5_.winsVSComputer < 3)
               {
                  _loc9_.tileListItem.disableMouseOverEffect();
               }
               else
               {
                  _loc9_.tileListItem.enableMouseOverEffect();
               }
               _loc11_++;
            }
            if(param1)
            {
               this.mechView.buildMech(_loc4_.mechStructures[_loc6_],"mechEquipment refreshEquipment");
               this.mechView.clearBreathingMovementData();
               this.mechView.removeTeasers(false);
               this.mechView.activateBreathing();
               this.mechView.x = 0;
               if(this.mechView.mechSizer.x < -170)
               {
                  this.mechView.x += Math.abs(this.mechView.mechSizer.x) - 170;
               }
            }
            this._lastMechStructure.resetStructure();
            this._lastMechStructure.torso = _loc7_.torso;
            this._lastMechStructure.leg = _loc7_.leg;
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["sideWeapon"])
            {
               this._lastMechStructure["sideWeapon" + _loc3_] = _loc7_["sideWeapon" + _loc3_];
               _loc3_++;
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["topWeapon"])
            {
               this._lastMechStructure["topWeapon" + _loc3_] = _loc7_["topWeapon" + _loc3_];
               _loc3_++;
            }
            this._lastMechStructure.drone = _loc7_.drone;
            this._lastMechStructure.shield = _loc7_.shield;
            this._lastMechStructure.teleport = _loc7_.teleport;
            this._lastMechStructure.charge = _loc7_.charge;
            this._lastMechStructure.harpoon = _loc7_.harpoon;
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["module"])
            {
               this._lastMechStructure["module" + _loc3_] = _loc7_["module" + _loc3_];
               _loc3_++;
            }
            this._lastMechStructure.perk = _loc7_.perk;
         }
      }
      
      private function refreshItemRarityColor(param1:BMTileListItem, param2:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         if(param2 > 0)
         {
            _loc3_ = "regular";
            _loc4_ = dataM.getPlayerItemData(dataM.player1PlayerID,param2);
            _loc5_ = dataM.itemsDB[_loc4_.itemID];
            switch(_loc5_.specialStatus)
            {
               case 1:
                  _loc3_ = "rare";
                  break;
               case 2:
                  _loc3_ = "epic";
                  break;
               case 3:
                  _loc3_ = "legendary";
                  break;
               case 4:
                  _loc3_ = "mythical";
                  break;
               case 5:
                  _loc3_ = "perk";
            }
            if(param1.item.backgroundMC != null)
            {
               param1.item.backgroundMC.gotoAndStop(_loc3_);
            }
         }
      }
      
      private function refreshEquipmentForSpecialItem(param1:String) : void
      {
         var _loc5_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc4_:Boolean = false;
         for each(_loc5_ in _loc3_.items)
         {
            if(_loc4_ == false)
            {
               if(_loc5_.equipmentType == param1)
               {
                  _loc4_ = true;
               }
            }
         }
         if(this["_firstLevel_" + param1] == 0)
         {
            this["_firstLevel_" + param1] = 999;
            for each(_loc7_ in dataM.itemsDB)
            {
               if(_loc7_.type == param1)
               {
                  if(_loc7_.level < this["_firstLevel_" + param1])
                  {
                     this["_firstLevel_" + param1] = _loc7_.level;
                  }
               }
            }
         }
         var _loc6_:Boolean = false;
         if(_loc2_.level >= this["_firstLevel_" + param1])
         {
            _loc6_ = true;
         }
         if(_loc6_ || _loc4_)
         {
            this[param1].showMe();
            this[param1].enableMe();
         }
      }
      
      private function breakApart() : void
      {
         this._breakApart();
      }
      
      private function refreshNotEnoughAmmoAlerts() : void
      {
         var _loc4_:String = null;
         this.resetNotEnoughAmmoAlerts();
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:uint = screensM.screenHangerMech.getTargetMechID();
         var _loc3_:BMMechStructure = _loc1_.mechStructures[_loc2_];
         _loc3_.updateEquipmentIndicators();
         this._notEnoughAmmoItems_old = new Object();
         for each(_loc4_ in this._notEnoughAmmoItems_new)
         {
            this._notEnoughAmmoItems_old[_loc4_] = _loc4_;
         }
         this._notEnoughAmmoItems_new = new Object();
         this.refreshSpecificNotEnoughAmmoAlert("sideWeapon",1,_loc3_.sideWeapon1);
         this.refreshSpecificNotEnoughAmmoAlert("sideWeapon",2,_loc3_.sideWeapon2);
         this.refreshSpecificNotEnoughAmmoAlert("sideWeapon",3,_loc3_.sideWeapon3);
         this.refreshSpecificNotEnoughAmmoAlert("sideWeapon",4,_loc3_.sideWeapon4);
         this.refreshSpecificNotEnoughAmmoAlert("topWeapon",1,_loc3_.topWeapon1);
         this.refreshSpecificNotEnoughAmmoAlert("topWeapon",2,_loc3_.topWeapon2);
         this.refreshSpecificNotEnoughAmmoAlert("drone",0,_loc3_.drone);
      }
      
      private function refreshSpecificNotEnoughAmmoAlert(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:BMPlayerData = null;
         var _loc5_:uint = 0;
         var _loc6_:BMMechStructure = null;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc9_:String = null;
         var _loc10_:MovieClip = null;
         if(param3 > 0)
         {
            _loc4_ = dataM.playersData[dataM.player1PlayerID];
            _loc5_ = screensM.screenHangerMech.getTargetMechID();
            _loc6_ = _loc4_.mechStructures[_loc5_];
            _loc7_ = dataM.getPlayerItemData(dataM.player1PlayerID,param3);
            _loc8_ = dataM.itemsDB[_loc7_.itemID];
            _loc9_ = param1;
            if(param2 > 0)
            {
               _loc9_ += param2;
            }
            _loc10_ = this[_loc9_ + "NotEnoughAmmo"];
            if(_loc8_.bullets > _loc6_.totalBullets)
            {
               _loc10_.gotoAndStop("notEnoughBullets");
               this._notEnoughAmmoItemIDs.push(_loc8_.itemID);
               this._notEnoughAmmoItems_new[_loc9_] = _loc9_;
            }
            else if(_loc8_.rockets > _loc6_.totalRockets)
            {
               _loc10_.gotoAndStop("notEnoughRockets");
               this._notEnoughAmmoItemIDs.push(_loc8_.itemID);
               this._notEnoughAmmoItems_new[_loc9_] = _loc9_;
            }
         }
      }
      
      public function resetNotEnoughAmmoAlerts() : void
      {
         this._notEnoughAmmoItemIDs = new Array();
         this.sideWeapon1NotEnoughAmmo.gotoAndStop("empty");
         this.sideWeapon2NotEnoughAmmo.gotoAndStop("empty");
         this.sideWeapon3NotEnoughAmmo.gotoAndStop("empty");
         this.sideWeapon4NotEnoughAmmo.gotoAndStop("empty");
         this.topWeapon1NotEnoughAmmo.gotoAndStop("empty");
         this.topWeapon2NotEnoughAmmo.gotoAndStop("empty");
         this.droneNotEnoughAmmo.gotoAndStop("empty");
      }
      
      public function getNotEnoughAmmoItemIDs() : Array
      {
         return this._notEnoughAmmoItemIDs;
      }
      
      public function addItemStaticGlow(param1:String, param2:Number) : void
      {
         var _loc3_:String = param1;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         switch(param1)
         {
            case "leg":
               _loc4_ = true;
               break;
            case "sideWeapon":
            case "topWeapon":
               _loc3_ += param2;
               _loc5_ = true;
               break;
            case "module":
            case "shield":
            case "teleport":
            case "charge":
            case "harpoon":
            case "perk":
               break;
            default:
               _loc5_ = true;
         }
         if(_loc4_)
         {
            this.mechView.addItemStaticGlow("leg1","lightGreen");
            this.mechView.addItemStaticGlow("leg2","lightGreen");
         }
         else if(_loc5_)
         {
            this.mechView.addItemStaticGlow(_loc3_,"lightGreen");
         }
      }
      
      public function removeAllItemsStaticGlow() : void
      {
         this.mechView.removeAllItemsStaticGlow();
      }
      
      public function equipmentItemMouseDown(param1:Number, param2:Number) : void
      {
         var _loc3_:BMMechEquipmentItem = this.equipmentItems[param1];
         this._equipmentItemMouseDown(_loc3_.equipmentType,_loc3_.equipmentID,param2);
      }
      
      public function equipmentItemMouseUp(param1:Number, param2:Number) : void
      {
         var _loc3_:BMMechEquipmentItem = this.equipmentItems[param1];
         this._equipmentItemMouseUp(_loc3_.equipmentType,_loc3_.equipmentID,param2,false,"mechEquipment equipmentItemMouseUp");
      }
      
      public function equipmentItemMouseOver(param1:Number, param2:Number) : void
      {
         var _loc3_:BMMechEquipmentItem = this.equipmentItems[param1];
         this._equipmentItemMouseOver(_loc3_.equipmentType,_loc3_.equipmentID,param2);
      }
      
      public function equipmentItemMouseOut(param1:Number, param2:Number) : void
      {
         var _loc3_:BMMechEquipmentItem = this.equipmentItems[param1];
         this._equipmentItemMouseOut(_loc3_.equipmentType,_loc3_.equipmentID,param2);
      }
      
      private function mouseHitAreaMouseUp(param1:MouseEvent) : void
      {
         this.mouseHitAreaMouseUpSub();
      }
      
      public function mouseHitAreaMouseUpSub() : void
      {
         this._mouseUpOutsideEquipment();
      }
      
      private function mouseHitAreaMouseDown(param1:MouseEvent) : void
      {
         this.mouseHitAreaMouseDownSub();
      }
      
      public function mouseHitAreaMouseDownSub() : void
      {
         this._mouseDownOutsideEquipment();
      }
      
      private function mouseHitAreaMouseOver(param1:MouseEvent) : void
      {
      }
      
      private function mouseHitAreaMouseOut(param1:MouseEvent) : void
      {
         this._mouseOutOutsideEquipment();
      }
      
      public function hideAllItemsExceptType(param1:String) : void
      {
         var _loc2_:uint = 0;
         this.torso.hideMe();
         this.leg.hideMe();
         this.drone.hideMe();
         this.shield.hideMe();
         this.teleport.hideMe();
         this.charge.hideMe();
         this.harpoon.hideMe();
         this.perk.hideMe();
         switch(param1)
         {
            case "torso":
            case "leg":
            case "drone":
            case "shield":
            case "teleport":
            case "charge":
            case "harpoon":
            case "perk":
               this[param1].showMe();
         }
         if(param1 != "sideWeapon")
         {
            _loc2_ = 1;
            while(_loc2_ <= dataM.maxEquipment["sideWeapon"])
            {
               this["sideWeapon" + _loc2_].hideMe();
               this["sideWeapon" + _loc2_ + "NotEnoughAmmo"].gotoAndStop("empty");
               _loc2_++;
            }
         }
         if(param1 != "topWeapon")
         {
            _loc2_ = 1;
            while(_loc2_ <= dataM.maxEquipment["topWeapon"])
            {
               this["topWeapon" + _loc2_].hideMe();
               this["topWeapon" + _loc2_ + "NotEnoughAmmo"].gotoAndStop("empty");
               _loc2_++;
            }
         }
         if(param1 != "module")
         {
            _loc2_ = 1;
            while(_loc2_ <= dataM.maxEquipment["module"])
            {
               if(this.hasOwnProperty("module" + _loc2_))
               {
                  this["module" + _loc2_].hideMe();
               }
               _loc2_++;
            }
         }
         if(param1 != "drone")
         {
            this.droneNotEnoughAmmo.gotoAndStop("empty");
         }
      }
      
      public function showAllAvailableItems() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.torso.showMe();
         this.leg.showMe();
         if(_loc1_.level >= dataM.equipmentUnlockDB["drone"].level)
         {
            this.drone.showMe();
         }
         if(_loc1_.level >= dataM.equipmentUnlockDB["shield"].level)
         {
            this.shield.showMe();
         }
         if(_loc1_.level >= dataM.equipmentUnlockDB["teleport"].level)
         {
            this.teleport.showMe();
         }
         if(_loc1_.level >= dataM.equipmentUnlockDB["charge"].level)
         {
            this.charge.showMe();
         }
         if(_loc1_.level >= dataM.equipmentUnlockDB["harpoon"].level)
         {
            this.harpoon.showMe();
         }
         _loc2_ = 1;
         while(_loc2_ <= dataM.maxEquipment["sideWeapon"])
         {
            if(_loc1_.level >= dataM.equipmentUnlockDB["sideWeapon" + _loc2_].level)
            {
               this["sideWeapon" + _loc2_].showMe();
            }
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= dataM.maxEquipment["topWeapon"])
         {
            if(_loc1_.level >= dataM.equipmentUnlockDB["topWeapon" + _loc2_].level)
            {
               this["topWeapon" + _loc2_].showMe();
            }
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ <= dataM.maxEquipment["module"])
         {
            if(_loc1_.level >= dataM.equipmentUnlockDB["module" + _loc2_].level && this.hasOwnProperty("module" + _loc2_))
            {
               this["module" + _loc2_].showMe();
            }
            _loc2_++;
         }
         if(_loc1_.hasPerks)
         {
            this.perk.showMe();
         }
         this.refreshNotEnoughAmmoAlerts();
      }
      
      public function showEquipmentMarkers(param1:String, param2:uint, param3:Boolean) : void
      {
         var _loc8_:Sprite = null;
         var _loc9_:String = null;
         var _loc11_:uint = 0;
         var _loc12_:Boolean = false;
         var _loc13_:uint = 0;
         this.removeEquipmentMarkers();
         var _loc4_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc5_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc6_:uint = screensM.screenHangerMech.getTargetMechID();
         var _loc7_:BMMechStructure = _loc5_.mechStructures[_loc6_];
         var _loc10_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,_loc7_.torso);
         switch(param1)
         {
            case "sideWeapon":
            case "topWeapon":
            case "module":
               if(param3)
               {
                  _loc13_ = 1;
                  while(_loc13_ <= dataM.maxEquipment[param1])
                  {
                     _loc11_ = dataM.getEquipmentUnlockByLevel(_loc4_.level,param1);
                     if(_loc13_ <= _loc11_)
                     {
                        _loc9_ = param1 + _loc13_;
                        _loc8_ = this["marker_" + _loc9_];
                        if(_loc8_.parent == null)
                        {
                           addChild(_loc8_);
                        }
                     }
                     _loc13_++;
                  }
               }
               else
               {
                  _loc11_ = dataM.getEquipmentUnlockByLevel(_loc4_.level,param1);
                  if(_loc13_ <= _loc11_)
                  {
                     _loc9_ = param1 + param2;
                     _loc8_ = this["marker_" + _loc9_];
                     if(_loc8_.parent == null)
                     {
                        addChild(_loc8_);
                     }
                  }
               }
               break;
            case "leg":
               _loc8_ = this["marker_" + param1];
               if(_loc8_.parent == null)
               {
                  addChild(_loc8_);
               }
               break;
            case "drone":
            case "shield":
            case "charge":
            case "teleport":
            case "harpoon":
               _loc12_ = true;
               if(_loc4_.level < dataM.equipmentUnlockDB[param1].level)
               {
                  _loc12_ = false;
               }
               if(_loc12_)
               {
                  _loc8_ = this["marker_" + param1];
                  _loc8_.x = this[param1].x;
                  _loc8_.y = this[param1].y;
                  if(_loc8_.parent == null)
                  {
                     addChild(_loc8_);
                  }
               }
               break;
            case "perk":
               _loc8_ = this["marker_" + param1];
               if(_loc8_.parent == null)
               {
                  addChild(_loc8_);
               }
         }
         if(param1 == "torso")
         {
            _loc8_ = this["marker_" + param1];
            if(_loc8_.parent == null)
            {
               addChild(_loc8_);
            }
         }
      }
      
      public function removeEquipmentMarkers() : void
      {
         var _loc1_:uint = 0;
         this.removeMarker(this.marker_torso);
         this.removeMarker(this.marker_leg);
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["sideWeapon"])
         {
            this.removeMarker(this["marker_sideWeapon" + _loc1_]);
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["topWeapon"])
         {
            this.removeMarker(this["marker_topWeapon" + _loc1_]);
            _loc1_++;
         }
         this.removeMarker(this.marker_drone);
         this.removeMarker(this.marker_shield);
         this.removeMarker(this.marker_teleport);
         this.removeMarker(this.marker_charge);
         this.removeMarker(this.marker_harpoon);
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["module"])
         {
            if(this.hasOwnProperty("marker_module" + _loc1_))
            {
               this.removeMarker(this["marker_module" + _loc1_]);
            }
            _loc1_++;
         }
         this.removeMarker(this.marker_perk);
      }
      
      private function removeMarker(param1:Sprite) : void
      {
         if(param1.parent != null)
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public function addAllListenersForItems() : void
      {
         var _loc2_:BMMechEquipmentItem = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.equipmentItems.length)
         {
            _loc2_ = this.equipmentItems[_loc1_];
            _loc2_.tileListItem.addAllListeners();
            _loc1_++;
         }
      }
      
      public function removeAllListenersForItems() : void
      {
         var _loc2_:BMMechEquipmentItem = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.equipmentItems.length)
         {
            _loc2_ = this.equipmentItems[_loc1_];
            _loc2_.tileListItem.removeAllListeners();
            _loc1_++;
         }
      }
      
      public function disableItems(param1:Array) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:BMMechEquipmentItem = null;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this.equipmentItems.length)
            {
               _loc4_ = this.equipmentItems[_loc3_];
               if(_loc4_.equipmentType == param1[_loc2_].type && _loc4_.equipmentID == param1[_loc2_].ID)
               {
                  _loc4_.tileListItem.disableMe(true);
                  _loc3_ = this.equipmentItems.length;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function enableItems(param1:Array) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:BMMechEquipmentItem = null;
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = 0;
            while(_loc3_ < this.equipmentItems.length)
            {
               _loc4_ = this.equipmentItems[_loc3_];
               if(_loc4_.equipmentType == param1[_loc2_].type && _loc4_.equipmentID == param1[_loc2_].ID)
               {
                  _loc4_.tileListItem.enableMe();
                  _loc3_ = this.equipmentItems.length;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function addDisabledEffectForSpecificItem(param1:String, param2:Number) : void
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case "sideWeapon":
            case "topWeapon":
            case "module":
               _loc3_ = param1 + param2;
               break;
            default:
               _loc3_ = param1;
         }
         var _loc4_:BMTileListItem = this[_loc3_];
         _loc4_.addDisabledEffect();
      }
   }
}

