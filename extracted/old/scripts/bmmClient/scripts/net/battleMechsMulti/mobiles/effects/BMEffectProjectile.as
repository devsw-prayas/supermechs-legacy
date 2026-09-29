package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectProjectile extends BMBaseClass
   {
      
      public var holderMC:MovieClip;
      
      private var _projectileMC:MovieClip;
      
      private var _attackingPlayerID:Number;
      
      private var _defendingPlayerID:Number;
      
      private var _fireEffect:String;
      
      private var _startFrames:Number;
      
      private var _frameCounter:uint;
      
      private var _xSpeed:Number;
      
      private var _ySpeed:Number;
      
      private var _xAcc:Number;
      
      private var _xDistance:Number;
      
      private var _yDistance:Number;
      
      private var _xStart:Number;
      
      private var _directionModifier:Number;
      
      private var _fireSound:String;
      
      private var _feedbackAndSoundFunction:Function;
      
      private var _getHitFunction:Function;
      
      private var _getHitExplosionSound:Boolean;
      
      private var _returnFunction:Function;
      
      private var _returnFunctionParameters:Array;
      
      private var _originalScaleX:Number;
      
      private var _originalScaleY:Number;
      
      private var _grenade:Boolean = false;
      
      private var _grenadeInitialRotation:Number;
      
      private var _grenadeYSpeedChange:Number;
      
      private var _grenadeRotationChange:Number;
      
      private var _grenadeYAddon:Number;
      
      public function BMEffectProjectile()
      {
         super();
      }
      
      public function initialize(param1:MovieClip, param2:MovieClip, param3:Number, param4:Number, param5:String, param6:Number, param7:Boolean, param8:Number, param9:Number, param10:Number, param11:Number, param12:String, param13:Function, param14:Function, param15:Boolean, param16:Function, param17:Array) : void
      {
         generateSingletonClassesPointers("");
         this.holderMC = param1;
         this._projectileMC = param2;
         this._attackingPlayerID = param3;
         this._defendingPlayerID = param4;
         this._fireEffect = param5;
         this._directionModifier = 1;
         if(param7)
         {
            this._directionModifier = -1;
         }
         this._startFrames = param6;
         this._xSpeed = param8 * this._directionModifier;
         this._xAcc = param9 * this._directionModifier;
         this._xStart = this._projectileMC.x;
         this._xDistance = param10 * this._directionModifier;
         this._yDistance = param11;
         if(this._projectileMC.mcGrenade != null)
         {
            this._grenade = true;
            this._grenadeInitialRotation = this._projectileMC.mcGrenade.rotation;
            this._ySpeed = -15;
            this._grenadeYSpeedChange = 15 / (this._xDistance / this._xSpeed / 2);
            this._grenadeRotationChange = -this._grenadeInitialRotation / (this._xDistance / this._xSpeed / 2);
            this._grenadeYAddon = 0;
         }
         this._fireSound = param12;
         this._feedbackAndSoundFunction = param13;
         this._getHitFunction = param14;
         this._getHitExplosionSound = param15;
         this._returnFunction = param16;
         this._returnFunctionParameters = param17;
         this._projectileMC.scaleX *= this._directionModifier;
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(this._startFrames > 0)
         {
            --this._startFrames;
         }
         else
         {
            if(parent == null)
            {
               if(this._feedbackAndSoundFunction != null)
               {
                  this._feedbackAndSoundFunction(this._attackingPlayerID,"xAxisFront",this._fireSound);
               }
               this.holderMC.addChild(this);
               addChild(this._projectileMC);
               if(this._projectileMC.mcFire != null)
               {
                  this._projectileMC.mcFire.visible = false;
               }
               _loc3_ = false;
               if(this._directionModifier == -1)
               {
                  _loc3_ = true;
               }
               if(this._fireEffect != "")
               {
                  effectsM.createFireEffect(this._fireEffect,x,y,_loc3_,0,this.holderMC);
               }
            }
            if(this._projectileMC.mcFire != null)
            {
               if(this._frameCounter >= 4)
               {
                  if(this._frameCounter == 4)
                  {
                     this._projectileMC.mcFire.visible = true;
                     this._originalScaleX = this._projectileMC.mcFire.scaleX;
                     this._originalScaleY = this._projectileMC.mcFire.scaleY;
                  }
                  if(this._frameCounter < 10)
                  {
                     this._projectileMC.mcFire.scaleX += this._originalScaleX;
                     this._projectileMC.mcFire.scaleY += this._originalScaleY * 0.2;
                  }
               }
            }
            _loc2_ = false;
            if(this._directionModifier == 1)
            {
               if(this._projectileMC.x + this._xSpeed >= this._xDistance)
               {
                  this._projectileMC.x = this._xDistance;
                  _loc2_ = true;
               }
            }
            else if(this._projectileMC.x + this._xSpeed <= this._xDistance)
            {
               this._projectileMC.x = this._xDistance;
               _loc2_ = true;
            }
            if(_loc2_)
            {
               if(this._getHitFunction != null)
               {
                  this._getHitFunction(this._defendingPlayerID,"xAxisFront",false,this._getHitExplosionSound);
               }
               _loc4_ = x + this._projectileMC.x;
               _loc5_ = y + this._projectileMC.y;
               _loc6_ = 1;
               effectsM.createExplosion(_loc6_,_loc4_,_loc5_,3,30,15,2,6,2,this.holderMC);
               if(this._returnFunction != null)
               {
                  switch(this._returnFunctionParameters.length)
                  {
                     case 0:
                        this._returnFunction();
                        break;
                     case 1:
                        this._returnFunction(this._returnFunctionParameters[0]);
                        break;
                     case 2:
                        this._returnFunction(this._returnFunctionParameters[0],this._returnFunctionParameters[1]);
                  }
               }
               effectsM.setProjectileForDeletion(param1);
            }
            else
            {
               this._projectileMC.x += this._xSpeed;
               this._xSpeed += this._xAcc;
               this._projectileMC.y = this._yDistance * this._projectileMC.x / this._xDistance;
               if(this._grenade)
               {
                  this._ySpeed += this._grenadeYSpeedChange;
                  this._grenadeYAddon += this._ySpeed;
                  this._projectileMC.y += this._grenadeYAddon;
                  this._projectileMC.mcGrenade.rotation += this._grenadeRotationChange;
               }
            }
            ++this._frameCounter;
         }
      }
      
      public function removeMe() : void
      {
         if(this._projectileMC.parent != null)
         {
            this._projectileMC.parent.removeChild(this._projectileMC);
         }
         this._projectileMC = null;
      }
   }
}

