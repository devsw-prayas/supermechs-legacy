package net.battleMechsMulti.mobiles.effects
{
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectFireBeam extends BMBaseClass
   {
      
      public static var COLOR_BLUE:String = "blue";
      
      public static var COLOR_ORANGE:String = "orange";
      
      public static var COLOR_RED:String = "red";
      
      public static var COLOR_WHITE:String = "white";
      
      private var _fast:Boolean;
      
      private var mcTopGlowHolder:Sprite;
      
      private var mcWaveHolder:Sprite;
      
      private var mcBeamHolder:Sprite;
      
      private var mcBottomGlowHolder:Sprite;
      
      private var mcTopGlow:Sprite;
      
      private var mcWave:Sprite;
      
      private var mcBeam:Sprite;
      
      private var mcBottomGlow:Sprite;
      
      private var triggerMe1:Function;
      
      private var triggerMe2:Function;
      
      private var _size:uint;
      
      private var _frameCounter:uint = 0;
      
      private var _chargeOnly:Boolean;
      
      private var _currentPhase:String;
      
      private var _effectDeleted:Boolean = false;
      
      public var holderMC:Sprite;
      
      public function BMEffectFireBeam()
      {
         super();
      }
      
      public function BMEffectBeamRound() : *
      {
      }
      
      public function initialize(param1:Sprite, param2:String, param3:String, param4:uint, param5:Boolean, param6:Function, param7:Function, param8:Boolean) : void
      {
         generateSingletonClassesPointers("");
         this.holderMC = param1;
         this._fast = param8;
         this._size = param4;
         this._chargeOnly = param5;
         this.triggerMe1 = param6;
         this.triggerMe2 = param7;
         switch(param2)
         {
            case "round":
               switch(param3)
               {
                  case COLOR_BLUE:
                     this.mcBottomGlow = externalAssetsM.getAsset("general","grpBeamChargeRoundBlue",0,0,false,false,false);
                     break;
                  case COLOR_ORANGE:
                     this.mcBottomGlow = externalAssetsM.getAsset("general","grpBeamChargeRoundYellow",0,0,false,false,false);
                     break;
                  case COLOR_RED:
                     this.mcBottomGlow = externalAssetsM.getAsset("general","grpBeamChargeRoundRed",0,0,false,false,false);
                     break;
                  case COLOR_WHITE:
                     this.mcBottomGlow = externalAssetsM.getAsset("general","grpBeamChargeRoundSnow",0,0,false,false,false);
               }
               if(this._chargeOnly == false)
               {
                  switch(param3)
                  {
                     case COLOR_BLUE:
                        this.mcBeam = externalAssetsM.getAsset("general","grpBeamSubBlue",0,0,false,false,false);
                        this.mcWave = externalAssetsM.getAsset("general","grpBeamWaveBlue",0,0,false,false,false);
                        break;
                     case COLOR_ORANGE:
                        this.mcBeam = externalAssetsM.getAsset("general","grpBeamSubYellow",0,0,false,false,false);
                        this.mcWave = externalAssetsM.getAsset("general","grpBeamWaveYellow",0,0,false,false,false);
                        break;
                     case COLOR_RED:
                        this.mcBeam = externalAssetsM.getAsset("general","grpBeamSubRed",0,0,false,false,false);
                        this.mcWave = externalAssetsM.getAsset("general","grpBeamWaveRed",0,0,false,false,false);
                        break;
                     case COLOR_WHITE:
                        this.mcBeam = externalAssetsM.getAsset("general","grpBeamSubSnow",0,0,false,false,false);
                        this.mcWave = externalAssetsM.getAsset("general","grpBeamWaveSnow",0,0,false,false,false);
                  }
                  this.mcTopGlow = externalAssetsM.getAsset("general","grpBeamChargeRoundSub",0,0,false,false,false);
               }
               break;
            case "straight":
               switch(param3)
               {
                  case COLOR_BLUE:
                     this.mcBottomGlow = externalAssetsM.getAsset("general","grpBeamChargeStraightBlue",0,0,false,false,false);
                     break;
                  case COLOR_ORANGE:
                     this.mcBottomGlow = externalAssetsM.getAsset("general","grpBeamChargeStraightYellow",0,0,false,false,false);
                     break;
                  case COLOR_RED:
                     this.mcBottomGlow = externalAssetsM.getAsset("general","grpBeamChargeStraightRed",0,0,false,false,false);
                     break;
                  case COLOR_WHITE:
                     this.mcBottomGlow = externalAssetsM.getAsset("general","grpBeamChargeStraightSnow",0,0,false,false,false);
               }
               if(this._chargeOnly == false)
               {
                  switch(param3)
                  {
                     case COLOR_BLUE:
                        this.mcBeam = externalAssetsM.getAsset("general","grpBeamSubBlue",0,0,false,false,false);
                        this.mcWave = externalAssetsM.getAsset("general","grpBeamWaveBlue",0,0,false,false,false);
                        break;
                     case COLOR_ORANGE:
                        this.mcBeam = externalAssetsM.getAsset("general","grpBeamSubYellow",0,0,false,false,false);
                        this.mcWave = externalAssetsM.getAsset("general","grpBeamWaveYellow",0,0,false,false,false);
                        break;
                     case COLOR_RED:
                        this.mcBeam = externalAssetsM.getAsset("general","grpBeamSubRed",0,0,false,false,false);
                        this.mcWave = externalAssetsM.getAsset("general","grpBeamWaveRed",0,0,false,false,false);
                        break;
                     case COLOR_WHITE:
                        this.mcBeam = externalAssetsM.getAsset("general","grpBeamSubSnow",0,0,false,false,false);
                        this.mcWave = externalAssetsM.getAsset("general","grpBeamWaveSnow",0,0,false,false,false);
                  }
                  this.mcTopGlow = externalAssetsM.getAsset("general","grpBeamChargeStraightSub",0,0,false,false,false);
               }
         }
         if(this._size == 1)
         {
            this.mcBottomGlow.width *= 0.6;
            this.mcBottomGlow.height *= 0.6;
            if(this._chargeOnly == false)
            {
               this.mcBeam.height *= 0.6;
               this.mcWave.width *= 0.6;
               this.mcWave.height *= 0.6;
               this.mcTopGlow.width *= 0.6;
               this.mcTopGlow.height *= 0.6;
            }
         }
         this._currentPhase = "createBottomGlow";
      }
      
      public function runFrame(param1:uint) : void
      {
         var _loc2_:Object = null;
         if(this._effectDeleted == false)
         {
            if(this._fast)
            {
               _loc2_ = effectsM.effectsParameters["fireBeam"]["fast"][this._currentPhase];
            }
            else
            {
               _loc2_ = effectsM.effectsParameters["fireBeam"]["regular"][this._currentPhase];
            }
            switch(this._currentPhase)
            {
               case "createBottomGlow":
                  this.mcBottomGlowHolder = new Sprite();
                  addChild(this.mcBottomGlowHolder);
                  this.mcBottomGlowHolder.addChild(this.mcBottomGlow);
                  if(dataM.runAsMobile == false)
                  {
                     this.mcBottomGlowHolder.alpha = 0.1;
                  }
                  this.mcBottomGlowHolder.scaleX = 0.1;
                  this.mcBottomGlowHolder.scaleY = 0.1;
                  this._currentPhase = "growBottomGlow";
                  break;
               case "growBottomGlow":
                  this.mcBottomGlowHolder.scaleX += _loc2_.scaleChange;
                  this.mcBottomGlowHolder.scaleY += _loc2_.scaleChange;
                  if(dataM.runAsMobile == false)
                  {
                     this.mcBottomGlowHolder.alpha += _loc2_.alphaChange;
                  }
                  ++this._frameCounter;
                  if(this._frameCounter == _loc2_.frames)
                  {
                     this._currentPhase = "createBeamWaveAndTopGlow";
                     this._frameCounter = 0;
                  }
                  break;
               case "createBeamWaveAndTopGlow":
                  this.mcBottomGlowHolder.scaleX = 1;
                  this.mcBottomGlowHolder.scaleY = 1;
                  if(this._chargeOnly == false)
                  {
                     this.mcBeamHolder = new Sprite();
                     this.mcWaveHolder = new Sprite();
                     this.mcTopGlowHolder = new Sprite();
                     addChild(this.mcBeamHolder);
                     addChild(this.mcWaveHolder);
                     addChild(this.mcTopGlowHolder);
                     this.mcBeamHolder.addChild(this.mcBeam);
                     this.mcWaveHolder.addChild(this.mcWave);
                     this.mcTopGlowHolder.addChild(this.mcTopGlow);
                     this.mcBeamHolder.width = 83;
                     this.mcWaveHolder.x = 80;
                     this.triggerMe1();
                  }
                  this._currentPhase = "moveBeamAndWave";
                  break;
               case "moveBeamAndWave":
                  if(this._chargeOnly == false)
                  {
                     this.mcBeamHolder.width += _loc2_.xChange;
                     this.mcWaveHolder.x += _loc2_.xChange;
                  }
                  ++this._frameCounter;
                  if(this._frameCounter == _loc2_.frames)
                  {
                     if(this._chargeOnly == false)
                     {
                        this.mcWaveHolder.removeChild(this.mcWave);
                     }
                     this._currentPhase = "beamStatic";
                     this._frameCounter = 0;
                  }
                  break;
               case "beamStatic":
                  ++this._frameCounter;
                  if(this._frameCounter == _loc2_.frames)
                  {
                     this._currentPhase = "beamShrink";
                     this._frameCounter = 0;
                     if(this._chargeOnly == false)
                     {
                        this.triggerMe2();
                     }
                  }
                  break;
               case "beamShrink":
                  ++this._frameCounter;
                  if(this._chargeOnly == false)
                  {
                     this.mcBeamHolder.scaleY -= _loc2_.scaleChange;
                     if(dataM.runAsMobile == false)
                     {
                        this.mcBeamHolder.alpha -= _loc2_.alphaChange;
                     }
                  }
                  if(this._frameCounter == _loc2_.frames)
                  {
                     if(this._chargeOnly == false)
                     {
                        this.mcBeamHolder.removeChild(this.mcBeam);
                     }
                     this._currentPhase = "glowShrink";
                     this._frameCounter = 0;
                  }
                  break;
               case "glowShrink":
                  ++this._frameCounter;
                  this.mcBottomGlowHolder.scaleX -= _loc2_.scaleChange;
                  this.mcBottomGlowHolder.scaleY -= _loc2_.scaleChange;
                  if(this._chargeOnly == false)
                  {
                     this.mcTopGlowHolder.scaleX -= _loc2_.scaleChange;
                     this.mcTopGlowHolder.scaleY -= _loc2_.scaleChange;
                  }
                  if(dataM.runAsMobile == false)
                  {
                     this.mcBottomGlowHolder.alpha -= _loc2_.alphaChange;
                     if(this._chargeOnly == false)
                     {
                        this.mcTopGlowHolder.alpha -= _loc2_.alphaChange;
                     }
                  }
                  if(this._frameCounter == _loc2_.frames)
                  {
                     effectsM.setFireBeamForDeletion(param1);
                     this._effectDeleted = true;
                  }
            }
         }
      }
      
      public function removeMe() : void
      {
         if(this.mcBottomGlow != null)
         {
            if(this.mcBottomGlow.parent != null)
            {
               this.mcBottomGlow.parent.removeChild(this.mcBottomGlow);
            }
            this.mcBottomGlow = null;
         }
         if(this.mcBottomGlowHolder != null)
         {
            if(this.mcBottomGlowHolder.parent != null)
            {
               this.mcBottomGlowHolder.parent.removeChild(this.mcBottomGlowHolder);
            }
         }
         if(this._chargeOnly == false)
         {
            if(this.mcTopGlow != null)
            {
               if(this.mcTopGlow.parent != null)
               {
                  this.mcTopGlow.parent.removeChild(this.mcTopGlow);
               }
               this.mcTopGlow = null;
            }
            if(this.mcTopGlowHolder != null)
            {
               if(this.mcTopGlowHolder.parent != null)
               {
                  this.mcTopGlowHolder.parent.removeChild(this.mcTopGlowHolder);
               }
            }
            if(this.mcWave != null)
            {
               if(this.mcWave.parent != null)
               {
                  this.mcWave.parent.removeChild(this.mcWave);
               }
               this.mcWave = null;
            }
            if(this.mcWaveHolder != null)
            {
               if(this.mcWaveHolder.parent != null)
               {
                  this.mcWaveHolder.parent.removeChild(this.mcWaveHolder);
               }
            }
            if(this.mcBeam != null)
            {
               if(this.mcBeam.parent != null)
               {
                  this.mcBeam.parent.removeChild(this.mcBeam);
               }
               this.mcBeam = null;
            }
            if(this.mcBeamHolder != null)
            {
               if(this.mcBeamHolder.parent != null)
               {
                  this.mcBeamHolder.parent.removeChild(this.mcBeamHolder);
               }
            }
         }
      }
   }
}

