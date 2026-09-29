package net.battleMechsMulti.managers
{
   import flash.events.Event;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechBattleData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.screens.BMScreenBattle;
   import net.battleMechsMulti.screens.battle.BMBattleManager;
   import net.tacticsoft.utils.RandomUtils;
   
   public class BMComputerManager extends BMBaseClass
   {
      
      private var screenBattle:BMScreenBattle;
      
      private var opponentProfile:BMPlayerProfile;
      
      private var opponentPlayerData:BMPlayerData;
      
      private var opponentMechSlot:String;
      
      private var opponentMechBattleData:BMMechBattleData;
      
      private var computerProfile:BMPlayerProfile;
      
      private var computerPlayerData:BMPlayerData;
      
      private var computerMechSlot:String;
      
      private var computerMechBattleData:BMMechBattleData;
      
      private var computerPlayerID:uint;
      
      private var opponentPlayerID:uint;
      
      private var userAutopilot:Boolean;
      
      private var desiredWeaponInfo:Object;
      
      private var forceTutorialMoveBack:Boolean;
      
      private var playDumb:Boolean;
      
      private var activateDrone:Boolean;
      
      private var deactivateDrone:Boolean;
      
      private var activateShield:Boolean;
      
      private var deactivateShield:Boolean;
      
      private var fireWeapon:Boolean;
      
      private var fireWeaponType:String;
      
      private var fireWeaponEquipmentID:Number;
      
      private var useKit:Boolean;
      
      private var useKitEquipmentID:Number;
      
      private var useTeleport:Boolean;
      
      private var useTeleportTargetStep:Number;
      
      private var useCharge:Boolean;
      
      private var useHarpoon:Boolean;
      
      private var useStomp:Boolean;
      
      private var walkRight:Boolean;
      
      private var walkLeft:Boolean;
      
      private var jumpRight:Boolean;
      
      private var jumpLeft:Boolean;
      
      private var canStomp:Boolean;
      
      private var canMove:Boolean;
      
      private var finalAction:String;
      
      private var botWaitingFramesCountdown:uint;
      
      private const KIT_RATIO_HP:Number = 0.75;
      
      private const KIT_RATIO_HEAT:Number = 0.75;
      
      private const KIT_RATIO_ENERGY:Number = 0.25;
      
      private const KIT_RATIO_BULLETS:Number = 0.25;
      
      private const KIT_RATIO_ROCKETS:Number = 0.25;
      
      private const KIT_MIN_BULLETS:Number = 5;
      
      private const KIT_MIN_ROCKETS:Number = 5;
      
      private const HP_RATIO_CRITICAL:Number = 0.2;
      
      private const DRONE_ATTACKS_REQUIRED_TO_ACTIVATE:Number = 2;
      
      private const SHIELD_ENERGY_BLOCKS_REQUIRED_TO_ACTIVATE:Number = 4;
      
      private const SHIELD_ENERGY_BLOCKS_REQUIRED_TO_DEACTIVATE:Number = 1;
      
      private const SHIELD_HEAT_RATIO_TO_ACTIVATE:Number = 0.5;
      
      private const MOTION_CALCULATION_AP:Number = 20;
      
      private const PLAY_DUMB_LEVEL_MAX:Number = 10;
      
      private const PLAY_DUMB_LEVEL_DIFFERENCE:Number = 4;
      
      private const PLAY_DUMB_HP_RATIO:Number = 0.3;
      
      public function BMComputerManager()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function executeTurn(param1:uint, param2:String = "") : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         this.screenBattle = screensM.screenBattle;
         this.computerPlayerID = param1;
         this.resetParams();
         if(this.computerPlayerID == dataM.player1PlayerID)
         {
            this.opponentPlayerID = dataM.player2PlayerID;
            this.userAutopilot = true;
         }
         else
         {
            this.opponentPlayerID = dataM.player1PlayerID;
         }
         this.setPlayerPointers();
         this.setCanStomp();
         if(this.userAutopilot == false)
         {
            if(this.opponentProfile.winsVSComputer == 0)
            {
               if(this.screenBattle.currentTurn == 2 && this.computerPlayerData.AP == 1)
               {
                  this.forceTutorialMoveBack = true;
               }
            }
         }
         if(this.forceTutorialMoveBack)
         {
            _loc6_ = BMBattleManager.ACTION_WALK_RIGHT;
         }
         else
         {
            _loc3_ = this.getPlayDumbRatio();
            _loc4_ = Math.random() * 100;
            if(_loc4_ <= _loc3_)
            {
               this.playDumb = true;
            }
            if(this.computerPlayerData.AP == this.computerPlayerData.APMax)
            {
               this.desiredWeaponInfo = null;
            }
            this.setAvailableDroneActions();
            this.setAvailableShieldActions();
            this.setAvailableKitActions();
            this.setAvailableMotionAndFiringActions();
            _loc6_ = BMBattleManager.ACTION_SHUTDOWN;
            if(this.deactivateDrone)
            {
               _loc6_ = BMBattleManager.ACTION_DEACTIVATE_DRONE;
            }
            else if(this.activateDrone)
            {
               _loc6_ = BMBattleManager.ACTION_ACTIVATE_DRONE;
            }
            else if(this.deactivateShield)
            {
               _loc6_ = BMBattleManager.ACTION_DEACTIVATE_SHIELD;
            }
            else if(this.activateShield)
            {
               _loc6_ = BMBattleManager.ACTION_ACTIVATE_SHIELD;
            }
            else if(this.useStomp)
            {
               if(this.computerPlayerID == dataM.player1PlayerID)
               {
                  _loc6_ = this.setAction(_loc6_,BMBattleManager.ACTION_STOMP,true);
               }
               else
               {
                  switch(dataM.battleSubType)
                  {
                     case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
                     case BMSinglePlayerManager.ENEMY_TYPE_TANK:
                        _loc6_ = this.setAction(_loc6_,BMBattleManager.ACTION_CRASH,true);
                        break;
                     default:
                        _loc6_ = this.setAction(_loc6_,BMBattleManager.ACTION_STOMP,true);
                  }
               }
            }
            else if(this.fireWeapon)
            {
               _loc6_ = BMBattleManager.ACTION_FIRE_WEAPON;
            }
            else if(this.useKit)
            {
               _loc6_ = BMBattleManager.ACTION_USE_KIT;
            }
            else if(this.useHarpoon)
            {
               _loc6_ = BMBattleManager.ACTION_HARPOON;
            }
            else if(this.useTeleport)
            {
               _loc6_ = BMBattleManager.ACTION_TELEPORT;
            }
            else if(this.useCharge)
            {
               _loc6_ = BMBattleManager.ACTION_CHARGE;
            }
            else if(this.jumpLeft)
            {
               _loc6_ = BMBattleManager.ACTION_JUMP_LEFT;
            }
            else if(this.jumpRight)
            {
               _loc6_ = BMBattleManager.ACTION_JUMP_RIGHT;
            }
            else if(this.walkLeft)
            {
               _loc6_ = BMBattleManager.ACTION_WALK_LEFT;
            }
            else if(this.walkRight)
            {
               _loc6_ = BMBattleManager.ACTION_WALK_RIGHT;
            }
         }
         this.finalAction = _loc6_;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
         {
            this.botWaitingFramesCountdown = Math.ceil(Math.random() * 40) + 20;
            addEventListener(Event.ENTER_FRAME,this.botWaitingHandler);
         }
         else
         {
            this.playFinalAction();
         }
      }
      
      private function playFinalAction() : void
      {
         switch(this.finalAction)
         {
            case BMBattleManager.ACTION_WALK_LEFT:
               this.screenBattle.walkJumpClickedSub(BMBattleManager.MOTION_TYPE_WALK,BMBattleManager.MOTION_DIRECTION_LEFT);
               break;
            case BMBattleManager.ACTION_WALK_RIGHT:
               this.screenBattle.walkJumpClickedSub(BMBattleManager.MOTION_TYPE_WALK,BMBattleManager.MOTION_DIRECTION_RIGHT);
               break;
            case BMBattleManager.ACTION_JUMP_LEFT:
               this.screenBattle.walkJumpClickedSub(BMBattleManager.MOTION_TYPE_JUMP,BMBattleManager.MOTION_DIRECTION_LEFT);
               break;
            case BMBattleManager.ACTION_JUMP_RIGHT:
               this.screenBattle.walkJumpClickedSub(BMBattleManager.MOTION_TYPE_JUMP,BMBattleManager.MOTION_DIRECTION_RIGHT);
               break;
            case BMBattleManager.ACTION_ACTIVATE_DRONE:
               if(BattleTypeResolver.isBattleOnServer)
               {
                  this.screenBattle.activateDeactivateDrone();
               }
               else
               {
                  this.screenBattle.activateDroneLocally();
               }
               break;
            case BMBattleManager.ACTION_DEACTIVATE_DRONE:
               if(BattleTypeResolver.isBattleOnServer)
               {
                  this.screenBattle.activateDeactivateDrone();
               }
               else
               {
                  this.screenBattle.deactivateDroneLocally();
               }
               break;
            case BMBattleManager.ACTION_ACTIVATE_SHIELD:
               if(BattleTypeResolver.isBattleOnServer)
               {
                  this.screenBattle.activateDeactivateShield();
               }
               else
               {
                  this.screenBattle.activateShieldLocally();
               }
               break;
            case BMBattleManager.ACTION_DEACTIVATE_SHIELD:
               if(BattleTypeResolver.isBattleOnServer)
               {
                  this.screenBattle.activateDeactivateShield();
               }
               else
               {
                  this.screenBattle.deactivateShieldLocally();
               }
               break;
            case BMBattleManager.ACTION_TELEPORT:
               if(BattleTypeResolver.isBattleOnServer)
               {
                  this.screenBattle.teleportLocationClicked(this.useTeleportTargetStep);
               }
               else
               {
                  this.screenBattle.teleportLocally(this.useTeleportTargetStep);
               }
               break;
            case BMBattleManager.ACTION_CHARGE:
               if(BattleTypeResolver.isBattleOnServer)
               {
                  this.screenBattle.chargeClicked();
               }
               else
               {
                  this.screenBattle.chargeLocally();
               }
               break;
            case BMBattleManager.ACTION_CRASH:
               this.screenBattle.crashLocally();
               break;
            case BMBattleManager.ACTION_HARPOON:
               if(BattleTypeResolver.isBattleOnServer)
               {
                  this.screenBattle.harpoonClicked();
               }
               else
               {
                  this.screenBattle.harpoonLocally();
               }
               break;
            case BMBattleManager.ACTION_FIRE_WEAPON:
               this.screenBattle.fireWeapon(this.fireWeaponType,this.fireWeaponEquipmentID);
               break;
            case BMBattleManager.ACTION_STOMP:
               this.screenBattle.fireWeapon(BMMechStructure.LEG,0);
               break;
            case BMBattleManager.ACTION_USE_KIT:
               this.screenBattle.useKit(this.useKitEquipmentID);
               break;
            case BMBattleManager.ACTION_SHUTDOWN:
               if(BattleTypeResolver.isBattleOnServer)
               {
                  this.screenBattle.shutDownClicked();
               }
               else
               {
                  this.screenBattle.shutDownLocally(1);
               }
         }
      }
      
      private function setAction(param1:String, param2:String, param3:Boolean) : String
      {
         if(param3)
         {
            param1 = param2;
         }
         return param1;
      }
      
      private function getPlayDumbRatio() : uint
      {
         if(this.userAutopilot)
         {
            return 0;
         }
         if(dataM.battleType != BMSinglePlayerManager.BATTLE_TYPE_MISSION)
         {
            return 0;
         }
         if(this.opponentProfile.level > this.PLAY_DUMB_LEVEL_MAX || this.opponentProfile.currentMissionMode > 0)
         {
            return 0;
         }
         var _loc1_:Number = Math.abs(this.opponentProfile.levelByItems - this.computerProfile.levelByItems);
         if(this.opponentProfile.levelByItems > this.PLAY_DUMB_LEVEL_MAX || this.computerProfile.levelByItems > this.PLAY_DUMB_LEVEL_MAX || _loc1_ > this.PLAY_DUMB_LEVEL_DIFFERENCE)
         {
            return 0;
         }
         if(this.computerMechBattleData.HP <= this.opponentMechBattleData.HP)
         {
            return 0;
         }
         if(dataM.battleSubType == BMSinglePlayerManager.ENEMY_TYPE_JEEP || dataM.battleSubType == BMSinglePlayerManager.ENEMY_TYPE_TANK)
         {
            if(this.computerProfile.levelByItems <= 5)
            {
               return 50;
            }
            if(this.computerProfile.levelByItems == 6)
            {
               return 40;
            }
            if(this.computerProfile.levelByItems == 7)
            {
               return 30;
            }
            if(this.computerProfile.levelByItems == 8)
            {
               return 20;
            }
            if(this.computerProfile.levelByItems == 9)
            {
               return 10;
            }
         }
         if(this.computerProfile.levelByItems <= 5)
         {
            return 100;
         }
         if(this.computerProfile.levelByItems == 6)
         {
            return 80;
         }
         if(this.computerProfile.levelByItems == 7)
         {
            return 60;
         }
         if(this.computerProfile.levelByItems == 8)
         {
            return 40;
         }
         if(this.computerProfile.levelByItems == 9)
         {
            return 20;
         }
         return 0;
      }
      
      private function setPlayerPointers() : void
      {
         this.computerProfile = dataM["player" + this.computerPlayerID + "Profile"];
         this.computerPlayerData = dataM.playersData[this.computerPlayerID];
         this.computerMechSlot = this.screenBattle.getMechSlot(this.computerPlayerID);
         this.computerMechBattleData = this.screenBattle.mechBattleDatas[this.computerMechSlot];
         this.opponentProfile = dataM["player" + this.opponentPlayerID + "Profile"];
         this.opponentPlayerData = dataM.playersData[this.opponentPlayerID];
         this.opponentMechSlot = this.screenBattle.getMechSlot(this.opponentPlayerID);
         this.opponentMechBattleData = this.screenBattle.mechBattleDatas[this.opponentMechSlot];
      }
      
      private function resetParams() : void
      {
         this.userAutopilot = false;
         this.canStomp = true;
         this.canMove = true;
         this.playDumb = false;
         this.forceTutorialMoveBack = false;
         this.activateDrone = false;
         this.deactivateDrone = false;
         this.activateShield = false;
         this.deactivateShield = false;
         this.fireWeapon = false;
         this.useKit = false;
         this.useTeleport = false;
         this.useCharge = false;
         this.useHarpoon = false;
         this.useStomp = false;
         this.walkRight = false;
         this.walkLeft = false;
         this.jumpRight = false;
         this.jumpLeft = false;
      }
      
      private function setCanStomp() : void
      {
         var _loc1_:BMPlayerItemData = dataM.getPlayerItemData(this.computerPlayerID,this.computerMechBattleData.mechStructure.leg);
         var _loc2_:BMItemData = dataM.itemsDB[_loc1_.itemID];
         if(_loc2_.damageBase + _loc2_.damageAddon == 0)
         {
            this.canStomp = false;
         }
      }
      
      private function setAvailableDroneActions() : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMItemData = null;
         var _loc1_:Number = this.computerMechBattleData.mechStructure.drone;
         if(_loc1_ > 0)
         {
            _loc2_ = dataM.getPlayerItemData(this.computerPlayerID,_loc1_);
            _loc3_ = dataM.itemsDB[_loc2_.itemID];
            if(this.computerMechBattleData.droneActive == false)
            {
               if(_loc3_.costEnergy * this.DRONE_ATTACKS_REQUIRED_TO_ACTIVATE <= this.computerMechBattleData.energy)
               {
                  this.activateDrone = true;
               }
            }
            else if(_loc3_.costEnergy > this.computerMechBattleData.energy)
            {
            }
         }
      }
      
      private function setAvailableShieldActions() : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMItemData = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:Number = this.computerMechBattleData.mechStructure.shield;
         if(_loc1_ > 0)
         {
            _loc2_ = dataM.getPlayerItemData(this.computerPlayerID,_loc1_);
            _loc3_ = dataM.itemsDB[_loc2_.itemID];
            switch(this.computerMechBattleData.shieldType)
            {
               case "energy":
                  _loc4_ = _loc3_.energyPerBlock * _loc3_.HPPerBlock;
                  if(this.computerMechBattleData.shieldActive == false)
                  {
                     if(_loc4_ * this.SHIELD_ENERGY_BLOCKS_REQUIRED_TO_ACTIVATE <= this.computerMechBattleData.energy)
                     {
                        this.activateShield = true;
                     }
                  }
                  else if(_loc4_ * this.SHIELD_ENERGY_BLOCKS_REQUIRED_TO_DEACTIVATE > this.computerMechBattleData.energy)
                  {
                  }
                  break;
               case "heat":
                  _loc5_ = _loc3_.heatPerBlock * _loc3_.HPPerBlock;
                  if(this.computerMechBattleData.shieldActive == false)
                  {
                     if(this.computerMechBattleData.heat < this.computerMechBattleData.heatMax * this.SHIELD_HEAT_RATIO_TO_ACTIVATE)
                     {
                        this.activateShield = true;
                     }
                  }
            }
         }
      }
      
      private function setAvailableKitActions() : void
      {
         var _loc1_:Array = null;
         if(this.computerMechBattleData.HP / this.computerMechBattleData.HPMax < this.KIT_RATIO_HP)
         {
            _loc1_ = this.getKitEquipmentID(this.computerPlayerID,this.computerMechBattleData,"HP");
            if(_loc1_.length > 0)
            {
               this.useKit = true;
               this.useKitEquipmentID = _loc1_[0];
            }
         }
         if(this.useKit == false)
         {
            if(this.computerMechBattleData.heat / this.computerMechBattleData.heatMax > this.KIT_RATIO_HEAT)
            {
               _loc1_ = this.getKitEquipmentID(this.computerPlayerID,this.computerMechBattleData,"heat");
               if(_loc1_.length > 0)
               {
                  this.useKit = true;
                  this.useKitEquipmentID = _loc1_[0];
               }
            }
         }
         if(this.useKit == false)
         {
            if(this.computerMechBattleData.energy / this.computerMechBattleData.energyMax < this.KIT_RATIO_ENERGY)
            {
               _loc1_ = this.getKitEquipmentID(this.computerPlayerID,this.computerMechBattleData,"energy");
               if(_loc1_.length > 0)
               {
                  this.useKit = true;
                  this.useKitEquipmentID = _loc1_[0];
               }
            }
         }
         if(this.useKit == false)
         {
            if(this.computerMechBattleData.bullets / this.computerMechBattleData.bulletsMax < this.KIT_RATIO_BULLETS || this.computerMechBattleData.bullets < this.KIT_MIN_BULLETS)
            {
               _loc1_ = this.getKitEquipmentID(this.computerPlayerID,this.computerMechBattleData,"bullets");
               if(_loc1_.length > 0)
               {
                  this.useKit = true;
                  this.useKitEquipmentID = _loc1_[0];
               }
            }
         }
         if(this.useKit == false)
         {
            if(this.computerMechBattleData.rockets / this.computerMechBattleData.rocketsMax < this.KIT_RATIO_ROCKETS || this.computerMechBattleData.rockets < this.KIT_MIN_ROCKETS)
            {
               _loc1_ = this.getKitEquipmentID(this.computerPlayerID,this.computerMechBattleData,"rockets");
               if(_loc1_.length > 0)
               {
                  this.useKit = true;
                  this.useKitEquipmentID = _loc1_[0];
               }
            }
         }
      }
      
      private function setAvailableMotionAndFiringActions() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Array = null;
         var _loc14_:Object = null;
         var _loc15_:Array = null;
         var _loc16_:Array = null;
         var _loc17_:Boolean = false;
         var _loc18_:BMItemData = null;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Array = null;
         var _loc22_:BMPlayerItemData = null;
         var _loc23_:BMItemData = null;
         var _loc24_:Array = null;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Boolean = false;
         var _loc30_:Number = NaN;
         var _loc31_:Boolean = false;
         var _loc32_:Boolean = false;
         var _loc33_:Number = NaN;
         var _loc34_:BMPlayerItemData = null;
         var _loc35_:BMItemData = null;
         var _loc36_:BMPlayerItemData = null;
         var _loc37_:BMItemData = null;
         var _loc38_:Number = NaN;
         var _loc39_:BMPlayerItemData = null;
         var _loc40_:BMItemData = null;
         if(this.playDumb)
         {
            if(this.canMove)
            {
               _loc5_ = [BMBattleManager.ACTION_WALK_LEFT,BMBattleManager.ACTION_WALK_RIGHT,BMBattleManager.ACTION_JUMP_LEFT,BMBattleManager.ACTION_JUMP_RIGHT,BMBattleManager.ACTION_SHUTDOWN];
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length)
               {
                  _loc6_ = uint(RandomUtils.chooseRandomIndex(_loc5_));
                  _loc7_ = _loc5_[_loc6_];
                  _loc5_[_loc6_] = _loc5_[_loc4_];
                  _loc5_[_loc4_] = _loc7_;
                  _loc4_++;
               }
               _loc1_ = this.computerMechBattleData.currentStepVisual;
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length)
               {
                  switch(_loc5_[_loc4_])
                  {
                     case BMBattleManager.ACTION_WALK_LEFT:
                        _loc2_ = _loc1_ - this.computerMechBattleData.stepsPerWalk;
                        _loc3_ = this.screenBattle.getAvailableStep(this.computerPlayerID,_loc1_,_loc2_,"walk");
                        if(_loc3_ > -1)
                        {
                           this.walkLeft = true;
                           _loc4_ = _loc5_.length;
                        }
                        break;
                     case BMBattleManager.ACTION_WALK_RIGHT:
                        _loc2_ = _loc1_ + this.computerMechBattleData.stepsPerWalk;
                        _loc3_ = this.screenBattle.getAvailableStep(this.computerPlayerID,_loc1_,_loc2_,"walk");
                        if(_loc3_ > -1)
                        {
                           this.walkRight = true;
                           _loc4_ = _loc5_.length;
                        }
                        break;
                     case BMBattleManager.ACTION_JUMP_LEFT:
                        if(this.computerMechBattleData.stepsPerJump > 0)
                        {
                           _loc2_ = _loc1_ - this.computerMechBattleData.stepsPerJump;
                           _loc3_ = this.screenBattle.getAvailableStep(this.computerPlayerID,_loc1_,_loc2_,"jump");
                           if(_loc3_ > -1)
                           {
                              this.jumpLeft = true;
                              _loc4_ = _loc5_.length;
                           }
                        }
                        break;
                     case BMBattleManager.ACTION_JUMP_RIGHT:
                        if(this.computerMechBattleData.stepsPerJump > 0)
                        {
                           _loc2_ = _loc1_ + this.computerMechBattleData.stepsPerJump;
                           _loc3_ = this.screenBattle.getAvailableStep(this.computerPlayerID,_loc1_,_loc2_,"jump");
                           if(_loc3_ > -1)
                           {
                              this.jumpRight = true;
                              _loc4_ = _loc5_.length;
                           }
                        }
                        break;
                     case BMBattleManager.ACTION_SHUTDOWN:
                        _loc4_ = _loc5_.length;
                  }
                  _loc4_++;
               }
            }
         }
         else
         {
            _loc10_ = 0;
            _loc11_ = 0;
            if(Math.abs(this.computerMechBattleData.currentStepCode - this.opponentMechBattleData.currentStepCode) == 1)
            {
               _loc13_ = screensM.screenBattle.getWeaponsInRangeUnfired(true,true,true,true);
               if(_loc13_.length > 0)
               {
                  _loc4_ = uint(RandomUtils.chooseRandomIndex(_loc13_));
                  _loc14_ = _loc13_[_loc4_];
                  this.fireWeapon = true;
                  this.fireWeaponType = _loc14_.type;
                  this.fireWeaponEquipmentID = _loc14_.equipmentID;
               }
               if(this.fireWeapon == false && this.canStomp)
               {
                  this.useStomp = true;
               }
            }
            if(this.fireWeapon == false && this.useStomp == false)
            {
               _loc15_ = this.screenBattle.getBestWeaponsToFire(this.computerPlayerID,this.opponentPlayerID,false,true,false,true);
               if(_loc15_.length > 0)
               {
                  _loc16_ = this.screenBattle.getBestWeaponsToFire(this.computerPlayerID,this.opponentPlayerID,true,true,false,true,true);
                  if(_loc16_.length > 0)
                  {
                     _loc12_ = RandomUtils.chooseRandomIndex(_loc16_);
                     this.desiredWeaponInfo = _loc16_[_loc12_];
                  }
                  else
                  {
                     this.desiredWeaponInfo = _loc15_[0];
                  }
                  _loc8_ = this.desiredWeaponInfo.type + this.desiredWeaponInfo.equipmentID;
                  _loc9_ = dataM.getPlayerItemData(this.computerPlayerID,this.computerMechBattleData.mechStructure[_loc8_]);
                  _loc17_ = false;
                  if(this.screenBattle.isOpponentInWeaponRange(this.computerPlayerID,this.opponentPlayerID,_loc9_.itemID,-1,-1,-1))
                  {
                     if(this.computerMechBattleData.weaponAlreadyFired[_loc8_] == false)
                     {
                        _loc17_ = true;
                     }
                  }
                  if(_loc17_)
                  {
                     this.fireWeapon = true;
                     this.fireWeaponType = this.desiredWeaponInfo.type;
                     this.fireWeaponEquipmentID = this.desiredWeaponInfo.equipmentID;
                  }
                  else
                  {
                     _loc18_ = dataM.itemsDB[_loc9_.itemID];
                     _loc21_ = new Array();
                     if(this.computerMechBattleData.mechStructure.teleport > 0)
                     {
                        _loc22_ = dataM.getPlayerItemData(this.computerPlayerID,this.computerMechBattleData.mechStructure.teleport);
                        _loc23_ = dataM.itemsDB[_loc22_.itemID];
                        _loc20_ = Number(this.computerMechBattleData.usesMax[BMMechStructure.TELEPORT]);
                        _loc19_ = Number(this.computerMechBattleData.uses[BMMechStructure.TELEPORT]);
                        if(_loc20_ == 0 || _loc20_ > 0 && _loc19_ < _loc20_)
                        {
                           if(this.computerMechBattleData.energy >= _loc23_.costEnergy)
                           {
                              _loc24_ = new Array();
                              _loc26_ = this.opponentMechBattleData.currentStepVisual - (_loc10_ + 1) - _loc11_ - (_loc18_.rangeBase + _loc18_.rangeAddon);
                              _loc27_ = this.opponentMechBattleData.currentStepVisual - (_loc10_ + 1) - _loc11_ - _loc18_.rangeBase;
                              _loc25_ = _loc26_;
                              while(_loc25_ <= _loc27_)
                              {
                                 if(this.screenBattle.getAvailableStep(this.computerPlayerID,this.computerMechBattleData.currentStepVisual,_loc25_,"teleport") > -1)
                                 {
                                    _loc24_.push(_loc25_);
                                 }
                                 _loc25_++;
                              }
                              _loc26_ = this.opponentMechBattleData.currentStepVisual + _loc10_ + _loc11_ + _loc18_.rangeBase;
                              _loc27_ = this.opponentMechBattleData.currentStepVisual + _loc10_ + _loc11_ + (_loc18_.rangeBase + _loc18_.rangeAddon);
                              _loc25_ = _loc26_;
                              while(_loc25_ <= _loc27_)
                              {
                                 if(this.screenBattle.getAvailableStep(this.computerPlayerID,this.computerMechBattleData.currentStepVisual,_loc25_,"teleport") > -1)
                                 {
                                    _loc24_.push(_loc25_);
                                 }
                                 _loc25_++;
                              }
                              if(_loc24_.length > 0)
                              {
                                 _loc12_ = RandomUtils.chooseRandomIndex(_loc24_);
                                 _loc28_ = Number(_loc24_[_loc12_]);
                                 _loc29_ = false;
                                 _loc30_ = 0;
                                 while(_loc29_ == false)
                                 {
                                    if(Math.abs(_loc28_ - this.opponentMechBattleData.currentStepVisual) <= _loc23_.rangeAddon + (_loc10_ + 1 + _loc11_))
                                    {
                                       _loc29_ = true;
                                    }
                                    else
                                    {
                                       _loc12_ = RandomUtils.chooseRandomIndex(_loc24_);
                                       _loc28_ = Number(_loc24_[_loc12_]);
                                       if(++_loc30_ > 20)
                                       {
                                          _loc29_ = true;
                                       }
                                    }
                                 }
                                 _loc31_ = false;
                                 _loc32_ = false;
                                 if(_loc23_.damageBase > 0 || _loc23_.damageAddon > 0)
                                 {
                                    if(Math.abs(_loc28_ - this.opponentMechBattleData.currentStepCode) <= 1 + _loc23_.rangeAddon)
                                    {
                                       _loc32_ = true;
                                    }
                                 }
                                 if(_loc32_ == false)
                                 {
                                    _loc33_ = Math.abs(_loc28_ - this.computerMechBattleData.currentStepCode);
                                    if(_loc33_ <= this.computerMechBattleData.stepsPerWalk || _loc33_ <= this.computerMechBattleData.stepsPerJump)
                                    {
                                       _loc31_ = true;
                                    }
                                 }
                                 if(_loc31_ == false)
                                 {
                                    _loc21_.push(BMBattleManager.ACTION_TELEPORT);
                                    this.useTeleportTargetStep = _loc28_;
                                 }
                              }
                           }
                        }
                     }
                     if(this.computerMechBattleData.mechStructure.charge > 0)
                     {
                        _loc34_ = dataM.getPlayerItemData(this.computerPlayerID,this.computerMechBattleData.mechStructure.charge);
                        _loc35_ = dataM.itemsDB[_loc34_.itemID];
                        _loc20_ = Number(this.computerMechBattleData.usesMax[BMMechStructure.CHARGE]);
                        _loc19_ = Number(this.computerMechBattleData.uses[BMMechStructure.CHARGE]);
                        if(this.screenBattle.isOpponentInWeaponRange(this.computerPlayerID,this.opponentPlayerID,_loc35_.itemID,-1,-1,-1))
                        {
                           if(_loc20_ == 0 || _loc20_ > 0 && _loc19_ < _loc20_)
                           {
                              if(this.computerMechBattleData.energy >= _loc35_.costEnergy)
                              {
                                 _loc21_.push(BMBattleManager.ACTION_CHARGE);
                              }
                           }
                        }
                     }
                     if(this.computerMechBattleData.mechStructure.harpoon > 0)
                     {
                        if(!(this.computerPlayerID == dataM.player1PlayerID && this.screenBattle.doesOpponentHasNoneMovableTorso()))
                        {
                           _loc36_ = dataM.getPlayerItemData(this.computerPlayerID,this.computerMechBattleData.mechStructure.harpoon);
                           _loc37_ = dataM.itemsDB[_loc36_.itemID];
                           _loc20_ = Number(this.computerMechBattleData.usesMax[BMMechStructure.HARPOON]);
                           _loc19_ = Number(this.computerMechBattleData.uses[BMMechStructure.HARPOON]);
                           if(this.screenBattle.isOpponentInWeaponRange(this.computerPlayerID,this.opponentPlayerID,_loc37_.itemID,-1,-1,-1))
                           {
                              if(_loc20_ == 0 || _loc20_ > 0 && _loc19_ < _loc20_)
                              {
                                 if(this.computerMechBattleData.energy >= _loc37_.costEnergy)
                                 {
                                    _loc21_.push(BMBattleManager.ACTION_HARPOON);
                                 }
                              }
                           }
                        }
                     }
                     if(_loc21_.length > 0)
                     {
                        _loc38_ = RandomUtils.chooseRandomIndex(_loc21_);
                        switch(_loc21_[_loc38_])
                        {
                           case BMBattleManager.ACTION_TELEPORT:
                              this.useTeleport = true;
                              break;
                           case BMBattleManager.ACTION_CHARGE:
                              this.useCharge = true;
                              break;
                           case BMBattleManager.ACTION_HARPOON:
                              this.useHarpoon = true;
                        }
                     }
                     else if(this.canMove)
                     {
                        _loc1_ = this.computerMechBattleData.currentStepVisual;
                        if(this.computerMechBattleData.stepsPerJump > 0)
                        {
                           _loc4_ = 1;
                           while(_loc4_ <= this.MOTION_CALCULATION_AP)
                           {
                              _loc2_ = _loc1_ + this.computerMechBattleData.stepsPerJump * _loc4_;
                              if(this.screenBattle.isOpponentInWeaponRange(this.computerPlayerID,this.opponentPlayerID,_loc9_.itemID,-1,-1,_loc2_))
                              {
                                 _loc3_ = this.screenBattle.getAvailableStep(this.computerPlayerID,_loc1_,_loc2_,"jump");
                                 if(_loc3_ >= _loc2_)
                                 {
                                    this.jumpRight = true;
                                    _loc4_ = this.MOTION_CALCULATION_AP;
                                 }
                              }
                              _loc4_++;
                           }
                        }
                        if(this.jumpRight == false)
                        {
                           if(this.computerMechBattleData.currentStepVisual > this.opponentMechBattleData.currentStepVisual)
                           {
                              _loc4_ = 1;
                              while(_loc4_ <= this.MOTION_CALCULATION_AP)
                              {
                                 _loc2_ = _loc1_ + this.computerMechBattleData.stepsPerWalk * _loc4_;
                                 if(this.screenBattle.isOpponentInWeaponRange(this.computerPlayerID,this.opponentPlayerID,_loc9_.itemID,-1,-1,_loc2_))
                                 {
                                    _loc3_ = this.screenBattle.getAvailableStep(this.computerPlayerID,_loc1_,_loc2_,"walk");
                                    if(_loc3_ >= _loc2_)
                                    {
                                       this.walkRight = true;
                                       _loc4_ = this.MOTION_CALCULATION_AP;
                                    }
                                 }
                                 _loc4_++;
                              }
                           }
                        }
                        if(this.computerMechBattleData.stepsPerJump > 0)
                        {
                           if(this.jumpRight == false && this.walkRight == false)
                           {
                              _loc4_ = 1;
                              while(_loc4_ <= this.MOTION_CALCULATION_AP)
                              {
                                 _loc2_ = _loc1_ - this.computerMechBattleData.stepsPerJump * _loc4_;
                                 if(this.screenBattle.isOpponentInWeaponRange(this.computerPlayerID,this.opponentPlayerID,_loc9_.itemID,-1,-1,_loc2_))
                                 {
                                    _loc3_ = this.screenBattle.getAvailableStep(this.computerPlayerID,_loc1_,_loc2_,"jump");
                                    if(_loc3_ > -1 && _loc3_ <= _loc2_)
                                    {
                                       this.jumpLeft = true;
                                       _loc4_ = this.MOTION_CALCULATION_AP;
                                    }
                                 }
                                 _loc4_++;
                              }
                           }
                        }
                        if(this.jumpRight == false && this.walkRight == false && this.jumpLeft == false)
                        {
                           if(this.computerMechBattleData.currentStepVisual < this.opponentMechBattleData.currentStepVisual)
                           {
                              _loc4_ = 1;
                              while(_loc4_ <= this.MOTION_CALCULATION_AP)
                              {
                                 _loc2_ = _loc1_ - this.computerMechBattleData.stepsPerWalk * _loc4_;
                                 if(this.screenBattle.isOpponentInWeaponRange(this.computerPlayerID,this.opponentPlayerID,_loc9_.itemID,-1,-1,_loc2_))
                                 {
                                    _loc3_ = this.screenBattle.getAvailableStep(this.computerPlayerID,_loc1_,_loc2_,"walk");
                                    if(_loc3_ > -1 && _loc3_ <= _loc2_)
                                    {
                                       this.walkLeft = true;
                                       _loc4_ = this.MOTION_CALCULATION_AP;
                                    }
                                 }
                                 _loc4_++;
                              }
                           }
                        }
                     }
                  }
               }
            }
            if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_CHALLENGE)
            {
               if(dataM.battleSubType == BMSinglePlayerManager.CHALLENGE_GODMODE)
               {
                  this.fireWeapon = false;
                  this.walkLeft = false;
                  this.walkRight = false;
                  this.jumpLeft = false;
                  this.jumpRight = false;
                  this.useTeleport = false;
                  this.useCharge = false;
                  this.useHarpoon = false;
                  _loc12_ = Math.ceil(Math.random() * 45);
                  if(_loc12_ <= this.opponentProfile.levelByItems)
                  {
                     this.fireWeapon = true;
                     this.fireWeaponType = BMMechStructure.SIDE_WEAPON;
                     this.fireWeaponEquipmentID = 1;
                     if(this.computerPlayerData.AP == 1)
                     {
                        this.fireWeaponEquipmentID = 2;
                     }
                  }
               }
            }
            if(this.useStomp == false && this.fireWeapon == false && this.walkLeft == false && this.walkRight == false && this.jumpLeft == false && this.jumpRight == false && this.useTeleport == false && this.useCharge == false && this.useHarpoon == false)
            {
               _loc39_ = dataM.getPlayerItemData(this.computerPlayerID,this.computerMechBattleData.mechStructure.leg);
               _loc40_ = dataM.itemsDB[_loc39_.itemID];
               if(this.screenBattle.isOpponentInWeaponRange(this.computerPlayerID,this.opponentPlayerID,-1,_loc40_.rangeBase,_loc40_.rangeAddon,-1))
               {
                  if(this.canStomp)
                  {
                     this.useStomp = true;
                  }
               }
               else if(this.canMove)
               {
                  if(this.computerMechBattleData.currentStepVisual < this.opponentMechBattleData.currentStepVisual)
                  {
                     if(this.computerMechBattleData.stepsPerJump > 0)
                     {
                        this.jumpRight = true;
                     }
                     else if(this.computerMechBattleData.stepsPerWalk > 0)
                     {
                        this.walkRight = true;
                     }
                  }
                  else if(this.computerMechBattleData.stepsPerJump > 0)
                  {
                     this.jumpLeft = true;
                  }
                  else if(this.computerMechBattleData.stepsPerWalk > 0)
                  {
                     this.walkLeft = true;
                  }
               }
            }
         }
      }
      
      private function getKitEquipmentID(param1:Number, param2:BMMechBattleData, param3:String) : Array
      {
         var _loc6_:Number = NaN;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc4_:Array = new Array();
         var _loc5_:uint = 1;
         for(; _loc5_ <= dataM.maxEquipment[BMMechStructure.KIT]; _loc5_++)
         {
            _loc6_ = Number(param2.mechStructure[BMMechStructure.KIT + _loc5_]);
            if(_loc6_ <= 0)
            {
               continue;
            }
            _loc7_ = dataM.getPlayerItemData(param1,param2.mechStructure["kit" + _loc5_]);
            _loc8_ = dataM.itemsDB[_loc7_.itemID];
            switch(param3)
            {
               case "HP":
                  if(_loc8_.HPBase > 0)
                  {
                     _loc4_.push(_loc5_);
                  }
                  break;
               case "energy":
                  if(_loc8_.energyBase > 0)
                  {
                     _loc4_.push(_loc5_);
                  }
                  break;
               case "heat":
                  if(_loc8_.heatBase > 0)
                  {
                     _loc4_.push(_loc5_);
                  }
            }
         }
         return _loc4_;
      }
      
      private function botWaitingHandler(param1:Event) : void
      {
         if(this.botWaitingFramesCountdown == 0)
         {
            removeEventListener(Event.ENTER_FRAME,this.botWaitingHandler);
            this.playFinalAction();
            return;
         }
         --this.botWaitingFramesCountdown;
      }
      
      public function stopMe() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.botWaitingHandler);
      }
   }
}

