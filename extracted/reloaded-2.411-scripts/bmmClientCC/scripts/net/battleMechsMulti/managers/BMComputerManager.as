package net.battleMechsMulti.managers
{
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechBattleData;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.screens.BMScreenBattle;
   import net.tacticsoft.utils.RandomUtils;
   
   public class BMComputerManager extends BMBaseClass
   {
      
      private var screenBattle:BMScreenBattle;
      
      private var playerProfile:BMPlayerProfile;
      
      private var playerData:BMPlayerData;
      
      private var playerMechSlot:String;
      
      private var playerMechBattleData:BMMechBattleData;
      
      private var computerProfile:BMPlayerProfile;
      
      private var computerPlayerData:BMPlayerData;
      
      private var computerMechSlot:String;
      
      private var computerMechBattleData:BMMechBattleData;
      
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
      
      public function executeTurn(param1:String) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this.screenBattle = screensM.screenBattle;
         this.playerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.playerData = dataM.playersData[dataM.player1PlayerID];
         this.playerMechSlot = this.screenBattle.getMechSlot(dataM.player1PlayerID);
         this.playerMechBattleData = this.screenBattle.mechBattleDatas[this.playerMechSlot];
         this.computerProfile = dataM["player" + dataM.player2PlayerID + "Profile"];
         this.computerPlayerData = dataM.playersData[dataM.player2PlayerID];
         this.computerMechSlot = this.screenBattle.getMechSlot(dataM.player2PlayerID);
         this.computerMechBattleData = this.screenBattle.mechBattleDatas[this.computerMechSlot];
         this.canStomp = true;
         this.canMove = true;
         switch(dataM.battleSubType)
         {
            case "jeep":
            case "tank":
               break;
            case "turret":
               this.canStomp = false;
               this.canMove = false;
         }
         this.playDumb = false;
         this.forceTutorialMoveBack = false;
         if(this.playerProfile.winsVSComputer == 0)
         {
            if(this.screenBattle.currentTurn == 2 && this.computerPlayerData.AP == 1)
            {
               this.forceTutorialMoveBack = true;
            }
         }
         if(this.forceTutorialMoveBack)
         {
            _loc3_ = "walkRight";
         }
         else
         {
            if(dataM.battleType == "mission")
            {
               if(this.playerProfile.level <= this.PLAY_DUMB_LEVEL_MAX)
               {
                  _loc4_ = Math.abs(this.playerProfile.levelByItems - this.computerProfile.levelByItems);
                  if(this.playerProfile.levelByItems <= this.PLAY_DUMB_LEVEL_MAX && this.computerProfile.levelByItems <= this.PLAY_DUMB_LEVEL_MAX && _loc4_ <= this.PLAY_DUMB_LEVEL_DIFFERENCE)
                  {
                     if(this.computerMechBattleData.HP > this.playerMechBattleData.HP)
                     {
                        _loc5_ = Math.random() * 100;
                        _loc6_ = 0;
                        if(this.computerProfile.levelByItems <= 5)
                        {
                           if(dataM.battleSubType == "jeep" || dataM.battleSubType == "tank")
                           {
                              _loc6_ = 50;
                           }
                           else
                           {
                              _loc6_ = 100;
                           }
                        }
                        else if(this.computerProfile.levelByItems == 6)
                        {
                           if(dataM.battleSubType == "jeep" || dataM.battleSubType == "tank")
                           {
                              _loc6_ = 40;
                           }
                           else
                           {
                              _loc6_ = 80;
                           }
                        }
                        else if(this.computerProfile.levelByItems == 7)
                        {
                           if(dataM.battleSubType == "jeep" || dataM.battleSubType == "tank")
                           {
                              _loc6_ = 30;
                           }
                           else
                           {
                              _loc6_ = 60;
                           }
                        }
                        else if(this.computerProfile.levelByItems == 8)
                        {
                           if(dataM.battleSubType == "jeep" || dataM.battleSubType == "tank")
                           {
                              _loc6_ = 20;
                           }
                           else
                           {
                              _loc6_ = 40;
                           }
                        }
                        else if(this.computerProfile.levelByItems == 9)
                        {
                           if(dataM.battleSubType == "jeep" || dataM.battleSubType == "tank")
                           {
                              _loc6_ = 10;
                           }
                           else
                           {
                              _loc6_ = 20;
                           }
                        }
                        if(_loc5_ <= _loc6_)
                        {
                           this.playDumb = true;
                        }
                     }
                  }
               }
            }
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
            if(this.computerPlayerData.AP == this.computerPlayerData.APMax)
            {
               this.desiredWeaponInfo = null;
            }
            this.droneHandler();
            this.shieldHandler();
            this.kitHandler();
            this.movingHandler();
            _loc3_ = "shutDown";
            _loc3_ = this.setAction(_loc3_,"walkRight",this.walkRight);
            _loc3_ = this.setAction(_loc3_,"walkLeft",this.walkLeft);
            _loc3_ = this.setAction(_loc3_,"jumpRight",this.jumpRight);
            _loc3_ = this.setAction(_loc3_,"jumpLeft",this.jumpLeft);
            _loc3_ = this.setAction(_loc3_,"charge",this.useCharge);
            _loc3_ = this.setAction(_loc3_,"teleport",this.useTeleport);
            _loc3_ = this.setAction(_loc3_,"harpoon",this.useHarpoon);
            _loc3_ = this.setAction(_loc3_,"useKit",this.useKit);
            _loc3_ = this.setAction(_loc3_,"fireWeapon",this.fireWeapon);
            if(this.useStomp)
            {
               switch(dataM.battleSubType)
               {
                  case "jeep":
                  case "tank":
                     _loc3_ = this.setAction(_loc3_,"crash",true);
                     break;
                  default:
                     _loc3_ = this.setAction(_loc3_,"stomp",true);
               }
            }
            _loc3_ = this.setAction(_loc3_,"activateShield",this.activateShield);
            _loc3_ = this.setAction(_loc3_,"deactivateShield",this.deactivateShield);
            _loc3_ = this.setAction(_loc3_,"activateDrone",this.activateDrone);
            _loc3_ = this.setAction(_loc3_,"deactivateDrone",this.deactivateDrone);
            if(_loc3_ == "fireWeapon")
            {
            }
         }
         switch(_loc3_)
         {
            case "walkLeft":
               this.screenBattle.walkJumpClickedSub("walk","left");
               break;
            case "walkRight":
               this.screenBattle.walkJumpClickedSub("walk","right");
               break;
            case "jumpLeft":
               this.screenBattle.walkJumpClickedSub("jump","left");
               break;
            case "jumpRight":
               this.screenBattle.walkJumpClickedSub("jump","right");
               break;
            case "activateDrone":
               this.screenBattle.activateDroneLocally();
               break;
            case "deactivateDrone":
               this.screenBattle.deactivateDroneLocally();
               break;
            case "activateShield":
               this.screenBattle.activateShieldLocally();
               break;
            case "deactivateShield":
               this.screenBattle.deactivateShieldLocally();
               break;
            case "teleport":
               this.screenBattle.teleportLocally(this.useTeleportTargetStep);
               break;
            case "charge":
               this.screenBattle.chargeLocally();
               break;
            case "crash":
               this.screenBattle.crashLocally();
               break;
            case "harpoon":
               this.screenBattle.harpoonLocally();
               break;
            case "fireWeapon":
               this.screenBattle.fireWeapon(this.fireWeaponType,this.fireWeaponEquipmentID);
               break;
            case "stomp":
               this.screenBattle.fireWeapon("leg",0);
               break;
            case "useKit":
               this.screenBattle.useKit(this.useKitEquipmentID);
               break;
            case "shutDown":
               this.screenBattle.shutDownLocally(1);
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
      
      private function droneHandler() : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMItemData = null;
         var _loc1_:Number = this.computerMechBattleData.mechStructure.drone;
         if(_loc1_ > 0)
         {
            _loc2_ = dataM.getPlayerItemData(dataM.player2PlayerID,_loc1_);
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
      
      private function shieldHandler() : void
      {
         var _loc2_:BMPlayerItemData = null;
         var _loc3_:BMItemData = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:Number = this.computerMechBattleData.mechStructure.shield;
         if(_loc1_ > 0)
         {
            _loc2_ = dataM.getPlayerItemData(dataM.player2PlayerID,_loc1_);
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
      
      private function kitHandler() : void
      {
         var _loc1_:Array = null;
         if(this.computerMechBattleData.HP / this.computerMechBattleData.HPMax < this.KIT_RATIO_HP)
         {
            _loc1_ = this.getKitEquipmentID(dataM.player2PlayerID,this.computerMechBattleData,"HP");
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
               _loc1_ = this.getKitEquipmentID(dataM.player2PlayerID,this.computerMechBattleData,"heat");
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
               _loc1_ = this.getKitEquipmentID(dataM.player2PlayerID,this.computerMechBattleData,"energy");
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
               _loc1_ = this.getKitEquipmentID(dataM.player2PlayerID,this.computerMechBattleData,"bullets");
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
               _loc1_ = this.getKitEquipmentID(dataM.player2PlayerID,this.computerMechBattleData,"rockets");
               if(_loc1_.length > 0)
               {
                  this.useKit = true;
                  this.useKitEquipmentID = _loc1_[0];
               }
            }
         }
      }
      
      private function movingHandler() : void
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
               _loc5_ = ["walkLeft","walkRight","jumpLeft","jumpRight","shutdown"];
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
                     case "walkLeft":
                        _loc2_ = _loc1_ - this.computerMechBattleData.stepsPerWalk;
                        _loc3_ = this.screenBattle.getAvailableStep(dataM.player2PlayerID,_loc1_,_loc2_,"walk");
                        if(_loc3_ > -1)
                        {
                           this.walkLeft = true;
                           _loc4_ = _loc5_.length;
                        }
                        break;
                     case "walkRight":
                        _loc2_ = _loc1_ + this.computerMechBattleData.stepsPerWalk;
                        _loc3_ = this.screenBattle.getAvailableStep(dataM.player2PlayerID,_loc1_,_loc2_,"walk");
                        if(_loc3_ > -1)
                        {
                           this.walkRight = true;
                           _loc4_ = _loc5_.length;
                        }
                        break;
                     case "jumpLeft":
                        if(this.computerMechBattleData.stepsPerJump > 0)
                        {
                           _loc2_ = _loc1_ - this.computerMechBattleData.stepsPerJump;
                           _loc3_ = this.screenBattle.getAvailableStep(dataM.player2PlayerID,_loc1_,_loc2_,"jump");
                           if(_loc3_ > -1)
                           {
                              this.jumpLeft = true;
                              _loc4_ = _loc5_.length;
                           }
                        }
                        break;
                     case "jumpRight":
                        if(this.computerMechBattleData.stepsPerJump > 0)
                        {
                           _loc2_ = _loc1_ + this.computerMechBattleData.stepsPerJump;
                           _loc3_ = this.screenBattle.getAvailableStep(dataM.player2PlayerID,_loc1_,_loc2_,"jump");
                           if(_loc3_ > -1)
                           {
                              this.jumpRight = true;
                              _loc4_ = _loc5_.length;
                           }
                        }
                        break;
                     case "shutdown":
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
            if(Math.abs(this.computerMechBattleData.currentStepCode - this.playerMechBattleData.currentStepCode) == 1)
            {
               _loc13_ = screensM.screenBattle.getWeaponsInRangeUnfired(true,true,true);
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
               _loc15_ = this.screenBattle.getBestWeaponsToFire(dataM.player2PlayerID,dataM.player1PlayerID,false,true,false,true);
               if(_loc15_.length > 0)
               {
                  _loc16_ = this.screenBattle.getBestWeaponsToFire(dataM.player2PlayerID,dataM.player1PlayerID,true,true,false,true);
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
                  _loc9_ = dataM.getPlayerItemData(dataM.player2PlayerID,this.computerMechBattleData.mechStructure[_loc8_]);
                  _loc17_ = false;
                  if(this.screenBattle.isOpponentInWeaponRange(dataM.player2PlayerID,dataM.player1PlayerID,_loc9_.itemID,-1,-1,-1))
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
                        _loc22_ = dataM.getPlayerItemData(dataM.player2PlayerID,this.computerMechBattleData.mechStructure.teleport);
                        _loc23_ = dataM.itemsDB[_loc22_.itemID];
                        _loc20_ = Number(this.computerMechBattleData.usesMax["teleport"]);
                        _loc19_ = Number(this.computerMechBattleData.uses["teleport"]);
                        if(_loc20_ == 0 || _loc20_ > 0 && _loc19_ < _loc20_)
                        {
                           if(this.computerMechBattleData.energy >= _loc23_.costEnergy)
                           {
                              _loc24_ = new Array();
                              _loc26_ = this.playerMechBattleData.currentStepVisual - (_loc10_ + 1) - _loc11_ - (_loc18_.rangeBase + _loc18_.rangeAddon);
                              _loc27_ = this.playerMechBattleData.currentStepVisual - (_loc10_ + 1) - _loc11_ - _loc18_.rangeBase;
                              _loc25_ = _loc26_;
                              while(_loc25_ <= _loc27_)
                              {
                                 if(this.screenBattle.getAvailableStep(dataM.player2PlayerID,this.computerMechBattleData.currentStepVisual,_loc25_,"teleport") > -1)
                                 {
                                    _loc24_.push(_loc25_);
                                 }
                                 _loc25_++;
                              }
                              _loc26_ = this.playerMechBattleData.currentStepVisual + _loc10_ + _loc11_ + _loc18_.rangeBase;
                              _loc27_ = this.playerMechBattleData.currentStepVisual + _loc10_ + _loc11_ + (_loc18_.rangeBase + _loc18_.rangeAddon);
                              _loc25_ = _loc26_;
                              while(_loc25_ <= _loc27_)
                              {
                                 if(this.screenBattle.getAvailableStep(dataM.player2PlayerID,this.computerMechBattleData.currentStepVisual,_loc25_,"teleport") > -1)
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
                                    if(Math.abs(_loc28_ - this.playerMechBattleData.currentStepVisual) <= _loc23_.rangeAddon + (_loc10_ + 1 + _loc11_))
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
                                    if(Math.abs(_loc28_ - this.playerMechBattleData.currentStepCode) <= 1 + _loc23_.rangeAddon)
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
                                    _loc21_.push("teleport");
                                    this.useTeleportTargetStep = _loc28_;
                                 }
                              }
                           }
                        }
                     }
                     if(this.computerMechBattleData.mechStructure.charge > 0)
                     {
                        _loc34_ = dataM.getPlayerItemData(dataM.player2PlayerID,this.computerMechBattleData.mechStructure.charge);
                        _loc35_ = dataM.itemsDB[_loc34_.itemID];
                        _loc20_ = Number(this.computerMechBattleData.usesMax["charge"]);
                        _loc19_ = Number(this.computerMechBattleData.uses["charge"]);
                        if(this.screenBattle.isOpponentInWeaponRange(dataM.player2PlayerID,dataM.player1PlayerID,_loc35_.itemID,-1,-1,-1))
                        {
                           if(_loc20_ == 0 || _loc20_ > 0 && _loc19_ < _loc20_)
                           {
                              if(this.computerMechBattleData.energy >= _loc35_.costEnergy)
                              {
                                 _loc21_.push("charge");
                              }
                           }
                        }
                     }
                     if(this.computerMechBattleData.mechStructure.harpoon > 0)
                     {
                        _loc36_ = dataM.getPlayerItemData(dataM.player2PlayerID,this.computerMechBattleData.mechStructure.harpoon);
                        _loc37_ = dataM.itemsDB[_loc36_.itemID];
                        _loc20_ = Number(this.computerMechBattleData.usesMax["harpoon"]);
                        _loc19_ = Number(this.computerMechBattleData.uses["harpoon"]);
                        if(this.screenBattle.isOpponentInWeaponRange(dataM.player2PlayerID,dataM.player1PlayerID,_loc37_.itemID,-1,-1,-1))
                        {
                           if(_loc20_ == 0 || _loc20_ > 0 && _loc19_ < _loc20_)
                           {
                              if(this.computerMechBattleData.energy >= _loc37_.costEnergy)
                              {
                                 _loc21_.push("harpoon");
                              }
                           }
                        }
                     }
                     if(_loc21_.length > 0)
                     {
                        _loc38_ = RandomUtils.chooseRandomIndex(_loc21_);
                        switch(_loc21_[_loc38_])
                        {
                           case "teleport":
                              this.useTeleport = true;
                              break;
                           case "charge":
                              this.useCharge = true;
                              break;
                           case "harpoon":
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
                              if(this.screenBattle.isOpponentInWeaponRange(dataM.player2PlayerID,dataM.player1PlayerID,_loc9_.itemID,-1,-1,_loc2_))
                              {
                                 _loc3_ = this.screenBattle.getAvailableStep(dataM.player2PlayerID,_loc1_,_loc2_,"jump");
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
                           if(this.computerMechBattleData.currentStepVisual > this.playerMechBattleData.currentStepVisual)
                           {
                              _loc4_ = 1;
                              while(_loc4_ <= this.MOTION_CALCULATION_AP)
                              {
                                 _loc2_ = _loc1_ + this.computerMechBattleData.stepsPerWalk * _loc4_;
                                 if(this.screenBattle.isOpponentInWeaponRange(dataM.player2PlayerID,dataM.player1PlayerID,_loc9_.itemID,-1,-1,_loc2_))
                                 {
                                    _loc3_ = this.screenBattle.getAvailableStep(dataM.player2PlayerID,_loc1_,_loc2_,"walk");
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
                                 if(this.screenBattle.isOpponentInWeaponRange(dataM.player2PlayerID,dataM.player1PlayerID,_loc9_.itemID,-1,-1,_loc2_))
                                 {
                                    _loc3_ = this.screenBattle.getAvailableStep(dataM.player2PlayerID,_loc1_,_loc2_,"jump");
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
                           if(this.computerMechBattleData.currentStepVisual < this.playerMechBattleData.currentStepVisual)
                           {
                              _loc4_ = 1;
                              while(_loc4_ <= this.MOTION_CALCULATION_AP)
                              {
                                 _loc2_ = _loc1_ - this.computerMechBattleData.stepsPerWalk * _loc4_;
                                 if(this.screenBattle.isOpponentInWeaponRange(dataM.player2PlayerID,dataM.player1PlayerID,_loc9_.itemID,-1,-1,_loc2_))
                                 {
                                    _loc3_ = this.screenBattle.getAvailableStep(dataM.player2PlayerID,_loc1_,_loc2_,"walk");
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
            if(dataM.battleType == "challenge")
            {
               if(dataM.battleSubType == "godMode")
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
                  if(_loc12_ <= this.playerProfile.levelByItems)
                  {
                     this.fireWeapon = true;
                     this.fireWeaponType = "sideWeapon";
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
               _loc39_ = dataM.getPlayerItemData(dataM.player2PlayerID,this.computerMechBattleData.mechStructure.leg);
               _loc40_ = dataM.itemsDB[_loc39_.itemID];
               if(this.screenBattle.isOpponentInWeaponRange(dataM.player2PlayerID,dataM.player1PlayerID,-1,_loc40_.rangeBase,_loc40_.rangeAddon,-1))
               {
                  if(this.canStomp)
                  {
                     this.useStomp = true;
                  }
               }
               else if(this.canMove)
               {
                  if(this.computerMechBattleData.currentStepVisual < this.playerMechBattleData.currentStepVisual)
                  {
                     if(this.computerMechBattleData.stepsPerJump > 0)
                     {
                        this.jumpRight = true;
                     }
                     else
                     {
                        this.walkRight = true;
                     }
                  }
                  else if(this.computerMechBattleData.stepsPerJump > 0)
                  {
                     this.jumpLeft = true;
                  }
                  else
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
         for(; _loc5_ <= dataM.maxEquipment["kit"]; _loc5_++)
         {
            _loc6_ = Number(param2.mechStructure["kit" + _loc5_]);
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
                  break;
               case "bullets":
                  if(_loc8_.bullets > 0)
                  {
                     _loc4_.push(_loc5_);
                  }
                  break;
               case "rockets":
                  if(_loc8_.rockets > 0)
                  {
                     _loc4_.push(_loc5_);
                  }
            }
         }
         return _loc4_;
      }
   }
}

