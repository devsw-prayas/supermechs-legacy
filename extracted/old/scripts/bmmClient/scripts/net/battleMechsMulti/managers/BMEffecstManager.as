package net.battleMechsMulti.managers
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMFlyingKit;
   import net.battleMechsMulti.mobiles.BMFlyingNumber;
   import net.battleMechsMulti.mobiles.BMMovingImage;
   import net.battleMechsMulti.mobiles.effects.BMEffectArtillery;
   import net.battleMechsMulti.mobiles.effects.BMEffectDebrie;
   import net.battleMechsMulti.mobiles.effects.BMEffectElectricity;
   import net.battleMechsMulti.mobiles.effects.BMEffectEnergyChargeCenter;
   import net.battleMechsMulti.mobiles.effects.BMEffectEnergyChargeSparkMC;
   import net.battleMechsMulti.mobiles.effects.BMEffectExplosion;
   import net.battleMechsMulti.mobiles.effects.BMEffectFireBeam;
   import net.battleMechsMulti.mobiles.effects.BMEffectFireEffect;
   import net.battleMechsMulti.mobiles.effects.BMEffectFlame;
   import net.battleMechsMulti.mobiles.effects.BMEffectFlameBaseLine;
   import net.battleMechsMulti.mobiles.effects.BMEffectFlyingGoldCoin;
   import net.battleMechsMulti.mobiles.effects.BMEffectGeneral;
   import net.battleMechsMulti.mobiles.effects.BMEffectMachineGunFire;
   import net.battleMechsMulti.mobiles.effects.BMEffectMegaExplosion;
   import net.battleMechsMulti.mobiles.effects.BMEffectOrb;
   import net.battleMechsMulti.mobiles.effects.BMEffectOrbExplosion;
   import net.battleMechsMulti.mobiles.effects.BMEffectOrbTail;
   import net.battleMechsMulti.mobiles.effects.BMEffectProjectile;
   import net.battleMechsMulti.mobiles.effects.BMEffectRepairBeam;
   import net.battleMechsMulti.mobiles.effects.BMEffectShield;
   import net.battleMechsMulti.mobiles.effects.BMEffectShockWave;
   import net.battleMechsMulti.mobiles.effects.BMEffectShutDown;
   import net.battleMechsMulti.mobiles.effects.BMEffectSpark;
   import net.battleMechsMulti.mobiles.effects.BMEffectSparkAutoMC;
   import net.battleMechsMulti.mobiles.effects.BMEffectSparkMC;
   import net.battleMechsMulti.mobiles.effects.BMEffectStompFire;
   import net.battleMechsMulti.mobiles.effects.BMEffectTeleportAfterEffect;
   import net.battleMechsMulti.mobiles.effects.BMEffectTeleportDisappear;
   import net.battleMechsMulti.mobiles.effects.BMEffectTeleportReappear;
   
   public class BMEffecstManager extends BMBaseClass
   {
      
      private static var _instance:BMEffecstManager;
      
      private static var _allowInstantiation:Boolean;
      
      private var _generalEffects:Array;
      
      private var _effectsStorage:Array;
      
      private var _effectsForDeletion:Array;
      
      public var movingImageIDCounter:Number;
      
      private var _flameThrowerActive:Boolean;
      
      private var _flameThrowerGetHitFunction:Function;
      
      private var _flameThrowerReturnFunction:Function;
      
      private var _flameThrowerReturnFunctionParams:Array;
      
      private var _flameThrowerHolder:MovieClip;
      
      private var _flameThrowerCounter:Number;
      
      private var _flameThrowerGetHitPlayerID:Number;
      
      private var _flameThrowerFireXPos:Number;
      
      private var _flameThrowerFireYPos:Number;
      
      private var _flameThrowerDirection:Number;
      
      private var _flameThrowerDistance:Number;
      
      private var _flameThrowerFireEffect:String;
      
      private var _createOnNextFrames:Array = new Array();
      
      private var _sparksAutoMCData:Object = new Object();
      
      private var _energyChargeSparksMCData:Array = new Array();
      
      private var _setAllSparksAndDebriesForDeletion:Boolean = false;
      
      private var currentSpark:BMEffectSpark;
      
      private var currentSparkMC:BMEffectSparkMC;
      
      private var currentSparkAutoMC:BMEffectSparkAutoMC;
      
      private var currentEnergyChargeSparkMC:BMEffectEnergyChargeSparkMC;
      
      private var currentEnergyChargeCenter:BMEffectEnergyChargeCenter;
      
      private var currentDebrie:BMEffectDebrie;
      
      private var currentExplosion:BMEffectExplosion;
      
      private var currentProjectile:BMEffectProjectile;
      
      private var currentArtillery:BMEffectArtillery;
      
      private var currentOrb:BMEffectOrb;
      
      private var currentOrbTail:BMEffectOrbTail;
      
      private var currentShockWave:BMEffectShockWave;
      
      private var currentFlyingNumber:BMFlyingNumber;
      
      private var currentFlyingKit:BMFlyingKit;
      
      private var currentMovingImage:BMMovingImage;
      
      private var currentFireBeam:BMEffectFireBeam;
      
      private var currentShield:BMEffectShield;
      
      private var currentFlame:BMEffectFlame;
      
      private var currentFlameBaseLine:BMEffectFlameBaseLine;
      
      private var currentMegaExplosion:BMEffectMegaExplosion;
      
      private var currentOrbExplosion:BMEffectOrbExplosion;
      
      private var currentMachineGunFire:BMEffectMachineGunFire;
      
      private var currentStompFire:BMEffectStompFire;
      
      private var currentTeleportDisappear:BMEffectTeleportDisappear;
      
      private var currentTeleportReappear:BMEffectTeleportReappear;
      
      private var currentTeleportAfterEffect:BMEffectTeleportAfterEffect;
      
      private var currentShutDown:BMEffectShutDown;
      
      private var currentElectricity:BMEffectElectricity;
      
      private var currentFireEffect:BMEffectFireEffect;
      
      private var currentFlyingGoldCoin:BMEffectFlyingGoldCoin;
      
      private var currentRepairBeam:BMEffectRepairBeam;
      
      private var screens:Array;
      
      private var screensWidth:Array;
      
      private var screensHeight:Array;
      
      public var effectsParameters:Object;
      
      private const MIN_SAVED_DATA_FOR_SPARK_AUTO:Number = 13;
      
      public function BMEffecstManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMEffecstManager.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : BMEffecstManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMEffecstManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMEffecstManager initialized");
         generateSingletonClassesPointers("effectsManager");
         this.effectsParameters = new Object();
         this.effectsParameters["fireBeam"] = new Object();
         this.effectsParameters["fireBeam"]["regular"] = new Object();
         this.effectsParameters["fireBeam"]["fast"] = new Object();
         this.effectsParameters["fireBeam"]["regular"]["createBottomGlow"] = {"scale":0.1};
         this.effectsParameters["fireBeam"]["fast"]["createBottomGlow"] = {"scale":0.1};
         this.effectsParameters["fireBeam"]["regular"]["growBottomGlow"] = {
            "scaleChange":0.1,
            "alphaChange":0.1,
            "frames":9
         };
         this.effectsParameters["fireBeam"]["fast"]["growBottomGlow"] = {
            "scaleChange":0.2,
            "alphaChange":0.2,
            "frames":4
         };
         this.effectsParameters["fireBeam"]["regular"]["createBeamWaveAndTopGlow"] = {};
         this.effectsParameters["fireBeam"]["fast"]["createBeamWaveAndTopGlow"] = {};
         this.effectsParameters["fireBeam"]["regular"]["moveBeamAndWave"] = {
            "xChange":240,
            "frames":10
         };
         this.effectsParameters["fireBeam"]["fast"]["moveBeamAndWave"] = {
            "xChange":480,
            "frames":5
         };
         this.effectsParameters["fireBeam"]["regular"]["beamStatic"] = {"frames":6};
         this.effectsParameters["fireBeam"]["fast"]["beamStatic"] = {"frames":3};
         this.effectsParameters["fireBeam"]["regular"]["beamShrink"] = {
            "scaleChange":0.15,
            "alphaChange":0.15,
            "frames":6
         };
         this.effectsParameters["fireBeam"]["fast"]["beamShrink"] = {
            "scaleChange":0.3,
            "alphaChange":0.3,
            "frames":3
         };
         this.effectsParameters["fireBeam"]["regular"]["glowShrink"] = {
            "scaleChange":0.15,
            "alphaChange":0.15,
            "frames":6
         };
         this.effectsParameters["fireBeam"]["fast"]["glowShrink"] = {
            "scaleChange":0.3,
            "alphaChange":0.3,
            "frames":3
         };
         this._generalEffects = new Array();
         this._effectsStorage = new Array();
         this._flameThrowerActive = false;
         this.movingImageIDCounter = 0;
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(dataM.battle_gamePaused == false)
         {
            this._effectsForDeletion = new Array();
            if(this._createOnNextFrames.length > 0)
            {
               if(this._createOnNextFrames[0] != null)
               {
                  _loc3_ = this._createOnNextFrames[0];
                  _loc2_ = _loc3_.length;
                  _loc1_ = 0;
                  while(_loc1_ < _loc2_)
                  {
                     _loc4_ = _loc3_[_loc1_];
                     switch(_loc4_.type)
                     {
                        case "generalEffect":
                           switch(_loc4_.effectName)
                           {
                              case "smallExplosionAnim1":
                                 this.createExplosion(1,_loc4_.xPos,_loc4_.yPos,50,30,20,2,7,2,_loc4_.holderMC);
                                 break;
                              case "electricityRedBig1":
                              case "electricityBig1":
                                 this.createElectricity(_loc4_.effectName,_loc4_.xPos,_loc4_.yPos,_loc4_.holderMC);
                                 break;
                              default:
                                 this.createGeneralEffect(_loc4_.holderMC,_loc4_.effectName,false,0,0,_loc4_.xPos,_loc4_.yPos,_loc4_.rotation,null,null);
                           }
                     }
                     _loc1_++;
                  }
               }
               this._createOnNextFrames.splice(0,1);
            }
            this.screens = new Array();
            this.screensWidth = new Array();
            this.screensHeight = new Array();
            this.screens.push("screenBattle");
            this.screens.push("screenBattleResult");
            this.screens.push("screenLadderStatus");
            this.screens.push("screenTopBar");
            this.screens.push("screenOpeningSequence");
            _loc1_ = 0;
            while(_loc1_ < this._effectsStorage.length)
            {
               switch(this._effectsStorage[_loc1_].type)
               {
                  case "sparkMC":
                  case "sparkAutoMC":
                  case "energyChargeSparkMC":
                     if(dataM.movieClipParticleEffects)
                     {
                        switch(this._effectsStorage[_loc1_].type)
                        {
                           case "sparkMC":
                              this.currentSparkMC = this._effectsStorage[_loc1_].effect;
                              this.currentSparkMC.runFrame(_loc1_);
                              break;
                           case "sparkAutoMC":
                              this.currentSparkAutoMC = this._effectsStorage[_loc1_].effect;
                              this.currentSparkAutoMC.runFrame(_loc1_);
                              break;
                           case "energyChargeSparkMC":
                              this.currentEnergyChargeSparkMC = this._effectsStorage[_loc1_].effect;
                              this.currentEnergyChargeSparkMC.runFrame(_loc1_);
                        }
                     }
                     break;
                  case "energyChargeCenter":
                     this.currentEnergyChargeCenter = this._effectsStorage[_loc1_].effect;
                     this.currentEnergyChargeCenter.runFrame(_loc1_);
                     break;
                  case "debrie":
                     this.currentDebrie = this._effectsStorage[_loc1_].effect;
                     this.currentDebrie.runFrame(_loc1_);
                     break;
                  case "explosion":
                     this.currentExplosion = this._effectsStorage[_loc1_].effect;
                     this.currentExplosion.runFrame(_loc1_);
                     break;
                  case "projectile":
                     this.currentProjectile = this._effectsStorage[_loc1_].effect;
                     this.currentProjectile.runFrame(_loc1_);
                     break;
                  case "artillery":
                     this.currentArtillery = this._effectsStorage[_loc1_].effect;
                     this.currentArtillery.runFrame(_loc1_);
                     break;
                  case "orb":
                     this.currentOrb = this._effectsStorage[_loc1_].effect;
                     this.currentOrb.runFrame(_loc1_);
                     break;
                  case "orbTail":
                     this.currentOrbTail = this._effectsStorage[_loc1_].effect;
                     this.currentOrbTail.runFrame(_loc1_);
                     break;
                  case "shockWave":
                     this.currentShockWave = this._effectsStorage[_loc1_].effect;
                     this.currentShockWave.runFrame(_loc1_);
                     break;
                  case "flyingNumber":
                     this.currentFlyingNumber = this._effectsStorage[_loc1_].effect;
                     this.currentFlyingNumber.runFrame(_loc1_);
                     break;
                  case "flyingKit":
                     this.currentFlyingKit = this._effectsStorage[_loc1_].effect;
                     this.currentFlyingKit.runFrame(_loc1_);
                     break;
                  case "movingImage":
                     this.currentMovingImage = this._effectsStorage[_loc1_].effect;
                     this.currentMovingImage.runFrame(_loc1_);
                     break;
                  case "fireBeam":
                     this.currentFireBeam = this._effectsStorage[_loc1_].effect;
                     this.currentFireBeam.runFrame(_loc1_);
                     break;
                  case "shield":
                     this.currentShield = this._effectsStorage[_loc1_].effect;
                     this.currentShield.runFrame(_loc1_);
                     break;
                  case "flame":
                     this.currentFlame = this._effectsStorage[_loc1_].effect;
                     this.currentFlame.runFrame(_loc1_);
                     break;
                  case "flameBaseLine":
                     this.currentFlameBaseLine = this._effectsStorage[_loc1_].effect;
                     this.currentFlameBaseLine.runFrame(_loc1_);
                     break;
                  case "megaExplosion":
                     this.currentMegaExplosion = this._effectsStorage[_loc1_].effect;
                     this.currentMegaExplosion.runFrame(_loc1_);
                     break;
                  case "orbExplosion":
                     this.currentOrbExplosion = this._effectsStorage[_loc1_].effect;
                     this.currentOrbExplosion.runFrame(_loc1_);
                     break;
                  case "machineGunFire":
                     this.currentMachineGunFire = this._effectsStorage[_loc1_].effect;
                     this.currentMachineGunFire.runFrame(_loc1_);
                     break;
                  case "stompFire":
                     this.currentStompFire = this._effectsStorage[_loc1_].effect;
                     this.currentStompFire.runFrame(_loc1_);
                     break;
                  case "teleportDisappear":
                     this.currentTeleportDisappear = this._effectsStorage[_loc1_].effect;
                     this.currentTeleportDisappear.runFrame(_loc1_);
                     break;
                  case "teleportReappear":
                     this.currentTeleportReappear = this._effectsStorage[_loc1_].effect;
                     this.currentTeleportReappear.runFrame(_loc1_);
                     break;
                  case "teleportAfterEffect":
                     this.currentTeleportAfterEffect = this._effectsStorage[_loc1_].effect;
                     this.currentTeleportAfterEffect.runFrame(_loc1_);
                     break;
                  case "shutdown":
                     this.currentShutDown = this._effectsStorage[_loc1_].effect;
                     this.currentShutDown.runFrame(_loc1_);
                     break;
                  case "electricity":
                     this.currentElectricity = this._effectsStorage[_loc1_].effect;
                     this.currentElectricity.runFrame(_loc1_);
                     break;
                  case "fireEffect":
                     this.currentFireEffect = this._effectsStorage[_loc1_].effect;
                     this.currentFireEffect.runFrame(_loc1_);
                     break;
                  case "flyingGoldCoin":
                     this.currentFlyingGoldCoin = this._effectsStorage[_loc1_].effect;
                     this.currentFlyingGoldCoin.runFrame(_loc1_);
                     break;
                  case "repairBeam":
                     this.currentRepairBeam = this._effectsStorage[_loc1_].effect;
                     this.currentRepairBeam.runFrame(_loc1_);
               }
               _loc1_++;
            }
            this._effectsForDeletion.sortOn("slot",Array.NUMERIC);
            this.deleteSetForDeletions();
            this.flameThrowerHandler();
         }
      }
      
      private function deleteSetForDeletions() : void
      {
         var _loc2_:uint = 0;
         if(this._setAllSparksAndDebriesForDeletion)
         {
            this._setAllSparksAndDebriesForDeletion = false;
            this.setAllSparksAndDebriesForDeletionSub();
         }
         var _loc1_:Number = this._effectsForDeletion.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = uint(this._effectsForDeletion[_loc1_].slot);
            if(this._effectsStorage[_loc2_] != null)
            {
               if(this._effectsStorage[_loc2_].effect != null)
               {
                  this._effectsStorage[_loc2_].effect.removeMe();
                  this._effectsStorage[_loc2_].effect = null;
               }
               if(this._effectsStorage[_loc2_].parent != null)
               {
                  this._effectsStorage[_loc2_].parent.removeChild(this._effectsStorage[_loc2_]);
               }
               this._effectsStorage[_loc2_] = null;
            }
            this._effectsStorage.splice(_loc2_,1);
            _loc1_--;
         }
      }
      
      public function setEffectForDeletion(param1:String, param2:uint) : void
      {
         this._effectsForDeletion.push({
            "type":param1,
            "slot":param2
         });
      }
      
      public function setFireBeamForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("fireBeam",param1);
      }
      
      public function setShieldForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("shield",param1);
      }
      
      public function setSparkForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("spark",param1);
      }
      
      public function setSparkMCForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("sparkMC",param1);
      }
      
      public function setSparkAutoMCForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("sparkAutoMC",param1);
      }
      
      public function setEnergyChargeSparkMCForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("energyChargeSparkMC",param1);
      }
      
      public function setEnergyChargeCenterForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("energyChargeCenter",param1);
      }
      
      public function setDebrieForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("debrie",param1);
      }
      
      public function setExplosionForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("explosion",param1);
      }
      
      public function setProjectileForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("projectile",param1);
      }
      
      public function setArtilleryForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("artillery",param1);
      }
      
      public function setOrbForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("orb",param1);
      }
      
      public function setOrbTailForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("orbTail",param1);
      }
      
      public function setShockWaveForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("shockWave",param1);
      }
      
      public function setFlyingNumberForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("flyingNumber",param1);
      }
      
      public function setFlyingKitForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("flyingKit",param1);
      }
      
      public function setMovingImageForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("movingImage",param1);
      }
      
      public function setFlameForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("flame",param1);
      }
      
      public function setFlameBaseLineForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("flameBaseLine",param1);
      }
      
      public function setMegaExplosionForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("megaExplosion",param1);
      }
      
      public function setOrbExplosionForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("orbExplosion",param1);
      }
      
      public function setMachineGunFireForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("machineGunFire",param1);
      }
      
      public function setStompFireForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("stompFire",param1);
      }
      
      public function setTeleportDisappearForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("teleportDisappear",param1);
      }
      
      public function setTeleportReappearForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("teleportReappear",param1);
      }
      
      public function setTeleportAfterEffectForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("teleportAfterEffect",param1);
      }
      
      public function setShutDownForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("shutdown",param1);
      }
      
      public function setElectricityForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("electricity",param1);
      }
      
      public function setFireEffectForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("fireEffect",param1);
      }
      
      public function setFlyingGoldCoinForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("flyingGoldCoin",param1);
      }
      
      public function setRepairBeamForDeletion(param1:uint) : void
      {
         this.setEffectForDeletion("repairBeam",param1);
      }
      
      public function setAllSparksAndDebriesForDeletion() : void
      {
         this._setAllSparksAndDebriesForDeletion = true;
      }
      
      private function setAllSparksAndDebriesForDeletionSub() : void
      {
         var _loc2_:String = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._effectsStorage.length)
         {
            _loc2_ = this._effectsStorage[_loc1_].type;
            switch(_loc2_)
            {
               case "spark":
               case "sparkMC":
               case "sparkAutoMC":
               case "energyChargeSparkMC":
               case "debrie":
                  this.setEffectForDeletion(_loc2_,_loc1_);
            }
            _loc1_++;
         }
      }
      
      public function setAllEffectsForDeletion() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._effectsStorage.length)
         {
            this.setEffectForDeletion(this._effectsStorage[_loc1_].type,_loc1_);
            _loc1_++;
         }
         this._createOnNextFrames = new Array();
      }
      
      public function setAllEffectsForDeletionAndDeleteThem(param1:Boolean) : void
      {
         this.setAllEffectsForDeletion();
         this.deleteSetForDeletions();
         if(param1)
         {
            this.abortGeneralEffects();
         }
      }
      
      public function createProjectileShots(param1:MovieClip, param2:Number, param3:Number, param4:String, param5:String, param6:Number, param7:Number, param8:Boolean, param9:Number, param10:Number, param11:Number, param12:Number, param13:Array, param14:String, param15:Function, param16:Function, param17:Function, param18:Array) : void
      {
         var _loc20_:MovieClip = null;
         var _loc21_:BMEffectProjectile = null;
         var _loc22_:Number = NaN;
         var _loc23_:Function = null;
         var _loc19_:int = int(param13.length);
         var _loc24_:Boolean = false;
         var _loc25_:Number = 1;
         while(_loc25_ <= _loc19_)
         {
            _loc20_ = externalAssetsM.getAsset("general",param4,0,0,false,false,false);
            _loc21_ = new BMEffectProjectile();
            _loc22_ = (_loc25_ - 1) * param7 + param6;
            _loc23_ = null;
            if(_loc25_ == param13.length)
            {
               _loc23_ = param17;
            }
            _loc21_.x = param13[_loc25_ - 1].x;
            _loc21_.y = param13[_loc25_ - 1].y;
            if(param16 != null)
            {
               if(_loc25_ == _loc19_)
               {
                  _loc24_ = true;
               }
            }
            _loc21_.initialize(param1,_loc20_,param2,param3,param5,_loc22_,param8,param9,param10,param11,param12,param14,param15,param16,_loc24_,_loc23_,param18);
            this._effectsStorage.push({
               "type":"projectile",
               "effect":_loc21_
            });
            _loc25_++;
         }
      }
      
      public function createRocketBarrage(param1:MovieClip, param2:Number, param3:Number, param4:String, param5:String, param6:Number, param7:Number, param8:Number, param9:Number, param10:Boolean, param11:Number, param12:Number, param13:Number, param14:Number, param15:Number, param16:Number, param17:String, param18:Function, param19:Function, param20:Function, param21:Array) : void
      {
         var _loc22_:MovieClip = null;
         var _loc23_:BMEffectProjectile = null;
         var _loc24_:Number = NaN;
         var _loc25_:Function = null;
         var _loc28_:Number = NaN;
         var _loc26_:Boolean = false;
         var _loc27_:Number = 1;
         while(_loc27_ <= param7)
         {
            _loc28_ = 1;
            while(_loc28_ <= param6)
            {
               _loc22_ = externalAssetsM.getAsset("general",param4,0,0,false,false,false);
               _loc23_ = new BMEffectProjectile();
               _loc24_ = (_loc28_ - 1 + param6 * (_loc27_ - 1)) * param8;
               _loc25_ = null;
               if(_loc27_ == param7 && _loc28_ == param6)
               {
                  _loc25_ = param20;
               }
               _loc23_.x = param15;
               _loc23_.y = param16 + (_loc28_ - 1) * param9 - param6 / 2 * param9;
               if(param19 != null)
               {
                  if(_loc27_ == param7 && _loc28_ == param6)
                  {
                     _loc26_ = true;
                  }
               }
               _loc23_.initialize(param1,_loc22_,param2,param3,param5,_loc24_,param10,param11,param12,param13,param14,param17,param18,param19,_loc26_,_loc25_,param21);
               this._effectsStorage.push({
                  "type":"projectile",
                  "effect":_loc23_
               });
               _loc28_++;
            }
            _loc27_++;
         }
      }
      
      public function createArtilleryBarrage(param1:MovieClip, param2:Number, param3:Number, param4:Boolean, param5:Boolean, param6:String, param7:String, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number, param15:Number, param16:Number, param17:Number, param18:String, param19:Function, param20:Function, param21:Function, param22:Array) : void
      {
         var _loc23_:MovieClip = null;
         var _loc24_:BMEffectArtillery = null;
         var _loc25_:Number = NaN;
         var _loc26_:Function = null;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc29_:Number = 1;
         while(_loc29_ <= param9)
         {
            _loc30_ = 1;
            while(_loc30_ <= param8)
            {
               _loc23_ = externalAssetsM.getAsset("general",param6,0,0,false,false,false);
               _loc24_ = new BMEffectArtillery();
               _loc25_ = (_loc30_ - 1 + param8 * (_loc29_ - 1)) * param10;
               _loc26_ = null;
               if(_loc29_ == param9 && _loc30_ == param8)
               {
                  _loc26_ = param21;
               }
               _loc27_ = param16 - param14;
               _loc28_ = param17 - param15;
               _loc24_.x = param14 + (_loc30_ - 1) * param11 - param8 / 2 * param11;
               _loc24_.y = param15 + (_loc30_ - 1) * param12 - param8 / 2 * param12;
               _loc24_.initialize(param1,_loc23_,param2,param3,param4,param5,param7,_loc25_,param13,_loc27_,_loc28_,param18,param19,param20,_loc26_,param22);
               this._effectsStorage.push({
                  "type":"artillery",
                  "effect":_loc24_
               });
               _loc30_++;
            }
            _loc29_++;
         }
      }
      
      public function createMegaProjectile(param1:MovieClip, param2:Number, param3:Number, param4:String, param5:String, param6:String, param7:String, param8:Boolean, param9:Number, param10:Number, param11:Array, param12:Function, param13:Function, param14:Function, param15:Array) : void
      {
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc16_:Number = 40;
         this.createProjectileShots(param1,param2,param3,param4,param5,0,0,param8,_loc16_,0,param9,param10,param11,param7,param12,param13,param14,param15);
         var _loc17_:Number = 1;
         if(param8)
         {
            _loc17_ = -1;
         }
         var _loc18_:int = Math.ceil(param9 / _loc16_);
         var _loc19_:Number = 20;
         var _loc23_:Number = 1;
         while(_loc23_ <= _loc18_)
         {
            _loc20_ = param11[0].x + _loc23_ * _loc16_ * _loc17_ + Math.random() * _loc19_ - _loc19_ / 2;
            _loc21_ = param11[0].y + param10 * _loc23_ / Math.ceil(param9 / _loc16_) + Math.random() * _loc19_ - _loc19_ / 2;
            _loc22_ = Math.ceil(Math.random() * 360);
            this.addCreateOnNextFrameData(_loc23_,{
               "type":"generalEffect",
               "holderMC":param1,
               "effectName":param6,
               "xPos":_loc20_,
               "yPos":_loc21_,
               "rotation":_loc22_
            });
            _loc23_++;
         }
      }
      
      private function addCreateOnNextFrameData(param1:Number, param2:Object) : void
      {
         if(this._createOnNextFrames[param1] == null)
         {
            this._createOnNextFrames[param1] = new Array();
         }
         this._createOnNextFrames[param1].push(param2);
      }
      
      public function createShockWave(param1:MovieClip, param2:Number, param3:Number, param4:String, param5:String, param6:String, param7:String, param8:Array, param9:String, param10:Boolean, param11:Number, param12:Number, param13:Function, param14:Function, param15:Function, param16:Array) : void
      {
         var _loc18_:BMEffectShockWave = null;
         var _loc19_:MovieClip = null;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:Number = NaN;
         var _loc23_:Function = null;
         var _loc24_:Array = null;
         var _loc17_:uint = 0;
         while(_loc17_ < param8.length)
         {
            _loc18_ = new BMEffectShockWave();
            _loc19_ = externalAssetsM.getAsset("general",param4,0,0,false,false,false);
            _loc18_.x = param8[_loc17_].x;
            _loc18_.y = param8[_loc17_].y;
            _loc20_ = 35;
            _loc21_ = _loc17_ * 10;
            _loc22_ = 0;
            _loc23_ = null;
            _loc24_ = new Array();
            if(_loc17_ == param8.length - 1)
            {
               _loc23_ = param15;
               _loc24_ = param16;
            }
            _loc18_.initialize(param1,_loc19_,param2,param3,param5,param6,param7,_loc21_,param10,_loc20_,_loc22_,param11,param12,param9,param13,param14,true,_loc23_,_loc24_);
            this._effectsStorage.push({
               "type":"shockWave",
               "effect":_loc18_
            });
            _loc17_++;
         }
      }
      
      public function createShockWaveTailEffect(param1:Number, param2:Number, param3:String, param4:MovieClip) : void
      {
         var _loc5_:Number = param1 + Math.random() * 10 - 5;
         var _loc6_:Number = param2 + Math.random() * 10 - 5;
         this.createGeneralEffect(param4,param3,false,0,0,_loc5_,_loc6_,0,null,null);
      }
      
      public function createOrb(param1:MovieClip, param2:Number, param3:Number, param4:String, param5:String, param6:String, param7:String, param8:String, param9:Boolean, param10:Number, param11:Array, param12:Function, param13:Function, param14:Function, param15:Array) : void
      {
         var _loc16_:BMEffectOrb = new BMEffectOrb();
         var _loc17_:MovieClip = externalAssetsM.getAsset("general",param4,0,0,false,false,false);
         _loc16_.x = param11[0].x;
         _loc16_.y = param11[0].y;
         var _loc18_:uint = 35;
         if(param10 < 250)
         {
            _loc18_ = 10;
         }
         else if(param10 < 500)
         {
            _loc18_ = 15;
         }
         else if(param10 < 1000)
         {
            _loc18_ = 20;
         }
         var _loc19_:uint = 0;
         _loc16_.initialize(param1,_loc17_,param2,param3,param5,param6,param7,_loc19_,param9,_loc18_,param10,param8,param12,param13,true,param14,param15);
         this._effectsStorage.push({
            "type":"orb",
            "effect":_loc16_
         });
      }
      
      public function createOrbTail(param1:Number, param2:Number, param3:String, param4:MovieClip) : void
      {
         var _loc5_:BMEffectOrbTail = new BMEffectOrbTail();
         _loc5_.initialize(param4,param3,param1,param2);
         this._effectsStorage.push({
            "type":"orbTail",
            "effect":_loc5_
         });
      }
      
      public function createOrbExplosion(param1:Number, param2:Number, param3:String, param4:MovieClip) : void
      {
         var _loc5_:String = null;
         switch(param3)
         {
            case "orange":
               _loc5_ = "stompFire1";
               break;
            case "red":
               _loc5_ = "stompFire2";
               break;
            case "blue":
               _loc5_ = "stompFire3";
         }
         this.createStompFire(param4,_loc5_,param1,param2,60,6,1,false);
         this.createStompFire(param4,_loc5_,param1,param2,60,6,1,true);
         this.createOrbExplosionSub(param4,param1,param2);
         screensM.screenBattle.createGetHitSound();
         soundM.createSound("fireBullet2",1);
      }
      
      public function createTeleportDisappear(param1:String, param2:Number, param3:Number, param4:Number, param5:Function, param6:Array, param7:MovieClip) : void
      {
         var _loc8_:BMEffectTeleportDisappear = new BMEffectTeleportDisappear();
         _loc8_.initialize(param1,param2,param3,param4,param5,param6,param7);
         this._effectsStorage.push({
            "type":"teleportDisappear",
            "effect":_loc8_
         });
      }
      
      public function createTeleportReappear(param1:String, param2:Number, param3:Number, param4:Number, param5:MovieClip) : void
      {
         var _loc6_:BMEffectTeleportReappear = new BMEffectTeleportReappear();
         _loc6_.initialize(param1,param2,param3,param4,param5);
         this._effectsStorage.push({
            "type":"teleportReappear",
            "effect":_loc6_
         });
      }
      
      public function createTeleportAfterEffect(param1:String, param2:Number, param3:Number, param4:Boolean, param5:MovieClip) : void
      {
         var _loc6_:BMEffectTeleportAfterEffect = new BMEffectTeleportAfterEffect();
         _loc6_.initialize(param1,param2,param3,param4,param5);
         this._effectsStorage.push({
            "type":"teleportAfterEffect",
            "effect":_loc6_
         });
      }
      
      public function createShutDown(param1:String, param2:Number, param3:Number, param4:Boolean, param5:Function, param6:MovieClip) : void
      {
         var _loc7_:BMEffectShutDown = new BMEffectShutDown();
         _loc7_.initialize(param1,param2,param3,param4,param5,param6);
         this._effectsStorage.push({
            "type":"shutdown",
            "effect":_loc7_
         });
      }
      
      public function createElectricity(param1:String, param2:Number, param3:Number, param4:MovieClip) : void
      {
         var _loc5_:BMEffectElectricity = new BMEffectElectricity();
         _loc5_.initialize(param1,param2,param3,param4);
         this._effectsStorage.push({
            "type":"electricity",
            "effect":_loc5_
         });
      }
      
      public function createFireEffect(param1:String, param2:Number, param3:Number, param4:Boolean, param5:Number, param6:MovieClip) : void
      {
         var _loc7_:BMEffectFireEffect = new BMEffectFireEffect();
         _loc7_.initialize(param1,param2,param3,param4,param5,param6);
         this._effectsStorage.push({
            "type":"fireEffect",
            "effect":_loc7_
         });
      }
      
      public function createGeneralEffect(param1:MovieClip, param2:String, param3:Boolean, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Function, param10:Array) : void
      {
         var _loc11_:MovieClip = externalAssetsM.getAsset("general",param2,param4,param5,false,false,true);
         var _loc12_:Number = this._generalEffects.length - 1;
         _loc11_.rotation = param8;
         if(param3)
         {
            _loc11_.scaleX = -1;
         }
         var _loc13_:BMEffectGeneral = new BMEffectGeneral();
         _loc13_.initialize(_loc12_,param1,_loc11_,param9,param10);
         _loc13_.x = param6;
         _loc13_.y = param7;
         param1.addChild(_loc13_);
         this._generalEffects.push(_loc13_);
      }
      
      public function createGeneralEffect2Triggers(param1:MovieClip, param2:String, param3:Boolean, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Function, param10:Function, param11:Array) : void
      {
         var _loc12_:MovieClip = externalAssetsM.getAsset("general",param2,param4,param5,false,false);
         var _loc13_:Number = this._generalEffects.length - 1;
         _loc12_.rotation = param8;
         if(param3)
         {
            _loc12_.scaleX = -1;
         }
         var _loc14_:BMEffectGeneral = new BMEffectGeneral();
         _loc14_.initialize(_loc13_,param1,_loc12_,param9,param11);
         _loc14_.setTrigger2Function(param10);
         _loc14_.x = param6;
         _loc14_.y = param7;
         param1.addChild(_loc14_);
         this._generalEffects.push(_loc14_);
      }
      
      public function abortGeneralEffects() : void
      {
         var _loc2_:BMEffectGeneral = null;
         var _loc1_:int = int(this._generalEffects.length);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            if(this._generalEffects[_loc3_] != null)
            {
               _loc2_ = this._generalEffects[_loc3_];
               _loc2_.abortEffect();
               if(_loc2_.parent != null)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               this._generalEffects[_loc3_] = null;
            }
            _loc3_++;
         }
         this._generalEffects = new Array();
      }
      
      public function createSparksMC(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:String, param9:String, param10:Boolean, param11:Number = 1) : void
      {
         var _loc12_:Boolean = false;
         var _loc13_:* = 0;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:String = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Array = null;
         var _loc23_:BMEffectSparkAutoMC = null;
         var _loc24_:Sprite = null;
         var _loc25_:BMEffectSparkMC = null;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Sprite = null;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:uint = 0;
         var _loc37_:uint = 0;
         if(dataM.movieClipParticleEffects)
         {
            _loc12_ = false;
            _loc13_ = 0;
            param5 = Math.ceil(dataM.movieClipParticleEffectsRatio * param5);
            _loc36_ = 0;
            while(_loc36_ < param6)
            {
               _loc37_ = 0;
               for(; _loc37_ < param5; _loc37_++)
               {
                  if(_loc12_ == false)
                  {
                     if(this._sparksAutoMCData[param2] != null)
                     {
                        if(this._sparksAutoMCData[param2][param8] != null)
                        {
                           if(this._sparksAutoMCData[param2][param8][param10] != null)
                           {
                              _loc21_ = Math.floor(param4 / 10) * 10;
                              if(this._sparksAutoMCData[param2][param8][param10][_loc21_] != null)
                              {
                                 if(this._sparksAutoMCData[param2][param8][param10][_loc21_].length >= this.MIN_SAVED_DATA_FOR_SPARK_AUTO)
                                 {
                                    _loc12_ = true;
                                 }
                              }
                           }
                        }
                     }
                  }
                  if(_loc12_)
                  {
                     _loc22_ = this._sparksAutoMCData[param2][param8][param10][_loc21_][_loc13_];
                     if(++_loc13_ >= this._sparksAutoMCData[param2][param8][param10][_loc21_].length)
                     {
                        _loc13_ = 0;
                     }
                     _loc23_ = new BMEffectSparkAutoMC();
                     _loc14_ = Math.random() * 20 - 10;
                     _loc15_ = Math.random() * 20 - 10;
                     switch(param8)
                     {
                        case "horizontalWider":
                           _loc14_ *= 3;
                           _loc15_ *= 3;
                     }
                     _loc19_ = param3 + _loc14_;
                     _loc20_ = param4 + _loc15_;
                     _loc16_ = _loc36_;
                     _loc17_ = "";
                     _loc18_ = 0;
                     switch(param2)
                     {
                        case "spark":
                           _loc17_ = "Grp_energySpark_" + param9;
                           break;
                        case "mcBulletShell1":
                        case "mcBulletShell2":
                           _loc17_ = param2;
                           _loc18_ = Math.random() * 360;
                           break;
                        case "debrie":
                           _loc17_ = "debrie_general" + Math.ceil(Math.random() * 5);
                           _loc18_ = Math.random() * 360;
                     }
                     _loc24_ = externalAssetsM.getAsset("general",_loc17_,0,0,false,false,false);
                     if(_loc18_ > 0)
                     {
                        _loc24_.rotation = _loc18_;
                     }
                     _loc24_.x = _loc19_;
                     _loc24_.y = _loc20_;
                     if(param11 != 1)
                     {
                        _loc24_.scaleX = param11;
                        _loc24_.scaleY = param11;
                     }
                     _loc23_.initialize(param1,_loc16_,_loc24_,_loc19_,_loc20_,_loc22_,this.setSparkAutoMCForDeletion);
                     this._effectsStorage.push({
                        "type":"sparkAutoMC",
                        "effect":_loc23_
                     });
                     switch(param1)
                     {
                        case "screenBattle":
                           screensM.screenBattle.holder_effects.addChild(_loc24_);
                           break;
                        case "screenBattleResult":
                           screensM.screenBattleResult.mcSparksHolder.addChild(_loc24_);
                           break;
                        case "screenMissionBaseMap":
                           screensM.screenMissionBaseMap.mcMapEffectsHolder.addChild(_loc24_);
                           break;
                        case "screenLadderStatus":
                           screensM.screenLadderStatus.mcRankStarsHolder_front.addChild(_loc24_);
                           break;
                        case "screenHangerMech":
                           screensM.screenHangerInventory.addChild(_loc24_);
                           break;
                        case "screenHelp":
                           screensM.screenHelp.mcMechsHolder.addChild(_loc24_);
                           break;
                        case "screenItemCards":
                           screensM.screenItemCards.mcEffectsHolder.addChild(_loc24_);
                           break;
                        case "screenOpeningSequence":
                           screensM.screenOpeningSequence.mcFrame1.addChild(_loc24_);
                     }
                     continue;
                  }
                  _loc25_ = new BMEffectSparkMC();
                  _loc26_ = 7;
                  _loc27_ = -2.5 + Math.random() * 5;
                  _loc28_ = 10;
                  _loc29_ = -10 + Math.random() * 20;
                  _loc14_ = Math.random() * 20 - 10;
                  _loc15_ = Math.random() * 20 - 10;
                  switch(param8)
                  {
                     case "left":
                        _loc30_ = -_loc26_ - _loc27_;
                        _loc31_ = _loc29_;
                        break;
                     case "right":
                        _loc30_ = _loc26_ + _loc27_;
                        _loc31_ = _loc29_;
                        break;
                     case "up":
                        _loc30_ = _loc27_;
                        _loc31_ = -_loc28_ - _loc29_;
                        break;
                     case "down":
                        _loc30_ = 0;
                        _loc31_ = -1;
                        break;
                     case "horizontal":
                        _loc30_ = Math.random() * _loc26_ * 2 - _loc26_;
                        _loc31_ = _loc29_;
                        break;
                     case "horizontalWider":
                        _loc30_ = Math.random() * _loc26_ * 4 - _loc26_ * 2;
                        _loc31_ = _loc29_ * 1.5;
                        _loc14_ *= 3;
                        _loc15_ *= 3;
                  }
                  _loc32_ = 1;
                  _loc19_ = param3 + _loc14_;
                  _loc20_ = param4 + _loc15_;
                  if(param1 == "screenMissionBaseMap")
                  {
                     _loc34_ = param4 + Math.ceil(Math.random() * 40);
                  }
                  else
                  {
                     _loc34_ = Math.ceil(Math.random() * 3);
                  }
                  _loc16_ = _loc36_;
                  _loc35_ = param7 + Math.ceil(Math.random() * param7 / 2);
                  _loc17_ = "";
                  _loc18_ = 0;
                  switch(param2)
                  {
                     case "spark":
                        _loc17_ = "Grp_energySpark_" + param9;
                        break;
                     case "mcBulletShell1":
                     case "mcBulletShell2":
                        _loc17_ = param2;
                        _loc18_ = Math.random() * 360;
                        break;
                     case "debrie":
                        _loc17_ = "debrie_general" + Math.ceil(Math.random() * 5);
                        _loc18_ = Math.random() * 360;
                  }
                  _loc33_ = externalAssetsM.getAsset("general",_loc17_,0,0,false,false,false);
                  if(_loc18_ > 0)
                  {
                     _loc33_.rotation = _loc18_;
                  }
                  _loc33_.x = _loc19_;
                  _loc33_.y = _loc20_;
                  if(param11 != 1)
                  {
                     _loc33_.scaleX = param11;
                     _loc33_.scaleY = param11;
                  }
                  _loc25_.initialize(param1,param2,_loc19_,_loc20_,_loc30_,_loc31_,_loc32_,_loc34_,_loc16_,_loc35_,param8,param10,_loc33_,this.setSparkMCForDeletion,this.saveSparkMCData);
                  this._effectsStorage.push({
                     "type":"sparkMC",
                     "effect":_loc25_
                  });
                  switch(param1)
                  {
                     case "screenBattle":
                        screensM.screenBattle.holder_effects.addChild(_loc33_);
                        break;
                     case "screenBattleResult":
                        screensM.screenBattleResult.mcSparksHolder.addChild(_loc33_);
                        break;
                     case "screenMissionBaseMap":
                        screensM.screenMissionBaseMap.mcMapEffectsHolder.addChild(_loc33_);
                        break;
                     case "screenLadderStatus":
                        screensM.screenLadderStatus.mcRankStarsHolder_front.addChild(_loc33_);
                        break;
                     case "screenHangerMech":
                        screensM.screenHangerInventory.addChild(_loc33_);
                        break;
                     case "screenHelp":
                        screensM.screenHelp.mcMechsHolder.addChild(_loc33_);
                        break;
                     case "screenItemCards":
                        screensM.screenItemCards.mcEffectsHolder.addChild(_loc33_);
                        break;
                     case "screenOpeningSequence":
                        screensM.screenOpeningSequence.mcFrame1.addChild(_loc33_);
                  }
               }
               _loc36_++;
            }
         }
      }
      
      private function saveSparkMCData(param1:String, param2:Number, param3:String, param4:Boolean, param5:Array) : void
      {
         var _loc6_:Number = Math.floor(param2 / 10) * 10;
         if(this._sparksAutoMCData[param1] == null)
         {
            this._sparksAutoMCData[param1] = new Object();
         }
         if(this._sparksAutoMCData[param1][param3] == null)
         {
            this._sparksAutoMCData[param1][param3] = new Object();
         }
         if(this._sparksAutoMCData[param1][param3][param4] == null)
         {
            this._sparksAutoMCData[param1][param3][param4] = new Object();
         }
         if(this._sparksAutoMCData[param1][param3][param4][_loc6_] == null)
         {
            this._sparksAutoMCData[param1][param3][param4][_loc6_] = new Array();
         }
         this._sparksAutoMCData[param1][param3][param4][_loc6_].push(param5);
      }
      
      public function createEnergyChargeMC(param1:String, param2:MovieClip, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:String, param10:MovieClip, param11:Function) : void
      {
         var _loc16_:BMEffectEnergyChargeSparkMC = null;
         var _loc17_:Function = null;
         var _loc18_:Array = null;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Sprite = null;
         var _loc24_:uint = 0;
         var _loc25_:uint = 0;
         var _loc12_:Number = 0.4;
         if(dataM.movieClipParticleEffects)
         {
            param6 = Math.ceil(dataM.movieClipParticleEffectsRatio * param6);
            _loc24_ = 0;
            while(_loc24_ < param7)
            {
               _loc25_ = 0;
               while(_loc25_ < param6)
               {
                  _loc16_ = new BMEffectEnergyChargeSparkMC();
                  _loc17_ = null;
                  _loc18_ = null;
                  if(this._energyChargeSparksMCData.length >= this.MIN_SAVED_DATA_FOR_SPARK_AUTO)
                  {
                     _loc18_ = this._energyChargeSparksMCData[Math.ceil(Math.random() * this._energyChargeSparksMCData.length) - 1];
                     _loc19_ = param3;
                     _loc20_ = param4;
                  }
                  else
                  {
                     _loc17_ = this.saveEnergyChargeSparkMCData;
                     _loc21_ = Math.random() * 360;
                     _loc22_ = param5 + Math.ceil(param5 * (Math.random() * _loc12_ - _loc12_ / 2));
                     _loc19_ = param3 + dataM.getVectorSizeOnXAxis(_loc22_,_loc21_);
                     _loc20_ = param4 + dataM.getVectorSizeOnYAxis(_loc22_,_loc21_);
                  }
                  _loc23_ = externalAssetsM.getAsset("general","Grp_energySpark_" + param9,0,0,false,false,false);
                  _loc23_.x = _loc19_;
                  _loc23_.y = _loc20_;
                  _loc16_.initialize(param1,param3,param4,_loc19_,_loc20_,param8,_loc21_,_loc24_,_loc23_,this.setEnergyChargeSparkMCForDeletion,_loc17_,_loc18_);
                  this._effectsStorage.push({
                     "type":"energyChargeSparkMC",
                     "effect":_loc16_
                  });
                  screensM.screenBattle.holder_effects.addChild(_loc23_);
                  _loc25_++;
               }
               _loc24_++;
            }
         }
         var _loc13_:BMEffectEnergyChargeCenter = new BMEffectEnergyChargeCenter();
         var _loc14_:Number = Math.ceil(param5 / param8);
         var _loc15_:Number = Math.ceil(_loc14_ / 3);
         _loc13_.initialize(param10,_loc14_,param7,_loc15_,this.setEnergyChargeCenterForDeletion,param11);
         _loc13_.x = param3;
         _loc13_.y = param4;
         param2.addChild(_loc13_);
         this._effectsStorage.push({
            "type":"energyChargeCenter",
            "effect":_loc13_
         });
      }
      
      private function saveEnergyChargeSparkMCData(param1:Array) : void
      {
         this._energyChargeSparksMCData.push(param1);
      }
      
      public function createDebries(param1:Number, param2:Number, param3:Number, param4:String, param5:MovieClip) : void
      {
         var _loc6_:BMEffectDebrie = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:String = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         param3 = Math.ceil(dataM.movieClipParticleEffectsRatio * param3);
         var _loc24_:uint = 0;
         while(_loc24_ < param3)
         {
            _loc6_ = new BMEffectDebrie();
            _loc7_ = 7;
            _loc8_ = -2.5 + Math.random() * 5;
            _loc9_ = 10;
            _loc10_ = -10 + Math.random() * 20;
            switch(param4)
            {
               case "up":
                  _loc11_ = _loc8_;
                  _loc12_ = -_loc9_ - _loc10_;
                  break;
               case "horizontal":
                  _loc11_ = Math.random() * _loc7_ * 2 - _loc7_;
                  _loc12_ = _loc10_;
            }
            _loc13_ = 1;
            _loc14_ = Math.random() * 20 - 10;
            _loc15_ = Math.random() * 20 - 10;
            _loc16_ = param1 + _loc14_;
            _loc17_ = param2 + _loc15_;
            _loc6_.x = _loc16_;
            _loc6_.y = _loc17_;
            _loc18_ = 0;
            if(-param2 > 0)
            {
               _loc18_ = -param2 - _loc15_;
            }
            _loc19_ = Math.ceil(_loc24_ / 5);
            _loc20_ = 40 + Math.ceil(Math.random() * 20);
            _loc21_ = "debrie_general" + Math.ceil(Math.random() * 5);
            _loc22_ = 10 + Math.random() * 10;
            _loc23_ = Math.random() * 360;
            _loc6_.initialize(_loc21_,_loc22_,_loc23_,_loc11_,_loc12_,_loc13_,_loc18_,_loc19_,_loc20_,false,param5);
            this._effectsStorage.push({
               "type":"debrie",
               "effect":_loc6_
            });
            _loc24_++;
         }
      }
      
      public function createExplosion(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:MovieClip) : void
      {
         var _loc11_:BMEffectExplosion = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:String = null;
         var _loc20_:uint = 0;
         while(_loc20_ < param1)
         {
            _loc11_ = new BMEffectExplosion();
            _loc12_ = param2 + Math.random() * param4 - param4 / 2;
            _loc13_ = param3 + Math.random() * param4 - param4 / 2;
            _loc14_ = Math.random() * 360;
            _loc15_ = Math.random() * 1 - 0.5;
            _loc16_ = _loc20_;
            _loc17_ = param5 + Math.random() * param5 / 2;
            _loc18_ = param6 + Math.random() * param6;
            _loc19_ = "explosion_orange" + Math.ceil(Math.random() * 3);
            if(_loc20_ == 0)
            {
               _loc12_ = param2;
               _loc13_ = param3;
               _loc17_ *= param7;
               _loc18_ *= param7;
            }
            _loc11_.x = _loc12_;
            _loc11_.y = _loc13_;
            _loc11_.rotation = _loc14_;
            _loc11_.initialize(_loc19_,_loc16_,param8,param9,_loc17_,_loc18_,_loc15_,param10);
            this._effectsStorage.push({
               "type":"explosion",
               "effect":_loc11_
            });
            _loc20_++;
         }
      }
      
      private function flameThrowerHandler() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         if(this._flameThrowerActive)
         {
            ++this._flameThrowerCounter;
            if(this._flameThrowerCounter == 1)
            {
               _loc8_ = false;
               if(this._flameThrowerDirection == -1)
               {
                  _loc8_ = true;
               }
               this.createFlameBaseLine(this._flameThrowerHolder,this._flameThrowerFireEffect,_loc8_,this._flameThrowerDistance,dataM.slowCPUMode,this._flameThrowerFireXPos,this._flameThrowerFireYPos);
            }
            _loc1_ = 15;
            _loc2_ = 20;
            if(dataM.slowCPUMode)
            {
               _loc1_ = 8;
               _loc2_ = 10;
            }
            _loc3_ = _loc2_ + _loc1_ * 2;
            _loc4_ = 64;
            _loc5_ = 170;
            _loc6_ = 10;
            _loc7_ = false;
            if(this._flameThrowerCounter < _loc3_)
            {
               _loc7_ = true;
            }
            if(_loc7_)
            {
               _loc8_ = false;
               _loc10_ = Math.ceil(Math.random() * 2);
               if(_loc10_ == 2)
               {
                  _loc8_ = true;
               }
               _loc11_ = 2;
               _loc12_ = 13;
               if(dataM.slowCPUMode)
               {
                  _loc11_ = 1;
               }
               switch(this._flameThrowerFireEffect)
               {
                  case "flameFire1":
                     _loc9_ = "flame1";
                     break;
                  case "flameFireB1":
                     _loc9_ = "flameB1";
                     break;
                  case "flameFireC1":
                     _loc9_ = "flameC1";
                     break;
                  case "flameFireD1":
                     _loc9_ = "flameD1";
               }
               _loc13_ = 0;
               if(this._flameThrowerCounter > _loc2_ + _loc1_)
               {
                  _loc13_ = (this._flameThrowerCounter - (_loc2_ + _loc1_)) / _loc1_ * this._flameThrowerDistance;
               }
               _loc14_ = this._flameThrowerDistance;
               if(this._flameThrowerCounter < _loc1_)
               {
                  _loc14_ = this._flameThrowerCounter / _loc1_ * this._flameThrowerDistance;
                  if(this._flameThrowerCounter % 3 == 0)
                  {
                     _loc15_ = _loc4_ + _loc5_ * _loc14_ / this._flameThrowerDistance;
                     this.createFlame(this._flameThrowerHolder,_loc9_,_loc15_,_loc8_,_loc11_,_loc12_,this._flameThrowerFireXPos + this._flameThrowerDirection * _loc14_,this._flameThrowerFireYPos);
                  }
               }
               _loc16_ = this._flameThrowerFireXPos + this._flameThrowerDirection * (_loc13_ + Math.random() * (_loc14_ - _loc13_));
               _loc17_ = Math.random() * _loc6_ - _loc6_ / 2 + this._flameThrowerFireYPos;
               _loc15_ = _loc4_ + _loc5_ * Math.abs(_loc16_ - this._flameThrowerFireXPos) / this._flameThrowerDistance;
               this.createFlame(this._flameThrowerHolder,_loc9_,_loc15_,_loc8_,_loc11_,_loc12_,_loc16_,_loc17_);
            }
            if(this._flameThrowerCounter < _loc3_)
            {
               if(this._flameThrowerCounter % 30 == 0)
               {
                  if(this._flameThrowerGetHitFunction != null)
                  {
                     this._flameThrowerGetHitFunction(this._flameThrowerGetHitPlayerID,"xAxisFront",false,true);
                  }
               }
            }
            else
            {
               this._flameThrowerActive = false;
               if(this._flameThrowerReturnFunction != null)
               {
                  this._flameThrowerReturnFunction(this._flameThrowerReturnFunctionParams);
               }
               if(this._flameThrowerGetHitFunction != null)
               {
                  this._flameThrowerGetHitFunction(this._flameThrowerGetHitPlayerID,"xAxisFront",false,true);
               }
            }
         }
      }
      
      public function activateFlameThrower(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:String, param7:Function, param8:Function, param9:Array) : void
      {
         this._flameThrowerGetHitPlayerID = param1;
         this._flameThrowerFireXPos = param2;
         this._flameThrowerFireYPos = param3;
         this._flameThrowerDirection = param4;
         this._flameThrowerDistance = param5;
         this._flameThrowerFireEffect = param6;
         this._flameThrowerHolder = screensM.screenBattle.holder_effects;
         this._flameThrowerCounter = 0;
         this._flameThrowerGetHitFunction = param7;
         this._flameThrowerReturnFunction = param8;
         this._flameThrowerReturnFunctionParams = param9;
         this._flameThrowerActive = true;
      }
      
      public function createFlame(param1:MovieClip, param2:String, param3:uint, param4:Boolean, param5:uint, param6:uint, param7:Number, param8:Number) : void
      {
         var _loc9_:BMEffectFlame = new BMEffectFlame();
         _loc9_.x = param7;
         _loc9_.y = param8;
         param1.addChild(_loc9_);
         _loc9_.initialize(param2,param3,param4,param5,param6,param1);
         this._effectsStorage.push({
            "type":"flame",
            "effect":_loc9_
         });
      }
      
      public function createFlameBaseLine(param1:MovieClip, param2:String, param3:Boolean, param4:uint, param5:Boolean, param6:Number, param7:Number) : void
      {
         var _loc8_:BMEffectFlameBaseLine = new BMEffectFlameBaseLine();
         _loc8_.initialize(param2,param3,param4,param6,param7,param5,param1);
         this._effectsStorage.push({
            "type":"flameBaseLine",
            "effect":_loc8_
         });
      }
      
      public function createMegaExplosion(param1:MovieClip, param2:Number, param3:Number) : void
      {
         var _loc4_:BMEffectMegaExplosion = new BMEffectMegaExplosion();
         _loc4_.initialize(param2,param3,param1);
         this._effectsStorage.push({
            "type":"megaExplosion",
            "effect":_loc4_
         });
      }
      
      public function createOrbExplosionSub(param1:MovieClip, param2:Number, param3:Number) : void
      {
         var _loc4_:BMEffectOrbExplosion = new BMEffectOrbExplosion();
         _loc4_.initialize(param2,param3,param1);
         this._effectsStorage.push({
            "type":"orbExplosion",
            "effect":_loc4_
         });
      }
      
      public function createMachineGunFire(param1:MovieClip, param2:String, param3:Number, param4:Number, param5:uint, param6:Boolean, param7:uint) : void
      {
         var _loc8_:BMEffectMachineGunFire = new BMEffectMachineGunFire();
         var _loc9_:MovieClip = externalAssetsM.getAsset("general",param2);
         _loc9_.x = param3;
         _loc9_.y = param4;
         if(param6)
         {
            _loc9_.scaleX = -1;
         }
         param1.addChild(_loc9_);
         _loc8_.initialize(param1,_loc9_,param5,param7);
         this._effectsStorage.push({
            "type":"machineGunFire",
            "effect":_loc8_
         });
      }
      
      public function createStompFire(param1:MovieClip, param2:String, param3:Number, param4:Number, param5:Number, param6:uint, param7:uint, param8:Boolean) : void
      {
         var _loc9_:BMEffectStompFire = new BMEffectStompFire();
         _loc9_.initialize(param2,param8,param3,param4,param5,param6,param7,param1);
         this._effectsStorage.push({
            "type":"stompFire",
            "effect":_loc9_
         });
      }
      
      public function createFlyingKit(param1:MovieClip, param2:Number, param3:Number, param4:MovieClip) : void
      {
         var _loc5_:BMFlyingKit = new BMFlyingKit();
         _loc5_.initialize(param1,param4);
         _loc5_.x = param2;
         _loc5_.y = param3;
         param1.addChild(_loc5_);
         this._effectsStorage.push({
            "type":"flyingKit",
            "effect":_loc5_
         });
      }
      
      public function createFireBeam(param1:MovieClip, param2:String, param3:String, param4:uint, param5:Boolean, param6:Boolean, param7:Boolean, param8:Number, param9:Number, param10:Function, param11:Function) : void
      {
         var _loc12_:BMEffectFireBeam = new BMEffectFireBeam();
         _loc12_.initialize(param1,param2,param3,param4,param5,param11,param10,param6);
         if(param7)
         {
            _loc12_.scaleX = -1;
         }
         _loc12_.x = param8;
         _loc12_.y = param9;
         param1.addChild(_loc12_);
         this._effectsStorage.push({
            "type":"fireBeam",
            "effect":_loc12_
         });
      }
      
      public function createShield(param1:MovieClip, param2:Number, param3:Number, param4:String, param5:String, param6:Boolean, param7:Boolean) : void
      {
         var _loc8_:BMEffectShield = new BMEffectShield();
         _loc8_.initialize(param1,param4,param5,param7);
         if(param6)
         {
            _loc8_.scaleX = -1;
         }
         _loc8_.x = param2;
         _loc8_.y = param3;
         param1.addChild(_loc8_);
         this._effectsStorage.push({
            "type":"shield",
            "effect":_loc8_
         });
      }
      
      public function createFlyingNumber(param1:MovieClip, param2:Number, param3:Number, param4:String, param5:String, param6:Number, param7:Number, param8:String) : void
      {
         var _loc9_:BMFlyingNumber = new BMFlyingNumber();
         _loc9_.initialize(param1,param4,param5,param6,param7,param8);
         _loc9_.x = param2;
         _loc9_.y = param3;
         _loc9_.width /= param7;
         _loc9_.height /= param7;
         param1.addChild(_loc9_);
         this._effectsStorage.push({
            "type":"flyingNumber",
            "effect":_loc9_
         });
      }
      
      public function createFlyingGoldCoinEffect(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:uint = 66;
         var _loc5_:uint = 30;
         if(param3)
         {
            _loc6_ = screensM.screenTopBar.mcTooltip_XP.x + 80;
            _loc7_ = screensM.screenTopBar.mcTooltip_XP.y + 40;
         }
         else
         {
            _loc6_ = screensM.screenTopBar.mcGold.x + 80;
            _loc7_ = screensM.screenTopBar.mcGold.y + 20;
         }
         var _loc8_:uint = 6;
         var _loc9_:BMEffectFlyingGoldCoin = new BMEffectFlyingGoldCoin();
         screensM.screenMissionCompleted.mcGoldCoinsFlyingHolder.addChild(_loc9_);
         _loc9_.initialize(param1,param2,_loc6_,_loc7_,_loc4_,_loc5_,_loc8_,param3);
         this._effectsStorage.push({
            "type":"flyingGoldCoin",
            "effect":_loc9_
         });
      }
      
      public function createRepairBeam(param1:Boolean, param2:Number, param3:Number, param4:MovieClip, param5:Function, param6:Array) : void
      {
         var _loc7_:BMEffectRepairBeam = new BMEffectRepairBeam();
         _loc7_.initialize(param1,param2,param3,param4,param5,param6);
         param4.addChild(_loc7_);
         this._effectsStorage.push({
            "type":"repairBeam",
            "effect":_loc7_
         });
      }
      
      public function createMovingImage(param1:DisplayObject, param2:Number, param3:Number, param4:MovieClip, param5:Function, param6:Boolean, param7:Number, param8:Number, param9:Number, param10:Number, param11:Boolean) : void
      {
         var _loc12_:BMMovingImage = new BMMovingImage();
         if(param6)
         {
            ++this.movingImageIDCounter;
         }
         _loc12_.initialize(this.movingImageIDCounter,param1,param2,param3,param4,this.setMovingImageForDeletion,param5,param7,param8,param9,param10,param11);
         this._effectsStorage.push({
            "type":"movingImage",
            "effect":_loc12_
         });
      }
      
      public function allowMovingImageMotion(param1:Number) : void
      {
         var _loc3_:BMMovingImage = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this._effectsStorage.length)
         {
            if(this._effectsStorage[_loc2_].type == "movingImage")
            {
               _loc3_ = this._effectsStorage[_loc2_].effect;
               if(_loc3_.movingImageID == param1)
               {
                  _loc3_.motionAllowed = true;
               }
            }
            _loc2_++;
         }
      }
      
      public function clearAllEffects() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._effectsStorage.length)
         {
            this.setEffectForDeletion(this._effectsStorage[_loc1_].type,_loc1_);
            _loc1_++;
         }
         this._flameThrowerActive = false;
         this.deleteSetForDeletions();
      }
      
      public function removeGeneralEffect(param1:MovieClip) : void
      {
         if(param1.parent != null)
         {
            param1.parent.removeChild(param1);
         }
         param1 = null;
      }
   }
}

