package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class BMMechBattleData extends BMBaseClass
   {
      
      public var team:Number;
      
      public var playerID:Number;
      
      public var mechID:Number;
      
      public var mechStructure:BMMechStructure;
      
      public var mechView:BMMechView;
      
      public var HPBar:BMBar;
      
      public var drone:BMMechDrone;
      
      public var currentStepVisual:Number;
      
      public var currentStepCode:Number;
      
      public var stepsPerWalk:Number;
      
      public var stepsPerJump:Number;
      
      public var weaponAlreadyFired:Array;
      
      public var forceShutDown:Number;
      
      public var usesMax:Array;
      
      public var uses:Array;
      
      public var HP:Number = 0;
      
      public var HPMax:Number = 0;
      
      public var energy:Number = 0;
      
      public var energyMax:Number = 0;
      
      public var energyRegeneration:Number = 0;
      
      public var heat:Number = 0;
      
      public var heatMax:Number = 0;
      
      public var heatCooling:Number = 0;
      
      public var bullets:Number = 0;
      
      public var bulletsMax:Number = 0;
      
      public var rockets:Number = 0;
      
      public var rocketsMax:Number = 0;
      
      public var droneActive:Boolean;
      
      public var droneFired:Boolean;
      
      public var shieldActive:Boolean;
      
      public var shieldType:String;
      
      public var resist1:Number = 0;
      
      public var resist2:Number = 0;
      
      public var resist3:Number = 0;
      
      public var dataSetByReplay:Boolean = false;
      
      public var stompDamageRatio:Number;
      
      public var generalDamageRatio:Number;
      
      private var _xPosBeforePush:Number;
      
      private var _pushDistance:Number;
      
      private var _pushDistanceLeft:Number;
      
      private var _pushEndFunction:Function;
      
      private var _pushEndRefreshBattleView:Boolean;
      
      private var _destructionOrder:Array;
      
      private var _destructionOrderSlot:Number;
      
      private var _destructionDelayFrames:Number;
      
      private var _destruction1FrameCountdown:Number;
      
      private var _destruction2FrameCounter:Number;
      
      private var _destruction2EquipmentData:Object;
      
      private var _destroyMechReturnFunction:Function;
      
      private var _chargeDirection:String;
      
      private var _chargeSpeed:Number;
      
      private var _chargeTargetXPos:Number;
      
      private var _chargePhase:String;
      
      private var _chargeChargingAnimationEndedFunction:Function;
      
      private var _crashDirection:String;
      
      private var _crashSpeed:Number;
      
      private var _crashTargetXPos:Number;
      
      private var _crashChargingAnimationEndedFunction:Function;
      
      private var _pushMeHandler:Boolean = false;
      
      private var _destruction1Handler:Boolean = false;
      
      private var _destruction2Handler:Boolean = false;
      
      private var _chargeHandler:Boolean = false;
      
      private var _crashHandler:Boolean = false;
      
      private var _pushMeMovementCounter:Number;
      
      private var _pushMeFromBack:Boolean;
      
      private var _pushMeMovementData:Object = new Object();
      
      private var _autoDeactivateDroneHandler:Boolean = false;
      
      private var _autoDeactivateDroneFramesCountdown:Number = 0;
      
      private const PUSH_RATIO_PER_FRAME_CLOSE:Number = 0.2;
      
      private const PUSH_RATIO_PER_FRAME_MEDIUM:Number = 0.15;
      
      private const PUSH_RATIO_PER_FRAME_FAR:Number = 0.1;
      
      private const SPARKS_PER_FRAME:Number = 20;
      
      private const SPARKS_SPAWNING_FRAMES:Number = 4;
      
      private const SPARKS_LIFE_FRAMES:Number = 40;
      
      public function BMMechBattleData()
      {
         super();
      }
      
      public function initialize() : *
      {
         generateSingletonClassesPointers("");
         this.droneActive = false;
         this.droneFired = false;
         this.shieldActive = false;
         this.shieldType = "none";
         this.forceShutDown = 0;
         this.stompDamageRatio = 1;
         this.generalDamageRatio = 1;
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.destruction1Handler();
         this.destruction2Handler();
         this.pushMeHandler();
         this.chargeHandler();
         this.crashHandler();
         this.autoDeactivateDroneHandler();
         if(this.mechView != null)
         {
            this.mechView.onEnterFrameTrigger();
         }
         if(this.drone != null && this.mechStructure.drone > 0)
         {
            this.drone.onEnterFrameTrigger();
         }
      }
      
      public function setHPMax() : void
      {
         var _loc1_:BMPlayerItemData = dataM.getPlayerItemData(this.playerID,this.mechStructure.torso);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_.itemID];
         this.HPMax = _loc2_.HPBase;
         if(this.mechStructure.leg > 0)
         {
            _loc1_ = dataM.getPlayerItemData(this.playerID,this.mechStructure.leg);
            _loc2_ = dataM.itemsDB[_loc1_.itemID];
            this.HPMax += _loc2_.HPBase;
         }
         var _loc3_:uint = 1;
         while(_loc3_ <= dataM.maxEquipment["module"])
         {
            if(this.mechStructure["module" + _loc3_] > 0)
            {
               _loc1_ = dataM.getPlayerItemData(this.playerID,this.mechStructure["module" + _loc3_]);
               _loc2_ = dataM.itemsDB[_loc1_.itemID];
               this.HPMax += _loc2_.HPBase;
            }
            _loc3_++;
         }
         this.HP = this.HPMax;
      }
      
      public function setEnergyMaxAndRegeneration() : void
      {
         var _loc1_:BMPlayerItemData = dataM.getPlayerItemData(this.playerID,this.mechStructure.torso);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_.itemID];
         this.energyMax = _loc2_.energyBase;
         this.energyRegeneration = _loc2_.energyAddon;
         var _loc3_:uint = 1;
         while(_loc3_ <= dataM.maxEquipment["module"])
         {
            if(this.mechStructure["module" + _loc3_] > 0)
            {
               _loc1_ = dataM.getPlayerItemData(this.playerID,this.mechStructure["module" + _loc3_]);
               _loc2_ = dataM.itemsDB[_loc1_.itemID];
               this.energyMax += _loc2_.energyBase;
               this.energyRegeneration += _loc2_.energyAddon;
            }
            _loc3_++;
         }
         this.energy = this.energyMax;
      }
      
      public function setHeatMaxAndCooling() : void
      {
         var _loc1_:BMPlayerItemData = dataM.getPlayerItemData(this.playerID,this.mechStructure.torso);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_.itemID];
         this.heatMax = _loc2_.heatBase;
         this.heatCooling = _loc2_.heatAddon;
         var _loc3_:uint = 1;
         while(_loc3_ <= dataM.maxEquipment["module"])
         {
            if(this.mechStructure["module" + _loc3_] > 0)
            {
               _loc1_ = dataM.getPlayerItemData(this.playerID,this.mechStructure["module" + _loc3_]);
               _loc2_ = dataM.itemsDB[_loc1_.itemID];
               this.heatMax += _loc2_.heatBase;
               this.heatCooling += _loc2_.heatAddon;
            }
            _loc3_++;
         }
         this.heat = 0;
      }
      
      public function setBulletsMax() : void
      {
         var _loc1_:BMPlayerItemData = dataM.getPlayerItemData(this.playerID,this.mechStructure.torso);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_.itemID];
         this.bulletsMax = _loc2_.bullets;
         var _loc3_:uint = 1;
         while(_loc3_ <= dataM.maxEquipment["module"])
         {
            if(this.mechStructure["module" + _loc3_] > 0)
            {
               _loc1_ = dataM.getPlayerItemData(this.playerID,this.mechStructure["module" + _loc3_]);
               _loc2_ = dataM.itemsDB[_loc1_.itemID];
               this.bulletsMax += _loc2_.bullets;
            }
            _loc3_++;
         }
         this.bullets = this.bulletsMax;
      }
      
      public function setRocketsMax() : void
      {
         var _loc1_:BMPlayerItemData = dataM.getPlayerItemData(this.playerID,this.mechStructure.torso);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_.itemID];
         this.rocketsMax = _loc2_.rockets;
         var _loc3_:uint = 1;
         while(_loc3_ <= dataM.maxEquipment["module"])
         {
            if(this.mechStructure["module" + _loc3_] > 0)
            {
               _loc1_ = dataM.getPlayerItemData(this.playerID,this.mechStructure["module" + _loc3_]);
               _loc2_ = dataM.itemsDB[_loc1_.itemID];
               this.rocketsMax += _loc2_.rockets;
            }
            _loc3_++;
         }
         this.rockets = this.rocketsMax;
      }
      
      public function setMovementParameters() : void
      {
         var _loc1_:BMPlayerItemData = dataM.getPlayerItemData(this.playerID,this.mechStructure.leg);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_.itemID];
         this.stepsPerWalk = _loc2_.stepsPerWalk;
         this.stepsPerJump = _loc2_.stepsPerJump;
      }
      
      public function resetAlreadyFired() : void
      {
         var _loc1_:uint = 0;
         this.weaponAlreadyFired = new Array();
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["sideWeapon"])
         {
            this.weaponAlreadyFired["sideWeapon" + _loc1_] = false;
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= dataM.maxEquipment["topWeapon"])
         {
            this.weaponAlreadyFired["topWeapon" + _loc1_] = false;
            _loc1_++;
         }
      }
      
      public function setUses() : void
      {
         var _loc1_:BMPlayerItemData = null;
         var _loc2_:BMItemData = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         this.usesMax = new Array();
         this.uses = new Array();
         _loc4_ = 1;
         while(_loc4_ <= dataM.maxEquipment["sideWeapon"])
         {
            this.updateUses("sideWeapon" + _loc4_);
            _loc4_++;
         }
         _loc4_ = 1;
         while(_loc4_ <= dataM.maxEquipment["topWeapon"])
         {
            this.updateUses("topWeapon" + _loc4_);
            _loc4_++;
         }
         this.updateUses("teleport");
         this.updateUses("charge");
         this.updateUses("harpoon");
         this.updateUses("drone");
         this.updateUses("leg");
      }
      
      private function updateUses(param1:String) : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMItemData = null;
         if(this.mechStructure[param1] > 0)
         {
            _loc2_ = dataM.getPlayerItemData(this.playerID,this.mechStructure[param1]);
            _loc3_ = dataM.itemsDB[_loc2_.itemID];
            this.uses[param1] = 0;
            this.usesMax[param1] = _loc3_.uses;
         }
      }
      
      public function setAllResistances() : void
      {
         this.setSpecificResistanc(1);
         this.setSpecificResistanc(2);
         this.setSpecificResistanc(3);
      }
      
      public function setSpecificResistanc(param1:Number) : void
      {
         var _loc2_:Number = 0;
         _loc2_ += this.getResistanceFromSpecificItem("torso",param1);
         _loc2_ += this.getResistanceFromSpecificItem("leg",param1);
         var _loc3_:uint = 1;
         while(_loc3_ <= dataM.maxEquipment["module"])
         {
            _loc2_ += this.getResistanceFromSpecificItem("module" + _loc3_,param1);
            _loc3_++;
         }
         this["resist" + param1] = _loc2_;
      }
      
      private function getResistanceFromSpecificItem(param1:String, param2:Number) : Number
      {
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:BMItemData = null;
         var _loc3_:Number = 0;
         var _loc4_:Number = Number(this.mechStructure[param1]);
         if(_loc4_ > 0)
         {
            _loc5_ = dataM.getPlayerItemData(this.playerID,_loc4_);
            _loc6_ = dataM.itemsDB[_loc5_.itemID];
            _loc3_ = Number(_loc6_["resist" + param2]);
         }
         return _loc3_;
      }
      
      public function launchHarpoon(param1:String, param2:Number, param3:Number, param4:String, param5:BMMechBattleData, param6:Function, param7:Function) : void
      {
         this.endCurrentPush();
         this.mechView.launchHarpoon(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function createDrone(param1:String) : void
      {
         var _loc2_:BMItemData = null;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:uint = 0;
         if(this.mechStructure.drone > 0)
         {
            _loc3_ = 0;
            switch(param1)
            {
               case "playerItemID":
                  _loc5_ = dataM.getPlayerItemData(this.playerID,this.mechStructure.drone);
                  _loc2_ = dataM.itemsDB[_loc5_.itemID];
                  if(_loc5_.colorID > 0)
                  {
                     _loc3_ = _loc5_.colorID;
                  }
                  else
                  {
                     _loc6_ = dataM.getItemPowerLevel(_loc2_);
                     if(_loc6_ > 1)
                     {
                        _loc3_ = dataM.getItemPowerColorID(this.playerID,this.mechStructure.drone);
                     }
                  }
                  break;
               case "itemID":
                  _loc2_ = dataM.itemsDB[this.mechStructure.drone];
            }
            _loc4_ = this.mechView.torso.item.itemGrp;
            this.drone.initialize(_loc2_.grp,this,_loc4_,this.mechView.sizeRatio,_loc3_);
         }
      }
      
      public function removeDroneStaticGlow() : void
      {
         if(this.drone != null)
         {
            this.drone.removeStaticGlow();
         }
      }
      
      public function addDroneStaticGlow(param1:String) : void
      {
         if(this.drone != null)
         {
            this.drone.addStaticGlow(param1);
         }
      }
      
      public function autoDeactivateDroneInXFrames(param1:uint) : void
      {
         this._autoDeactivateDroneHandler = true;
         this._autoDeactivateDroneFramesCountdown = param1;
      }
      
      private function autoDeactivateDroneHandler() : void
      {
         if(this._autoDeactivateDroneHandler)
         {
            if(this._autoDeactivateDroneFramesCountdown > 0)
            {
               --this._autoDeactivateDroneFramesCountdown;
            }
            else
            {
               this._autoDeactivateDroneHandler = false;
               soundM.createSound("droneOff",1);
               this.droneActive = false;
               this.uses["drone"] = 0;
            }
         }
      }
      
      public function activateShield() : void
      {
         this.shieldActive = true;
         if(dataM.runAsMobile)
         {
            this.mechView.activateShield_mobile(this.shieldType);
         }
         else
         {
            this.mechView.activateShield(this.shieldType);
         }
      }
      
      public function deactivateShield() : void
      {
         this.shieldActive = false;
         if(dataM.runAsMobile)
         {
            this.mechView.deactivateShield_mobile();
         }
         else
         {
            this.mechView.deactivateShield();
         }
      }
      
      public function pushMe(param1:Number, param2:Boolean, param3:Function, param4:Boolean) : void
      {
         this.endCurrentPush();
         this._xPosBeforePush = this.mechView.x;
         this._pushDistance = param1;
         this._pushMeFromBack = param2;
         this._pushDistanceLeft = this._pushDistance;
         this._pushEndFunction = param3;
         this._pushEndRefreshBattleView = param4;
         this._pushMeHandler = true;
         var _loc5_:Boolean = false;
         var _loc6_:String = this._pushDistance + "_" + this._pushMeFromBack + "_" + this.mechView.scaleX;
         if(this._pushMeMovementData[_loc6_] == null)
         {
            _loc5_ = true;
         }
         else if(this._pushMeMovementData[_loc6_].completed == false)
         {
            _loc5_ = true;
         }
         if(_loc5_)
         {
            this._pushMeMovementData[_loc6_] = new Object();
            this._pushMeMovementData[_loc6_].xChangeArray = new Array();
            this._pushMeMovementData[_loc6_].completed = false;
         }
         else
         {
            this._pushMeMovementCounter = 0;
         }
      }
      
      private function pushMeHandler() : void
      {
         var _loc1_:String = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this._pushMeHandler)
         {
            if(this.mechView != null)
            {
               _loc1_ = this._pushDistance + "_" + this._pushMeFromBack + "_" + this.mechView.scaleX;
               if(this._pushMeMovementData[_loc1_] == null)
               {
                  this._pushMeMovementData[_loc1_] = new Object();
                  this._pushMeMovementData[_loc1_].xChangeArray = new Array();
                  this._pushMeMovementData[_loc1_].completed = false;
               }
               if(this._pushMeMovementData[_loc1_].completed)
               {
                  if(this._pushMeMovementCounter == this._pushMeMovementData[_loc1_].xChangeArray.length - 1)
                  {
                     this._pushEndFunction(this._pushEndRefreshBattleView);
                     this._pushMeHandler = false;
                  }
                  else if(this._pushMeFromBack)
                  {
                     this.mechView.x += this._pushMeMovementData[_loc1_].xChangeArray[this._pushMeMovementCounter];
                  }
                  else
                  {
                     this.mechView.x -= this._pushMeMovementData[_loc1_].xChangeArray[this._pushMeMovementCounter];
                  }
                  ++this._pushMeMovementCounter;
               }
               else
               {
                  _loc2_ = this.mechView.x;
                  if(this._pushDistanceLeft == 0)
                  {
                     this._pushEndFunction(this._pushEndRefreshBattleView);
                     this._pushMeHandler = false;
                     this._pushMeMovementData[_loc1_].completed = true;
                  }
                  else
                  {
                     if(this._pushDistanceLeft < 1)
                     {
                        if(this._pushMeFromBack)
                        {
                           this.mechView.x = this._xPosBeforePush + this._pushDistance * this.mechView.scaleX;
                        }
                        else
                        {
                           this.mechView.x = this._xPosBeforePush - this._pushDistance * this.mechView.scaleX;
                        }
                        this._pushDistanceLeft = 0;
                     }
                     else
                     {
                        if(this._pushDistance < 210)
                        {
                           _loc3_ = this.PUSH_RATIO_PER_FRAME_CLOSE;
                        }
                        else if(this._pushDistance < 410)
                        {
                           _loc3_ = this.PUSH_RATIO_PER_FRAME_MEDIUM;
                        }
                        else
                        {
                           _loc3_ = this.PUSH_RATIO_PER_FRAME_FAR;
                        }
                        if(dataM.slowCPUMode)
                        {
                           _loc3_ *= 2;
                        }
                        _loc4_ = this._pushDistanceLeft * _loc3_;
                        if(this._pushMeFromBack)
                        {
                           this.mechView.x += _loc4_ * this.mechView.scaleX;
                        }
                        else
                        {
                           this.mechView.x -= _loc4_ * this.mechView.scaleX;
                        }
                        this._pushDistanceLeft -= _loc4_;
                     }
                     if(this._pushMeFromBack)
                     {
                        this._pushMeMovementData[_loc1_].xChangeArray.push(this.mechView.x - _loc2_);
                     }
                     else
                     {
                        this._pushMeMovementData[_loc1_].xChangeArray.push(_loc2_ - this.mechView.x);
                     }
                  }
               }
            }
            else
            {
               TsLogger.log("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
            }
         }
      }
      
      public function endCurrentPush() : void
      {
         if(this._pushMeHandler)
         {
            TsLogger.log(" ! ! ! WARNING - PUSH ANIMATION ENDED MANUALLY FOR PLAYER ID " + this.playerID);
            this.mechView.x = this._xPosBeforePush - this._pushDistance * this.mechView.scaleX;
            this._pushDistanceLeft = 0;
            this._pushEndFunction(this._pushEndRefreshBattleView);
            this._pushMeHandler = false;
         }
      }
      
      public function mechBeingPushed() : Boolean
      {
         return this._pushMeHandler;
      }
      
      public function destroyMech(param1:Number, param2:Number, param3:Function) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         this._destroyMechReturnFunction = param3;
         this._destructionDelayFrames = param2;
         this._destructionOrder = new Array();
         if(param1 == 1)
         {
            this.addEquipmentToDestructionOrderArray("drone");
         }
         this._destruction2EquipmentData = new Object();
         _loc4_ = 1;
         while(_loc4_ <= dataM.maxEquipment["sideWeapon"])
         {
            this.addEquipmentToDestructionOrderArray("sideWeapon" + _loc4_);
            _loc4_++;
         }
         _loc4_ = 1;
         while(_loc4_ <= dataM.maxEquipment["topWeapon"])
         {
            this.addEquipmentToDestructionOrderArray("topWeapon" + _loc4_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < this._destructionOrder.length)
         {
            _loc6_ = Math.ceil(Math.random() * this._destructionOrder.length) - 1;
            if(_loc6_ != _loc4_)
            {
               _loc5_ = this._destructionOrder[_loc4_];
               this._destructionOrder[_loc4_] = this._destructionOrder[_loc6_];
               this._destructionOrder[_loc6_] = _loc5_;
            }
            _loc4_++;
         }
         this._destruction1FrameCountdown = 20;
         this._destructionOrderSlot = 0;
         this._destruction2FrameCounter = 0;
         switch(param1)
         {
            case 1:
               this._destruction1Handler = true;
               break;
            case 2:
               this._destruction2Handler = true;
         }
         this.mechView.deactivateBreathing();
      }
      
      private function addEquipmentToDestructionOrderArray(param1:String) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Boolean = false;
         if(this.mechStructure[param1] > 0)
         {
            if(param1 == "drone")
            {
               if(this.droneActive)
               {
                  _loc2_ = true;
               }
            }
            else
            {
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            this._destructionOrder.push(param1);
            _loc3_ = 40 + Math.ceil(Math.random() * 40);
            _loc4_ = -(15 + Math.random() * 10);
            switch(param1)
            {
               case "sideWeapon1":
               case "sideWeapon3":
                  this._destruction2EquipmentData[param1] = {
                     "floorHits":0,
                     "framesTotal":_loc3_,
                     "xSpeed":Math.random() * -3 - 2,
                     "ySpeed":_loc4_
                  };
                  break;
               case "topWeapon1":
                  this._destruction2EquipmentData[param1] = {
                     "floorHits":0,
                     "framesTotal":_loc3_,
                     "xSpeed":Math.random() * -3,
                     "ySpeed":_loc4_
                  };
                  break;
               case "sideWeapon2":
               case "sideWeapon4":
                  this._destruction2EquipmentData[param1] = {
                     "floorHits":0,
                     "framesTotal":_loc3_,
                     "xSpeed":Math.random() * 3 + 2,
                     "ySpeed":_loc4_
                  };
                  break;
               case "topWeapon2":
                  this._destruction2EquipmentData[param1] = {
                     "floorHits":0,
                     "framesTotal":_loc3_,
                     "xSpeed":Math.random() * 3,
                     "ySpeed":_loc4_
                  };
            }
         }
      }
      
      private function destruction1Handler() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Point = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         if(this._destruction1Handler)
         {
            if(this._destructionDelayFrames == 0)
            {
               if(this._destruction1FrameCountdown == 0)
               {
                  if(this._destructionOrderSlot < this._destructionOrder.length)
                  {
                     switch(this._destructionOrder[this._destructionOrderSlot])
                     {
                        case "drone":
                           _loc1_ = this.drone;
                           this.drone.droneGrp.visible = false;
                           _loc2_ = new Point(this.drone.droneGrp.x,this.drone.droneGrp.y);
                           break;
                        default:
                           _loc1_ = this.mechView[this._destructionOrder[this._destructionOrderSlot]];
                           _loc1_.visible = false;
                           _loc8_ = new Point(_loc1_.x,_loc1_.y);
                           _loc9_ = this.mechView.localToGlobal(_loc8_);
                           _loc2_ = screensM.screenBattle.holder_effects.globalToLocal(_loc9_);
                     }
                     screensM.screenBattle.createMechReflection(this.playerID,false);
                     this.createMechSmallExplosion(_loc2_.x,_loc2_.y);
                     this._destruction1FrameCountdown = Math.ceil(Math.random() * 4) + 5;
                     ++this._destructionOrderSlot;
                     _loc3_ = false;
                     _loc4_ = false;
                     _loc5_ = false;
                     _loc6_ = Math.ceil(Math.random() * 3);
                     if(_loc6_ == 1)
                     {
                        _loc3_ = true;
                     }
                     else if(_loc6_ == 2)
                     {
                        _loc4_ = true;
                     }
                     else
                     {
                        _loc5_ = true;
                     }
                     this.mechView.activateGetHitAnimation(_loc3_,_loc4_,_loc5_);
                     _loc6_ = Math.ceil(Math.random() * 2);
                     _loc7_ = "explosionSmall";
                     if(_loc6_ == 1)
                     {
                        _loc7_ = "explosionMedium";
                     }
                     soundM.createSound(_loc7_,1);
                  }
                  else if(this._destructionOrderSlot == this._destructionOrder.length)
                  {
                     this._destruction1FrameCountdown = 30;
                     ++this._destructionOrderSlot;
                     this.mechView.visible = false;
                     this.createMechBigExplosion(1);
                     soundM.createSound("explosionBig",1);
                     screensM.screenBattle.createEarthQuake();
                  }
                  else
                  {
                     this._destruction1Handler = false;
                     if(this._destroyMechReturnFunction != null)
                     {
                        this._destroyMechReturnFunction(this.playerID);
                     }
                     this.removeMe();
                  }
               }
               else
               {
                  --this._destruction1FrameCountdown;
               }
            }
            else
            {
               --this._destructionDelayFrames;
            }
         }
      }
      
      private function createMechSmallExplosion(param1:Number, param2:Number) : void
      {
         effectsM.createExplosion(3,param1,param2,0,30,20,2,7,2,screensM.screenBattle.holder_effects);
         effectsM.createSparksMC("screenBattle","debrie",param1,param2,7,1,40,"horizontal","",true);
         effectsM.createSparksMC("screenBattle","spark",param1,param2,Math.ceil(this.SPARKS_PER_FRAME / 2),this.SPARKS_SPAWNING_FRAMES,Math.ceil(this.SPARKS_LIFE_FRAMES / 2),"horizontal","orange",true);
      }
      
      private function createMechBigExplosion(param1:Number) : void
      {
         effectsM.createSparksMC("screenBattle","debrie",this.mechView.x,this.mechView.y,30,1,40,"horizontal","",true);
         effectsM.createSparksMC("screenBattle","debrie",this.mechView.x,this.mechView.y,20,1,40,"vertical","",true);
         switch(param1)
         {
            case 1:
               effectsM.createExplosion(10,this.mechView.x,this.mechView.y,100,60,40,3,10,5,screensM.screenBattle.holder_effects);
               break;
            case 2:
               effectsM.createMegaExplosion(screensM.screenBattle.holder_effects,this.mechView.x,this.mechView.y - 20);
         }
         effectsM.createSparksMC("screenBattle","spark",this.mechView.x,this.mechView.y,this.SPARKS_PER_FRAME,this.SPARKS_SPAWNING_FRAMES,this.SPARKS_LIFE_FRAMES,"horizontal","orange",true);
      }
      
      private function destruction2Handler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Number = NaN;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         if(this._destruction2Handler)
         {
            if(this._destructionDelayFrames == 0)
            {
               if(this._destruction2FrameCounter == 0)
               {
                  this._destruction1FrameCountdown = 30;
                  ++this._destructionOrderSlot;
                  this.mechView.torso.visible = false;
                  this.mechView.leg1.visible = false;
                  this.mechView.leg2.visible = false;
                  if(this.mechView.useLegsShadow)
                  {
                     this.mechView.legsShadowHolder.visible = false;
                  }
                  this.createMechBigExplosion(2);
                  if(this.droneActive)
                  {
                     this.drone.droneGrp.visible = false;
                     this.createMechSmallExplosion(this.drone.droneGrp.x,this.drone.droneGrp.y);
                  }
                  soundM.createSound("explosionBig",1);
                  screensM.screenBattle.createEarthQuake();
               }
               _loc1_ = 0;
               _loc2_ = 0;
               while(_loc2_ < this._destructionOrder.length)
               {
                  _loc3_ = this.mechView[this._destructionOrder[_loc2_]];
                  if(this._destruction2FrameCounter == 0)
                  {
                     _loc3_.rotation = Math.random() * 20 - 10;
                  }
                  if(this._destruction2EquipmentData[this._destructionOrder[_loc2_]].framesTotal > this._destruction2FrameCounter)
                  {
                     _loc1_++;
                     _loc3_.x += this._destruction2EquipmentData[this._destructionOrder[_loc2_]].xSpeed;
                     _loc3_.y += this._destruction2EquipmentData[this._destructionOrder[_loc2_]].ySpeed;
                     _loc4_ = _loc3_.y + _loc3_.height - _loc3_.item.itemGrp.mcTorso.x * this.mechView.sizeRatio;
                     if(this._destruction2EquipmentData[this._destructionOrder[_loc2_]].ySpeed > 0 && _loc4_ > this.mechView.mechSizer.height + this.mechView.mechSizer.y)
                     {
                        ++this._destruction2EquipmentData[this._destructionOrder[_loc2_]].floorHits;
                        this._destruction2EquipmentData[this._destructionOrder[_loc2_]].ySpeed = -10 + this._destruction2EquipmentData[this._destructionOrder[_loc2_]].floorHits;
                        _loc3_.rotation = Math.random() * 20 - 10;
                        if(this._destruction2EquipmentData[this._destructionOrder[_loc2_]].ySpeed > -2)
                        {
                           this._destruction2EquipmentData[this._destructionOrder[_loc2_]].ySpeed = -2;
                        }
                     }
                     else
                     {
                        this._destruction2EquipmentData[this._destructionOrder[_loc2_]].ySpeed += 1;
                     }
                  }
                  else if(this._destruction2EquipmentData[this._destructionOrder[_loc2_]].framesTotal == this._destruction2FrameCounter)
                  {
                     _loc3_.visible = false;
                     _loc5_ = new Point(_loc3_.x,_loc3_.y);
                     _loc6_ = this.mechView.localToGlobal(_loc5_);
                     _loc7_ = screensM.screenBattle.holder_effects.globalToLocal(_loc6_);
                     this.createMechSmallExplosion(_loc7_.x,_loc7_.y);
                     soundM.createSound("explosionSmall",1);
                  }
                  _loc2_++;
               }
               if(_loc1_ == 0)
               {
                  this._destruction2Handler = false;
                  if(this._destroyMechReturnFunction != null)
                  {
                     this._destroyMechReturnFunction(this.playerID);
                  }
                  this.removeMe();
               }
               ++this._destruction2FrameCounter;
            }
            else
            {
               --this._destructionDelayFrames;
            }
         }
      }
      
      public function charge(param1:Number, param2:Function) : void
      {
         this.endCurrentPush();
         this._chargeTargetXPos = param1;
         this._chargeDirection = "right";
         this._chargeSpeed = 4;
         if(dataM.slowCPUMode)
         {
            this._chargeSpeed = 8;
         }
         this._chargePhase = "rocketAnimation";
         this._chargeChargingAnimationEndedFunction = param2;
         if(this._chargeTargetXPos < this.mechView.x)
         {
            this._chargeDirection = "left";
            this._chargeSpeed *= -1;
         }
         this.mechView.activateChargeEngine(this.chargeEngineFireStarted,this.chargeEngineFireEnded);
         this._chargeHandler = true;
      }
      
      private function chargeEngineFireStarted() : void
      {
         this._chargePhase = "charge_withSmoke";
      }
      
      private function chargeEngineFireEnded() : void
      {
         this._chargePhase = "charge_withoutSmoke";
      }
      
      private function chargeHandler() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         if(this._chargeHandler)
         {
            switch(this._chargePhase)
            {
               case "rocketAnimation":
                  break;
               case "charge_withSmoke":
               case "charge_withoutSmoke":
                  _loc1_ = false;
                  switch(this._chargeDirection)
                  {
                     case "right":
                        if(this.mechView.x + this._chargeSpeed >= this._chargeTargetXPos)
                        {
                           _loc1_ = true;
                        }
                        else
                        {
                           this.mechView.x += this._chargeSpeed;
                        }
                        break;
                     case "left":
                        if(this.mechView.x + this._chargeSpeed <= this._chargeTargetXPos)
                        {
                           _loc1_ = true;
                        }
                        else
                        {
                           this.mechView.x += this._chargeSpeed;
                        }
                  }
                  if(_loc1_)
                  {
                     this.mechView.x = this._chargeTargetXPos;
                     this._chargeChargingAnimationEndedFunction();
                     this._chargeHandler = false;
                  }
                  else if(dataM.slowCPUMode)
                  {
                     this._chargeSpeed *= 1.2;
                  }
                  else
                  {
                     this._chargeSpeed *= 1.1;
                  }
                  if(this._chargePhase == "charge_withSmoke")
                  {
                     _loc2_ = 40;
                     if(this._chargeSpeed > _loc2_)
                     {
                        _loc3_ = 1;
                        while(_loc3_ < Math.floor(this._chargeSpeed / _loc2_))
                        {
                           _loc3_++;
                        }
                     }
                  }
            }
         }
      }
      
      public function crash(param1:Number, param2:Function) : void
      {
         this.endCurrentPush();
         this._crashTargetXPos = param1;
         this._crashDirection = "right";
         this._crashSpeed = 4;
         if(dataM.slowCPUMode)
         {
            this._crashSpeed = 8;
         }
         this._crashChargingAnimationEndedFunction = param2;
         if(this._crashTargetXPos < this.mechView.x)
         {
            this._crashDirection = "left";
            this._crashSpeed *= -1;
         }
         this.mechView.activateWheelsAnimation();
         this._crashHandler = true;
      }
      
      private function crashHandler() : void
      {
         var _loc1_:Boolean = false;
         if(this._crashHandler)
         {
            _loc1_ = false;
            switch(this._crashDirection)
            {
               case "right":
                  if(this.mechView.x + this._crashSpeed >= this._crashTargetXPos)
                  {
                     _loc1_ = true;
                  }
                  else
                  {
                     this.mechView.x += this._crashSpeed;
                  }
                  break;
               case "left":
                  if(this.mechView.x + this._crashSpeed <= this._crashTargetXPos)
                  {
                     _loc1_ = true;
                  }
                  else
                  {
                     this.mechView.x += this._crashSpeed;
                  }
            }
            if(_loc1_)
            {
               this.mechView.x = this._crashTargetXPos;
               this._crashChargingAnimationEndedFunction();
               this.mechView.deactivateWheelsAnimation();
               this._crashHandler = false;
            }
            else if(dataM.slowCPUMode)
            {
               this._crashSpeed *= 1.3;
            }
            else
            {
               this._crashSpeed *= 1.15;
            }
         }
      }
      
      public function showMe() : void
      {
         this.mechView.visible = true;
         if(this.drone != null)
         {
            this.drone.visible = true;
         }
      }
      
      public function hideMe() : void
      {
         this.mechView.visible = false;
         if(this.drone != null)
         {
            this.drone.visible = false;
         }
      }
      
      public function removeMe() : void
      {
         if(this.mechView != null)
         {
            this.mechView.removeMe();
            this.mechView = null;
         }
         if(this.drone != null)
         {
            this.drone.removeMe();
            this.drone = null;
         }
      }
   }
}

