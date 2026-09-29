package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectShockWave extends BMBaseClass
   {
      
      public var holderMC:MovieClip;
      
      private var _projectileMC:MovieClip;
      
      private var _attackingPlayerID:Number;
      
      private var _defendingPlayerID:Number;
      
      private var _startFrames:Number;
      
      private var _xSpeed:Number;
      
      private var _xAcc:Number;
      
      private var _targetYPos:Number;
      
      private var _xDistance:Number;
      
      private var _yDistance:Number;
      
      private var _xStart:Number;
      
      private var _directionModifier:Number;
      
      private var _fireEffect:String;
      
      private var _tailEffect:String;
      
      private var _effectColor:String;
      
      private var _fireSound:String;
      
      private var _feedbackAndSoundFunction:Function;
      
      private var _getHitFunction:Function;
      
      private var _getHitExplosionSound:Boolean;
      
      private var _returnFunction:Function;
      
      private var _returnFunctionParameters:Array;
      
      private var _tailEffectCooldown:Number = 0;
      
      public function BMEffectShockWave()
      {
         super();
      }
      
      public function initialize(param1:MovieClip, param2:MovieClip, param3:Number, param4:Number, param5:String, param6:String, param7:String, param8:Number, param9:Boolean, param10:Number, param11:Number, param12:Number, param13:Number, param14:String, param15:Function, param16:Function, param17:Boolean, param18:Function, param19:Array) : void
      {
         generateSingletonClassesPointers("");
         this.holderMC = param1;
         this._projectileMC = param2;
         this._attackingPlayerID = param3;
         this._defendingPlayerID = param4;
         this._fireEffect = param5;
         this._tailEffect = param6;
         this._effectColor = param7;
         this._directionModifier = 1;
         if(param9)
         {
            this._directionModifier = -1;
         }
         this._startFrames = param8;
         this._xSpeed = param10 * this._directionModifier;
         this._xAcc = param11 * this._directionModifier;
         this._xStart = this._projectileMC.x;
         this._xDistance = param12 * this._directionModifier;
         this._yDistance = param13;
         this._targetYPos = Math.abs(y) - 10;
         this._fireSound = param14;
         this._feedbackAndSoundFunction = param15;
         this._getHitFunction = param16;
         this._getHitExplosionSound = param17;
         this._returnFunction = param18;
         this._returnFunctionParameters = param19;
      }
      
      public function runFrame(param1:uint) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
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
                  this._feedbackAndSoundFunction(this._attackingPlayerID,"xAxisBack",this._fireSound);
               }
               this.holderMC.addChild(this);
               addChild(this._projectileMC);
               if(this._projectileMC.mcFire != null)
               {
                  this._projectileMC.mcFire.gotoAndPlay("animOn");
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
            if(this._tailEffectCooldown > 0)
            {
               --this._tailEffectCooldown;
            }
            else
            {
               if(dataM.runAsMobile)
               {
                  this._tailEffectCooldown = 1;
               }
               else
               {
                  this._tailEffectCooldown = 0;
               }
               _loc4_ = x + this._projectileMC.x;
               if(this._directionModifier > 0)
               {
                  _loc4_ -= 10;
               }
               else
               {
                  _loc4_ += 10;
               }
               effectsM.createShockWaveTailEffect(_loc4_,y + this._projectileMC.y,this._tailEffect,this.holderMC);
            }
            if(_loc2_)
            {
               if(this._getHitFunction != null)
               {
                  this._getHitFunction(this._defendingPlayerID,"xAxisFront",true,this._getHitExplosionSound);
               }
               _loc5_ = x + this._projectileMC.x;
               _loc6_ = y + this._projectileMC.y;
               _loc7_ = 1;
               effectsM.createExplosion(_loc7_,_loc5_,_loc6_,3,30,15,2,6,2,this.holderMC);
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
               effectsM.setShockWaveForDeletion(param1);
            }
            else
            {
               this._projectileMC.x += this._xSpeed;
               this._xSpeed += this._xAcc;
               this._projectileMC.y = this._yDistance * this._projectileMC.x / this._xDistance;
            }
         }
      }
      
      public function removeMe() : void
      {
         removeChild(this._projectileMC);
         this._projectileMC = null;
      }
   }
}

