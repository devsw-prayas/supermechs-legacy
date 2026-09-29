package net.battleMechsMulti.mobiles
{
   import fl.motion.Color;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BevelFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class BMMechView extends BMBaseClass
   {
      
      private var _playerID:uint;
      
      private var _viewType:String;
      
      private var _closestSlot:Number;
      
      private var _lastMechStructure:BMMechStructure;
      
      private var _mechStructure:BMMechStructure;
      
      private var _itemHolders:Array;
      
      private var _itemHoldersNames:Array;
      
      private var _itemHoldersReversByNames:Object;
      
      private var _centerMech:Boolean;
      
      private var _steps:Number;
      
      private var _legsType:String;
      
      private var _structureType:String;
      
      private var _itemsOriginPoints:Object;
      
      private var _shutdownAddons:Object;
      
      private var _bumpParametersSet:Boolean;
      
      private var _bumpFrameCounter:Number;
      
      private var _bumpItems:Array;
      
      private var _bumpHeight:Number;
      
      private var _bumpFrames:Number;
      
      private var _bumpMultiplier:Number;
      
      private var _bumpResumBreathing:Boolean;
      
      private var _getHitFrameCounter:Number;
      
      private var _getHitItems:Array;
      
      private var _getHitDistance:Number;
      
      private var _getHitFrames:Number;
      
      private var _getHitMultiplier:Number;
      
      private var _getHitXAxisFront:Boolean;
      
      private var _getHitXAxisBack:Boolean;
      
      private var _getHitYAxis:Boolean;
      
      private var _getPushedFrameCounter:Number;
      
      private var _getPushedFrames:Number;
      
      private var _getPushedFromBack:Boolean;
      
      private var _legXDistance:Number;
      
      private var _legXPerFrame:Number;
      
      private var _legYPerFrame:Number;
      
      private var _walkingDirtFunction:Function;
      
      private var _leg2MotionStatus:String;
      
      private var _leg1MotionStatus:String;
      
      private var _shieldActive:Boolean;
      
      private var _shieldGlowStrength:Number;
      
      private var _shieldGlowFilter1:GlowFilter;
      
      private var _shieldGlowFilter2:GlowFilter;
      
      private var _innerGlowFilter:GlowFilter;
      
      private var _innerGlowFilterRemoveMe:Boolean;
      
      private var _innerGlowFilterRemoveMeCounter:Number;
      
      private var _animatedGlowStrength:Number;
      
      private var _animatedGlowModifier:Number;
      
      private var _bevelFilter:BevelFilter;
      
      private var _chargeEngineFireStartedFunction:Function;
      
      private var _chargeEngineFireEndedFunction:Function;
      
      private var _walkingEndedReturnFunction:Function;
      
      private var _walkingUseSound:Boolean;
      
      private var _weaponsOriginXYPos:Object;
      
      private var _weaponsFeedbackData:Object;
      
      private var _limpEffect:Boolean = false;
      
      private var _walkingForwardHandler:Boolean = false;
      
      private var _walkingBackwardsHandler:Boolean = false;
      
      private var _wheelsAnimationHandler:Boolean = false;
      
      private var _bumpAnimationHandler:Boolean = false;
      
      private var _getHitAnimationHandler:Boolean = false;
      
      private var _getPushedAnimationHandler:Boolean = false;
      
      private var _shieldAnimationHandler:Boolean = false;
      
      private var _animatedGlowHandler:Boolean = false;
      
      private var _weaponFeedbackHandler:Boolean = false;
      
      private var _machineGunBarrelHandler:Boolean = false;
      
      private var _crouchBeforeJumpHandler:Boolean = false;
      
      private var _refreshFiltersHandler:Boolean = false;
      
      private var _breathingHandler:Boolean = false;
      
      private var _swordHandler:Boolean = false;
      
      private var _wandHandler:Boolean = false;
      
      private var _stompHandler:Boolean = false;
      
      private var _harpoonHandler:Boolean = false;
      
      private var _grenadeLauncherHandler:Boolean = false;
      
      private var _grenadeLauncherItemName:String;
      
      private var _grenadeLauncherAngle:Number;
      
      private var _stompReturnFunction:Function;
      
      private var _shieldType:String;
      
      private var _shieldAngle:Number;
      
      private var _shieldRadius:Number;
      
      private var _shieldSpeed:Number;
      
      private var _shieldLastXPos:Number;
      
      private var _shieldEffectStatingXPos:uint = 120;
      
      private var _machineGunBarrelItemName:String;
      
      private var _machineGunBarrelCountdown:Number;
      
      private var _harpoonType:String;
      
      private var _harpoonFlyDistance:Number;
      
      private var _harpoonPullDistance:Number;
      
      private var _harpoonPullDirection:String;
      
      private var _harpoonOpponentMechBattleData:BMMechBattleData;
      
      private var _harpoonReachedTargetFunction:Function;
      
      private var _harpoonAnimationEndedFunction:Function;
      
      private var _harpoonStatus:String;
      
      private var _harpoonCounter:Number;
      
      private var _harpoonRopeXStart:Number;
      
      private var _harpoonEdgeXStart:Number;
      
      private var _swordReturnFunction:Function;
      
      private var _swordEquipmentID:Number;
      
      private var _wandReturnFunction:Function;
      
      private var _wandEquipmentID:Number;
      
      private var _tease1Handler:Boolean = false;
      
      private var _tease2Handler:Boolean = false;
      
      private var _tease3Handler:Boolean = false;
      
      private var _tease4Handler:Boolean = false;
      
      private var _tease5Handler:Boolean = false;
      
      private var _tease6Handler:Boolean = false;
      
      private var _tease7Handler:Boolean = false;
      
      private var _tease8Handler:Boolean = false;
      
      private var _tease9Handler:Boolean = false;
      
      private var _tease10Handler:Boolean = false;
      
      private var _tease11Handler:Boolean = false;
      
      private var _tease12Handler:Boolean = false;
      
      private var _entry1Handler:Boolean = false;
      
      private var _entry2Handler:Boolean = false;
      
      private var _entry3Handler:Boolean = false;
      
      private var _entry4Handler:Boolean = false;
      
      private var _entry5Handler:Boolean = false;
      
      private var _entry1Sound:Boolean;
      
      private var _entry2Sound:Boolean;
      
      private var _exit1Handler:Boolean = false;
      
      private var _defeatedHandler:Boolean = false;
      
      private var _overheatHandler:Boolean = false;
      
      private var _finish1Handler:Boolean = false;
      
      private var _finish7Handler:Boolean = false;
      
      private var _entryActive:Boolean = false;
      
      private var _wheelsAnimationCounter:Number;
      
      private var _breathingCounter:Number;
      
      private var _breathingPaused:Boolean;
      
      private var _breathingLegOriginalHeight:Number;
      
      private var _shutDownHandler:Boolean = false;
      
      private var _shutDownCounter:Number;
      
      private var _shutDownStatus:String = "";
      
      private var _shutDownReturnFunction:Function = null;
      
      private var _crouchBeforeJumpReturnFunction:Function;
      
      private var _crouchBeforeJumpCounter:Number;
      
      private var _swordCounter:Number;
      
      private var _swordResumeBreathing:Boolean;
      
      private var _wandCounter:Number;
      
      private var _wandResumeBreathing:Boolean;
      
      private var _stompCounter:Number;
      
      private var _tease1Counter:Number;
      
      private var _tease2Counter:Number;
      
      private var _tease3Counter:Number;
      
      private var _tease4Counter:Number;
      
      private var _tease5Counter:Number;
      
      private var _tease6Counter:Number;
      
      private var _tease7Counter:Number;
      
      private var _tease8Counter:Number;
      
      private var _tease9Counter:Number;
      
      private var _tease10Counter:Number;
      
      private var _tease11Counter:Number;
      
      private var _tease12Counter:Number;
      
      private var _entry1Counter:Number;
      
      private var _entry2Counter:Number;
      
      private var _entry3Counter:Number;
      
      private var _entry4Counter:Number;
      
      private var _entry5Counter:Number;
      
      private var _exit1Counter:Number;
      
      private var _defeatedCounter:Number;
      
      private var _overheatCounter:Number;
      
      private var _finish1Counter:Number;
      
      private var _finish7Counter:Number;
      
      private var _tease9Jumps:Number;
      
      private var _tease9Sound:Boolean;
      
      private var _overheatFrames:Number;
      
      private var _finish1MechTargetXPos:Number;
      
      private var _finish7XDistance:Number;
      
      private var _finishReturnFunction:Function;
      
      private var _entry2WeaponCounter:Number;
      
      private var _entry2ActiveWeapons:Array;
      
      private var _entry4Items:Array;
      
      private var _entry4CurrentItemSlot:Number;
      
      private var _teaseEntryEndedFunction:Function;
      
      private var _manualColors:Object;
      
      private var _torsoColorID:Number;
      
      private var _activeAnimations:Array = new Array();
      
      private var _itemStaticGlowLock:String = "";
      
      private var _equipItemsData:Array = new Array();
      
      private var _unequipItemsData:Array = new Array();
      
      private var _itemsToBuild:Array;
      
      private var _itemsToBuildSlot:Number;
      
      private var _mechEnabled:Boolean = false;
      
      private var _lastSlowCPUMode:Boolean = false;
      
      private var _breathingAnimationData:Object = new Object();
      
      private var _stompAnimationData:Object = new Object();
      
      private var _shieldEffectForMobile:MovieClip;
      
      public var shutDownActive:Boolean = true;
      
      public var shieldEffectBackHolder:Sprite;
      
      public var itemsHolder:Sprite;
      
      public var centerPosition:Sprite;
      
      public var mechSizer:Sprite;
      
      public var torso:MovieClip;
      
      public var leg2:MovieClip;
      
      public var leg1:MovieClip;
      
      public var sideWeapon1:MovieClip;
      
      public var sideWeapon2:MovieClip;
      
      public var sideWeapon3:MovieClip;
      
      public var sideWeapon4:MovieClip;
      
      public var topWeapon1:MovieClip;
      
      public var topWeapon2:MovieClip;
      
      public var drone:MovieClip;
      
      public var harpoon:MovieClip;
      
      public var leg2Shadow:MovieClip;
      
      public var leg1Shadow:MovieClip;
      
      public var legsShadowHolder:MovieClip;
      
      private var unequip_torso:MovieClip;
      
      private var unequip_leg2:MovieClip;
      
      private var unequip_leg1:MovieClip;
      
      private var unequip_sideWeapon1:MovieClip;
      
      private var unequip_sideWeapon2:MovieClip;
      
      private var unequip_sideWeapon3:MovieClip;
      
      private var unequip_sideWeapon4:MovieClip;
      
      private var unequip_topWeapon1:MovieClip;
      
      private var unequip_topWeapon2:MovieClip;
      
      public var chargeEngineHolder:MovieClip;
      
      public var chargeEngine:MovieClip;
      
      public var sizeRatio:Number;
      
      public var useLegsShadow:Boolean = false;
      
      public var forceRebuildingTorso:Boolean = false;
      
      private var _equipAnimations:Boolean = false;
      
      private var _dynamicBuilding:Boolean = false;
      
      private var _lastGeneralSpeedRatio:Number = 1;
      
      private var _canBreath:Boolean = true;
      
      private var _chargeActive:Boolean = false;
      
      private var _chargeFrameCounter:uint;
      
      private const INNER_GLOW_STRENGTH_MIN:Number = 0.3;
      
      private const INNER_GLOW_STRENGTH_MAX:Number = 0.6;
      
      private const INNER_GLOW_STRENGTH_CHANGE:Number = 0.005;
      
      private const SHIELD_GLOW_STRENGTH_MAX:Number = 3;
      
      private const SHIELD_GLOW_STRENGTH_CHANGE:Number = 0.6;
      
      private const BREATHING_FRAMES:Number = 80;
      
      private const BREATHING_MOTION:Number = 10;
      
      private const HARPOON_X_SCALE_MIN:Number = 0.2;
      
      private const HARPOON_X_SCALE_CHANGE:Number = 0.1;
      
      private const HARPOON_FLYING_SPEED:Number = 60;
      
      private const HARPOON_PULLING_SPEED:Number = 50;
      
      private const HARPOON_REACHED_TARGET_WAITING_FRAMES_REGULAR:Number = 10;
      
      private const HARPOON_REACHED_TARGET_WAITING_FRAMES_FINISH:Number = 55;
      
      private const WEAPONS_X_SCALE_MIN:Number = 0.2;
      
      private const WEAPONS_X_SCALE_CHANGE:Number = 0.1;
      
      private const GET_PUSHED_DISTANCE_TORSO:Number = 30;
      
      private const GET_PUSHED_DISTANCE_ITEMS:Number = 10;
      
      private const SHIELD_SPEED_CHANGE_MOBILE:Number = 0.2;
      
      private const SHIELD_SCALE_CHANGE_MOBILE:Number = 0.015;
      
      private const SHIELD_X_PUSH_MOBILE:uint = 15;
      
      public function BMMechView()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:String, param3:String, param4:Number, param5:Boolean) : *
      {
         var _loc8_:MovieClip = null;
         generateSingletonClassesPointers("");
         this._playerID = param1;
         this._viewType = param2;
         this._structureType = param3;
         this.sizeRatio = param4;
         this._equipAnimations = param5;
         this.chargeEngineHolder = new MovieClip();
         addChild(this.chargeEngineHolder);
         if(this.useLegsShadow)
         {
            this.legsShadowHolder = new MovieClip();
            addChild(this.legsShadowHolder);
            _loc8_ = new MovieClip();
            this.legsShadowHolder.legsShadowMask = _loc8_;
            this.legsShadowHolder.addChild(_loc8_);
         }
         if(dataM.runAsMobile)
         {
            this.shieldEffectBackHolder = new Sprite();
            addChild(this.shieldEffectBackHolder);
         }
         this.itemsHolder = new Sprite();
         addChild(this.itemsHolder);
         this.mechSizer = new Sprite();
         addChild(this.mechSizer);
         this._itemHolders = new Array();
         this._itemHoldersNames = new Array();
         this._itemHoldersReversByNames = new Object();
         this._bumpItems = new Array();
         this._getHitItems = new Array();
         this._centerMech = false;
         this._shieldGlowStrength = 0;
         this._shieldActive = false;
         this._bumpHeight = 0;
         this._itemsOriginPoints = new Object();
         this._shutdownAddons = new Object();
         this._shutdownAddons["torso"] = {
            "xAddon":0,
            "yAddon":10
         };
         this._shutdownAddons["leg1"] = {
            "xAddon":-10,
            "yAddon":0
         };
         this._shutdownAddons["leg2"] = {
            "xAddon":10,
            "yAddon":0
         };
         this._shutdownAddons["sideWeapon1"] = {
            "xAddon":0,
            "yAddon":10
         };
         this._shutdownAddons["sideWeapon2"] = {
            "xAddon":0,
            "yAddon":10
         };
         this._shutdownAddons["sideWeapon3"] = {
            "xAddon":0,
            "yAddon":10
         };
         this._shutdownAddons["sideWeapon4"] = {
            "xAddon":0,
            "yAddon":10
         };
         this._shutdownAddons["topWeapon1"] = {
            "xAddon":0,
            "yAddon":10
         };
         this._shutdownAddons["topWeapon2"] = {
            "xAddon":0,
            "yAddon":10
         };
         this._animatedGlowStrength = this.INNER_GLOW_STRENGTH_MIN;
         this._animatedGlowModifier = this.INNER_GLOW_STRENGTH_CHANGE;
         this._weaponsOriginXYPos = new Object();
         this._weaponsFeedbackData = new Object();
         this.addUnequipItemHolder("sideWeapon2");
         this.addItemHolder("sideWeapon2");
         this.addUnequipItemHolder("sideWeapon4");
         this.addItemHolder("sideWeapon4");
         this.addUnequipItemHolder("topWeapon2");
         this.addItemHolder("topWeapon2");
         this.addItemHolder("harpoon");
         this.addUnequipItemHolder("leg2");
         this.addItemHolder("leg2");
         this.addItemHolder("drone");
         this.addUnequipItemHolder("torso");
         this.addItemHolder("torso");
         this.addUnequipItemHolder("topWeapon1");
         this.addItemHolder("topWeapon1");
         this.addUnequipItemHolder("leg1");
         this.addItemHolder("leg1");
         this.addUnequipItemHolder("sideWeapon1");
         this.addItemHolder("sideWeapon1");
         this.addUnequipItemHolder("sideWeapon3");
         this.addItemHolder("sideWeapon3");
         var _loc6_:Color = new Color();
         _loc6_.setTint(0,0.2);
         var _loc7_:String = GlobalAccess.stage.quality;
         if(dataM.runAsMobile)
         {
         }
         this.leg2.transform.colorTransform = _loc6_;
         this.sideWeapon2.transform.colorTransform = _loc6_;
         this.sideWeapon4.transform.colorTransform = _loc6_;
         this.topWeapon2.transform.colorTransform = _loc6_;
         this._bumpParametersSet = false;
         switch(this._playerID)
         {
            case dataM.OFFLINE_OPPONENT_ID:
            case dataM.ONLINE_OPPONENT_ID:
               switch(dataM.battleSubType)
               {
                  case "turret":
                     this._canBreath = false;
               }
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._mechEnabled)
         {
            this.walkingForwardHandler();
            this.walkingBackwardsHandler();
            this.wheelsAnimationHandler();
            this.bumpAnimationHandler();
            this.getHitAnimationHandler();
            this.getPushedAnimationHandler();
            this.shieldHandlerHandler();
            this.animatedGlowHandler();
            this.weaponsFeedbackHandler();
            this.machineGunBarrelHandler();
            this.shutDownHandlerHandler();
            this.crouchBeforeJumpHandler();
            this.refreshFiltersHandler();
            this.breathingHandler();
            this.swordHandler();
            this.wandHandler();
            this.stompHandler();
            this.harpoonHandler();
            this.chargeHandler();
            this.grenadeLauncherHandler();
            this.tease1Handler();
            this.tease2Handler();
            this.tease3Handler();
            this.tease4Handler();
            this.tease5Handler();
            this.tease6Handler();
            this.tease7Handler();
            this.tease8Handler();
            this.tease9Handler();
            this.tease10Handler();
            this.tease11Handler();
            this.tease12Handler();
            this.entry1Handler();
            this.entry2Handler();
            this.entry3Handler();
            this.entry4Handler();
            this.exit1Handler();
            this.defeatedHandler();
            this.overheatHandler();
            this.finish1Handler();
            this.finish7Handler();
            this.equipAnimationHandler();
            this.unequipAnimationHandler();
         }
      }
      
      private function addItemHolder(param1:String) : void
      {
         this[param1] = new MovieClip();
         this[param1].item = null;
         this.itemsHolder.addChild(this[param1]);
         this._itemHolders.push(this[param1]);
         this._itemHoldersNames.push(param1);
         this._itemHoldersReversByNames[param1] = this._itemHolders.length - 1;
         switch(param1)
         {
            case "leg1":
            case "leg2":
            case "drone":
            case "harpoon":
               break;
            default:
               this._bumpItems.push(param1);
               this._getHitItems.push(param1);
         }
      }
      
      private function addUnequipItemHolder(param1:String) : void
      {
         if(this._equipAnimations)
         {
            this["unequip_" + param1] = new MovieClip();
            this.itemsHolder.addChild(this["unequip_" + param1]);
         }
      }
      
      public function getItemsHolder() : Array
      {
         return this._itemHolders;
      }
      
      public function getItemsHoldersNames() : Array
      {
         return this._itemHoldersNames;
      }
      
      public function setManualColors(param1:Object) : void
      {
         this._manualColors = param1;
      }
      
      public function rebuildMechStructure() : void
      {
         if(this._mechStructure != null)
         {
            this.buildMech(this._mechStructure,"rebuildMechStructure");
         }
         else
         {
            TsLogger.log("error mechView : rebuildMechStructure : _mechStructure is nulled");
         }
      }
      
      public function buildMech(param1:BMMechStructure, param2:String) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:BMItemData = null;
         var _loc5_:BMPlayerItemData = null;
         if(this._mechStructure != null)
         {
            this._lastMechStructure = new BMMechStructure();
            this._lastMechStructure.torso = this._mechStructure.torso;
            this._lastMechStructure.leg = this._mechStructure.leg;
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["sideWeapon"])
            {
               this._lastMechStructure["sideWeapon" + _loc3_] = this._mechStructure["sideWeapon" + _loc3_];
               _loc3_++;
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["topWeapon"])
            {
               this._lastMechStructure["topWeapon" + _loc3_] = this._mechStructure["topWeapon" + _loc3_];
               _loc3_++;
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["kit"])
            {
               this._lastMechStructure["kit" + _loc3_] = this._mechStructure["kit" + _loc3_];
               _loc3_++;
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["module"])
            {
               this._lastMechStructure["module" + _loc3_] = this._mechStructure["module" + _loc3_];
               _loc3_++;
            }
         }
         this._mechStructure = new BMMechStructure();
         this._mechStructure.initialize(param1.playerID,0);
         this._mechStructure.torso = param1.torso;
         this._mechStructure.torso_colorID = param1.torso_colorID;
         this._mechStructure.leg = param1.leg;
         this._mechStructure.leg_colorID = param1.leg_colorID;
         _loc3_ = 1;
         while(_loc3_ <= dataM.maxEquipment["sideWeapon"])
         {
            this._mechStructure["sideWeapon" + _loc3_] = param1["sideWeapon" + _loc3_];
            this._mechStructure["sideWeapon" + _loc3_ + "_colorID"] = param1["sideWeapon" + _loc3_ + "_colorID"];
            _loc3_++;
         }
         _loc3_ = 1;
         while(_loc3_ <= dataM.maxEquipment["topWeapon"])
         {
            this._mechStructure["topWeapon" + _loc3_] = param1["topWeapon" + _loc3_];
            this._mechStructure["topWeapon" + _loc3_ + "_colorID"] = param1["topWeapon" + _loc3_ + "_colorID"];
            _loc3_++;
         }
         this._mechStructure.drone = param1.drone;
         this._mechStructure.shield = param1.shield;
         this._mechStructure.teleport = param1.teleport;
         this._mechStructure.charge = param1.charge;
         this._mechStructure.harpoon = param1.harpoon;
         _loc3_ = 1;
         while(_loc3_ <= dataM.maxEquipment["kit"])
         {
            this._mechStructure["kit" + _loc3_] = param1["kit" + _loc3_];
            _loc3_++;
         }
         _loc3_ = 1;
         while(_loc3_ <= dataM.maxEquipment["module"])
         {
            this._mechStructure["module" + _loc3_] = param1["module" + _loc3_];
            _loc3_++;
         }
         this._mechStructure.perk = param1.perk;
         if(this._mechStructure.torso == 0)
         {
            this._mechStructure.resetStructure();
         }
         if(this._playerID == 0)
         {
            this._mechStructure.torso_colorID = 0;
            this._mechStructure.leg_colorID = 0;
            this._mechStructure.sideWeapon1_colorID = 0;
            this._mechStructure.sideWeapon2_colorID = 0;
            this._mechStructure.sideWeapon3_colorID = 0;
            this._mechStructure.sideWeapon4_colorID = 0;
            this._mechStructure.topWeapon1_colorID = 0;
            this._mechStructure.topWeapon2_colorID = 0;
         }
         this._legsType = "legs";
         if(this._mechStructure.leg > 0)
         {
            switch(this._structureType)
            {
               case "itemID":
                  _loc4_ = dataM.itemsDB[this._mechStructure.leg];
                  break;
               case "playerItemID":
                  _loc5_ = dataM.getPlayerItemData(this._playerID,this._mechStructure.leg);
                  _loc4_ = dataM.itemsDB[_loc5_.itemID];
            }
            this._legsType = _loc4_.subType;
         }
         this._torsoColorID = 0;
         this._itemsToBuild = new Array();
         this._itemsToBuild.push({
            "equipmentType":"torso",
            "equipmentID":0
         });
         this._itemsToBuild.push({
            "equipmentType":"leg",
            "equipmentID":0
         });
         this._itemsToBuild.push({
            "equipmentType":"sideWeapon",
            "equipmentID":1
         });
         this._itemsToBuild.push({
            "equipmentType":"sideWeapon",
            "equipmentID":2
         });
         this._itemsToBuild.push({
            "equipmentType":"sideWeapon",
            "equipmentID":3
         });
         this._itemsToBuild.push({
            "equipmentType":"sideWeapon",
            "equipmentID":4
         });
         this._itemsToBuild.push({
            "equipmentType":"topWeapon",
            "equipmentID":1
         });
         this._itemsToBuild.push({
            "equipmentType":"topWeapon",
            "equipmentID":2
         });
         this._itemsToBuildSlot = 0;
         this.buildNextItem();
      }
      
      private function buildMechLastFunctions() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Number = NaN;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc6_:Sprite = null;
         if(this._viewType == "battle")
         {
            _loc1_ = externalAssetsM.getAsset("items1","harpoon");
            _loc2_ = 0;
            if(this._structureType == "playerItemID")
            {
               if(this._playerID < 100)
               {
                  if(this._mechStructure.harpoon > 0)
                  {
                     _loc3_ = dataM.getPlayerItemData(this._playerID,this._mechStructure.harpoon);
                     _loc2_ = _loc3_.colorID;
                  }
               }
            }
            if(_loc2_ == 0)
            {
               _loc2_ = this._torsoColorID;
            }
            dataM.colorMovieClip(_loc1_.mcColor,_loc2_);
            _loc1_.harpoonEdge.mcClosed.visible = true;
            _loc1_.harpoonEdge.mcOpened.visible = false;
            this._harpoonRopeXStart = _loc1_.harpoonRope.x;
            this._harpoonEdgeXStart = _loc1_.harpoonEdge.x;
            this.harpoon.addChild(_loc1_);
            this.harpoon.harpoonMC = _loc1_;
            if(this.torso.item.itemGrp.mcSide2 != null)
            {
               _loc4_ = false;
               if(dataM.playingVSComputer && this._playerID == dataM.player1PlayerID)
               {
                  if(dataM.battleType == "mission")
                  {
                     switch(dataM.battleSubType)
                     {
                        case "jeep":
                        case "tank":
                           if(this.torso.item.itemGrp.mcSide4 != null)
                           {
                              if(this.torso.item.itemGrp.mcSide2.y < this.torso.item.itemGrp.mcSide4.y)
                              {
                                 _loc4_ = true;
                              }
                           }
                     }
                  }
               }
               this.harpoon.x = this.torso.x + (this.torso.item.itemGrp.mcSide2.x - this.torso.item.itemGrp.mcCenter.x) * this.sizeRatio - 10;
               if(_loc4_)
               {
                  this.harpoon.y = this.torso.y + (this.torso.item.itemGrp.mcSide4.y - this.torso.item.itemGrp.mcCenter.y) * this.sizeRatio;
               }
               else
               {
                  this.harpoon.y = this.torso.y + (this.torso.item.itemGrp.mcSide2.y - this.torso.item.itemGrp.mcCenter.y) * this.sizeRatio;
               }
            }
            else
            {
               this.harpoon.x = this.torso.x + (this.torso.item.itemGrp.mcChargeEngine.x - this.torso.item.itemGrp.mcCenter.x) * this.sizeRatio;
               this.harpoon.y = this.torso.y + (this.torso.item.itemGrp.mcChargeEngine.y - this.torso.item.itemGrp.mcCenter.y) * this.sizeRatio;
            }
            this.harpoon.scaleX = this.HARPOON_X_SCALE_MIN;
            this.harpoon.visible = false;
         }
         this.deactivateShutdown(null);
         this.refreshMechSizer();
         if(this.useLegsShadow)
         {
            this.legsShadowHolder.legsShadowMask.addChild(this.leg1Shadow);
            this.legsShadowHolder.legsShadowMask.addChild(this.leg2Shadow);
            this.leg1Shadow.x = this.leg1.x - this.leg1.item.itemGrp.mcTorso.x * this.sizeRatio + 6;
            this.leg2Shadow.x = this.leg2.x - this.leg2.item.itemGrp.mcTorso.x * this.sizeRatio + 6;
            _loc5_ = this.leg1Shadow.height * 0.6;
            this.leg1Shadow.height += _loc5_;
            this.leg1Shadow.y += _loc5_;
            this.leg2Shadow.height += _loc5_;
            this.leg2Shadow.y += _loc5_;
            this.leg1Shadow.y = this.leg1.y + this.leg1Shadow.height + this.leg1.height - this.leg1.item.itemGrp.mcTorso.y * this.sizeRatio - 10;
            this.leg2Shadow.y = this.leg2.y + this.leg2Shadow.height + this.leg2.height - this.leg2.item.itemGrp.mcTorso.y * this.sizeRatio - 10;
            this.leg1Shadow.scaleY *= -1;
            this.leg2Shadow.scaleY *= -1;
            this._itemsOriginPoints["leg1Shadow"] = new Point(this.leg1Shadow.x,this.leg1Shadow.y);
            this._itemsOriginPoints["leg2Shadow"] = new Point(this.leg2Shadow.x,this.leg2Shadow.y);
            _loc6_ = new mcMechShadow();
            _loc6_.width = this.mechSizer.width + 60;
            _loc6_.height = this.leg1Shadow.height * 0.9;
            _loc6_.x = this.mechSizer.x - 30;
            _loc6_.y = this.leg1Shadow.y - this.leg1Shadow.height;
            _loc6_.mask = this.legsShadowHolder.legsShadowMask;
            this.legsShadowHolder.addChild(_loc6_);
         }
         if(this._centerMech)
         {
            this.centerMechSub();
         }
         if(this._mechStructure.torso > 0 && this._mechStructure.leg == 0)
         {
            if(this.torso.item.itemGrp.mcShutdown != null)
            {
               this.torso.item.itemGrp.mcShutdown.alpha = 1;
            }
         }
         this._weaponFeedbackHandler = true;
         this._mechEnabled = true;
      }
      
      private function buildItem(param1:String, param2:Number) : void
      {
         var _loc5_:BMItemData = null;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:MovieClip = null;
         var _loc12_:Boolean = false;
         var _loc13_:BMItem = null;
         var _loc14_:BMItem = null;
         var _loc15_:BMItem = null;
         var _loc16_:Boolean = false;
         var _loc17_:Number = NaN;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:MovieClip = null;
         var _loc21_:MovieClip = null;
         var _loc22_:BMItem = null;
         var _loc23_:Number = NaN;
         var _loc24_:String = null;
         var _loc25_:Sprite = null;
         var _loc3_:String = param1;
         if(param2 > 0)
         {
            _loc3_ = param1 + param2;
         }
         var _loc4_:Number = Number(this._mechStructure[_loc3_]);
         if(_loc4_ > 0)
         {
            switch(this._structureType)
            {
               case "itemID":
                  _loc5_ = dataM.itemsDB[_loc4_];
                  break;
               case "playerItemID":
                  _loc6_ = dataM.getPlayerItemData(this._playerID,_loc4_);
                  _loc5_ = dataM.itemsDB[_loc6_.itemID];
            }
            _loc9_ = _loc5_.grp;
            _loc10_ = "";
            if(_loc5_ == null)
            {
               TsLogger.log("WARNING !!! itemID " + _loc4_ + " cannot be found in the items database");
            }
            if(_loc3_ == "torso")
            {
               if(this._mechStructure.perk > 0)
               {
                  switch(this._structureType)
                  {
                     case "itemID":
                        _loc7_ = dataM.itemsDB[this._mechStructure.perk];
                        break;
                     case "playerItemID":
                        _loc8_ = dataM.getPlayerItemData(this._playerID,this._mechStructure.perk);
                        _loc7_ = dataM.itemsDB[_loc8_.itemID];
                  }
                  switch(_loc7_.grp)
                  {
                     case "perk_torso1":
                        _loc9_ = "torsoPerk1";
                        break;
                     case "perk_hat1":
                        _loc10_ = "hatPerk1";
                  }
               }
               _loc17_ = this._equipItemsData.length - 1;
               while(_loc17_ >= 0)
               {
                  if(this._equipItemsData[_loc17_].itemName == "torso")
                  {
                     this.torso.x = this._equipItemsData[_loc17_].targetXPos;
                     this.torso.y = this._equipItemsData[_loc17_].targetYPos;
                  }
                  _loc17_--;
               }
            }
            if(_loc3_ == "leg")
            {
               _loc3_ = "leg2";
               if(this.useLegsShadow)
               {
                  if(this.leg1Shadow == null)
                  {
                     _loc18_ = _loc9_;
                     _loc19_ = _loc18_.substr(_loc18_.length - 1,1);
                     switch(_loc19_)
                     {
                        case "A":
                        case "B":
                        case "C":
                        case "D":
                           _loc18_ = _loc18_.substr(0,_loc18_.length - 1) + "_shadow";
                           break;
                        default:
                           _loc18_ += "_shadow";
                     }
                     this.leg1Shadow = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc5_.type],_loc18_);
                     this.leg1Shadow.width *= this.sizeRatio;
                     this.leg1Shadow.height *= this.sizeRatio;
                     this.leg2Shadow = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc5_.type],_loc18_);
                     this.leg2Shadow.width *= this.sizeRatio;
                     this.leg2Shadow.height *= this.sizeRatio;
                  }
               }
            }
            _loc11_ = this[_loc3_];
            _loc12_ = false;
            if(this._lastMechStructure != null)
            {
               switch(param1)
               {
                  case "torso":
                     if(this.forceRebuildingTorso)
                     {
                        this.forceRebuildingTorso = false;
                     }
                     else if(this._lastMechStructure[_loc3_] == this._mechStructure[_loc3_])
                     {
                        _loc12_ = true;
                     }
                     break;
                  case "leg":
                     if(this._lastMechStructure.leg == this._mechStructure.leg)
                     {
                        _loc12_ = true;
                     }
                     break;
                  default:
                     if(this._lastMechStructure[_loc3_] == this._mechStructure[_loc3_])
                     {
                        _loc12_ = true;
                     }
               }
            }
            if(_loc12_ == false)
            {
               if(param1 == "leg")
               {
                  if(this.leg1.item != null)
                  {
                     this.leg1.item.removeMe();
                     this._itemHolders[this._itemHoldersReversByNames["leg1"]].item = null;
                  }
                  if(this.leg2.item != null)
                  {
                     this.leg2.item.removeMe();
                     this._itemHolders[this._itemHoldersReversByNames["leg2"]].item = null;
                  }
               }
               else if(_loc11_.item != null)
               {
                  _loc11_.item.removeMe();
                  this._itemHolders[this._itemHoldersReversByNames[_loc3_]].item = null;
               }
               _loc20_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc5_.type],_loc9_,0,0,false,true);
               _loc13_ = new BMItem();
               _loc13_.initialize(_loc4_,0,0,_loc20_,0,0,false,null,dataM.runAsMobile);
               _loc23_ = 0;
               if(_loc6_ != null)
               {
                  _loc23_ = _loc6_.colorID;
               }
               else if(this._manualColors != null)
               {
                  if(this._manualColors[_loc5_.type] != null)
                  {
                     _loc23_ = Number(this._manualColors[_loc5_.type]);
                  }
                  else if(this._manualColors[_loc5_.type + param2] != null)
                  {
                     _loc23_ = Number(this._manualColors[_loc5_.type + param2]);
                  }
               }
               else
               {
                  _loc24_ = _loc3_;
                  if(_loc24_ == "leg2")
                  {
                     _loc24_ = "leg";
                  }
                  if(this._mechStructure[_loc24_ + "_colorID"] != null)
                  {
                     _loc23_ = Number(this._mechStructure[_loc24_ + "_colorID"]);
                  }
               }
               switch(dataM.getColoringType(this._playerID))
               {
                  case "colorID":
                     dataM.colorItem(_loc13_,_loc23_);
                     break;
                  case "power":
                     if(_loc6_.colorID > 0)
                     {
                        dataM.colorItem(_loc13_,_loc6_.colorID);
                     }
                     else
                     {
                        dataM.colorItem(_loc13_,dataM.getItemPowerColorID(this._playerID,_loc6_.playerItemID));
                     }
               }
               _loc13_.width *= this.sizeRatio;
               _loc13_.height *= this.sizeRatio;
               _loc11_.item = _loc13_;
               _loc11_.addChild(_loc13_);
            }
            else
            {
               _loc13_ = _loc11_.item;
            }
            _loc15_ = this.torso.item;
            _loc16_ = false;
            switch(_loc5_.type)
            {
               case "leg":
               case "sideWeapon":
               case "topWeapon":
                  _loc13_.x = _loc13_.width / 2 - _loc13_.itemGrp.mcTorso.x * this.sizeRatio;
                  _loc13_.y = _loc13_.height / 2 - _loc13_.itemGrp.mcTorso.y * this.sizeRatio;
                  _loc11_.x += _loc13_.itemGrp.mcTorso.x * this.sizeRatio;
                  _loc11_.y += _loc13_.itemGrp.mcTorso.y * this.sizeRatio;
                  if(_loc16_)
                  {
                     _loc13_.itemGrp.mcTorso.addChild(new mcCenter2());
                     _loc11_.addChild(new mcCenter());
                  }
            }
            switch(_loc5_.type)
            {
               case "torso":
                  _loc13_.x = _loc13_.width / 2 - _loc13_.itemGrp.mcCenter.x * this.sizeRatio;
                  _loc13_.y = _loc13_.height / 2 - _loc13_.itemGrp.mcCenter.y * this.sizeRatio;
                  if(_loc16_)
                  {
                     _loc13_.itemGrp.mcCenter.addChild(new mcCenter2());
                     _loc11_.addChild(new mcCenter());
                  }
                  this._itemsOriginPoints["torso"] = new Point(_loc11_.x,_loc11_.y);
                  if(_loc10_ != "")
                  {
                     if(_loc13_.itemGrp.mcHat != null)
                     {
                        _loc25_ = externalAssetsM.getAsset("items1",_loc10_);
                        _loc25_.x = _loc13_.itemGrp.mcHat.x;
                        _loc25_.y = _loc13_.itemGrp.mcHat.y;
                        _loc13_.itemGrp.hatPerk = _loc25_;
                        _loc13_.itemGrp.addChild(_loc25_);
                     }
                  }
                  switch(dataM.getColoringType(this._playerID))
                  {
                     case "colorID":
                        this._torsoColorID = _loc23_;
                        break;
                     case "power":
                        if(_loc6_.colorID > 0)
                        {
                           this._torsoColorID = _loc6_.colorID;
                        }
                        else
                        {
                           this._torsoColorID = dataM.getItemPowerColorID(this._playerID,_loc6_.playerItemID);
                        }
                  }
                  break;
               case "leg":
                  _loc11_.x = this.torso.x + (_loc15_.itemGrp.mcLeg2.x - _loc15_.itemGrp.mcCenter.x) * this.sizeRatio;
                  _loc11_.y = this.torso.y + (_loc15_.itemGrp.mcLeg2.y - _loc15_.itemGrp.mcCenter.y) * this.sizeRatio;
                  this._itemsOriginPoints["leg2"] = new Point(_loc11_.x,_loc11_.y);
                  _loc20_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc5_.type],_loc9_,0,0,false,true);
                  _loc13_ = new BMItem();
                  _loc13_.initialize(_loc4_,0,0,_loc20_,0,0,false,null,dataM.runAsMobile);
                  switch(dataM.getColoringType(this._playerID))
                  {
                     case "colorID":
                        dataM.colorItem(_loc13_,_loc23_);
                        break;
                     case "power":
                        if(_loc6_.colorID > 0)
                        {
                           dataM.colorItem(_loc13_,_loc6_.colorID);
                        }
                        else
                        {
                           dataM.colorItem(_loc13_,dataM.getItemPowerColorID(this._playerID,_loc6_.playerItemID));
                        }
                  }
                  _loc13_.width *= this.sizeRatio;
                  _loc13_.height *= this.sizeRatio;
                  if(this.leg1.item != null)
                  {
                     this.leg1.item.removeMe();
                  }
                  this.leg1.item = _loc13_;
                  this.leg1.addChild(_loc13_);
                  _loc11_ = this.leg1;
                  _loc13_.x = _loc13_.width / 2 - _loc13_.itemGrp.mcTorso.x * this.sizeRatio;
                  _loc13_.y = _loc13_.height / 2 - _loc13_.itemGrp.mcTorso.y * this.sizeRatio;
                  if(this._viewType == "battle")
                  {
                     _loc13_.y += 4;
                  }
                  _loc11_.x += _loc13_.itemGrp.mcTorso.x * this.sizeRatio;
                  _loc11_.y += _loc13_.itemGrp.mcTorso.y * this.sizeRatio;
                  if(_loc16_)
                  {
                     _loc13_.itemGrp.mcTorso.addChild(new mcCenter2());
                     _loc11_.addChild(new mcCenter());
                  }
                  _loc11_.x = this.torso.x + (_loc15_.itemGrp.mcLeg1.x - _loc15_.itemGrp.mcCenter.x) * this.sizeRatio;
                  _loc11_.y = this.torso.y + (_loc15_.itemGrp.mcLeg1.y - _loc15_.itemGrp.mcCenter.y) * this.sizeRatio;
                  this._itemsOriginPoints["leg1"] = new Point(_loc11_.x,_loc11_.y);
                  this._breathingLegOriginalHeight = this.leg1.height;
                  break;
               case "sideWeapon":
                  if(_loc15_.itemGrp["mcSide" + param2] != null)
                  {
                     _loc11_.x = this.torso.x + (_loc15_.itemGrp["mcSide" + param2].x - _loc15_.itemGrp.mcCenter.x) * this.sizeRatio;
                     _loc11_.y = this.torso.y + (_loc15_.itemGrp["mcSide" + param2].y - _loc15_.itemGrp.mcCenter.y) * this.sizeRatio;
                     this._weaponsOriginXYPos[_loc3_] = {
                        "xPos":_loc11_.item.x,
                        "yPos":_loc11_.item.y
                     };
                     this._itemsOriginPoints["sideWeapon" + param2] = new Point(_loc11_.x,_loc11_.y);
                  }
                  else
                  {
                     TsLogger.log("ERROR - SIDE WEAPON " + param2 + " HOLDER DOESN\'T EXIST ON CURRENT TORSO");
                  }
                  break;
               case "topWeapon":
                  if(_loc15_.itemGrp["mcTop" + param2] != null)
                  {
                     _loc11_.x = this.torso.x + (_loc15_.itemGrp["mcTop" + param2].x - _loc15_.itemGrp.mcCenter.x) * this.sizeRatio;
                     _loc11_.y = this.torso.y + (_loc15_.itemGrp["mcTop" + param2].y - _loc15_.itemGrp.mcCenter.y) * this.sizeRatio;
                     this._weaponsOriginXYPos[_loc3_] = {
                        "xPos":_loc11_.item.x,
                        "yPos":_loc11_.item.y
                     };
                     this._itemsOriginPoints["topWeapon" + param2] = new Point(_loc11_.x,_loc11_.y);
                  }
                  else
                  {
                     TsLogger.log("ERROR - TOP WEAPON " + param2 + " HOLDER DOESN\'T EXIST ON CURRENT TORSO");
                  }
            }
         }
         else if(this._lastMechStructure != null)
         {
            switch(param1)
            {
               case "leg":
                  if(this._lastMechStructure.leg > 0)
                  {
                     this.leg1.item.removeMe();
                     this.leg2.item.removeMe();
                     this._itemHolders[this._itemHoldersReversByNames["leg1"]].item = null;
                     this._itemHolders[this._itemHoldersReversByNames["leg2"]].item = null;
                  }
                  break;
               default:
                  if(this._lastMechStructure[_loc3_] > 0)
                  {
                     this[_loc3_].item.removeMe();
                     this._itemHolders[this._itemHoldersReversByNames[_loc3_]].item = null;
                  }
            }
         }
         ++this._itemsToBuildSlot;
         if(this._dynamicBuilding)
         {
            addEventListener(Event.ENTER_FRAME,this.buildNextItemOnEnterFrameTrigger);
         }
         else
         {
            this.buildNextItem();
         }
      }
      
      private function buildNextItemOnEnterFrameTrigger(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.buildNextItemOnEnterFrameTrigger);
         this.buildNextItem();
      }
      
      private function buildNextItem() : void
      {
         var _loc1_:Object = null;
         if(this._itemsToBuildSlot >= this._itemsToBuild.length)
         {
            this.buildMechLastFunctions();
         }
         else
         {
            _loc1_ = this._itemsToBuild[this._itemsToBuildSlot];
            this.buildItem(_loc1_.equipmentType,_loc1_.equipmentID);
         }
      }
      
      private function clearAllItems(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:BMItem = null;
         var _loc5_:uint = 0;
         if(this._itemHolders != null)
         {
            _loc2_ = int(this._itemHolders.length);
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc3_ = this._itemHolders[_loc5_];
               if(_loc3_.item != null)
               {
                  _loc4_ = _loc3_.item;
                  _loc4_.removeMe();
                  this._itemHolders[_loc5_].item = null;
                  if(param1)
                  {
                     if(this._itemHolders[_loc5_].parent != null)
                     {
                        this._itemHolders[_loc5_].parent.removeChild(this._itemHolders[_loc5_]);
                     }
                  }
               }
               _loc5_++;
            }
            if(param1)
            {
               this._itemHolders = null;
               this.torso = null;
               this.leg2 = null;
               this.leg1 = null;
               this.sideWeapon1 = null;
               this.sideWeapon2 = null;
               this.sideWeapon3 = null;
               this.sideWeapon4 = null;
               this.topWeapon1 = null;
               this.topWeapon2 = null;
               this.drone = null;
               this.harpoon = null;
            }
         }
      }
      
      public function activateBreathing() : void
      {
         if(this._shutDownStatus == "")
         {
            if(this._canBreath && this._mechStructure.torso > 0 && this._mechStructure.leg > 0)
            {
               this._breathingHandler = true;
               this._breathingPaused = false;
               this._breathingCounter = 0;
               this.resetBreathing_torsoAndWeapons(false);
               this.resetBreathing_legs(false);
            }
            else
            {
               this.deactivateBreathing();
            }
         }
      }
      
      public function deactivateBreathing() : void
      {
         this._breathingHandler = false;
      }
      
      private function pauseBreathingAndRemoveTeasers(param1:Boolean) : void
      {
         if(this._breathingHandler && this._breathingPaused == false)
         {
            this._breathingPaused = true;
         }
         this.removeTeasers(param1);
      }
      
      public function removeTeasers(param1:Boolean) : void
      {
         this.resetBreathing_torsoAndWeapons(param1);
         this.resetBreathing_legs(param1);
         this._tease1Handler = false;
         this._tease2Handler = false;
         this._tease3Handler = false;
         this._tease4Handler = false;
         this._tease5Handler = false;
         this._tease6Handler = false;
         this._tease7Handler = false;
         this._tease8Handler = false;
         this._tease9Handler = false;
         this._tease10Handler = false;
         this._tease11Handler = false;
         this._tease12Handler = false;
         this.removeAllTeaseActiveAnimations();
      }
      
      private function resetBreathing_torsoAndWeapons(param1:Boolean) : void
      {
         this.breathingResetItem("torso",param1);
         this.breathingResetItem("sideWeapon1",param1);
         this.breathingResetItem("sideWeapon2",param1);
         this.breathingResetItem("sideWeapon3",param1);
         this.breathingResetItem("sideWeapon4",param1);
         this.breathingResetItem("topWeapon1",param1);
         this.breathingResetItem("topWeapon2",param1);
      }
      
      private function resetBreathing_legs(param1:Boolean) : void
      {
         this.leg1.scaleX = 1;
         this.leg1.scaleY = 1;
         this.leg2.scaleX = 1;
         this.leg2.scaleY = 1;
         this.breathingResetItem("leg1",param1);
         this.breathingResetItem("leg2",param1);
      }
      
      public function resumeBreathing() : void
      {
         if(this._breathingHandler && this._breathingPaused)
         {
            this.activateBreathing();
         }
      }
      
      private function breathingHandler() : void
      {
         if(dataM.breathingEffect)
         {
            if(this._breathingHandler && this._breathingPaused == false)
            {
               ++this._breathingCounter;
               if(this._breathingCounter > this.BREATHING_FRAMES)
               {
                  this._breathingCounter = 0;
               }
               else if(this._breathingCounter == this.BREATHING_FRAMES)
               {
                  this.resetBreathing_torsoAndWeapons(false);
               }
               else
               {
                  if(this._breathingCounter == this.BREATHING_FRAMES / 2)
                  {
                     this.resetBreathing_legs(false);
                  }
                  this.breathingMoveItem("torso",0,-1.2);
                  this.breathingMoveItem("sideWeapon1",-1,0);
                  this.breathingMoveItem("sideWeapon2",1,0);
                  this.breathingMoveItem("sideWeapon3",-1,0);
                  this.breathingMoveItem("sideWeapon4",1,0);
                  this.breathingMoveItem("topWeapon1",-0.75,-1);
                  this.breathingMoveItem("topWeapon2",0.75,-1);
                  this.breathingResizeItem("leg1",0,0.05);
                  this.breathingResizeItem("leg2",0,0.05);
               }
            }
         }
      }
      
      private function breathingMoveItem(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:MovieClip = this[param1];
         if(_loc4_.item != null)
         {
            if(this._breathingAnimationData[param1] == null)
            {
               this._breathingAnimationData[param1] = new Object();
            }
            if(this._breathingAnimationData[param1][this._breathingCounter] == null)
            {
               if(this._breathingCounter < this.BREATHING_FRAMES / 2)
               {
                  if(param2 != 0)
                  {
                     _loc4_.x = this._itemsOriginPoints[param1].x + param2 * (this.BREATHING_MOTION * this._breathingCounter / this.BREATHING_FRAMES / 2);
                  }
                  if(param3 != 0)
                  {
                     _loc4_.y = this._itemsOriginPoints[param1].y + param3 * (this.BREATHING_MOTION * this._breathingCounter / this.BREATHING_FRAMES / 2);
                  }
               }
               else
               {
                  if(param2 != 0)
                  {
                     _loc4_.x = this._itemsOriginPoints[param1].x + param2 * (this.BREATHING_MOTION * (this.BREATHING_FRAMES - this._breathingCounter) / this.BREATHING_FRAMES / 2);
                  }
                  if(param3 != 0)
                  {
                     _loc4_.y = this._itemsOriginPoints[param1].y + param3 * (this.BREATHING_MOTION * (this.BREATHING_FRAMES - this._breathingCounter) / this.BREATHING_FRAMES / 2);
                  }
               }
               this._breathingAnimationData[param1][this._breathingCounter] = {
                  "xPos":_loc4_.x,
                  "yPos":_loc4_.y
               };
            }
            else
            {
               _loc4_.x = this._breathingAnimationData[param1][this._breathingCounter].xPos;
               _loc4_.y = this._breathingAnimationData[param1][this._breathingCounter].yPos;
            }
         }
      }
      
      private function breathingResizeItem(param1:String, param2:Number, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:MovieClip = this[param1];
         if(_loc4_.item != null)
         {
            if(this._breathingAnimationData[param1] == null)
            {
               this._breathingAnimationData[param1] = new Object();
            }
            if(this._breathingAnimationData[param1][this._breathingCounter] == null)
            {
               if(this._breathingCounter < this.BREATHING_FRAMES / 2)
               {
                  if(param2 != 0)
                  {
                  }
                  if(param3 != 0)
                  {
                     _loc5_ = _loc4_.height;
                     _loc4_.scaleY = 1 + param3 - param3 * ((this.BREATHING_FRAMES / 2 - this._breathingCounter) / (this.BREATHING_FRAMES / 2));
                     _loc4_.y = this._itemsOriginPoints[param1].y + this._breathingLegOriginalHeight - _loc4_.height;
                  }
               }
               else
               {
                  if(param2 != 0)
                  {
                  }
                  if(param3 != 0)
                  {
                     _loc5_ = _loc4_.height;
                     _loc4_.scaleY = 1 + param3 - param3 * ((this._breathingCounter - this.BREATHING_FRAMES / 2) / (this.BREATHING_FRAMES / 2));
                     _loc4_.y = this._itemsOriginPoints[param1].y + this._breathingLegOriginalHeight - _loc4_.height;
                  }
               }
               this._breathingAnimationData[param1][this._breathingCounter] = {
                  "yPos":_loc4_.y,
                  "scaleY":_loc4_.scaleY
               };
            }
            else
            {
               _loc4_.y = this._breathingAnimationData[param1][this._breathingCounter].yPos;
               _loc4_.scaleY = this._breathingAnimationData[param1][this._breathingCounter].scaleY;
            }
         }
      }
      
      private function breathingResetItem(param1:String, param2:Boolean) : void
      {
         var _loc3_:MovieClip = this[param1];
         if(_loc3_.item != null)
         {
            _loc3_.x = this._itemsOriginPoints[param1].x;
            _loc3_.y = this._itemsOriginPoints[param1].y;
            if(this.useLegsShadow)
            {
               if(param1 == "leg1")
               {
                  this.leg1Shadow.x = this._itemsOriginPoints["leg1Shadow"].x;
                  this.leg1Shadow.y = this._itemsOriginPoints["leg1Shadow"].y;
               }
               else if(param1 == "leg2")
               {
                  this.leg2Shadow.x = this._itemsOriginPoints["leg2Shadow"].x;
                  this.leg2Shadow.y = this._itemsOriginPoints["leg2Shadow"].y;
               }
            }
            if(param2)
            {
               _loc3_.x += this._shutdownAddons[param1].xAddon;
               _loc3_.y += this._shutdownAddons[param1].yAddon;
               if(this.useLegsShadow)
               {
                  if(param1 == "leg1")
                  {
                     this.leg1Shadow.x += this._shutdownAddons[param1].xAddon;
                     this.leg1Shadow.y += this._shutdownAddons[param1].yAddon;
                  }
                  else if(param1 == "leg2")
                  {
                     this.leg2Shadow.x += this._shutdownAddons[param1].xAddon;
                     this.leg2Shadow.y += this._shutdownAddons[param1].yAddon;
                  }
               }
            }
            _loc3_.rotation = 0;
            _loc3_.scaleX = 1;
            _loc3_.scaleY = 1;
         }
      }
      
      public function clearBreathingMovementData() : void
      {
         this._breathingAnimationData = new Object();
      }
      
      public function activateShield(param1:String) : void
      {
         this._lastSlowCPUMode = dataM.slowCPUMode;
         this._shieldActive = true;
         this._shieldAnimationHandler = true;
         this._shieldType = param1;
      }
      
      public function activateShield_mobile(param1:String) : void
      {
         this.removeShieldForMobile();
         this._shieldAngle = 0;
         this._shieldRadius = this.mechSizer.height * 0.75;
         switch(param1)
         {
            case "energy":
               this._shieldEffectForMobile = externalAssetsM.getAsset("general","mcShieldBlue");
               break;
            case "heat":
               this._shieldEffectForMobile = externalAssetsM.getAsset("general","mcShieldRed");
         }
         this._shieldActive = true;
         this._shieldAnimationHandler = true;
         this._shieldEffectForMobile.x = this._shieldEffectStatingXPos + this.SHIELD_X_PUSH_MOBILE;
         this._shieldLastXPos = this._shieldEffectForMobile.x;
         this._shieldSpeed = 0;
         this.shieldEffectBackHolder.addChild(this._shieldEffectForMobile);
      }
      
      public function deactivateShield() : void
      {
         this._lastSlowCPUMode = dataM.slowCPUMode;
         this._shieldActive = false;
      }
      
      public function deactivateShield_mobile() : void
      {
         this.removeShieldForMobile();
         this._shieldAnimationHandler = false;
      }
      
      private function removeShieldForMobile() : void
      {
         if(this._shieldEffectForMobile != null)
         {
            if(this._shieldEffectForMobile.parent != null)
            {
               this._shieldEffectForMobile.parent.removeChild(this._shieldEffectForMobile);
            }
            this._shieldEffectForMobile = null;
         }
      }
      
      private function shieldHandlerHandler() : void
      {
         var _loc1_:Number = NaN;
         if(this._shieldAnimationHandler)
         {
            if(dataM.runAsMobile)
            {
               if(this._shieldEffectForMobile.x < this.SHIELD_X_PUSH_MOBILE)
               {
                  this._shieldSpeed += this.SHIELD_SPEED_CHANGE_MOBILE;
                  if(this._shieldLastXPos >= this.SHIELD_X_PUSH_MOBILE)
                  {
                     this._shieldSpeed += this.SHIELD_SPEED_CHANGE_MOBILE;
                  }
                  this._shieldEffectForMobile.scaleX += this.SHIELD_SCALE_CHANGE_MOBILE;
                  this._shieldEffectForMobile.scaleY += this.SHIELD_SCALE_CHANGE_MOBILE;
               }
               else
               {
                  this._shieldSpeed -= this.SHIELD_SPEED_CHANGE_MOBILE;
                  if(this._shieldLastXPos < this.SHIELD_X_PUSH_MOBILE)
                  {
                     this._shieldSpeed -= this.SHIELD_SPEED_CHANGE_MOBILE;
                  }
                  this._shieldEffectForMobile.scaleX -= this.SHIELD_SCALE_CHANGE_MOBILE;
                  this._shieldEffectForMobile.scaleY -= this.SHIELD_SCALE_CHANGE_MOBILE;
               }
               this._shieldLastXPos = this._shieldEffectForMobile.x;
               if(this._shieldSpeed > -0.05 && this._shieldSpeed < 0.05)
               {
                  if(this._shieldEffectForMobile.x < this.SHIELD_X_PUSH_MOBILE)
                  {
                     this._shieldEffectForMobile.x = -this._shieldEffectStatingXPos + this.SHIELD_X_PUSH_MOBILE;
                     this._shieldEffectForMobile.parent.removeChild(this._shieldEffectForMobile);
                     addChild(this._shieldEffectForMobile);
                  }
                  else
                  {
                     this._shieldEffectForMobile.x = this._shieldEffectStatingXPos + this.SHIELD_X_PUSH_MOBILE;
                     this._shieldEffectForMobile.parent.removeChild(this._shieldEffectForMobile);
                     this.shieldEffectBackHolder.addChild(this._shieldEffectForMobile);
                  }
                  this._shieldEffectForMobile.scaleX = 1;
                  this._shieldEffectForMobile.scaleY = 1;
               }
               else
               {
                  this._shieldEffectForMobile.x += this._shieldSpeed;
               }
            }
            else
            {
               _loc1_ = this.SHIELD_GLOW_STRENGTH_CHANGE;
               if(this._lastSlowCPUMode)
               {
                  _loc1_ *= 2;
               }
               if(this._shieldActive)
               {
                  if(this._shieldGlowStrength < this.SHIELD_GLOW_STRENGTH_MAX)
                  {
                     this._shieldGlowStrength += _loc1_;
                  }
               }
               else if(this._shieldGlowStrength > 0)
               {
                  this._shieldGlowStrength -= _loc1_;
                  if(this._shieldGlowStrength < 0)
                  {
                     this._shieldGlowStrength = 0;
                  }
               }
               if(this._shieldActive == false && this._shieldGlowStrength == 0)
               {
                  this._shieldGlowFilter1 = null;
                  this._shieldGlowFilter2 = null;
                  this._shieldAnimationHandler = false;
               }
               else if(!dataM.runAsMobile)
               {
                  switch(this._shieldType)
                  {
                     case "energy":
                        this._shieldGlowFilter1 = new GlowFilter(16777215,1,3,3,this._shieldGlowStrength,3,false,false);
                        this._shieldGlowFilter2 = new GlowFilter(52479,1,9,9,this._shieldGlowStrength,3,false,false);
                        break;
                     case "heat":
                        this._shieldGlowFilter1 = new GlowFilter(16777215,1,3,3,this._shieldGlowStrength,3,false,false);
                        this._shieldGlowFilter2 = new GlowFilter(16711680,1,9,9,this._shieldGlowStrength,3,false,false);
                  }
               }
               this._refreshFiltersHandler = true;
            }
         }
      }
      
      public function addAnimatedGlow() : void
      {
         if(!dataM.runAsMobile)
         {
            this._innerGlowFilterRemoveMe = false;
            this._animatedGlowHandler = true;
         }
      }
      
      public function removeAnimatedGlow() : void
      {
         if(!dataM.runAsMobile)
         {
            this._innerGlowFilterRemoveMe = true;
            this._innerGlowFilterRemoveMeCounter = 2;
            this._refreshFiltersHandler = true;
         }
      }
      
      private function animatedGlowHandler() : void
      {
         if(!dataM.runAsMobile && this._animatedGlowHandler)
         {
            this._animatedGlowStrength += this._animatedGlowModifier;
            if(this._animatedGlowModifier > 0)
            {
               if(this._animatedGlowStrength > this.INNER_GLOW_STRENGTH_MAX)
               {
                  this._animatedGlowStrength = this.INNER_GLOW_STRENGTH_MAX;
                  this._animatedGlowModifier *= -1;
               }
            }
            else if(this._animatedGlowStrength < this.INNER_GLOW_STRENGTH_MIN)
            {
               this._animatedGlowStrength = this.INNER_GLOW_STRENGTH_MIN;
               this._animatedGlowModifier *= -1;
            }
            this._innerGlowFilter = new GlowFilter(13369344,this._animatedGlowStrength,100,100,10,1,true,false);
            if(this._innerGlowFilterRemoveMe)
            {
               if(this._innerGlowFilterRemoveMeCounter > 0)
               {
                  --this._innerGlowFilterRemoveMeCounter;
               }
               else
               {
                  this._innerGlowFilter = null;
                  this._innerGlowFilterRemoveMe = false;
                  this._animatedGlowHandler = false;
               }
            }
            this._refreshFiltersHandler = true;
         }
      }
      
      private function refreshFiltersHandler() : void
      {
         var _loc1_:Array = null;
         if(!dataM.runAsMobile && this._refreshFiltersHandler)
         {
            _loc1_ = new Array();
            if(this._bevelFilter != null)
            {
               _loc1_.push(this._bevelFilter);
            }
            if(this._innerGlowFilter != null)
            {
               _loc1_.push(this._innerGlowFilter);
            }
            if(this._shieldGlowFilter1 != null)
            {
               _loc1_.push(this._shieldGlowFilter1);
               _loc1_.push(this._shieldGlowFilter2);
            }
            this.itemsHolder.filters = _loc1_;
            this._refreshFiltersHandler = false;
         }
      }
      
      public function createChargeEngine() : void
      {
         if(this._mechStructure.charge > 0)
         {
            this.chargeEngineHolder.x = this.torso.x + (this.torso.item.itemGrp.mcChargeEngine.x - this.torso.item.itemGrp.mcCenter.x) * this.sizeRatio;
            this.chargeEngineHolder.y = this.torso.y + (this.torso.item.itemGrp.mcChargeEngine.y - this.torso.item.itemGrp.mcCenter.y) * this.sizeRatio;
            this.chargeEngine = externalAssetsM.getAsset("general","chargeEngineAnimation",0,0,false,true);
            this.chargeEngine.visible = false;
            this.chargeEngineHolder.addChild(this.chargeEngine);
         }
      }
      
      public function activateChargeEngine(param1:Function, param2:Function) : void
      {
         this.pauseBreathingAndRemoveTeasers(false);
         this._chargeEngineFireStartedFunction = param1;
         this._chargeEngineFireEndedFunction = param2;
         this._chargeActive = true;
         this._chargeFrameCounter = 0;
      }
      
      private function chargeHandler() : void
      {
         if(this._chargeActive)
         {
            if(this._chargeFrameCounter <= 19)
            {
               if(this._chargeFrameCounter == 0)
               {
                  this.chargeEngine.visible = true;
                  this.chargeEngine.mcFireA.alpha = 0;
                  this.chargeEngine.mcFireB1.visible = false;
                  this.chargeEngine.mcFireB2.visible = false;
                  this.chargeEngine.mcFireB3.visible = false;
                  this.chargeEngine.mcFireB4.visible = false;
                  this.chargeEngine.mcFireB5.visible = false;
                  this.chargeEngine.mcEngine.x = 40;
               }
               if(this._chargeFrameCounter < 19)
               {
                  this.chargeEngine.mcEngine.x -= (this.chargeEngine.mcEngine.x + 10) * 0.15;
               }
               else
               {
                  this.chargeEngineFireStarted();
                  this.chargeEngine.mcFireA.alpha = 1;
               }
            }
            else if(this._chargeFrameCounter <= 51)
            {
               if(this._chargeFrameCounter <= 31)
               {
                  if(this._chargeFrameCounter == 20)
                  {
                     this.chargeEngine.mcFireB1.visible = true;
                     this.chargeEngine.mcFireB1.scaleX = 0.7;
                     this.chargeEngine.mcFireB1.scaleY = 0.7;
                     this.chargeEngine.mcFireB1.x = -50;
                     this.chargeEngine.mcFireB1.y = 0;
                  }
                  else if(this._chargeFrameCounter < 31)
                  {
                     this.chargeEngine.mcFireB1.scaleX -= 0.063;
                     this.chargeEngine.mcFireB1.scaleY -= 0.063;
                     this.chargeEngine.mcFireB1.x -= 7;
                     this.chargeEngine.mcFireB1.y -= 2;
                  }
                  else
                  {
                     this.chargeEngine.mcFireB1.visible = false;
                  }
               }
               if(this._chargeFrameCounter >= 21 && this._chargeFrameCounter <= 38)
               {
                  if(this._chargeFrameCounter == 21)
                  {
                     this.chargeEngine.mcFireB2.visible = true;
                     this.chargeEngine.mcFireB2.rotation = -30;
                     this.chargeEngine.mcFireB2.scaleX = 0.6;
                     this.chargeEngine.mcFireB2.scaleY = 0.6;
                     this.chargeEngine.mcFireB2.x = -52;
                     this.chargeEngine.mcFireB2.y = 5;
                  }
                  else if(this._chargeFrameCounter < 38)
                  {
                     this.chargeEngine.mcFireB2.scaleX -= 0.035;
                     this.chargeEngine.mcFireB2.scaleY -= 0.035;
                     this.chargeEngine.mcFireB2.x -= 8;
                  }
                  else
                  {
                     this.chargeEngine.mcFireB2.visible = false;
                  }
               }
               if(this._chargeFrameCounter >= 22 && this._chargeFrameCounter <= 35)
               {
                  if(this._chargeFrameCounter == 22)
                  {
                     this.chargeEngine.mcFireB3.visible = true;
                     this.chargeEngine.mcFireB3.rotation = 30;
                     this.chargeEngine.mcFireB3.scaleX = 0.63;
                     this.chargeEngine.mcFireB3.scaleY = 0.63;
                     this.chargeEngine.mcFireB3.x = -46;
                     this.chargeEngine.mcFireB3.y = -4;
                  }
                  else if(this._chargeFrameCounter < 35)
                  {
                     this.chargeEngine.mcFireB3.scaleX -= 0.045;
                     this.chargeEngine.mcFireB3.scaleY -= 0.045;
                     this.chargeEngine.mcFireB3.x -= 7;
                     --this.chargeEngine.mcFireB3.y;
                  }
                  else
                  {
                     this.chargeEngine.mcFireB3.visible = false;
                  }
               }
               if(this._chargeFrameCounter >= 23 && this._chargeFrameCounter <= 37)
               {
                  if(this._chargeFrameCounter == 23)
                  {
                     this.chargeEngine.mcFireB4.visible = true;
                     this.chargeEngine.mcFireB4.rotation = -75;
                     this.chargeEngine.mcFireB4.scaleX = 0.65;
                     this.chargeEngine.mcFireB4.scaleY = 0.65;
                     this.chargeEngine.mcFireB4.x = -55;
                     this.chargeEngine.mcFireB4.y = 2;
                  }
                  else if(this._chargeFrameCounter < 37)
                  {
                     this.chargeEngine.mcFireB4.scaleX -= 0.045;
                     this.chargeEngine.mcFireB4.scaleY -= 0.045;
                     this.chargeEngine.mcFireB4.x -= 9;
                     this.chargeEngine.mcFireB4.y += 2;
                  }
                  else
                  {
                     this.chargeEngine.mcFireB4.visible = false;
                  }
               }
               if(this._chargeFrameCounter >= 25 && this._chargeFrameCounter <= 40)
               {
                  if(this._chargeFrameCounter == 25)
                  {
                     this.chargeEngine.mcFireB5.visible = true;
                     this.chargeEngine.mcFireB5.rotation = -135;
                     this.chargeEngine.mcFireB5.scaleX = 0.7;
                     this.chargeEngine.mcFireB5.scaleY = 0.7;
                     this.chargeEngine.mcFireB5.x = -46;
                     this.chargeEngine.mcFireB5.y = 3;
                  }
                  else if(this._chargeFrameCounter < 40)
                  {
                     this.chargeEngine.mcFireB5.scaleX -= 0.046;
                     this.chargeEngine.mcFireB5.scaleY -= 0.046;
                     this.chargeEngine.mcFireB5.x -= 8;
                  }
                  else
                  {
                     this.chargeEngine.mcFireB5.visible = false;
                  }
               }
               if(this._chargeFrameCounter < 51)
               {
                  if(this._chargeFrameCounter >= 42)
                  {
                     this.chargeEngine.mcFireA.alpha -= 0.1;
                  }
               }
               else
               {
                  this.chargeEngineFireEnded();
                  this.chargeEngine.mcFireA.alpha = 0;
               }
            }
            else if(this._chargeFrameCounter < 69)
            {
               this.chargeEngine.mcEngine.x += (40 - this.chargeEngine.mcEngine.x) * 0.15;
            }
            else
            {
               this._chargeActive = false;
               this.chargeEngine.visible = false;
               this.chargeEngine.mcEngine.x = 40;
            }
            ++this._chargeFrameCounter;
         }
      }
      
      public function chargeEngineFireStarted() : void
      {
         this._chargeEngineFireStartedFunction();
      }
      
      public function chargeEngineFireEnded() : void
      {
         this._chargeEngineFireEndedFunction();
         this.chargeEngine.visible = false;
      }
      
      public function addBevel() : void
      {
         if(!dataM.runAsMobile)
         {
            this._bevelFilter = new BevelFilter(2,45,16777215,0.5,0,0.3,3,3,2,3);
            this._refreshFiltersHandler = true;
         }
      }
      
      private function refreshMechSizer() : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:int = int(this._itemHolders.length);
         var _loc9_:uint = 0;
         for(; _loc9_ < _loc5_; _loc9_++)
         {
            _loc6_ = this._itemHolders[_loc9_];
            if(_loc6_.item == null)
            {
               continue;
            }
            _loc7_ = _loc6_.item.itemGrp;
            if(_loc7_.mcCenter != null)
            {
               _loc8_ = _loc7_.mcCenter;
            }
            else
            {
               _loc8_ = _loc7_.mcTorso;
            }
            if(_loc1_ > _loc6_.x - _loc8_.x * this.sizeRatio)
            {
               _loc1_ = _loc6_.x - _loc8_.x * this.sizeRatio;
            }
            if(_loc2_ < _loc6_.x + (_loc7_.width - _loc8_.x) * this.sizeRatio)
            {
               _loc2_ = _loc6_.x + (_loc7_.width - _loc8_.x) * this.sizeRatio;
            }
            if(_loc3_ > _loc6_.y - _loc8_.y * this.sizeRatio)
            {
               _loc3_ = _loc6_.y - _loc8_.y * this.sizeRatio;
            }
            switch(this._itemHoldersNames[_loc9_])
            {
               case "torso":
               case "leg1":
               case "leg2":
                  if(_loc4_ < _loc6_.y + (_loc7_.height - _loc8_.y) * this.sizeRatio)
                  {
                     _loc4_ = _loc6_.y + (_loc7_.height - _loc8_.y) * this.sizeRatio;
                  }
            }
         }
         this.mechSizer.graphics.clear();
         this.mechSizer.graphics.beginFill(0,0);
         this.mechSizer.graphics.drawRect(0,0,_loc2_ - _loc1_,_loc4_ - _loc3_);
         this.mechSizer.x = _loc1_;
         this.mechSizer.y = _loc3_;
      }
      
      public function set centerMech(param1:Boolean) : void
      {
         this._centerMech = param1;
      }
      
      private function centerMechSub() : void
      {
         var _loc4_:MovieClip = null;
         var _loc1_:Number = this.mechSizer.x + this.mechSizer.width / 2;
         var _loc2_:Number = this.mechSizer.y + this.mechSizer.height / 2;
         var _loc3_:int = int(this._itemHolders.length);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = this._itemHolders[_loc5_];
            _loc4_.x -= _loc1_;
            _loc4_.y -= _loc2_;
            _loc5_++;
         }
         this.mechSizer.x -= _loc1_;
         this.mechSizer.y -= _loc2_;
         this._itemsOriginPoints["torso"] = new Point(this.torso.x,this.torso.y);
         this._itemsOriginPoints["leg1"] = new Point(this.leg1.x,this.leg1.y);
         this._itemsOriginPoints["leg2"] = new Point(this.leg2.x,this.leg2.y);
         if(this.useLegsShadow)
         {
            this._itemsOriginPoints["leg1Shadow"] = new Point(this.leg1Shadow.x,this.leg1Shadow.y);
            this._itemsOriginPoints["leg2Shadow"] = new Point(this.leg2Shadow.x,this.leg2Shadow.y);
         }
         this._itemsOriginPoints["sideWeapon1"] = new Point(this.sideWeapon1.x,this.sideWeapon1.y);
         this._itemsOriginPoints["sideWeapon2"] = new Point(this.sideWeapon2.x,this.sideWeapon2.y);
         this._itemsOriginPoints["sideWeapon3"] = new Point(this.sideWeapon3.x,this.sideWeapon3.y);
         this._itemsOriginPoints["sideWeapon4"] = new Point(this.sideWeapon4.x,this.sideWeapon4.y);
         this._itemsOriginPoints["topWeapon1"] = new Point(this.topWeapon1.x,this.topWeapon1.y);
         this._itemsOriginPoints["topWeapon2"] = new Point(this.topWeapon2.x,this.topWeapon2.y);
         this._itemsOriginPoints["drone"] = new Point(this.drone.x,this.drone.y);
      }
      
      public function setWalkingParameters(param1:Number, param2:Number, param3:Function, param4:Number = 3) : void
      {
         this._legXDistance = param1;
         this._legXPerFrame = this._legXDistance / param2 * 2;
         this._legYPerFrame = param4;
         this._walkingDirtFunction = param3;
      }
      
      public function walkForward(param1:Number, param2:Boolean, param3:Function) : void
      {
         this.pauseBreathingAndRemoveTeasers(false);
         if(param2)
         {
            this._lastGeneralSpeedRatio = dataM.generalSpeedRatio;
         }
         else
         {
            this._lastGeneralSpeedRatio = 1;
         }
         this._steps = param1;
         this._walkingEndedReturnFunction = param3;
         this._walkingUseSound = param2;
         this._leg2MotionStatus = "backwards";
         this._leg1MotionStatus = "upFront";
         this._walkingForwardHandler = true;
         this.addActiveAnimation("walkingForward");
      }
      
      public function mechIsLimping() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this._limpEffect)
         {
            switch(this._leg1MotionStatus)
            {
               case "upFront":
               case "downFront":
               case "upBack":
               case "downBack":
                  _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public function activateLimping() : void
      {
         this._limpEffect = true;
      }
      
      public function deactivateLimping() : void
      {
         this._limpEffect = false;
      }
      
      private function walkingForwardHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._walkingForwardHandler)
         {
            _loc1_ = this._legXPerFrame * this._lastGeneralSpeedRatio;
            _loc2_ = this._legYPerFrame * this._lastGeneralSpeedRatio;
            switch(this._leg1MotionStatus)
            {
               case "upFront":
                  if(this._limpEffect)
                  {
                     this.leg1.x += _loc1_ * 0.5;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x += _loc1_ * 0.5;
                     }
                  }
                  else
                  {
                     this.leg1.x += _loc1_;
                     this.leg1.y -= _loc2_;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x += _loc1_;
                        this.leg1Shadow.y += _loc2_;
                     }
                  }
                  if(this.leg1.x >= this._itemsOriginPoints["leg1"].x + this._legXDistance / 2)
                  {
                     this._leg1MotionStatus = "downFront";
                  }
                  break;
               case "downFront":
                  if(this._limpEffect)
                  {
                     this.leg1.x += _loc1_ * 0.5;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x += _loc1_ * 0.5;
                     }
                  }
                  else
                  {
                     this.leg1.x += _loc1_;
                     this.leg1.y += _loc2_;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x += _loc1_;
                        this.leg1Shadow.y -= _loc2_;
                     }
                  }
                  if(this.leg1.x >= this._itemsOriginPoints["leg1"].x + this._legXDistance)
                  {
                     this.leg1.y = this._itemsOriginPoints["leg1"].y;
                     this._leg1MotionStatus = "backwards";
                     if(this._limpEffect == false)
                     {
                        this.activateBumpAnimation(false);
                        if(this._walkingUseSound)
                        {
                           soundM.createSound("footStep",1);
                        }
                     }
                     if(this._walkingDirtFunction != null)
                     {
                        this._walkingDirtFunction();
                     }
                  }
                  break;
               case "backwards":
                  this.leg1.x -= _loc1_;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x -= _loc1_;
                  }
                  if(this.leg1.x <= this._itemsOriginPoints["leg1"].x)
                  {
                     this._leg1MotionStatus = "stop";
                  }
                  break;
               case "stop":
                  this.leg1.x = this._itemsOriginPoints["leg1"].x;
                  this.leg1.y = this._itemsOriginPoints["leg1"].y;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x = this._itemsOriginPoints["leg1Shadow"].x;
                     this.leg1Shadow.y = this._itemsOriginPoints["leg1Shadow"].y;
                  }
            }
            switch(this._leg2MotionStatus)
            {
               case "backwards":
                  if(this._limpEffect)
                  {
                     this.leg2.x -= _loc1_ * 0.5;
                     if(this.useLegsShadow)
                     {
                        this.leg2Shadow.x -= _loc1_ * 0.5;
                     }
                  }
                  else
                  {
                     this.leg2.x -= _loc1_;
                     if(this.useLegsShadow)
                     {
                        this.leg2Shadow.x -= _loc1_;
                     }
                  }
                  if(this.leg2.x <= this._itemsOriginPoints["leg2"].x - this._legXDistance)
                  {
                     this._leg2MotionStatus = "upFront";
                  }
                  break;
               case "upFront":
                  this.leg2.x += _loc1_;
                  this.leg2.y -= _loc2_;
                  if(this.useLegsShadow)
                  {
                     this.leg2Shadow.x += _loc1_;
                     this.leg2Shadow.y += _loc2_;
                  }
                  if(this.leg2.x >= this._itemsOriginPoints["leg2"].x - this._legXDistance / 2)
                  {
                     this._leg2MotionStatus = "downFront";
                  }
                  break;
               case "downFront":
                  this.leg2.x += _loc1_;
                  this.leg2.y += _loc2_;
                  if(this.useLegsShadow)
                  {
                     this.leg2Shadow.x += _loc1_;
                     this.leg2Shadow.y -= _loc2_;
                  }
                  if(this.leg2.x >= this._itemsOriginPoints["leg2"].x)
                  {
                     this.leg2.y = this._itemsOriginPoints["leg2"].y;
                     this._leg2MotionStatus = "stop";
                     this.activateBumpAnimation(false);
                     if(this._walkingUseSound)
                     {
                        soundM.createSound("footStep",1);
                     }
                     if(this._walkingDirtFunction != null)
                     {
                        this._walkingDirtFunction();
                     }
                  }
                  break;
               case "stop":
                  this.leg2.x = this._itemsOriginPoints["leg2"].x;
                  this.leg2.y = this._itemsOriginPoints["leg2"].y;
                  if(this.useLegsShadow)
                  {
                     this.leg2Shadow.x = this._itemsOriginPoints["leg2Shadow"].x;
                     this.leg2Shadow.y = this._itemsOriginPoints["leg2Shadow"].y;
                  }
                  this.leg1.x = this._itemsOriginPoints["leg1"].x;
                  this.leg1.y = this._itemsOriginPoints["leg1"].y;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x = this._itemsOriginPoints["leg1Shadow"].x;
                     this.leg1Shadow.y = this._itemsOriginPoints["leg1Shadow"].y;
                  }
                  --this._steps;
                  if(this._steps > 0)
                  {
                     this._leg1MotionStatus = "upFront";
                     this._leg2MotionStatus = "backwards";
                  }
                  else
                  {
                     this._walkingForwardHandler = false;
                     this.removeActiveAnimation("walkingForward",true);
                     this.resumeBreathing();
                     if(this._walkingEndedReturnFunction != null)
                     {
                        this._walkingEndedReturnFunction();
                     }
                  }
            }
         }
      }
      
      public function walkBackwards(param1:Number, param2:Boolean, param3:Function) : void
      {
         this.pauseBreathingAndRemoveTeasers(false);
         this._lastGeneralSpeedRatio = dataM.generalSpeedRatio;
         this._steps = param1;
         this._walkingEndedReturnFunction = param3;
         this._walkingUseSound = param2;
         this._leg2MotionStatus = "upBack";
         this._leg1MotionStatus = "forward";
         this._walkingBackwardsHandler = true;
         this.addActiveAnimation("walkingBackwards");
      }
      
      private function walkingBackwardsHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._walkingBackwardsHandler)
         {
            _loc1_ = this._legXPerFrame * this._lastGeneralSpeedRatio;
            _loc2_ = this._legYPerFrame * this._lastGeneralSpeedRatio;
            switch(this._leg1MotionStatus)
            {
               case "forward":
                  this.leg1.x += _loc1_;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x += _loc1_;
                  }
                  if(this.leg1.x >= this._itemsOriginPoints["leg1"].x + this._legXDistance)
                  {
                     this._leg1MotionStatus = "upBack";
                  }
                  break;
               case "upBack":
                  if(this._limpEffect)
                  {
                     this.leg1.x -= _loc1_ * 0.5;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x -= _loc1_ * 0.5;
                     }
                  }
                  else
                  {
                     this.leg1.x -= _loc1_;
                     this.leg1.y -= _loc2_;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x -= _loc1_;
                        this.leg1Shadow.y += _loc2_;
                     }
                  }
                  if(this.leg1.x <= this._itemsOriginPoints["leg1"].x + this._legXDistance / 2)
                  {
                     this._leg1MotionStatus = "downBack";
                  }
                  break;
               case "downBack":
                  if(this._limpEffect)
                  {
                     this.leg1.x -= _loc1_ * 0.5;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x -= _loc1_ * 0.5;
                     }
                  }
                  else
                  {
                     this.leg1.x -= _loc1_;
                     this.leg1.y += _loc2_;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x -= _loc1_;
                        this.leg1Shadow.y -= _loc2_;
                     }
                  }
                  if(this.leg1.x <= this._itemsOriginPoints["leg1"].x)
                  {
                     this.leg1.y = this._itemsOriginPoints["leg1"].y;
                     this._leg1MotionStatus = "stop";
                     if(this._limpEffect == false)
                     {
                        this.activateBumpAnimation(false);
                        if(this._walkingUseSound)
                        {
                           soundM.createSound("footStep",1);
                        }
                     }
                     if(this._walkingDirtFunction != null)
                     {
                        this._walkingDirtFunction();
                     }
                  }
                  break;
               case "stop":
                  this.leg1.x = this._itemsOriginPoints["leg1"].x;
                  this.leg1.y = this._itemsOriginPoints["leg1"].y;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x = this._itemsOriginPoints["leg1Shadow"].x;
                     this.leg1Shadow.y = this._itemsOriginPoints["leg1Shadow"].y;
                  }
            }
            switch(this._leg2MotionStatus)
            {
               case "upBack":
                  this.leg2.x -= _loc1_;
                  this.leg2.y -= _loc2_;
                  if(this.useLegsShadow)
                  {
                     this.leg2Shadow.x -= _loc1_;
                     this.leg2Shadow.y += _loc2_;
                  }
                  if(this.leg2.x <= this._itemsOriginPoints["leg2"].x - this._legXDistance / 2)
                  {
                     this._leg2MotionStatus = "downBack";
                  }
                  break;
               case "downBack":
                  this.leg2.x -= _loc1_;
                  this.leg2.y += _loc2_;
                  if(this.useLegsShadow)
                  {
                     this.leg2Shadow.x -= _loc1_;
                     this.leg2Shadow.y -= _loc2_;
                  }
                  if(this.leg2.x <= this._itemsOriginPoints["leg2"].x - this._legXDistance)
                  {
                     this.leg2.y = this._itemsOriginPoints["leg2"].y;
                     this._leg2MotionStatus = "forward";
                     this.activateBumpAnimation(false);
                     if(this._walkingUseSound)
                     {
                        soundM.createSound("footStep",1);
                     }
                     if(this._walkingDirtFunction != null)
                     {
                        this._walkingDirtFunction();
                     }
                  }
                  break;
               case "forward":
                  if(this._limpEffect)
                  {
                     this.leg2.x += _loc1_ * 0.5;
                     if(this.useLegsShadow)
                     {
                        this.leg2Shadow.x += _loc1_ * 0.5;
                     }
                  }
                  else
                  {
                     this.leg2.x += _loc1_;
                     if(this.useLegsShadow)
                     {
                        this.leg2Shadow.x += _loc1_;
                     }
                  }
                  if(this.leg2.x >= this._itemsOriginPoints["leg2"].x)
                  {
                     this._leg2MotionStatus = "stop";
                  }
                  break;
               case "stop":
                  this.leg2.x = this._itemsOriginPoints["leg2"].x;
                  this.leg2.y = this._itemsOriginPoints["leg2"].y;
                  if(this.useLegsShadow)
                  {
                     this.leg2Shadow.x = this._itemsOriginPoints["leg2Shadow"].x;
                     this.leg2Shadow.y = this._itemsOriginPoints["leg2Shadow"].y;
                  }
                  this.leg1.x = this._itemsOriginPoints["leg1"].x;
                  this.leg1.y = this._itemsOriginPoints["leg1"].y;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x = this._itemsOriginPoints["leg1Shadow"].x;
                     this.leg1Shadow.y = this._itemsOriginPoints["leg1Shadow"].y;
                  }
                  --this._steps;
                  if(this._steps > 0)
                  {
                     this._leg1MotionStatus = "forward";
                     this._leg2MotionStatus = "upBack";
                  }
                  else
                  {
                     this._walkingBackwardsHandler = false;
                     this.removeActiveAnimation("walkingBackwards",true);
                     this.resumeBreathing();
                     if(this._walkingEndedReturnFunction != null)
                     {
                        this._walkingEndedReturnFunction();
                     }
                  }
            }
         }
      }
      
      public function activateBumpAnimation(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         if(this._bumpHeight > 0)
         {
            this._bumpMultiplier = 1;
            this._bumpFrameCounter = 0;
            this._bumpResumBreathing = param1;
            _loc2_ = 0;
            while(_loc2_ < this._bumpItems.length)
            {
               _loc3_ = this[this._bumpItems[_loc2_]];
               if(_loc3_.item != null)
               {
                  _loc3_.y = this._itemsOriginPoints[this._bumpItems[_loc2_]].y + this._bumpHeight * this._bumpMultiplier;
               }
               _loc2_++;
            }
            this._bumpAnimationHandler = true;
            this.addActiveAnimation("bumpAnimation");
         }
      }
      
      private function bumpAnimationHandler() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:uint = 0;
         if(this._bumpAnimationHandler)
         {
            ++this._bumpFrameCounter;
            if(this._bumpFrameCounter <= this._bumpFrames)
            {
               _loc2_ = 0;
               while(_loc2_ < this._bumpItems.length)
               {
                  _loc1_ = this[this._bumpItems[_loc2_]];
                  if(_loc1_.item != null)
                  {
                     _loc1_.y -= this._bumpHeight / this._bumpFrames * this._bumpMultiplier;
                  }
                  _loc2_++;
               }
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < this._bumpItems.length)
               {
                  _loc1_ = this[this._bumpItems[_loc2_]];
                  if(_loc1_.item != null)
                  {
                     _loc1_.y = this._itemsOriginPoints[this._bumpItems[_loc2_]].y;
                  }
                  _loc2_++;
               }
               this._bumpAnimationHandler = false;
               this.removeActiveAnimation("bumpAnimation",true);
               if(this._bumpResumBreathing)
               {
                  this.resumeBreathing();
               }
            }
         }
      }
      
      public function setBumpParameters(param1:Number, param2:Number) : void
      {
         this._bumpParametersSet = true;
         this._bumpHeight = param1;
         this._bumpFrames = param2;
      }
      
      public function activateGetHitAnimation(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:MovieClip = null;
         if(this._getPushedAnimationHandler == false)
         {
            if(this._getHitDistance > 0)
            {
               this.pauseBreathingAndRemoveTeasers(this.shutDownActive);
               this._getHitMultiplier = 1;
               this._getHitFrameCounter = 0;
               this._getHitXAxisFront = param1;
               this._getHitXAxisBack = param2;
               this._getHitYAxis = param3;
               _loc4_ = 0;
               while(_loc4_ < this._getHitItems.length)
               {
                  _loc5_ = this[this._getHitItems[_loc4_]];
                  if(_loc5_.item != null)
                  {
                     if(this._getHitXAxisFront)
                     {
                        _loc5_.x = this._itemsOriginPoints[this._getHitItems[_loc4_]].x - this._getHitDistance * this._getHitMultiplier;
                     }
                     else if(this._getHitXAxisBack)
                     {
                        _loc5_.x = this._itemsOriginPoints[this._getHitItems[_loc4_]].x + this._getHitDistance * this._getHitMultiplier;
                     }
                     if(this._getHitYAxis)
                     {
                        _loc5_.y = this._itemsOriginPoints[this._getHitItems[_loc4_]].y + this._getHitDistance * this._getHitMultiplier;
                     }
                  }
                  _loc4_++;
               }
               this._getHitAnimationHandler = true;
               this.addActiveAnimation("getHitAnimation");
            }
         }
      }
      
      private function getHitAnimationHandler() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:uint = 0;
         if(this._getHitAnimationHandler)
         {
            ++this._getHitFrameCounter;
            if(this._getHitFrameCounter <= this._getHitFrames)
            {
               _loc2_ = 0;
               while(_loc2_ < this._getHitItems.length)
               {
                  _loc1_ = this[this._getHitItems[_loc2_]];
                  if(_loc1_.item != null)
                  {
                     if(this._getHitXAxisFront)
                     {
                        _loc1_.x += this._getHitDistance / this._getHitFrames * this._getHitMultiplier;
                     }
                     else if(this._getHitXAxisBack)
                     {
                        _loc1_.x -= this._getHitDistance / this._getHitFrames * this._getHitMultiplier;
                     }
                     if(this._getHitYAxis)
                     {
                        _loc1_.y -= this._getHitDistance / this._getHitFrames * this._getHitMultiplier;
                     }
                  }
                  _loc2_++;
               }
            }
            else if(this._getHitFrameCounter == this._getHitFrames + 1)
            {
               _loc2_ = 0;
               while(_loc2_ < this._getHitItems.length)
               {
                  _loc1_ = this[this._getHitItems[_loc2_]];
                  if(_loc1_.item != null)
                  {
                     if(this._getHitXAxisFront || this._getHitXAxisBack)
                     {
                        _loc1_.x = this._itemsOriginPoints[this._getHitItems[_loc2_]].x;
                     }
                     if(this._getHitYAxis)
                     {
                        _loc1_.y = this._itemsOriginPoints[this._getHitItems[_loc2_]].y;
                     }
                  }
                  _loc2_++;
               }
            }
            else if(this._getHitFrameCounter == this._getHitFrames + 3)
            {
               this._getHitAnimationHandler = false;
               this.removeActiveAnimation("getHitAnimation",true);
               if(this._defeatedHandler == false)
               {
                  this.resumeBreathing();
               }
            }
         }
      }
      
      public function setGetHitParameters(param1:Number, param2:Number) : void
      {
         this._getHitDistance = param1;
         this._getHitFrames = param2;
      }
      
      public function activateGetPushedAnimation(param1:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:MovieClip = null;
         if(this._getHitAnimationHandler)
         {
            this._getHitAnimationHandler = false;
            this.removeActiveAnimation("getHitAnimation",true);
         }
         this.pauseBreathingAndRemoveTeasers(this.shutDownActive);
         this._getPushedFrameCounter = 0;
         this._getPushedFrames = 20;
         this._getPushedFromBack = param1;
         if(dataM.slowCPUMode)
         {
            this._getPushedFrames = 10;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this._getHitItems.length)
         {
            _loc3_ = this._getHitItems[_loc2_];
            _loc4_ = this[_loc3_];
            if(_loc4_.item != null)
            {
               if(this._getPushedFromBack)
               {
                  if(_loc3_ == "torso")
                  {
                     _loc4_.x = this._itemsOriginPoints[this._getHitItems[_loc2_]].x + this.GET_PUSHED_DISTANCE_TORSO;
                  }
                  else
                  {
                     _loc4_.x = this._itemsOriginPoints[this._getHitItems[_loc2_]].x - this.GET_PUSHED_DISTANCE_ITEMS;
                  }
               }
               else if(_loc3_ == "torso")
               {
                  _loc4_.x = this._itemsOriginPoints[this._getHitItems[_loc2_]].x - this.GET_PUSHED_DISTANCE_TORSO;
               }
               else
               {
                  _loc4_.x = this._itemsOriginPoints[this._getHitItems[_loc2_]].x + this.GET_PUSHED_DISTANCE_ITEMS;
               }
            }
            _loc2_++;
         }
         this._getPushedAnimationHandler = true;
         this.addActiveAnimation("getPushedAnimation");
      }
      
      private function getPushedAnimationHandler() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         if(this._getPushedAnimationHandler)
         {
            ++this._getPushedFrameCounter;
            if(this._getPushedFrameCounter < this._getPushedFrames)
            {
               _loc2_ = 0;
               while(_loc2_ < this._getHitItems.length)
               {
                  _loc3_ = this._getHitItems[_loc2_];
                  _loc1_ = this[_loc3_];
                  if(_loc1_.item != null)
                  {
                     if(this._getPushedFromBack)
                     {
                        if(_loc3_ == "torso")
                        {
                           _loc1_.x -= this.GET_PUSHED_DISTANCE_TORSO / this._getPushedFrames;
                        }
                        else
                        {
                           _loc1_.x += this.GET_PUSHED_DISTANCE_ITEMS / this._getPushedFrames;
                        }
                     }
                     else if(_loc3_ == "torso")
                     {
                        _loc1_.x += this.GET_PUSHED_DISTANCE_TORSO / this._getPushedFrames;
                     }
                     else
                     {
                        _loc1_.x -= this.GET_PUSHED_DISTANCE_ITEMS / this._getPushedFrames;
                     }
                  }
                  _loc2_++;
               }
            }
            else if(this._getPushedFrameCounter == this._getPushedFrames)
            {
               _loc2_ = 0;
               while(_loc2_ < this._getHitItems.length)
               {
                  _loc1_ = this[this._getHitItems[_loc2_]];
                  if(_loc1_.item != null)
                  {
                     _loc1_.x = this._itemsOriginPoints[this._getHitItems[_loc2_]].x;
                  }
                  _loc2_++;
               }
               this._getPushedAnimationHandler = false;
               this.removeActiveAnimation("getPushedAnimation",true);
               this.resumeBreathing();
            }
         }
      }
      
      public function addWeaponFeedback(param1:String, param2:Number, param3:Number, param4:Number) : void
      {
         this.pauseBreathingAndRemoveTeasers(false);
         this._weaponsFeedbackData[param1 + param2] = {
            "equipmentType":param1,
            "equipmentID":param2,
            "xFeedback":param3,
            "yFeedback":param4
         };
      }
      
      private function weaponsFeedbackHandler() : void
      {
         var _loc1_:Object = null;
         var _loc2_:BMItem = null;
         if(this._weaponFeedbackHandler)
         {
            for each(_loc1_ in this._weaponsFeedbackData)
            {
               if(_loc1_ != null)
               {
                  _loc2_ = this[_loc1_.equipmentType + _loc1_.equipmentID].item;
                  if(_loc1_.xFeedback <= 0 && _loc1_.yFeedback <= 0)
                  {
                     _loc2_.x = this._weaponsOriginXYPos[_loc1_.equipmentType + _loc1_.equipmentID].xPos;
                     _loc2_.y = this._weaponsOriginXYPos[_loc1_.equipmentType + _loc1_.equipmentID].yPos;
                     this._weaponsFeedbackData[_loc1_.equipmentType + _loc1_.equipmentID] = null;
                     this.resumeBreathing();
                  }
                  else
                  {
                     _loc2_.x = this._weaponsOriginXYPos[_loc1_.equipmentType + _loc1_.equipmentID].xPos - _loc1_.xFeedback;
                     _loc2_.y = this._weaponsOriginXYPos[_loc1_.equipmentType + _loc1_.equipmentID].yPos - _loc1_.yFeedback;
                     if(_loc1_.xFeedback > 0)
                     {
                        --this._weaponsFeedbackData[_loc1_.equipmentType + _loc1_.equipmentID].xFeedback;
                     }
                     if(_loc1_.yFeedback > 0)
                     {
                        --this._weaponsFeedbackData[_loc1_.equipmentType + _loc1_.equipmentID].yFeedback;
                     }
                  }
               }
            }
         }
      }
      
      private function machineGunBarrelHandler() : void
      {
         var _loc1_:MovieClip = null;
         if(this._machineGunBarrelHandler)
         {
            if(this._machineGunBarrelCountdown > 0)
            {
               --this._machineGunBarrelCountdown;
               if(this._machineGunBarrelCountdown == 0)
               {
                  _loc1_ = this[this._machineGunBarrelItemName];
                  _loc1_.item.itemGrp.mcBarrel.gotoAndStop("animOff");
                  this._machineGunBarrelHandler = false;
               }
            }
         }
      }
      
      public function activateMachineGunBarrel(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         if(this._machineGunBarrelHandler)
         {
            _loc2_ = this[this._machineGunBarrelItemName];
            _loc2_.item.itemGrp.mcBarrel.gotoAndStop("animOff");
         }
         _loc2_ = this[param1];
         if(_loc2_.item.itemGrp.mcBarrel != null)
         {
            _loc2_.item.itemGrp.removeChild(_loc2_.item.itemGrp.mcBarrel);
            _loc2_.item.itemGrp.addChild(_loc2_.item.itemGrp.mcBarrel);
            _loc2_.item.itemGrp.mcBarrel.gotoAndStop("animOn");
            this._machineGunBarrelHandler = true;
            this._machineGunBarrelCountdown = 50;
            this._machineGunBarrelItemName = param1;
         }
      }
      
      public function activateShotgunHandle(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = this[param1];
         if(_loc2_.item.itemGrp.mcHandle != null)
         {
            _loc2_.item.itemGrp.mcHandle.gotoAndPlay("animOn");
         }
      }
      
      public function activateGrenadeLauncher(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         this.pauseBreathingAndRemoveTeasers(false);
         this._grenadeLauncherHandler = true;
         this._grenadeLauncherAngle = -30;
         this._grenadeLauncherItemName = param1;
         _loc2_ = this[this._grenadeLauncherItemName];
         _loc2_.rotation = this._grenadeLauncherAngle;
         this.addActiveAnimation("grenadeLauncher");
      }
      
      private function grenadeLauncherHandler() : void
      {
         var _loc1_:MovieClip = null;
         if(this._grenadeLauncherHandler)
         {
            this._grenadeLauncherAngle += 2;
            if(this._grenadeLauncherAngle >= 0)
            {
               this._grenadeLauncherAngle = 0;
               this._grenadeLauncherHandler = false;
               this.removeActiveAnimation("grenadeLauncher",false);
            }
            _loc1_ = this[this._grenadeLauncherItemName];
            _loc1_.rotation = this._grenadeLauncherAngle;
         }
      }
      
      private function moveTorsoAndAllWeapons(param1:Number, param2:Number) : void
      {
         this.moveSideWeapons(param1,param2);
         this.moveTopWeapons(param1,param2);
         this.torso.x += param1;
         this.torso.y += param2;
      }
      
      private function moveAllWeapons(param1:Number, param2:Number) : void
      {
         this.moveSideWeapons(param1,param2);
         this.moveTopWeapons(param1,param2);
      }
      
      private function moveSideWeapons(param1:Number, param2:Number) : void
      {
         this.sideWeapon1.x += param1;
         this.sideWeapon2.x += param1;
         this.sideWeapon3.x += param1;
         this.sideWeapon4.x += param1;
         this.sideWeapon1.y += param2;
         this.sideWeapon2.y += param2;
         this.sideWeapon3.y += param2;
         this.sideWeapon4.y += param2;
      }
      
      private function moveTopWeapons(param1:Number, param2:Number) : void
      {
         this.topWeapon1.x += param1;
         this.topWeapon2.x += param1;
         this.topWeapon1.y += param2;
         this.topWeapon2.y += param2;
      }
      
      private function rotateSideWeapons(param1:Number) : void
      {
         this.sideWeapon1.rotation += param1;
         this.sideWeapon2.rotation += param1;
         this.sideWeapon3.rotation += param1;
         this.sideWeapon4.rotation += param1;
      }
      
      private function rotateTopWeapons(param1:Number) : void
      {
         this.topWeapon1.rotation += param1;
         this.topWeapon2.rotation += param1;
      }
      
      private function swordHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:MovieClip = null;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(this._swordHandler)
         {
            ++this._swordCounter;
            _loc1_ = true;
            _loc2_ = this["sideWeapon" + this._swordEquipmentID];
            switch(this._swordEquipmentID)
            {
               case 2:
               case 4:
                  _loc1_ = false;
            }
            _loc3_ = [this.topWeapon1,this.topWeapon2];
            _loc4_ = 1;
            while(_loc4_ <= dataM.maxEquipment["sideWeapon"])
            {
               if(_loc4_ != this._swordEquipmentID)
               {
                  _loc3_.push(this["sideWeapon" + _loc4_]);
               }
               _loc4_++;
            }
            if(this._lastSlowCPUMode)
            {
               if(this._swordCounter <= 5)
               {
                  if(_loc1_)
                  {
                     if(this._swordCounter <= 2)
                     {
                        this.leg1.x += 25;
                        this.leg1.y -= 5;
                        if(this.useLegsShadow)
                        {
                           this.leg1Shadow.x += 25;
                           this.leg1Shadow.y += 5;
                        }
                        this.moveTorsoAndAllWeapons(12.5,-5);
                     }
                     else if(this._swordCounter <= 5)
                     {
                        this.leg1.x += 20;
                        this.leg1.y += 4;
                        if(this.useLegsShadow)
                        {
                           this.leg1Shadow.x += 20;
                           this.leg1Shadow.y -= 4;
                        }
                        this.moveTorsoAndAllWeapons(10,4);
                     }
                  }
                  _loc2_.rotation -= 20;
                  if(_loc2_.item.itemGrp.mcLight != null)
                  {
                     if(_loc2_.item.itemGrp.mcLight.alpha < 0.8)
                     {
                        _loc2_.item.itemGrp.mcLight.alpha += 0.2;
                     }
                  }
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_.length)
                  {
                     _loc3_[_loc5_].rotation -= 2;
                     _loc5_++;
                  }
                  this.torso.rotation -= 2;
               }
               else if(this._swordCounter <= 10)
               {
                  _loc2_.rotation += 36;
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_.length)
                  {
                     _loc3_[_loc5_].rotation += 4;
                     _loc5_++;
                  }
                  this.torso.rotation += 4;
                  if(this._swordCounter == 7)
                  {
                     if(this._swordReturnFunction != null)
                     {
                        this._swordReturnFunction();
                     }
                  }
               }
               else if(this._swordCounter <= 20)
               {
                  _loc2_.rotation -= 8;
                  if(this._swordCounter >= 16)
                  {
                     if(_loc2_.item.itemGrp.mcLight != null)
                     {
                        if(_loc2_.item.itemGrp.mcLight.alpha > 0)
                        {
                           _loc2_.item.itemGrp.mcLight.alpha -= 0.2;
                        }
                     }
                  }
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_.length)
                  {
                     --_loc3_[_loc5_].rotation;
                     _loc5_++;
                  }
                  --this.torso.rotation;
               }
               else if(_loc1_)
               {
                  if(this._swordCounter <= 22)
                  {
                     this.leg1.x -= 25;
                     this.leg1.y -= 5;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x -= 25;
                        this.leg1Shadow.y += 5;
                     }
                     this.moveTorsoAndAllWeapons(-12.5,-5);
                  }
                  else if(this._swordCounter <= 25)
                  {
                     this.leg1.x -= 20;
                     this.leg1.y += 4;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x -= 20;
                        this.leg1Shadow.y -= 4;
                     }
                     this.moveTorsoAndAllWeapons(-10,4);
                  }
                  else
                  {
                     this._swordCounter = 0;
                     this._swordHandler = false;
                     this.removeActiveAnimation("sword",true);
                     if(this._swordResumeBreathing)
                     {
                        this.resumeBreathing();
                     }
                  }
               }
               else
               {
                  this._swordCounter = 0;
                  this._swordHandler = false;
                  this.removeActiveAnimation("sword",true);
                  if(this._swordResumeBreathing)
                  {
                     this.resumeBreathing();
                  }
               }
            }
            else if(this._swordCounter <= 10)
            {
               if(_loc1_)
               {
                  if(this._swordCounter <= 5)
                  {
                     this.leg1.x += 10;
                     this.leg1.y -= 2;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x += 10;
                        this.leg1Shadow.y += 2;
                     }
                     this.moveTorsoAndAllWeapons(5,-2);
                  }
                  else if(this._swordCounter <= 10)
                  {
                     this.leg1.x += 10;
                     this.leg1.y += 2;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x += 10;
                        this.leg1Shadow.y -= 2;
                     }
                     this.moveTorsoAndAllWeapons(5,2);
                  }
               }
               _loc2_.rotation -= 10;
               if(_loc2_.item.itemGrp.mcLight != null)
               {
                  if(_loc2_.item.itemGrp.mcLight.alpha < 0.8)
                  {
                     _loc2_.item.itemGrp.mcLight.alpha += 0.1;
                  }
               }
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  --_loc3_[_loc5_].rotation;
                  _loc5_++;
               }
               --this.torso.rotation;
            }
            else if(this._swordCounter <= 20)
            {
               _loc2_.rotation += 18;
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  _loc3_[_loc5_].rotation += 2;
                  _loc5_++;
               }
               this.torso.rotation += 2;
               if(this._swordCounter == 13)
               {
                  if(this._swordReturnFunction != null)
                  {
                     this._swordReturnFunction();
                  }
               }
            }
            else if(this._swordCounter <= 40)
            {
               _loc2_.rotation -= 4;
               if(this._swordCounter >= 32)
               {
                  if(_loc2_.item.itemGrp.mcLight != null)
                  {
                     if(_loc2_.item.itemGrp.mcLight.alpha > 0)
                     {
                        _loc2_.item.itemGrp.mcLight.alpha -= 0.1;
                     }
                  }
               }
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  _loc3_[_loc5_].rotation -= 0.5;
                  _loc5_++;
               }
               this.torso.rotation -= 0.5;
            }
            else if(_loc1_)
            {
               if(this._swordCounter <= 45)
               {
                  this.leg1.x -= 10;
                  this.leg1.y -= 2;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x -= 10;
                     this.leg1Shadow.y += 2;
                  }
                  this.moveTorsoAndAllWeapons(-5,-2);
               }
               else if(this._swordCounter <= 50)
               {
                  this.leg1.x -= 10;
                  this.leg1.y += 2;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x -= 10;
                     this.leg1Shadow.y -= 2;
                  }
                  this.moveTorsoAndAllWeapons(-5,2);
               }
               else
               {
                  this._swordCounter = 0;
                  this._swordHandler = false;
                  this.removeActiveAnimation("sword",true);
                  if(this._swordResumeBreathing)
                  {
                     this.resumeBreathing();
                  }
               }
            }
            else
            {
               this._swordCounter = 0;
               this._swordHandler = false;
               this.removeActiveAnimation("sword",true);
               if(this._swordResumeBreathing)
               {
                  this.resumeBreathing();
               }
            }
         }
      }
      
      public function activateSword(param1:Number, param2:Function, param3:Boolean) : void
      {
         this._lastSlowCPUMode = dataM.slowCPUMode;
         if(this._swordHandler)
         {
            this.resetBreathing_torsoAndWeapons(false);
         }
         this.pauseBreathingAndRemoveTeasers(false);
         this._swordHandler = true;
         this._swordCounter = 0;
         this._swordResumeBreathing = param3;
         this.addActiveAnimation("sword");
         this._swordEquipmentID = param1;
         this._swordReturnFunction = param2;
      }
      
      private function wandHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:MovieClip = null;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(this._wandHandler)
         {
            ++this._wandCounter;
            _loc1_ = true;
            _loc2_ = this["sideWeapon" + this._wandEquipmentID];
            switch(this._wandEquipmentID)
            {
               case 2:
               case 4:
                  _loc1_ = false;
            }
            _loc3_ = [this.topWeapon1,this.topWeapon2];
            _loc4_ = 1;
            while(_loc4_ <= dataM.maxEquipment["sideWeapon"])
            {
               if(_loc4_ != this._wandEquipmentID)
               {
                  _loc3_.push(this["sideWeapon" + _loc4_]);
               }
               _loc4_++;
            }
            if(this._wandCounter <= 10)
            {
               if(_loc1_)
               {
                  if(this._wandCounter <= 5)
                  {
                     this.leg1.x += 10;
                     this.leg1.y -= 2;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x += 10;
                        this.leg1Shadow.y += 2;
                     }
                     this.moveTorsoAndAllWeapons(5,-2);
                  }
                  else if(this._wandCounter <= 10)
                  {
                     this.leg1.x += 10;
                     this.leg1.y += 2;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.x += 10;
                        this.leg1Shadow.y -= 2;
                     }
                     this.moveTorsoAndAllWeapons(5,2);
                  }
               }
               _loc2_.rotation -= 10;
               if(_loc2_.item.itemGrp.mcLight != null)
               {
                  if(_loc2_.item.itemGrp.mcLight.alpha < 0.8)
                  {
                     _loc2_.item.itemGrp.mcLight.alpha += 0.1;
                  }
               }
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  --_loc3_[_loc5_].rotation;
                  _loc5_++;
               }
               --this.torso.rotation;
            }
            else if(this._wandCounter <= 20)
            {
               --this._wandCounter;
            }
            else if(this._wandCounter <= 40)
            {
               _loc2_.rotation -= 4;
               if(this._wandCounter >= 32)
               {
                  if(_loc2_.item.itemGrp.mcLight != null)
                  {
                     if(_loc2_.item.itemGrp.mcLight.alpha > 0)
                     {
                        _loc2_.item.itemGrp.mcLight.alpha -= 0.1;
                     }
                  }
               }
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  _loc3_[_loc5_].rotation -= 0.5;
                  _loc5_++;
               }
               this.torso.rotation -= 0.5;
            }
            else if(_loc1_)
            {
               if(this._wandCounter <= 45)
               {
                  this.leg1.x -= 10;
                  this.leg1.y -= 2;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x -= 10;
                     this.leg1Shadow.y += 2;
                  }
                  this.moveTorsoAndAllWeapons(-5,-2);
               }
               else if(this._wandCounter <= 50)
               {
                  this.leg1.x -= 10;
                  this.leg1.y += 2;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x -= 10;
                     this.leg1Shadow.y -= 2;
                  }
                  this.moveTorsoAndAllWeapons(-5,2);
               }
               else
               {
                  this._wandCounter = 0;
                  this._wandHandler = false;
                  this.removeActiveAnimation("wand",true);
                  if(this._wandResumeBreathing)
                  {
                     this.resumeBreathing();
                  }
               }
            }
            else
            {
               this._wandCounter = 0;
               this._wandHandler = false;
               this.removeActiveAnimation("wand",true);
               if(this._wandResumeBreathing)
               {
                  this.resumeBreathing();
               }
            }
         }
      }
      
      public function activateWand(param1:Number, param2:Function, param3:Boolean) : void
      {
         this._lastSlowCPUMode = dataM.slowCPUMode;
         if(this._wandHandler)
         {
            this.resetBreathing_torsoAndWeapons(false);
         }
         this.pauseBreathingAndRemoveTeasers(false);
         this._wandHandler = true;
         this._wandCounter = 0;
         this._wandResumeBreathing = param3;
         this.addActiveAnimation("wand");
         this._wandEquipmentID = param1;
         this._wandReturnFunction = param2;
      }
      
      private function stompHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc8_:uint = 0;
         if(this._stompHandler)
         {
            ++this._stompCounter;
            _loc1_ = 20;
            _loc2_ = 2;
            _loc3_ = 1;
            _loc4_ = 5;
            _loc5_ = 8;
            _loc6_ = 4;
            if(this._lastSlowCPUMode)
            {
               _loc1_ = 10;
               _loc2_ = 4;
               _loc3_ = 2;
               _loc4_ = 3;
               _loc5_ = 13.33;
               _loc6_ = 6.66;
            }
            if(this._stompAnimationData[this._lastSlowCPUMode] == null)
            {
               this._stompAnimationData[this._lastSlowCPUMode] = new Array();
            }
            _loc7_ = false;
            if(this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter] == null)
            {
               if(this._stompCounter <= _loc1_)
               {
                  this.leg1.y -= _loc2_;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.y += _loc2_;
                  }
                  this.torso.y -= _loc3_;
                  this.moveAllWeapons(0,-_loc3_);
                  this.addStompAnimationData();
               }
               else if(this._stompCounter <= _loc1_ + _loc4_)
               {
                  this.leg1.y += _loc5_;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.y -= _loc5_;
                  }
                  this.torso.y += _loc6_;
                  this.moveAllWeapons(0,_loc6_);
                  this.addStompAnimationData();
               }
               else
               {
                  _loc7_ = true;
               }
            }
            else if(this._stompCounter > _loc1_ + _loc4_)
            {
               _loc7_ = true;
            }
            else
            {
               this.torso.x = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].torso.xPos;
               this.torso.y = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].torso.yPos;
               this.leg1.x = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg1.xPos;
               this.leg1.y = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg1.yPos;
               this.leg2.x = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg2.xPos;
               this.leg2.y = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg2.yPos;
               if(this.useLegsShadow)
               {
                  this.leg1Shadow.x = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg1Shadow.xPos;
                  this.leg1Shadow.y = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg1Shadow.yPos;
                  this.leg2Shadow.x = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg2Shadow.xPos;
                  this.leg2Shadow.y = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg2Shadow.yPos;
               }
               _loc8_ = 1;
               while(_loc8_ <= dataM.maxEquipment["sideWeapon"])
               {
                  this["sideWeapon" + _loc8_].x = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter]["sideWeapon" + _loc8_].xPos;
                  this["sideWeapon" + _loc8_].y = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter]["sideWeapon" + _loc8_].yPos;
                  _loc8_++;
               }
               _loc8_ = 1;
               while(_loc8_ <= dataM.maxEquipment["topWeapon"])
               {
                  this["topWeapon" + _loc8_].x = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter]["topWeapon" + _loc8_].xPos;
                  this["topWeapon" + _loc8_].y = this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter]["topWeapon" + _loc8_].yPos;
                  _loc8_++;
               }
            }
            if(_loc7_)
            {
               this._stompHandler = false;
               this.removeActiveAnimation("stomp",true);
               this.activateBumpAnimation(true);
               if(this._stompReturnFunction != null)
               {
                  this._stompReturnFunction();
               }
            }
         }
      }
      
      private function addStompAnimationData() : void
      {
         var _loc1_:uint = 0;
         this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter] = new Object();
         this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].torso = {
            "xPos":this.torso.x,
            "yPos":this.torso.y
         };
         this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg1 = {
            "xPos":this.leg1.x,
            "yPos":this.leg1.y
         };
         this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg2 = {
            "xPos":this.leg2.x,
            "yPos":this.leg2.y
         };
         if(this.useLegsShadow)
         {
            this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg1Shadow = {
               "xPos":this.leg1Shadow.x,
               "yPos":this.leg1Shadow.y
            };
            this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter].leg2Shadow = {
               "xPos":this.leg2Shadow.x,
               "yPos":this.leg2Shadow.y
            };
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["sideWeapon"])
         {
            this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter]["sideWeapon" + _loc1_] = {
               "xPos":this["sideWeapon" + _loc1_].x,
               "yPos":this["sideWeapon" + _loc1_].y
            };
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["topWeapon"])
         {
            this._stompAnimationData[this._lastSlowCPUMode][this._stompCounter]["topWeapon" + _loc1_] = {
               "xPos":this["topWeapon" + _loc1_].x,
               "yPos":this["topWeapon" + _loc1_].y
            };
            _loc1_++;
         }
      }
      
      public function activateStomp(param1:Function) : void
      {
         if(this._stompHandler == false)
         {
            this._lastSlowCPUMode = dataM.slowCPUMode;
            this.pauseBreathingAndRemoveTeasers(false);
            this._stompReturnFunction = param1;
            this._stompHandler = true;
            this._stompCounter = 0;
            this.addActiveAnimation("stomp");
         }
      }
      
      private function shutDownHandlerHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         if(this._shutDownHandler)
         {
            ++this._shutDownCounter;
            if(this._lastSlowCPUMode)
            {
               switch(this._shutDownStatus)
               {
                  case "activate":
                     if(this._shutDownCounter <= 3)
                     {
                        this.leg1.x = this._itemsOriginPoints["leg1"].x - this._shutDownCounter * 3.33;
                        if(this.useLegsShadow)
                        {
                           this.leg1Shadow.x = this._itemsOriginPoints["leg1Shadow"].x - this._shutDownCounter * 3.33;
                        }
                     }
                     else if(this._shutDownCounter <= 6)
                     {
                        this.leg2.x = this._itemsOriginPoints["leg2"].x + (this._shutDownCounter - 3) * 3.33;
                        if(this.useLegsShadow)
                        {
                           this.leg2Shadow.x = this._itemsOriginPoints["leg2Shadow"].x + (this._shutDownCounter - 3) * 3.33;
                        }
                     }
                     else if(this._shutDownCounter <= 9)
                     {
                        _loc1_ = 0;
                        while(_loc1_ < this._bumpItems.length)
                        {
                           _loc2_ = this[this._bumpItems[_loc1_]];
                           if(_loc2_.item != null)
                           {
                              _loc2_.y = this._itemsOriginPoints[this._bumpItems[_loc1_]].y + (this._shutDownCounter - 6) * 3.33;
                           }
                           _loc1_++;
                        }
                     }
                     else
                     {
                        if(this.torso.item.itemGrp.mcShutdown != null)
                        {
                           this.torso.item.itemGrp.mcShutdown.alpha = 1;
                        }
                        this._shutDownStatus = "shutDownActivationComplete";
                        this._shutDownHandler = false;
                        this.removeActiveAnimation("shutDown",true);
                     }
                     break;
                  case "deactivate":
                     if(this._shutDownCounter <= 3)
                     {
                        this.leg1.x = this._itemsOriginPoints["leg1"].x - (3 - this._shutDownCounter) * 3.33;
                        if(this.useLegsShadow)
                        {
                           this.leg1Shadow.x = this._itemsOriginPoints["leg1Shadow"].x - (3 - this._shutDownCounter) * 3.33;
                        }
                     }
                     else if(this._shutDownCounter <= 6)
                     {
                        this.leg2.x = this._itemsOriginPoints["leg2"].x + (6 - this._shutDownCounter) * 3.33;
                        if(this.useLegsShadow)
                        {
                           this.leg2Shadow.x = this._itemsOriginPoints["leg2Shadow"].x + (6 - this._shutDownCounter) * 3.33;
                        }
                     }
                     else if(this._shutDownCounter <= 9)
                     {
                        _loc1_ = 0;
                        while(_loc1_ < this._bumpItems.length)
                        {
                           _loc2_ = this[this._bumpItems[_loc1_]];
                           if(_loc2_.item != null)
                           {
                              _loc2_.y = this._itemsOriginPoints[this._bumpItems[_loc1_]].y + (9 - this._shutDownCounter) * 3.33;
                           }
                           _loc1_++;
                        }
                     }
                     else
                     {
                        if(this.torso.item.itemGrp.mcShutdown != null)
                        {
                           this.torso.item.itemGrp.mcShutdown.alpha = 0;
                        }
                        this._shutDownHandler = false;
                        this.removeActiveAnimation("shutDown",true);
                        if(this._shutDownReturnFunction != null)
                        {
                           this._shutDownStatus = "";
                           this.resumeBreathing();
                           this._shutDownReturnFunction();
                        }
                     }
               }
            }
            else
            {
               switch(this._shutDownStatus)
               {
                  case "activate":
                     if(this._shutDownCounter <= 5)
                     {
                        this.leg1.x = this._itemsOriginPoints["leg1"].x - this._shutDownCounter * 2;
                        if(this.useLegsShadow)
                        {
                           this.leg1Shadow.x = this._itemsOriginPoints["leg1Shadow"].x - this._shutDownCounter * 2;
                        }
                     }
                     else if(this._shutDownCounter <= 10)
                     {
                        this.leg2.x = this._itemsOriginPoints["leg2"].x + (this._shutDownCounter - 5) * 2;
                        if(this.useLegsShadow)
                        {
                           this.leg2Shadow.x = this._itemsOriginPoints["leg2Shadow"].x + (this._shutDownCounter - 5) * 2;
                        }
                     }
                     else if(this._shutDownCounter <= 15)
                     {
                        _loc1_ = 0;
                        while(_loc1_ < this._bumpItems.length)
                        {
                           _loc2_ = this[this._bumpItems[_loc1_]];
                           if(_loc2_.item != null)
                           {
                              _loc2_.y = this._itemsOriginPoints[this._bumpItems[_loc1_]].y + (this._shutDownCounter - 10) * 2;
                           }
                           _loc1_++;
                        }
                     }
                     else
                     {
                        if(this.torso.item.itemGrp.mcShutdown != null)
                        {
                           this.torso.item.itemGrp.mcShutdown.alpha = 1;
                        }
                        this._shutDownStatus = "shutDownActivationComplete";
                        this._shutDownHandler = false;
                        this.removeActiveAnimation("shutDown",true);
                     }
                     break;
                  case "deactivate":
                     if(this._shutDownCounter <= 5)
                     {
                        this.leg1.x = this._itemsOriginPoints["leg1"].x - (5 - this._shutDownCounter) * 2;
                        if(this.useLegsShadow)
                        {
                           this.leg1Shadow.x = this._itemsOriginPoints["leg1Shadow"].x - (5 - this._shutDownCounter) * 2;
                        }
                     }
                     else if(this._shutDownCounter <= 10)
                     {
                        this.leg2.x = this._itemsOriginPoints["leg2"].x + (10 - this._shutDownCounter) * 2;
                        if(this.useLegsShadow)
                        {
                           this.leg2Shadow.x = this._itemsOriginPoints["leg2Shadow"].x + (10 - this._shutDownCounter) * 2;
                        }
                     }
                     else if(this._shutDownCounter <= 15)
                     {
                        _loc1_ = 0;
                        while(_loc1_ < this._bumpItems.length)
                        {
                           _loc2_ = this[this._bumpItems[_loc1_]];
                           if(_loc2_.item != null)
                           {
                              _loc2_.y = this._itemsOriginPoints[this._bumpItems[_loc1_]].y + (15 - this._shutDownCounter) * 2;
                           }
                           _loc1_++;
                        }
                     }
                     else
                     {
                        if(this.torso.item.itemGrp.mcShutdown != null)
                        {
                           this.torso.item.itemGrp.mcShutdown.alpha = 0;
                        }
                        this._shutDownHandler = false;
                        this.removeActiveAnimation("shutDown",true);
                        if(this._shutDownReturnFunction != null)
                        {
                           this._shutDownStatus = "";
                           this.resumeBreathing();
                           this._shutDownReturnFunction();
                        }
                     }
               }
            }
         }
      }
      
      public function activateShutdown() : void
      {
         if(this.torso != null)
         {
            if(this.torso.item != null)
            {
               if(this.torso.item.itemGrp.mcShutdown != null)
               {
                  this._lastSlowCPUMode = dataM.slowCPUMode;
                  this.pauseBreathingAndRemoveTeasers(false);
                  this.shutDownActive = true;
                  if(this._bumpParametersSet)
                  {
                     this._shutDownHandler = true;
                     this._shutDownCounter = 0;
                     this._shutDownStatus = "activate";
                     this.addActiveAnimation("shutDown");
                  }
               }
            }
         }
      }
      
      public function deactivateShutdown(param1:Function) : void
      {
         if(this.torso != null)
         {
            if(this.torso.item != null)
            {
               if(this.torso.item.itemGrp.mcShutdown != null)
               {
                  this.shutDownActive = false;
                  if(this._bumpParametersSet)
                  {
                     this._shutDownHandler = true;
                     this._shutDownCounter = 0;
                     this._shutDownStatus = "deactivate";
                     this._shutDownReturnFunction = param1;
                     this.addActiveAnimation("shutDown");
                  }
                  else if(this.torso.item.itemGrp.mcShutdown != null)
                  {
                     this.torso.item.itemGrp.mcShutdown.alpha = 0;
                  }
               }
            }
         }
      }
      
      private function crouchBeforeJumpHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         if(this._crouchBeforeJumpHandler)
         {
            if(this._crouchBeforeJumpCounter <= 10 / this._lastGeneralSpeedRatio)
            {
               _loc1_ = 0;
               while(_loc1_ < this._bumpItems.length)
               {
                  _loc2_ = this[this._bumpItems[_loc1_]];
                  if(_loc2_.item != null)
                  {
                     _loc2_.y = this._itemsOriginPoints[this._bumpItems[_loc1_]].y + this._crouchBeforeJumpCounter * 2 * this._lastGeneralSpeedRatio;
                  }
                  _loc1_++;
               }
               this.leg1.scaleY -= 0.01 * this._lastGeneralSpeedRatio;
               this.leg2.scaleY -= 0.01 * this._lastGeneralSpeedRatio;
               this.leg1.y = this._itemsOriginPoints["leg1"].y + this._breathingLegOriginalHeight - this.leg1.height;
               this.leg2.y = this._itemsOriginPoints["leg2"].y + this._breathingLegOriginalHeight - this.leg2.height;
               ++this._crouchBeforeJumpCounter;
            }
            else
            {
               this.resetBreathing_legs(false);
               this._crouchBeforeJumpHandler = false;
               this.removeActiveAnimation("crouchBeforeJump",true);
               this.resetBreathing_torsoAndWeapons(false);
               this._crouchBeforeJumpReturnFunction();
            }
         }
      }
      
      public function activateCrouchBeforeJump(param1:Function) : void
      {
         this._lastGeneralSpeedRatio = dataM.generalSpeedRatio;
         this._crouchBeforeJumpReturnFunction = param1;
         this._crouchBeforeJumpCounter = 0;
         this._crouchBeforeJumpHandler = true;
         this.pauseBreathingAndRemoveTeasers(false);
         this.addActiveAnimation("crouchBeforeJump");
      }
      
      public function activeJumpJetAnimation() : void
      {
         var _loc2_:String = null;
         var _loc1_:BMItem = this.leg1.item;
         if(_loc1_.itemGrp.mcJet != null)
         {
            _loc2_ = "";
            if(dataM.slowCPUMode)
            {
               _loc2_ = "_fast";
            }
            effectsM.createGeneralEffect(_loc1_.itemGrp,"jumpJetAnim" + _loc2_,false,0,0,_loc1_.itemGrp.mcJet.x,_loc1_.itemGrp.mcJet.y,0,null,[]);
            _loc1_ = this.leg2.item;
            effectsM.createGeneralEffect(_loc1_.itemGrp,"jumpJetAnim" + _loc2_,false,0,0,_loc1_.itemGrp.mcJet.x,_loc1_.itemGrp.mcJet.y,0,null,[]);
         }
      }
      
      private function wheelsAnimationHandler() : void
      {
         if(this._wheelsAnimationHandler)
         {
            ++this._wheelsAnimationCounter;
            if(this._wheelsAnimationCounter == 3)
            {
               this.torso.y -= 4;
            }
            else
            {
               this.torso.y += 0.5;
            }
            if(this._wheelsAnimationCounter == 5)
            {
               this.moveSideWeapons(0,-4);
               this.moveTopWeapons(0,-8);
            }
            else
            {
               this.moveSideWeapons(0,0.5);
               this.moveTopWeapons(0,1);
            }
            if(this._wheelsAnimationCounter == 9)
            {
               this.leg1.height = this._breathingLegOriginalHeight;
               this.leg2.height = this._breathingLegOriginalHeight;
               this._wheelsAnimationCounter = 0;
            }
            else
            {
               this.leg1.height -= 0.5;
               this.leg2.height -= 0.5;
            }
            this.leg1.y = this._itemsOriginPoints["leg1"].y + this._breathingLegOriginalHeight - this.leg1.height;
            this.leg2.y = this._itemsOriginPoints["leg2"].y + this._breathingLegOriginalHeight - this.leg2.height;
         }
      }
      
      public function activateWheelsAnimation() : void
      {
         if(this._wheelsAnimationHandler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._wheelsAnimationHandler = true;
            this._wheelsAnimationCounter = 0;
            this.addActiveAnimation("wheels");
         }
      }
      
      public function deactivateWheelsAnimation() : void
      {
         this._wheelsAnimationHandler = false;
         this.removeActiveAnimation("wheels",true);
         this.resumeBreathing();
      }
      
      public function addItemStaticGlowToEntireMech(param1:String) : void
      {
         this.addItemStaticGlow("torso",param1);
         this.addItemStaticGlow("leg1",param1);
         this.addItemStaticGlow("leg2",param1);
         this.addItemStaticGlow("sideWeapon1",param1);
         this.addItemStaticGlow("sideWeapon2",param1);
         this.addItemStaticGlow("sideWeapon3",param1);
         this.addItemStaticGlow("sideWeapon4",param1);
         this.addItemStaticGlow("topWeapon1",param1);
         this.addItemStaticGlow("topWeapon2",param1);
         this.addItemStaticGlow("drone",param1);
      }
      
      public function addItemStaticGlow(param1:String, param2:String) : void
      {
         if(this._itemStaticGlowLock != param1)
         {
            if(param1 == "leg")
            {
               this.addItemStaticGlowSub("leg1",param2);
               this.addItemStaticGlowSub("leg2",param2);
            }
            else
            {
               this.addItemStaticGlowSub(param1,param2);
            }
         }
      }
      
      private function addItemStaticGlowSub(param1:String, param2:String) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Color = null;
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         _loc3_ = this[param1];
         if(_loc3_ != null)
         {
            _loc4_ = new Color();
            _loc6_ = 0.4;
            switch(param2)
            {
               case "lightGreen":
                  _loc5_ = 13434828;
                  break;
               case "strongGreen":
                  _loc5_ = 65280;
                  _loc6_ = 0.35;
                  break;
               case "black":
                  _loc5_ = 0;
                  _loc6_ = 0.65;
            }
            _loc4_.setTint(_loc5_,_loc6_);
            _loc3_.transform.colorTransform = _loc4_;
         }
      }
      
      public function removeAllItemsStaticGlow() : void
      {
         this.removeItemStaticGlow("torso");
         this.removeItemStaticGlow("leg1");
         this.removeItemStaticGlow("leg2");
         this.removeItemStaticGlow("sideWeapon1");
         this.removeItemStaticGlow("sideWeapon2");
         this.removeItemStaticGlow("sideWeapon3");
         this.removeItemStaticGlow("sideWeapon4");
         this.removeItemStaticGlow("topWeapon1");
         this.removeItemStaticGlow("topWeapon2");
         this.removeItemStaticGlow("drone");
      }
      
      public function removeItemStaticGlow(param1:String) : void
      {
         if(this._itemStaticGlowLock != param1)
         {
            if(param1 == "leg")
            {
               this.removeItemStaticGlowSub("leg1");
               this.removeItemStaticGlowSub("leg2");
            }
            else
            {
               this.removeItemStaticGlowSub(param1);
            }
         }
      }
      
      private function removeItemStaticGlowSub(param1:String) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = this[param1];
         if(_loc2_ != null)
         {
            _loc2_.transform.colorTransform = new ColorTransform();
         }
      }
      
      public function addItemStaticGlowLock(param1:String) : void
      {
         this._itemStaticGlowLock = param1;
      }
      
      public function removeItemStaticGlowLock() : void
      {
         var _loc1_:String = null;
         if(this._itemStaticGlowLock != "")
         {
            _loc1_ = this._itemStaticGlowLock;
            this._itemStaticGlowLock = "";
            this.removeItemStaticGlow(_loc1_);
         }
      }
      
      public function launchHarpoon(param1:String, param2:Number, param3:Number, param4:String, param5:BMMechBattleData, param6:Function, param7:Function) : void
      {
         this._lastSlowCPUMode = dataM.slowCPUMode;
         this.pauseBreathingAndRemoveTeasers(false);
         this._harpoonType = param1;
         this._harpoonFlyDistance = param2;
         this._harpoonPullDistance = param3;
         this._harpoonPullDirection = param4;
         this._harpoonOpponentMechBattleData = param5;
         this._harpoonReachedTargetFunction = param6;
         this._harpoonAnimationEndedFunction = param7;
         this._harpoonStatus = "showHarpoon";
         this._harpoonCounter = 0;
         this._harpoonHandler = true;
         this.harpoon.visible = true;
         this.addActiveAnimation("harpoon");
      }
      
      private function harpoonHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._harpoonHandler)
         {
            _loc1_ = this.HARPOON_FLYING_SPEED;
            _loc2_ = this.HARPOON_PULLING_SPEED;
            if(this._lastSlowCPUMode)
            {
               _loc1_ *= 1.5;
               _loc2_ *= 1.5;
            }
            switch(this._harpoonStatus)
            {
               case "showHarpoon":
                  this.sideWeapon2.scaleX -= this.WEAPONS_X_SCALE_CHANGE;
                  this.sideWeapon4.scaleX -= this.WEAPONS_X_SCALE_CHANGE;
                  this.harpoon.scaleX += this.HARPOON_X_SCALE_CHANGE;
                  if(this.harpoon.scaleX >= 1)
                  {
                     this.harpoon.scaleX = 1;
                     this._harpoonStatus = "flyingToOpponent";
                     this.harpoon.harpoonMC.harpoonEdge.mcClosed.visible = false;
                     this.harpoon.harpoonMC.harpoonEdge.mcOpened.visible = true;
                     soundM.createSound("fireBullet1",1);
                  }
                  break;
               case "flyingToOpponent":
                  this.harpoon.harpoonMC.harpoonEdge.x += _loc1_;
                  this.harpoon.harpoonMC.harpoonRope.width += _loc1_;
                  if(this.harpoon.harpoonMC.harpoonEdge.x - this._harpoonEdgeXStart >= this._harpoonFlyDistance)
                  {
                     this.harpoon.harpoonMC.harpoonEdge.x = this._harpoonEdgeXStart + this._harpoonFlyDistance;
                     this.harpoon.harpoonMC.harpoonRope.width = this._harpoonFlyDistance;
                     this._harpoonStatus = "waiting";
                     this._harpoonReachedTargetFunction();
                     this.harpoon.harpoonMC.harpoonEdge.mcClosed.visible = true;
                     this.harpoon.harpoonMC.harpoonEdge.mcOpened.visible = false;
                  }
                  break;
               case "waiting":
                  ++this._harpoonCounter;
                  switch(this._harpoonType)
                  {
                     case "regular":
                        if(this._harpoonCounter > this.HARPOON_REACHED_TARGET_WAITING_FRAMES_REGULAR)
                        {
                           this._harpoonStatus = "pulling";
                        }
                        break;
                     case "finish":
                        if(this._harpoonCounter > this.HARPOON_REACHED_TARGET_WAITING_FRAMES_FINISH)
                        {
                           this._harpoonStatus = "pulling";
                        }
                  }
                  break;
               case "pulling":
                  this.harpoon.harpoonMC.harpoonEdge.x -= _loc2_;
                  this.harpoon.harpoonMC.harpoonRope.width -= _loc2_;
                  _loc3_ = 1;
                  if(this._harpoonPullDirection == "right")
                  {
                     _loc3_ = -1;
                  }
                  if(this._harpoonType == "regular")
                  {
                     this._harpoonOpponentMechBattleData.mechView.x -= _loc3_ * _loc2_;
                  }
                  if(this.harpoon.harpoonMC.harpoonEdge.x <= this._harpoonFlyDistance - this._harpoonPullDistance - this._harpoonEdgeXStart)
                  {
                     this.harpoon.harpoonMC.harpoonEdge.x = this._harpoonFlyDistance - this._harpoonPullDistance - this._harpoonEdgeXStart;
                     this.harpoon.harpoonMC.harpoonRope.width = this._harpoonFlyDistance - this._harpoonPullDistance - this._harpoonEdgeXStart - this._harpoonRopeXStart;
                     this._harpoonStatus = "pullingWithoutMech";
                     this.harpoon.harpoonMC.harpoonEdge.mcClosed.visible = false;
                     this.harpoon.harpoonMC.harpoonEdge.mcOpened.visible = true;
                  }
                  break;
               case "pullingWithoutMech":
                  this.harpoon.harpoonMC.harpoonEdge.x -= _loc2_;
                  this.harpoon.harpoonMC.harpoonRope.width -= _loc2_;
                  if(this.harpoon.harpoonMC.harpoonEdge.x <= this._harpoonEdgeXStart)
                  {
                     this.harpoon.harpoonMC.harpoonEdge.x = this._harpoonEdgeXStart;
                     this.harpoon.harpoonMC.harpoonRope.width = 1;
                     this._harpoonStatus = "hideHarpoon";
                     this.harpoon.harpoonMC.harpoonEdge.mcClosed.visible = true;
                     this.harpoon.harpoonMC.harpoonEdge.mcOpened.visible = false;
                  }
                  break;
               case "hideHarpoon":
                  this.sideWeapon2.scaleX += this.WEAPONS_X_SCALE_CHANGE;
                  this.sideWeapon4.scaleX += this.WEAPONS_X_SCALE_CHANGE;
                  this.harpoon.scaleX -= this.HARPOON_X_SCALE_CHANGE;
                  if(this.harpoon.scaleX <= this.HARPOON_X_SCALE_MIN)
                  {
                     this.sideWeapon2.scaleX = 1;
                     this.sideWeapon4.scaleX = 1;
                     this.harpoon.scaleX = this.HARPOON_X_SCALE_MIN;
                     this._harpoonHandler = false;
                     this.removeActiveAnimation("harpoon",true);
                     if(this._harpoonType == "regular")
                     {
                        this._harpoonAnimationEndedFunction();
                     }
                     this.resumeBreathing();
                     this.harpoon.visible = false;
                  }
            }
         }
      }
      
      public function showCenterPosition() : void
      {
         this.centerPosition = new Sprite();
         this.centerPosition.graphics.lineStyle(1,0,0);
         this.centerPosition.graphics.moveTo(0,this.mechSizer.height + this.mechSizer.y);
         this.centerPosition.graphics.lineTo(0,this.mechSizer.height + this.mechSizer.y + 20);
         addChild(this.centerPosition);
      }
      
      private function tease1Handler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._tease1Handler)
         {
            ++this._tease1Counter;
            _loc1_ = this._tease1Counter;
            _loc2_ = 2;
            _loc3_ = 0.6;
            if(_loc1_ <= 7)
            {
               this.torso.y += _loc2_;
               this.moveAllWeapons(0,_loc3_);
               --this.leg1.x;
               this.leg2.x += 1;
               if(this.useLegsShadow)
               {
                  --this.leg1Shadow.x;
                  this.leg2Shadow.x += 1;
               }
               if(_loc1_ >= 5)
               {
                  this.sideWeapon1.x -= 3;
                  this.sideWeapon3.x -= 3;
                  this.sideWeapon2.x += 3;
                  this.sideWeapon4.x += 3;
               }
            }
            else if(_loc1_ <= 24)
            {
               if(_loc1_ == 8 || _loc1_ == 24)
               {
                  this.torso.x += 3;
               }
               if(_loc1_ >= 12 && _loc1_ <= 14 || _loc1_ >= 18 && _loc1_ <= 20)
               {
                  this.torso.x += 2;
               }
               if(_loc1_ >= 9 && _loc1_ <= 11 || _loc1_ >= 15 && _loc1_ <= 17 || _loc1_ >= 21 && _loc1_ <= 23)
               {
                  this.torso.x -= 2;
               }
            }
            else if(_loc1_ <= 31)
            {
               this.torso.y -= _loc2_;
               this.moveAllWeapons(0,-_loc3_);
               this.leg1.x += 1;
               --this.leg2.x;
               if(this.useLegsShadow)
               {
                  this.leg1Shadow.x += 1;
                  --this.leg2Shadow.x;
               }
               if(_loc1_ <= 27)
               {
                  this.sideWeapon1.x += 3;
                  this.sideWeapon3.x += 3;
                  this.sideWeapon2.x -= 3;
                  this.sideWeapon4.x -= 3;
               }
            }
            else
            {
               this._tease1Handler = false;
               this.removeActiveAnimation("tease1",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease1(param1:Function) : void
      {
         if(this._tease1Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease1Handler = true;
            this._tease1Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease1");
         }
      }
      
      private function tease2Handler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._tease2Handler)
         {
            ++this._tease2Counter;
            _loc1_ = this._tease2Counter;
            _loc2_ = 2;
            _loc3_ = 0.6;
            if(_loc1_ <= 8)
            {
               this.sideWeapon1.rotation -= 10;
               this.sideWeapon3.rotation -= 10;
               this.sideWeapon2.rotation -= 4;
               this.sideWeapon4.rotation -= 4;
               --this.torso.rotation;
               this.rotateTopWeapons(-1);
            }
            else if(_loc1_ <= 25)
            {
               if(_loc1_ >= 8 && _loc1_ <= 10 || _loc1_ >= 14 && _loc1_ <= 16 || _loc1_ >= 20 && _loc1_ <= 22)
               {
                  this.sideWeapon1.y -= 3;
                  this.sideWeapon3.y -= 3;
                  this.sideWeapon2.y -= 2;
                  this.sideWeapon4.y -= 2;
               }
               if(_loc1_ >= 11 && _loc1_ <= 13 || _loc1_ >= 17 && _loc1_ <= 19 || _loc1_ >= 23 && _loc1_ <= 25)
               {
                  this.sideWeapon1.y += 3;
                  this.sideWeapon3.y += 3;
                  this.sideWeapon2.y += 2;
                  this.sideWeapon4.y += 2;
               }
            }
            else if(_loc1_ <= 33)
            {
               this.sideWeapon1.rotation += 10;
               this.sideWeapon3.rotation += 10;
               this.sideWeapon2.rotation += 4;
               this.sideWeapon4.rotation += 4;
               this.torso.rotation += 1;
               this.rotateTopWeapons(1);
            }
            else
            {
               this._tease2Handler = false;
               this.removeActiveAnimation("tease2",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease2(param1:Function) : void
      {
         if(this._tease2Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease2Handler = true;
            this._tease2Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease2");
         }
      }
      
      private function tease3Handler() : void
      {
         var _loc1_:Number = NaN;
         if(this._tease3Handler)
         {
            ++this._tease3Counter;
            _loc1_ = this._tease3Counter;
            if(_loc1_ <= 40)
            {
               if(_loc1_ <= 4)
               {
                  this.rotateSideWeapons(-5);
                  this.rotateTopWeapons(-1);
               }
               else if(_loc1_ >= 37)
               {
                  this.rotateSideWeapons(5);
                  this.rotateTopWeapons(1);
               }
               if(_loc1_ >= 1 && _loc1_ <= 3 || _loc1_ >= 13 && _loc1_ <= 15 || _loc1_ >= 25 && _loc1_ <= 27)
               {
                  this.leg1.y -= 3;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.y += 3;
                  }
                  this.torso.y += 2;
                  this.sideWeapon1.y += 3;
                  this.sideWeapon3.y += 3;
               }
               if(_loc1_ >= 4 && _loc1_ <= 6 || _loc1_ >= 16 && _loc1_ <= 18 || _loc1_ >= 28 && _loc1_ <= 30)
               {
                  this.leg1.y += 3;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.y -= 3;
                  }
                  this.torso.y -= 2;
                  this.sideWeapon1.y -= 3;
                  this.sideWeapon3.y -= 3;
               }
               if(_loc1_ >= 7 && _loc1_ <= 9 || _loc1_ >= 19 && _loc1_ <= 21 || _loc1_ >= 31 && _loc1_ <= 33)
               {
                  this.leg2.y -= 3;
                  if(this.useLegsShadow)
                  {
                     this.leg2Shadow.y += 3;
                  }
                  this.torso.y += 2;
                  this.sideWeapon2.y += 3;
                  this.sideWeapon4.y += 3;
               }
               if(_loc1_ >= 10 && _loc1_ <= 12 || _loc1_ >= 22 && _loc1_ <= 24 || _loc1_ >= 34 && _loc1_ <= 36)
               {
                  this.leg2.y += 3;
                  if(this.useLegsShadow)
                  {
                     this.leg2Shadow.y -= 3;
                  }
                  this.torso.y -= 2;
                  this.sideWeapon2.y -= 3;
                  this.sideWeapon4.y -= 3;
               }
            }
            else
            {
               this._tease3Handler = false;
               this.removeActiveAnimation("tease3",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease3(param1:Function) : void
      {
         if(this._tease3Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease3Handler = true;
            this._tease3Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease3");
         }
      }
      
      private function tease4Handler() : void
      {
         var _loc1_:Number = NaN;
         if(this._tease4Handler)
         {
            ++this._tease4Counter;
            _loc1_ = this._tease4Counter;
            if(_loc1_ <= 36)
            {
               if(_loc1_ <= 6 || _loc1_ >= 19 && _loc1_ <= 24)
               {
                  this.leg1.x += 3;
                  this.leg1.y -= 3;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x += 3;
                     this.leg1Shadow.y += 3;
                  }
                  this.torso.x += 2;
                  this.moveSideWeapons(1.5,0);
                  this.moveTopWeapons(2,0);
               }
               else if(_loc1_ <= 12 || _loc1_ >= 25 && _loc1_ <= 30)
               {
                  this.leg1.x += 3;
                  this.leg1.y += 3;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x += 3;
                     this.leg1Shadow.y -= 3;
                  }
                  this.torso.x += 2;
                  this.moveSideWeapons(1.5,0);
                  this.moveTopWeapons(2,0);
               }
               else if(_loc1_ <= 18 || _loc1_ >= 31 && _loc1_ <= 36)
               {
                  this.leg1.x -= 6;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x -= 6;
                  }
                  this.torso.x -= 4;
                  this.moveSideWeapons(-3,0);
                  this.moveTopWeapons(-4,0);
               }
            }
            else
            {
               this._tease4Handler = false;
               this.removeActiveAnimation("tease4",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease4(param1:Function) : void
      {
         if(this._tease4Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease4Handler = true;
            this._tease4Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease4");
         }
      }
      
      private function tease5Handler() : void
      {
         var _loc1_:Number = NaN;
         if(this._tease5Handler)
         {
            ++this._tease5Counter;
            _loc1_ = this._tease5Counter;
            if(_loc1_ <= 40)
            {
               if(_loc1_ <= 10)
               {
                  this.torso.x += 1;
                  this.torso.y += 0.5;
                  this.torso.scaleX += 0.01;
                  this.leg1.x -= 0.5;
                  this.leg2.x += 0.5;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x -= 0.5;
                     this.leg2Shadow.x += 0.5;
                  }
                  this.moveSideWeapons(-0.5,0.25);
                  this.moveTopWeapons(-0.25,0);
               }
               if(_loc1_ >= 30)
               {
                  --this.torso.x;
                  this.torso.y -= 0.5;
                  this.torso.scaleX -= 0.01;
                  this.leg1.x += 0.5;
                  this.leg2.x -= 0.5;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x += 0.5;
                     this.leg2Shadow.x -= 0.5;
                  }
                  this.moveSideWeapons(0.5,-0.25);
                  this.moveTopWeapons(0.25,0);
               }
            }
            else
            {
               this._tease5Handler = false;
               this.removeActiveAnimation("tease5",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease5(param1:Function) : void
      {
         if(this._tease5Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease5Handler = true;
            this._tease5Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease5");
         }
      }
      
      private function tease6Handler() : void
      {
         var _loc1_:Number = NaN;
         if(this._tease6Handler)
         {
            ++this._tease6Counter;
            _loc1_ = this._tease6Counter;
            if(_loc1_ <= 47)
            {
               if(_loc1_ <= 5)
               {
                  this.torso.rotation += 3;
                  this.rotateSideWeapons(2);
                  this.rotateTopWeapons(1);
               }
               if(_loc1_ >= 6 && _loc1_ <= 10)
               {
                  this.leg2.rotation += 1;
               }
               if(_loc1_ >= 11 && _loc1_ <= 14 || _loc1_ >= 19 && _loc1_ <= 22 || _loc1_ >= 27 && _loc1_ <= 30 || _loc1_ >= 35 && _loc1_ <= 38)
               {
                  this.leg2.x -= 2;
                  if(this.useLegsShadow)
                  {
                     this.leg2Shadow.x -= 2;
                  }
               }
               if(_loc1_ >= 15 && _loc1_ <= 18 || _loc1_ >= 23 && _loc1_ <= 26 || _loc1_ >= 31 && _loc1_ <= 34 || _loc1_ >= 39 && _loc1_ <= 42)
               {
                  this.leg2.x += 2;
                  if(this.useLegsShadow)
                  {
                     this.leg2Shadow.x += 2;
                  }
               }
               if(_loc1_ >= 43 && _loc1_ <= 47)
               {
                  this.torso.rotation -= 3;
                  --this.leg2.rotation;
                  this.rotateSideWeapons(-2);
                  this.rotateTopWeapons(-1);
               }
            }
            else
            {
               this._tease6Handler = false;
               this.removeActiveAnimation("tease6",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease6(param1:Function) : void
      {
         if(this._tease6Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease6Handler = true;
            this._tease6Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease6");
         }
      }
      
      private function tease7Handler() : void
      {
         var _loc1_:Number = NaN;
         if(this._tease7Handler)
         {
            ++this._tease7Counter;
            _loc1_ = this._tease7Counter;
            if(_loc1_ <= 63)
            {
               if(_loc1_ <= 6)
               {
                  this.leg1.x += 1.5;
                  this.leg1.y -= 3;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x += 1.5;
                     this.leg1Shadow.y += 3;
                  }
               }
               else if(_loc1_ <= 12)
               {
                  this.leg1.x += 1.5;
                  this.leg1.y += 3;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x += 1.5;
                     this.leg1Shadow.y -= 3;
                  }
               }
               else if(_loc1_ <= 18)
               {
                  this.leg1.x -= 1.5;
                  this.leg1.y -= 3;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x -= 1.5;
                     this.leg1Shadow.y += 3;
                  }
               }
               else if(_loc1_ <= 24)
               {
                  this.leg1.x -= 1.5;
                  this.leg1.y += 3;
                  if(this.useLegsShadow)
                  {
                     this.leg1Shadow.x -= 1.5;
                     this.leg1Shadow.y -= 3;
                  }
               }
               if(_loc1_ <= 12)
               {
                  this.torso.x += 2;
                  this.moveAllWeapons(1,0);
               }
               else if(_loc1_ <= 24)
               {
                  this.torso.x -= 2;
                  this.moveAllWeapons(-1,0);
               }
               if(_loc1_ >= 25)
               {
                  if(_loc1_ <= 31)
                  {
                     this.leg2.x += 1;
                     this.leg2.y -= 3;
                     if(this.useLegsShadow)
                     {
                        this.leg2Shadow.x += 1;
                        this.leg2Shadow.y += 3;
                     }
                  }
                  else if(_loc1_ <= 37)
                  {
                     this.leg2.x += 1;
                     this.leg2.y += 3;
                     if(this.useLegsShadow)
                     {
                        this.leg2Shadow.x += 1;
                        this.leg2Shadow.y -= 3;
                     }
                  }
                  if(_loc1_ <= 37)
                  {
                     this.torso.x += 1;
                     this.moveAllWeapons(0.5,0);
                  }
               }
               if(_loc1_ >= 38)
               {
                  if(_loc1_ >= 38 && _loc1_ <= 40 || _loc1_ >= 44 && _loc1_ <= 46 || _loc1_ >= 50 && _loc1_ <= 52)
                  {
                     this.sideWeapon1.x += 7;
                     this.sideWeapon2.x -= 7;
                     this.sideWeapon3.x += 7;
                     this.sideWeapon4.x -= 7;
                  }
                  if(_loc1_ >= 41 && _loc1_ <= 43 || _loc1_ >= 47 && _loc1_ <= 49 || _loc1_ >= 53 && _loc1_ <= 55)
                  {
                     this.sideWeapon1.x -= 7;
                     this.sideWeapon2.x += 7;
                     this.sideWeapon3.x -= 7;
                     this.sideWeapon4.x += 7;
                  }
               }
               if(_loc1_ >= 56 && _loc1_ <= 62)
               {
                  this.torso.rotation -= 2;
                  this.torso.x -= 2;
                  this.sideWeapon1.rotation -= 8;
                  this.sideWeapon2.rotation -= 5;
                  this.sideWeapon3.rotation -= 8;
                  this.sideWeapon4.rotation -= 5;
                  this.topWeapon1.rotation -= 3;
                  this.topWeapon2.rotation -= 2;
               }
            }
            else
            {
               this._tease7Handler = false;
               this.removeActiveAnimation("tease7",true);
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease7(param1:Function) : void
      {
         if(this._tease7Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease7Handler = true;
            this._tease7Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease7");
         }
      }
      
      private function tease8Handler() : void
      {
         var _loc1_:Number = NaN;
         if(this._tease8Handler)
         {
            ++this._tease8Counter;
            if(this._tease8Counter <= 38)
            {
               if(this._tease8Counter <= 10)
               {
                  this.torso.y += 1;
                  this.leg1.scaleY -= 0.01;
                  this.leg2.scaleY -= 0.01;
                  this.moveAllWeapons(0,1);
               }
               else if(this._tease8Counter <= 13)
               {
                  this.torso.y -= 5;
                  this.leg1.scaleY += 0.05;
                  this.leg2.scaleY += 0.05;
                  this.moveTopWeapons(0,-5);
               }
               else if(this._tease8Counter <= 18)
               {
                  this.torso.y += 1;
                  this.leg1.scaleY -= 0.01;
                  this.leg2.scaleY -= 0.01;
                  this.moveTopWeapons(0,1);
               }
               if(this._tease8Counter <= 18)
               {
                  this.leg1.y = this._itemsOriginPoints["leg1"].y + this._breathingLegOriginalHeight - this.leg1.height;
                  this.leg2.y = this._itemsOriginPoints["leg2"].y + this._breathingLegOriginalHeight - this.leg2.height;
               }
               if(this._tease8Counter >= 11)
               {
                  if(this._tease8Counter <= 33)
                  {
                     _loc1_ = 2;
                     this.moveSideWeapons(0,(this._tease8Counter - 12 - 10) * _loc1_);
                     this.rotateSideWeapons(360 / 23);
                  }
                  else
                  {
                     this.moveSideWeapons(0,-2);
                  }
               }
            }
            else
            {
               this._tease8Handler = false;
               this.removeActiveAnimation("tease8",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease8(param1:Function) : void
      {
         if(this._tease8Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease8Handler = true;
            this._tease8Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease8");
         }
      }
      
      private function tease9Handler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this._tease9Handler)
         {
            ++this._tease9Counter;
            if(this._tease9Counter <= 43)
            {
               _loc1_ = 3;
               if(this._tease9Counter <= 10)
               {
                  this.torso.y += 1 * _loc1_;
                  this.leg1.scaleY -= 0.01 * _loc1_;
                  this.leg2.scaleY -= 0.01 * _loc1_;
                  this.moveAllWeapons(0,1 * _loc1_);
               }
               else if(this._tease9Counter <= 32)
               {
                  if(this._tease9Counter == 11)
                  {
                     this.torso.y -= 10 * _loc1_;
                     this.moveAllWeapons(0,-10 * _loc1_);
                     this.leg1.scaleY = 1;
                     this.leg2.scaleY = 1;
                  }
                  if(this._tease9Counter >= 12)
                  {
                     _loc2_ = 2.5 * (this._tease9Counter - 10 - 12);
                     this.moveTorsoAndAllWeapons(0,_loc2_);
                     this.leg1.y += _loc2_;
                     this.leg2.y += _loc2_;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.y -= _loc2_;
                        this.leg2Shadow.y -= _loc2_;
                     }
                  }
               }
               else if(this._tease9Counter == 33)
               {
                  this.torso.y += 10 * _loc1_;
                  this.moveAllWeapons(0,10 * _loc1_);
                  this.leg1.scaleY = 1 - 0.1 * _loc1_;
                  this.leg2.scaleY = 1 - 0.1 * _loc1_;
               }
               else
               {
                  this.torso.y -= 1 * _loc1_;
                  this.leg1.scaleY += 0.01 * _loc1_;
                  this.leg2.scaleY += 0.01 * _loc1_;
                  this.moveAllWeapons(0,-1 * _loc1_);
               }
               if(this._tease9Counter <= 11 || this._tease9Counter >= 33)
               {
                  this.leg1.y = this._itemsOriginPoints["leg1"].y + this._breathingLegOriginalHeight - this.leg1.height;
                  this.leg2.y = this._itemsOriginPoints["leg2"].y + this._breathingLegOriginalHeight - this.leg2.height;
               }
               if(this._tease9Counter == 32)
               {
                  if(this._tease9Sound)
                  {
                     soundM.createSound("footStep",1);
                  }
                  if(screensM.isScreenOpened("screenBattle"))
                  {
                     screensM.screenBattle.createEarthQuake();
                  }
               }
               if(this._tease9Counter == 43)
               {
                  ++this._tease9Jumps;
                  if(this._tease9Jumps == 1)
                  {
                     this._tease9Counter = 11;
                  }
               }
            }
            else
            {
               this._tease9Handler = false;
               this.removeActiveAnimation("tease9",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease9(param1:Function, param2:Boolean = true) : void
      {
         if(this._tease9Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease9Handler = true;
            this._tease9Counter = 0;
            this._tease9Jumps = 0;
            this._tease9Sound = param2;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease9");
         }
      }
      
      private function tease10Handler() : void
      {
         if(this._tease10Handler)
         {
            ++this._tease10Counter;
            if(this._tease10Counter <= 80)
            {
               --this.itemsHolder.x;
            }
            else
            {
               this._tease10Handler = false;
               this.removeActiveAnimation("tease10",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease10(param1:Function) : void
      {
         if(this._tease10Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this.walkForward(3,true,null);
            this._tease10Handler = true;
            this._tease10Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease10");
         }
      }
      
      private function tease11Handler() : void
      {
         var _loc1_:Number = NaN;
         if(this._tease11Handler)
         {
            ++this._tease11Counter;
            _loc1_ = this._tease11Counter;
            if(_loc1_ <= 47)
            {
               if(_loc1_ <= 5)
               {
                  this.torso.rotation += 3;
                  this.rotateSideWeapons(2);
                  this.rotateTopWeapons(1);
                  this.moveTorsoAndAllWeapons(1,0.5);
               }
               if(_loc1_ >= 43 && _loc1_ <= 47)
               {
                  this.torso.rotation -= 3;
                  this.rotateSideWeapons(-2);
                  this.rotateTopWeapons(-1);
                  this.moveTorsoAndAllWeapons(-1,-0.5);
               }
            }
            else
            {
               this._tease11Handler = false;
               this.removeActiveAnimation("tease11",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease11(param1:Function) : void
      {
         if(this._tease11Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease11Handler = true;
            this._tease11Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease11");
         }
      }
      
      private function tease12Handler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._tease12Handler)
         {
            ++this._tease12Counter;
            _loc1_ = this._tease12Counter;
            _loc2_ = 2;
            _loc3_ = 0.6;
            if(_loc1_ <= 8)
            {
               this.sideWeapon2.rotation -= 4;
               this.sideWeapon4.rotation -= 4;
               --this.torso.rotation;
               this.rotateTopWeapons(-1);
            }
            else if(_loc1_ <= 25)
            {
               if(_loc1_ >= 8 && _loc1_ <= 10 || _loc1_ >= 14 && _loc1_ <= 16 || _loc1_ >= 20 && _loc1_ <= 22)
               {
                  this.sideWeapon2.y -= 2;
                  this.sideWeapon4.y -= 2;
               }
               if(_loc1_ >= 11 && _loc1_ <= 13 || _loc1_ >= 17 && _loc1_ <= 19 || _loc1_ >= 23 && _loc1_ <= 25)
               {
                  this.sideWeapon2.y += 2;
                  this.sideWeapon4.y += 2;
               }
            }
            else if(_loc1_ <= 33)
            {
               this.sideWeapon2.rotation += 4;
               this.sideWeapon4.rotation += 4;
               this.torso.rotation += 1;
               this.rotateTopWeapons(1);
            }
            else
            {
               this._tease12Handler = false;
               this.removeActiveAnimation("tease12",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateTease12(param1:Function) : void
      {
         if(this._tease12Handler == false && this._getHitAnimationHandler == false && this._shutDownHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._tease12Handler = true;
            this._tease12Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("tease12");
         }
      }
      
      private function entry1Handler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         if(this._entry1Handler)
         {
            ++this._entry1Counter;
            _loc1_ = this._entry1Counter;
            _loc2_ = 800;
            if(_loc1_ <= 45)
            {
               if(_loc1_ <= 20)
               {
                  if(_loc1_ <= 10)
                  {
                     if(_loc1_ == 1)
                     {
                        this.torso.y -= _loc2_;
                        this.leg1.y -= _loc2_;
                        this.leg2.y -= _loc2_;
                        if(this.useLegsShadow)
                        {
                           this.leg1Shadow.y += _loc2_;
                           this.leg2Shadow.y += _loc2_;
                        }
                        _loc3_ = 1;
                        while(_loc3_ <= 4)
                        {
                           if(this["sideWeapon" + _loc3_].item != null)
                           {
                              this["sideWeapon" + _loc3_].y = this._itemsOriginPoints["sideWeapon" + _loc3_].y - _loc2_;
                           }
                           _loc3_++;
                        }
                        _loc3_ = 1;
                        while(_loc3_ <= 2)
                        {
                           if(this["topWeapon" + _loc3_].item != null)
                           {
                              this["topWeapon" + _loc3_].y = this._itemsOriginPoints["topWeapon" + _loc3_].y - _loc2_;
                           }
                           _loc3_++;
                        }
                        if(this.torso.item.itemGrp.mcShutdown != null)
                        {
                           this.torso.item.itemGrp.mcShutdown.alpha = 1;
                        }
                     }
                  }
                  else if(_loc1_ == 20)
                  {
                     this.torso.y = this._itemsOriginPoints["torso"].y;
                     this.leg1.y = this._itemsOriginPoints["leg1"].y;
                     this.leg2.y = this._itemsOriginPoints["leg2"].y;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.y = this._itemsOriginPoints["leg1Shadow"].y;
                        this.leg2Shadow.y = this._itemsOriginPoints["leg2Shadow"].y;
                     }
                     _loc3_ = 1;
                     while(_loc3_ <= 4)
                     {
                        if(this["sideWeapon" + _loc3_].item != null)
                        {
                           this["sideWeapon" + _loc3_].y = this._itemsOriginPoints["sideWeapon" + _loc3_].y;
                        }
                        _loc3_++;
                     }
                     _loc3_ = 1;
                     while(_loc3_ <= 2)
                     {
                        if(this["topWeapon" + _loc3_].item != null)
                        {
                           this["topWeapon" + _loc3_].y = this._itemsOriginPoints["topWeapon" + _loc3_].y;
                        }
                        _loc3_++;
                     }
                     if(screensM.isScreenOpened("screenBattle"))
                     {
                        screensM.screenBattle.createEarthQuake();
                     }
                     if(this._entry1Sound)
                     {
                        soundM.createSound("footStep",1);
                     }
                  }
                  else
                  {
                     _loc4_ = (10 - (_loc1_ - 10)) / 10 * _loc2_;
                     this.torso.y = this._itemsOriginPoints["torso"].y - _loc4_;
                     this.leg1.y = this._itemsOriginPoints["leg1"].y - _loc4_;
                     this.leg2.y = this._itemsOriginPoints["leg2"].y - _loc4_;
                     if(this.useLegsShadow)
                     {
                        this.leg1Shadow.y = this._itemsOriginPoints["leg1Shadow"].y + _loc4_;
                        this.leg2Shadow.y = this._itemsOriginPoints["leg2Shadow"].y + _loc4_;
                     }
                     _loc3_ = 1;
                     while(_loc3_ <= 4)
                     {
                        if(this["sideWeapon" + _loc3_].item != null)
                        {
                           this["sideWeapon" + _loc3_].y = this._itemsOriginPoints["sideWeapon" + _loc3_].y - _loc4_;
                        }
                        _loc3_++;
                     }
                     _loc3_ = 1;
                     while(_loc3_ <= 2)
                     {
                        if(this["topWeapon" + _loc3_].item != null)
                        {
                           this["topWeapon" + _loc3_].y = this._itemsOriginPoints["topWeapon" + _loc3_].y - _loc4_;
                        }
                        _loc3_++;
                     }
                  }
               }
               else if(_loc1_ <= 30)
               {
                  this.torso.y += 1.5;
                  _loc3_ = 1;
                  while(_loc3_ <= 4)
                  {
                     if(this["sideWeapon" + _loc3_].item != null)
                     {
                        this["sideWeapon" + _loc3_].y += 1;
                     }
                     _loc3_++;
                  }
                  _loc3_ = 1;
                  while(_loc3_ <= 2)
                  {
                     if(this["topWeapon" + _loc3_].item != null)
                     {
                        this["topWeapon" + _loc3_].y += 1.5;
                     }
                     _loc3_++;
                  }
               }
               else if(_loc1_ > 40)
               {
                  if(_loc1_ <= 45)
                  {
                     this.torso.y -= 3;
                     _loc3_ = 1;
                     while(_loc3_ <= 4)
                     {
                        if(this["sideWeapon" + _loc3_].item != null)
                        {
                           this["sideWeapon" + _loc3_].y -= 2;
                        }
                        _loc3_++;
                     }
                     _loc3_ = 1;
                     while(_loc3_ <= 2)
                     {
                        if(this["topWeapon" + _loc3_].item != null)
                        {
                           this["topWeapon" + _loc3_].y -= 3;
                        }
                        _loc3_++;
                     }
                     if(_loc1_ == 45)
                     {
                        if(this.torso.item.itemGrp.mcShutdown != null)
                        {
                           this.torso.item.itemGrp.mcShutdown.alpha = 0;
                        }
                     }
                  }
               }
            }
            else
            {
               this._entry1Handler = false;
               this._entryActive = false;
               this.removeActiveAnimation("entry1",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateEntry1(param1:Boolean, param2:Function) : void
      {
         if(this._entry1Handler == false && this._getHitAnimationHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._entry1Handler = true;
            this._entry1Sound = param1;
            this._entryActive = true;
            this._entry1Counter = 0;
            this._teaseEntryEndedFunction = param2;
            this.addActiveAnimation("entry1");
         }
      }
      
      private function entry2Handler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         if(this._entry2Handler)
         {
            ++this._entry2Counter;
            _loc1_ = this._entry2Counter;
            _loc2_ = 700;
            _loc3_ = false;
            if(_loc1_ == 1)
            {
               this.torso.y = this._itemsOriginPoints["torso"].y - _loc2_;
               this.leg1.y = this._itemsOriginPoints["leg1"].y - _loc2_;
               this.leg2.y = this._itemsOriginPoints["leg2"].y - _loc2_;
               if(this.useLegsShadow)
               {
                  this.leg1Shadow.y = this._itemsOriginPoints["leg1Shadow"].y + _loc2_;
                  this.leg2Shadow.y = this._itemsOriginPoints["leg2Shadow"].y + _loc2_;
               }
               this._entry2ActiveWeapons = new Array();
               _loc4_ = 1;
               while(_loc4_ <= 4)
               {
                  if(this["sideWeapon" + _loc4_].item != null)
                  {
                     this["sideWeapon" + _loc4_].y = this._itemsOriginPoints["sideWeapon" + _loc4_].y - _loc2_;
                     this._entry2ActiveWeapons.push("sideWeapon" + _loc4_);
                  }
                  _loc4_++;
               }
               _loc4_ = 1;
               while(_loc4_ <= 2)
               {
                  if(this["topWeapon" + _loc4_].item != null)
                  {
                     this["topWeapon" + _loc4_].y = this._itemsOriginPoints["topWeapon" + _loc4_].y - _loc2_;
                     this._entry2ActiveWeapons.push("topWeapon" + _loc4_);
                  }
                  _loc4_++;
               }
            }
            if(_loc1_ <= 10)
            {
               this.leg1.y += _loc2_ / 10;
               if(this.useLegsShadow)
               {
                  this.leg1Shadow.y += _loc2_ / 10;
               }
               if(_loc1_ == 10)
               {
                  if(screensM.isScreenOpened("screenBattle"))
                  {
                     screensM.screenBattle.createEarthQuake();
                  }
                  if(this._entry2Sound)
                  {
                     soundM.createSound("footStep",1);
                  }
               }
            }
            else if(_loc1_ <= 20)
            {
               this.leg2.y += _loc2_ / 10;
               if(this.useLegsShadow)
               {
                  this.leg2Shadow.y += _loc2_ / 10;
               }
               if(_loc1_ == 20)
               {
                  if(screensM.isScreenOpened("screenBattle"))
                  {
                     screensM.screenBattle.createEarthQuake();
                  }
                  if(this._entry2Sound)
                  {
                     soundM.createSound("footStep",1);
                  }
               }
            }
            else if(_loc1_ <= 30)
            {
               this.torso.y += _loc2_ / 10;
               if(_loc1_ == 30)
               {
                  this.torso.y = this._itemsOriginPoints["torso"].y + 12;
                  if(this._entry2Sound)
                  {
                     soundM.createSound("footStep",1);
                  }
               }
            }
            else if(this._entry2ActiveWeapons[this._entry2WeaponCounter] != null)
            {
               if(_loc1_ <= 30 + (this._entry2WeaponCounter + 1) * 10)
               {
                  this[this._entry2ActiveWeapons[this._entry2WeaponCounter]].y += _loc2_ / 10;
               }
               if(_loc1_ == 30 + (this._entry2WeaponCounter + 1) * 10)
               {
                  ++this._entry2WeaponCounter;
               }
               if(this._entry2ActiveWeapons[this._entry2WeaponCounter] != null)
               {
                  if(_loc1_ == 30 + this._entry2WeaponCounter * 10)
                  {
                     this.torso.y += 12;
                     if(this._entry2WeaponCounter > 0)
                     {
                        _loc4_ = 0;
                        while(_loc4_ < this._entry2WeaponCounter)
                        {
                           this[this._entry2ActiveWeapons[_loc4_]].y += 12;
                           _loc4_++;
                        }
                     }
                  }
                  else if(_loc1_ <= 34 + this._entry2WeaponCounter * 10)
                  {
                     this.torso.y -= 3;
                     if(this._entry2WeaponCounter > 0)
                     {
                        _loc4_ = 0;
                        while(_loc4_ < this._entry2WeaponCounter)
                        {
                           this[this._entry2ActiveWeapons[_loc4_]].y -= 3;
                           _loc4_++;
                        }
                     }
                  }
               }
            }
            else if(_loc1_ <= 35 + this._entry2WeaponCounter * 10)
            {
               if(_loc1_ == 31 + this._entry2WeaponCounter * 10)
               {
                  this.torso.y += 12;
                  _loc4_ = 0;
                  while(_loc4_ < this._entry2ActiveWeapons.length)
                  {
                     this[this._entry2ActiveWeapons[_loc4_]].y += 12;
                     _loc4_++;
                  }
               }
               else if(_loc1_ <= 35 + this._entry2WeaponCounter * 10)
               {
                  this.torso.y -= 3;
                  _loc4_ = 0;
                  while(_loc4_ < this._entry2ActiveWeapons.length)
                  {
                     this[this._entry2ActiveWeapons[_loc4_]].y -= 3;
                     _loc4_++;
                  }
               }
            }
            else
            {
               _loc3_ = true;
            }
            if(_loc3_)
            {
               this._entry2Handler = false;
               this._entryActive = false;
               this.removeActiveAnimation("entry2",true);
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateEntry2(param1:Boolean, param2:Function) : void
      {
         if(this._entry2Handler == false && this._getHitAnimationHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._entry2Handler = true;
            this._entry2Sound = param1;
            this._entryActive = true;
            this._entry2Counter = 0;
            this._entry2WeaponCounter = 0;
            this._teaseEntryEndedFunction = param2;
            this.addActiveAnimation("entry2");
         }
      }
      
      private function entry3Handler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this._entry3Handler)
         {
            ++this._entry3Counter;
            _loc1_ = this._entry3Counter;
            if(_loc1_ == 1)
            {
               visible = false;
            }
            if(_loc1_ == 20)
            {
               _loc2_ = this.mechSizer.width * 1.8;
               _loc3_ = x;
               _loc4_ = y + 30;
               effectsM.createTeleportReappear("teleportReappearAnim",_loc3_,_loc4_,_loc2_,screensM.screenBattle.holder_effects);
               soundM.createSound("teleportAppear",1);
            }
            if(_loc1_ == 22)
            {
               this._entry3Handler = false;
               this._entryActive = false;
               this.removeActiveAnimation("entry3",true);
               visible = true;
               this.resumeBreathing();
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateEntry3(param1:Function) : void
      {
         if(this._entry3Handler == false && this._getHitAnimationHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._entry3Handler = true;
            this._entryActive = true;
            this._entry3Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("entry3");
         }
      }
      
      private function entry4Handler() : void
      {
         var _loc1_:String = null;
         var _loc2_:Number = NaN;
         var _loc3_:MovieClip = null;
         if(this._entry4Handler)
         {
            ++this._entry4Counter;
            if(this._entry4Counter >= 10)
            {
               _loc1_ = this._entry4Items[this._entry4CurrentItemSlot];
               _loc2_ = 0.1;
               _loc3_ = this[_loc1_];
               if(_loc3_.alpha < 1)
               {
                  _loc3_.alpha += _loc2_;
               }
               if(this.useLegsShadow)
               {
                  if(this.legsShadowHolder.alpha < 1)
                  {
                     this.legsShadowHolder.alpha += _loc2_ / 2;
                  }
               }
               if(_loc3_.alpha >= 1)
               {
                  _loc3_.alpha = 1;
                  ++this._entry4CurrentItemSlot;
                  if(this._entry4CurrentItemSlot >= this._entry4Items.length)
                  {
                     this._entry4Handler = false;
                     this._entryActive = false;
                     this.removeActiveAnimation("entry4",true);
                     this.resumeBreathing();
                     if(this._teaseEntryEndedFunction != null)
                     {
                        this._teaseEntryEndedFunction();
                     }
                  }
               }
            }
         }
      }
      
      public function activateEntry4(param1:Function) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         if(this._entry4Handler == false && this._getHitAnimationHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._entry4Handler = true;
            this._entryActive = true;
            this._entry4Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this._entry4Items = new Array();
            this._entry4Items.push("leg1","leg2","torso");
            _loc2_ = 1;
            while(_loc2_ <= dataM.maxEquipment["sideWeapon"])
            {
               if(this._mechStructure["sideWeapon" + _loc2_] > 0)
               {
                  this._entry4Items.push("sideWeapon" + _loc2_);
               }
               _loc2_++;
            }
            _loc2_ = 1;
            while(_loc2_ <= dataM.maxEquipment["topWeapon"])
            {
               if(this._mechStructure["topWeapon" + _loc2_] > 0)
               {
                  this._entry4Items.push("topWeapon" + _loc2_);
               }
               _loc2_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this._entry4Items.length)
            {
               _loc4_ = this[this._entry4Items[_loc3_]];
               _loc4_.alpha = 0;
               _loc3_++;
            }
            if(this.useLegsShadow)
            {
               this.legsShadowHolder.alpha = 0;
            }
            this._entry4CurrentItemSlot = 0;
            this.addActiveAnimation("entry4");
         }
      }
      
      public function entry4Active() : Boolean
      {
         return this._entry4Handler;
      }
      
      public function entryAnimationActive() : Boolean
      {
         return this._entryActive;
      }
      
      private function exit1Handler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this._exit1Handler)
         {
            ++this._exit1Counter;
            _loc1_ = this._exit1Counter;
            if(_loc1_ == 20)
            {
               visible = false;
            }
            if(_loc1_ == 1)
            {
               _loc2_ = this.mechSizer.width * 1.8;
               _loc3_ = x;
               _loc4_ = y + 30;
               effectsM.createTeleportDisappear("teleportDisappearAnim",_loc3_,_loc4_,_loc2_,null,null,screensM.screenBattle.holder_effects);
               soundM.createSound("teleportDisappear",1);
            }
            if(_loc1_ == 20)
            {
               this._exit1Handler = false;
               this.removeActiveAnimation("exit1",true);
               if(this._teaseEntryEndedFunction != null)
               {
                  this._teaseEntryEndedFunction();
               }
            }
         }
      }
      
      public function activateExit1(param1:Function) : void
      {
         if(this._exit1Handler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._exit1Handler = true;
            this._exit1Counter = 0;
            this._teaseEntryEndedFunction = param1;
            this.addActiveAnimation("exit1");
         }
      }
      
      private function defeatedHandler() : void
      {
         if(this._defeatedHandler)
         {
            if(this._getPushedAnimationHandler == false && this._getHitAnimationHandler == false)
            {
               ++this._defeatedCounter;
               if(this._defeatedCounter == 1)
               {
                  if(this._breathingPaused == false)
                  {
                     this.pauseBreathingAndRemoveTeasers(false);
                  }
                  this.addActiveAnimation("defeated");
                  if(this.torso.item.itemGrp.mcShutdown != null)
                  {
                     this.torso.item.itemGrp.mcShutdown.alpha = 1;
                  }
               }
               if(this._defeatedCounter < 20)
               {
                  this.torso.rotation += 0.4;
                  this.rotateSideWeapons(0.8);
                  this.rotateTopWeapons(0.4);
                  this.moveTorsoAndAllWeapons(0,0.5);
               }
            }
         }
      }
      
      public function activateDefeated() : void
      {
         if(this._defeatedHandler == false)
         {
            this._defeatedHandler = true;
            this._defeatedCounter = 0;
         }
      }
      
      private function overheatHandler() : void
      {
         if(this._overheatHandler)
         {
            ++this._overheatCounter;
            if(this._overheatCounter <= this._overheatFrames)
            {
               if(this._overheatCounter % 2 == 0)
               {
                  ++x;
               }
               else
               {
                  --x;
               }
               this.overheatColorItems(this._overheatCounter / (this._overheatFrames * 2));
            }
            else
            {
               this.overheatColorItems(0);
               this._overheatHandler = false;
               if(this._finishReturnFunction != null)
               {
                  this._finishReturnFunction();
               }
            }
         }
      }
      
      private function overheatColorItems(param1:Number) : void
      {
         var _loc2_:Color = null;
         var _loc3_:uint = 0;
         if(dataM.runAsMobile == false)
         {
            _loc2_ = new Color();
            _loc2_.setTint(16711680,param1);
            this.torso.transform.colorTransform = _loc2_;
            this.leg1.transform.colorTransform = _loc2_;
            this.leg2.transform.colorTransform = _loc2_;
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["sideWeapon"])
            {
               this["sideWeapon" + _loc3_].transform.colorTransform = _loc2_;
               _loc3_++;
            }
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["topWeapon"])
            {
               this["topWeapon" + _loc3_].transform.colorTransform = _loc2_;
               _loc3_++;
            }
         }
      }
      
      public function activateOverheat(param1:Number, param2:Function) : void
      {
         if(this._overheatHandler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._overheatFrames = param1;
            this._overheatHandler = true;
            this._overheatCounter = 0;
            this._finishReturnFunction = param2;
            this.addActiveAnimation("overheat");
         }
      }
      
      public function finish1Handler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this._finish1Handler)
         {
            ++this._finish1Counter;
            _loc1_ = 25;
            if(this._finish1Counter <= 50 + _loc1_)
            {
               _loc2_ = 3;
               if(this._finish1Counter <= 10)
               {
                  this.moveTorsoAndAllWeapons(0,1 * _loc2_);
                  this.leg1.scaleY -= 0.01 * _loc2_;
                  this.leg2.scaleY -= 0.01 * _loc2_;
               }
               else
               {
                  if(this._finish1Counter == 11)
                  {
                     this.moveTorsoAndAllWeapons(0,-10 * _loc2_);
                     this.leg1.scaleY = 1;
                     this.leg2.scaleY = 1;
                     this.leg1.y = this._itemsOriginPoints["leg1"].y + this._breathingLegOriginalHeight - this.leg1.height;
                     this.leg2.y = this._itemsOriginPoints["leg2"].y + this._breathingLegOriginalHeight - this.leg2.height;
                     if(this.useLegsShadow)
                     {
                        this.legsShadowHolder.visible = false;
                     }
                  }
                  _loc3_ = 75;
                  if(this._finish1Counter <= 20)
                  {
                     this.moveTorsoAndAllWeapons(0,-_loc3_);
                     this.leg1.y -= _loc3_;
                     this.leg2.y -= _loc3_;
                  }
                  else
                  {
                     if(this._finish1Counter == 21 + Math.floor(_loc1_ / 2))
                     {
                        x = this._finish1MechTargetXPos;
                     }
                     if(this._finish1Counter > 20 + _loc1_)
                     {
                        if(this._finish1Counter <= 30 + _loc1_)
                        {
                           this.moveTorsoAndAllWeapons(0,_loc3_);
                           this.leg1.y += _loc3_;
                           this.leg2.y += _loc3_;
                           if(this._finish1Counter == 30 + _loc1_)
                           {
                              if(this.useLegsShadow)
                              {
                                 this.legsShadowHolder.visible = true;
                              }
                              if(this._finishReturnFunction != null)
                              {
                                 this._finishReturnFunction();
                              }
                           }
                        }
                        else if(this._finish1Counter <= 50 + _loc1_)
                        {
                           if(this._finish1Counter == 31 + _loc1_)
                           {
                              this.moveTorsoAndAllWeapons(0,10 * _loc2_);
                              this.leg1.scaleY = 1 - 0.1 * _loc2_;
                              this.leg2.scaleY = 1 - 0.1 * _loc2_;
                           }
                           this.moveTorsoAndAllWeapons(0,-1 * _loc2_ / 2);
                           this.leg1.scaleY += 0.01 * _loc2_ / 2;
                           this.leg2.scaleY += 0.01 * _loc2_ / 2;
                        }
                     }
                  }
               }
               if(this._finish1Counter <= 10 || this._finish1Counter >= 30 + _loc1_)
               {
                  this.leg1.y = this._itemsOriginPoints["leg1"].y + this._breathingLegOriginalHeight - this.leg1.height;
                  this.leg2.y = this._itemsOriginPoints["leg2"].y + this._breathingLegOriginalHeight - this.leg2.height;
               }
            }
            else
            {
               this._finish1Handler = false;
               this.removeActiveAnimation("finish1",true);
            }
         }
      }
      
      public function activateFinish1(param1:Number, param2:Function) : void
      {
         if(this._finish1Handler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._finish1Handler = true;
            this._finish1Counter = 0;
            this._finish1MechTargetXPos = param1;
            this._finishReturnFunction = param2;
            this.addActiveAnimation("finish1");
         }
      }
      
      public function finish7Handler() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Number = NaN;
         if(this._finish7Handler)
         {
            ++this._finish7Counter;
            _loc1_ = this["sideWeapon" + this._swordEquipmentID];
            if(this._finish7Counter <= 10)
            {
               _loc1_.rotation -= 10;
               this.moveTorsoAndAllWeapons(0,2);
               this.leg1.scaleY -= 0.02;
               this.leg2.scaleY -= 0.02;
            }
            else if(this._finish7Counter <= 30)
            {
               x += this._finish7XDistance / 20;
               if(this._finish7Counter == 11)
               {
                  this.moveTorsoAndAllWeapons(0,-20);
                  this.moveTorsoAndAllWeapons(0,-20);
                  this.leg1.scaleY = 1;
                  this.leg2.scaleY = 1;
                  this.leg1.y = this._itemsOriginPoints["leg1"].y + this._breathingLegOriginalHeight - this.leg1.height;
                  this.leg2.y = this._itemsOriginPoints["leg2"].y + this._breathingLegOriginalHeight - this.leg2.height;
                  if(this.useLegsShadow)
                  {
                     this.legsShadowHolder.visible = false;
                  }
               }
               _loc2_ = -(10 - (this._finish7Counter - 10)) * 3;
               this.moveTorsoAndAllWeapons(0,_loc2_);
               this.leg1.y += _loc2_;
               this.leg2.y += _loc2_;
               if(this._finish7Counter >= 21)
               {
                  _loc1_.rotation += 15;
               }
               if(this._finish7Counter == 27)
               {
                  this._finishReturnFunction();
               }
            }
            else if(this._finish7Counter <= 40)
            {
               if(this._finish7Counter <= 35)
               {
                  _loc1_.rotation -= 10;
               }
               if(this._finish7Counter == 31)
               {
                  this.moveTorsoAndAllWeapons(0,20);
                  this.leg1.scaleY -= 0.2;
                  this.leg2.scaleY -= 0.2;
                  if(this.useLegsShadow)
                  {
                     this.legsShadowHolder.visible = true;
                  }
               }
               this.moveTorsoAndAllWeapons(0,-2);
               this.leg1.scaleY += 0.02;
               this.leg2.scaleY += 0.02;
            }
            else
            {
               this._finish7Counter = 0;
               this._finish7Handler = false;
               this.removeActiveAnimation("finish7",true);
            }
            if(this._finish7Counter <= 10 || this._finish7Counter >= 30)
            {
               this.leg1.y = this._itemsOriginPoints["leg1"].y + this._breathingLegOriginalHeight - this.leg1.height;
               this.leg2.y = this._itemsOriginPoints["leg2"].y + this._breathingLegOriginalHeight - this.leg2.height;
            }
         }
      }
      
      public function activateFinish7(param1:Number, param2:Number, param3:Function) : void
      {
         if(this._finish7Handler == false)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            this._finish7Handler = true;
            this._finish7Counter = 0;
            this._swordEquipmentID = param1;
            this._finish7XDistance = param2 - x;
            this._finishReturnFunction = param3;
            this.addActiveAnimation("finish7");
         }
      }
      
      public function activateEquipmentAnimation(param1:String, param2:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         if(param1 == "torso" || this._mechStructure.torso > 0)
         {
            this.pauseBreathingAndRemoveTeasers(false);
            _loc3_ = param1;
            if(param2 > 0)
            {
               _loc3_ = param1 + param2;
            }
            _loc4_ = this._equipItemsData.length - 1;
            while(_loc4_ >= 0)
            {
               if(_loc3_ == this._equipItemsData[_loc4_].itemName)
               {
                  this._equipItemsData.splice(_loc4_,1);
               }
               _loc4_--;
            }
            switch(param1)
            {
               case "torso":
                  this._equipItemsData.push({
                     "itemName":"torso",
                     "equipmentType":param1,
                     "originXPos":this.torso.x,
                     "targetXPos":this.torso.x,
                     "originYPos":this.torso.y - 300,
                     "targetYPos":this.torso.y
                  });
                  this.torso.y -= 300;
                  break;
               case "leg":
                  this._equipItemsData.push({
                     "itemName":"leg1",
                     "equipmentType":param1,
                     "originXPos":this.leg1.x - 300,
                     "targetXPos":this.leg1.x,
                     "originYPos":this.leg1.y,
                     "targetYPos":this.leg1.y
                  });
                  this._equipItemsData.push({
                     "itemName":"leg2",
                     "equipmentType":param1,
                     "originXPos":this.leg2.x + 300,
                     "targetXPos":this.leg2.x,
                     "originYPos":this.leg2.y,
                     "targetYPos":this.leg2.y
                  });
                  this.leg1.x -= 300;
                  this.leg2.x += 300;
                  break;
               case "sideWeapon":
                  switch(param2)
                  {
                     case 1:
                     case 3:
                        this._equipItemsData.push({
                           "itemName":_loc3_,
                           "equipmentType":param1,
                           "originXPos":this[_loc3_].x - 300,
                           "targetXPos":this[_loc3_].x,
                           "originYPos":this[_loc3_].y,
                           "targetYPos":this[_loc3_].y
                        });
                        this[_loc3_].x -= 300;
                        break;
                     case 2:
                     case 4:
                        this._equipItemsData.push({
                           "itemName":_loc3_,
                           "equipmentType":param1,
                           "originXPos":this[_loc3_].x + 300,
                           "targetXPos":this[_loc3_].x,
                           "originYPos":this[_loc3_].y,
                           "targetYPos":this[_loc3_].y
                        });
                        this[_loc3_].x += 300;
                  }
                  break;
               case "topWeapon":
                  this._equipItemsData.push({
                     "itemName":_loc3_,
                     "equipmentType":param1,
                     "originXPos":this[_loc3_].x,
                     "targetXPos":this[_loc3_].x,
                     "originYPos":this[_loc3_].y - 300,
                     "targetYPos":this[_loc3_].y
                  });
                  this[_loc3_].y -= 300;
            }
         }
      }
      
      private function equipAnimationHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:String = null;
         if(this._equipItemsData.length > 0)
         {
            _loc1_ = this._equipItemsData.length - 1;
            while(_loc1_ >= 0)
            {
               _loc2_ = 20;
               _loc3_ = this._equipItemsData[_loc1_].itemName;
               _loc4_ = _loc3_;
               _loc5_ = Number(this._equipItemsData[_loc1_].originXPos);
               _loc6_ = Number(this._equipItemsData[_loc1_].targetXPos);
               _loc7_ = Number(this._equipItemsData[_loc1_].originYPos);
               _loc8_ = Number(this._equipItemsData[_loc1_].targetYPos);
               switch(this._equipItemsData[_loc1_].equipmentType)
               {
                  case "torso":
                  case "topWeapon":
                     if(_loc7_ > _loc8_)
                     {
                        if(this[_loc3_].y - _loc2_ <= _loc8_)
                        {
                           this[_loc3_].y = _loc8_;
                           _loc3_ = "";
                        }
                        else
                        {
                           this[_loc3_].y -= _loc2_;
                        }
                     }
                     else if(this[_loc3_].y + _loc2_ >= _loc8_)
                     {
                        this[_loc3_].y = _loc8_;
                        _loc3_ = "";
                     }
                     else
                     {
                        this[_loc3_].y += _loc2_;
                     }
                     break;
                  default:
                     if(_loc5_ > _loc6_)
                     {
                        if(this[_loc3_].x - _loc2_ <= _loc6_)
                        {
                           this[_loc3_].x = _loc6_;
                           _loc3_ = "";
                        }
                        else
                        {
                           this[_loc3_].x -= _loc2_;
                        }
                     }
                     else if(this[_loc3_].x + _loc2_ >= _loc6_)
                     {
                        this[_loc3_].x = _loc6_;
                        _loc3_ = "";
                     }
                     else
                     {
                        this[_loc3_].x += _loc2_;
                     }
               }
               if(_loc3_ == "")
               {
                  _loc9_ = "getHit" + (Math.ceil(Math.random() * 2) + 1);
                  soundM.createSound(_loc9_,0.3);
                  this.resumeBreathing();
                  this._equipItemsData.splice(_loc1_,1);
               }
               _loc1_--;
            }
         }
      }
      
      public function activateUnequipAnimation(param1:String, param2:Number) : void
      {
         if(this._mechStructure.torso > 0)
         {
            if(param1 == "leg")
            {
               this.activateUnequipAnimationSub("leg1",0);
               this.activateUnequipAnimationSub("leg2",0);
            }
            else
            {
               this.activateUnequipAnimationSub(param1,param2);
            }
         }
      }
      
      public function activateUnequipAnimationSub(param1:String, param2:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:MovieClip = null;
         var _loc6_:BitmapData = null;
         var _loc7_:Bitmap = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         _loc3_ = param1;
         if(param2 > 0)
         {
            _loc3_ = param1 + param2;
         }
         _loc4_ = this[_loc3_];
         var _loc5_:MovieClip = this["unequip_" + _loc3_];
         _loc6_ = new BitmapData(_loc4_.width,_loc4_.height,true,0);
         _loc7_ = new Bitmap(_loc6_,"auto",true);
         if(param1 == "torso")
         {
            _loc8_ = this[_loc3_].item.itemGrp.mcCenter.x * this.sizeRatio;
            _loc9_ = this[_loc3_].item.itemGrp.mcCenter.y * this.sizeRatio;
         }
         else
         {
            _loc8_ = this[_loc3_].item.itemGrp.mcTorso.x * this.sizeRatio;
            _loc9_ = this[_loc3_].item.itemGrp.mcTorso.y * this.sizeRatio;
         }
         this[_loc3_].item.x += _loc8_;
         this[_loc3_].item.y += _loc9_;
         this[_loc3_].x -= _loc8_;
         this[_loc3_].y -= _loc9_;
         _loc6_.draw(_loc4_);
         _loc7_.smoothing = true;
         if(this["unequip_" + _loc3_].itemBMD != null)
         {
            this["unequip_" + _loc3_].itemBM.parent.removeChild(this["unequip_" + _loc3_].itemBM);
            this["unequip_" + _loc3_].itemBMD.dispose();
            this["unequip_" + _loc3_].itemBMD = null;
            this["unequip_" + _loc3_].itemBM = null;
         }
         this["unequip_" + _loc3_].itemBMD = _loc6_;
         this["unequip_" + _loc3_].itemBM = _loc7_;
         this["unequip_" + _loc3_].addChild(_loc7_);
         this["unequip_" + _loc3_].x = _loc4_.x;
         this["unequip_" + _loc3_].y = _loc4_.y;
         this._unequipItemsData.push(_loc3_);
      }
      
      private function unequipAnimationHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:MovieClip = null;
         var _loc3_:Boolean = false;
         if(this._equipAnimations)
         {
            if(this._unequipItemsData.length > 0)
            {
               _loc1_ = this._unequipItemsData.length - 1;
               while(_loc1_ >= 0)
               {
                  _loc2_ = this["unequip_" + this._unequipItemsData[_loc1_]];
                  _loc3_ = false;
                  switch(this._unequipItemsData[_loc1_])
                  {
                     case "torso":
                     case "leg1":
                     case "sideWeapon1":
                     case "sideWeapon3":
                     case "topWeapon1":
                        _loc2_.x -= 20;
                        if(_loc2_.x < -450)
                        {
                           _loc3_ = true;
                        }
                        break;
                     case "leg2":
                     case "sideWeapon2":
                     case "sideWeapon4":
                     case "topWeapon2":
                        _loc2_.x += 20;
                        if(_loc2_.x > 450)
                        {
                           _loc3_ = true;
                        }
                  }
                  if(_loc3_)
                  {
                     if(this["unequip_" + this._unequipItemsData[_loc1_]].itemBMD != null)
                     {
                        this["unequip_" + this._unequipItemsData[_loc1_]].itemBM.parent.removeChild(this["unequip_" + this._unequipItemsData[_loc1_]].itemBM);
                        this["unequip_" + this._unequipItemsData[_loc1_]].itemBMD.dispose();
                        this["unequip_" + this._unequipItemsData[_loc1_]].itemBMD = null;
                        this["unequip_" + this._unequipItemsData[_loc1_]].itemBM = null;
                     }
                     this._unequipItemsData.splice(_loc1_,1);
                  }
                  _loc1_--;
               }
            }
         }
      }
      
      private function addActiveAnimation(param1:String) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         _loc2_ = false;
         _loc3_ = 0;
         while(_loc3_ < this._activeAnimations.length)
         {
            if(this._activeAnimations[_loc3_] == param1)
            {
               _loc2_ = true;
            }
            _loc3_++;
         }
         if(!_loc2_)
         {
            this._activeAnimations.push(param1);
         }
      }
      
      private function removeActiveAnimation(param1:String, param2:Boolean) : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:Boolean = false;
         _loc4_ = 0;
         while(_loc4_ < this._activeAnimations.length)
         {
            if(this._activeAnimations[_loc4_] == param1)
            {
               this._activeAnimations.splice(_loc4_,1);
               _loc3_ = true;
               _loc4_ = this._activeAnimations.length;
            }
            _loc4_++;
         }
      }
      
      private function removeAllTeaseActiveAnimations() : void
      {
         var _loc1_:Number = NaN;
         _loc1_ = this._activeAnimations.length - 1;
         while(_loc1_ >= 0)
         {
            if(this._activeAnimations[_loc1_].substr(0,5) == "tease")
            {
               this._activeAnimations.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      public function getActiveAnimations() : Array
      {
         return this._activeAnimations;
      }
      
      public function removeMe() : void
      {
         this.clearAllItems(true);
         if(this.useLegsShadow)
         {
            if(this.leg1Shadow != null)
            {
               if(this.leg1Shadow.parent != null)
               {
                  this.leg1Shadow.parent.removeChild(this.leg1Shadow);
                  this.leg2Shadow.parent.removeChild(this.leg2Shadow);
                  this.leg1Shadow = null;
                  this.leg2Shadow = null;
               }
            }
         }
         if(this.mechSizer != null)
         {
            if(this.mechSizer.parent != null)
            {
               this.mechSizer.parent.removeChild(this.mechSizer);
               this.mechSizer = null;
            }
         }
         if(this.chargeEngine != null)
         {
            if(this.chargeEngine.parent != null)
            {
               this.chargeEngine.parent.removeChild(this.chargeEngine);
               this.chargeEngine = null;
            }
         }
         if(this.harpoon != null)
         {
            if(this.harpoon.harpoonMC != null)
            {
               if(this.harpoon.harpoonMC.parent != null)
               {
                  this.harpoon.harpoonMC.parent.removeChild(this.harpoon.harpoonMC);
               }
               this.harpoon.harpoonMC = null;
            }
            if(this.harpoon.parent != null)
            {
               this.harpoon.parent.removeChild(this.harpoon);
            }
            this.harpoon = null;
         }
         if(dataM.runAsMobile)
         {
            this.removeShieldForMobile();
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}

