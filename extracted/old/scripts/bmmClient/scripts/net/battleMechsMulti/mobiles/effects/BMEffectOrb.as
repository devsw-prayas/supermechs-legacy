package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectOrb extends BMBaseClass
   {
      
      public var holderMC:MovieClip;
      
      private var _projectileMC:MovieClip;
      
      private var _attackingPlayerID:Number;
      
      private var _defendingPlayerID:Number;
      
      private var _startFrames:Number;
      
      private var _xSpeed:Number;
      
      private var _ySpeed:Number;
      
      private var _yAcc:uint;
      
      private var _targetYPos:Number;
      
      private var _xDistance:Number;
      
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
      
      private var _tailActive:Boolean = false;
      
      private var _tailEffectCooldown:Number = 0;
      
      public function BMEffectOrb()
      {
         super();
      }
      
      public function initialize(param1:MovieClip, param2:MovieClip, param3:Number, param4:Number, param5:String, param6:String, param7:String, param8:Number, param9:Boolean, param10:Number, param11:Number, param12:String, param13:Function, param14:Function, param15:Boolean, param16:Function, param17:Array) : void
      {
         generateSingletonClassesPointers("");
         this.holderMC = param1;
         this._projectileMC = param2;
         this._projectileMC.mcEffect1.visible = true;
         this._projectileMC.mcEffect2.visible = false;
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
         this._xStart = this._projectileMC.x;
         this._xDistance = param11 * this._directionModifier;
         this._ySpeed = 0;
         this._yAcc = 1;
         this._targetYPos = Math.abs(y) - 10;
         this._fireSound = param12;
         this._feedbackAndSoundFunction = param13;
         this._getHitFunction = param14;
         this._getHitExplosionSound = param15;
         this._returnFunction = param16;
         this._returnFunctionParameters = param17;
      }
      
      public function runFrame(param1:uint) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
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
            if(this._tailActive)
            {
               this._projectileMC.scaleX += 0.03;
               this._projectileMC.scaleY += 0.03;
               if(this._tailEffectCooldown > 0)
               {
                  --this._tailEffectCooldown;
               }
               else
               {
                  this._tailEffectCooldown = 1;
                  _loc4_ = x + this._projectileMC.x;
                  if(this._directionModifier > 0)
                  {
                     _loc4_ -= 10;
                  }
                  else
                  {
                     _loc4_ += 10;
                  }
                  effectsM.createOrbTail(_loc4_,y + this._projectileMC.y,this._tailEffect,this.holderMC);
               }
            }
            if(_loc2_)
            {
               effectsM.createOrbExplosion(x + this._projectileMC.x,y + this._projectileMC.y,this._effectColor,this.holderMC);
               if(this._getHitFunction != null)
               {
                  this._getHitFunction(this._defendingPlayerID,"xAxisBack",false,this._getHitExplosionSound);
               }
               _loc5_ = this._projectileMC.width * this._directionModifier;
               _loc6_ = x + this._projectileMC.x;
               _loc7_ = y + this._projectileMC.y;
               _loc8_ = 1;
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
               effectsM.setOrbForDeletion(param1);
            }
            else
            {
               this._projectileMC.x += this._xSpeed;
               if(this._projectileMC.y < this._targetYPos)
               {
                  this._projectileMC.y += this._ySpeed;
                  this._ySpeed += this._yAcc;
                  if(this._projectileMC.y >= this._targetYPos)
                  {
                     this._projectileMC.y = this._targetYPos;
                     this._tailActive = true;
                     if(this._projectileMC.mcEffect1.visible)
                     {
                        this._projectileMC.mcEffect1.visible = false;
                        this._projectileMC.mcEffect2.visible = true;
                     }
                  }
               }
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

