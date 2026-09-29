package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectArtillery extends BMBaseClass
   {
      
      public var holderMC:MovieClip;
      
      private var _rocketMC:MovieClip;
      
      private var _attackingPlayerID:Number;
      
      private var _defendingPlayerID:Number;
      
      private var _fireEffect:String;
      
      private var _startFrames:Number;
      
      private var _frameCounter:uint;
      
      private var _diagonal:Boolean;
      
      private var _flipHorizontal:Boolean;
      
      private var _speed:Number;
      
      private var _targetXPos:Number;
      
      private var _targetYPos:Number;
      
      private var _fireSound:String;
      
      private var _feedbackAndSoundFunction:Function;
      
      private var _getHitFunction:Function;
      
      private var _returnFunction:Function;
      
      private var _returnFunctionParameters:Array;
      
      private var _getHitEffect:String;
      
      private var _originalScaleX:Number;
      
      private var _originalScaleY:Number;
      
      private var _direction:String;
      
      private const CEILING_Y_POS_REGULAR:uint = 1200;
      
      private const CEILING_Y_POS_DIAGONAL:uint = 850;
      
      public function BMEffectArtillery()
      {
         super();
      }
      
      public function initialize(param1:MovieClip, param2:MovieClip, param3:Number, param4:Number, param5:Boolean, param6:Boolean, param7:String, param8:Number, param9:Number, param10:Number, param11:Number, param12:String, param13:String, param14:Function, param15:Function, param16:Function, param17:Array) : void
      {
         generateSingletonClassesPointers("");
         this.holderMC = param1;
         this._rocketMC = param2;
         this._attackingPlayerID = param3;
         this._defendingPlayerID = param4;
         this._fireEffect = param7;
         this._startFrames = param8;
         this._diagonal = param5;
         this._flipHorizontal = param6;
         this._speed = param9;
         this._targetXPos = param10;
         this._targetYPos = param11;
         this._fireSound = param13;
         this._getHitEffect = param12;
         this._feedbackAndSoundFunction = param14;
         this._getHitFunction = param15;
         this._returnFunction = param16;
         this._returnFunctionParameters = param17;
         if(this._diagonal)
         {
            if(this._flipHorizontal)
            {
               this._rocketMC.rotation = -135;
            }
            else
            {
               this._rocketMC.rotation = -45;
            }
            this._speed *= 0.66;
         }
         else
         {
            this._rocketMC.rotation = -90;
         }
         this._rocketMC.mcFire.visible = false;
         this._direction = "up";
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(this._startFrames > 0)
         {
            --this._startFrames;
            return;
         }
         if(this._rocketMC.parent == null)
         {
            if(this._feedbackAndSoundFunction != null)
            {
               this._feedbackAndSoundFunction(this._attackingPlayerID,"yAxis",this._fireSound);
            }
            this.holderMC.addChild(this);
            addChild(this._rocketMC);
            if(this._rocketMC.mcFire != null)
            {
               this._rocketMC.mcFire.visible = false;
            }
            if(this._fireEffect != "")
            {
               if(this._diagonal)
               {
                  if(this._flipHorizontal)
                  {
                     _loc3_ = -135;
                  }
                  else
                  {
                     _loc3_ = -45;
                  }
               }
               else
               {
                  _loc3_ = -90;
               }
               effectsM.createFireEffect(this._fireEffect,x,y,false,_loc3_,this.holderMC);
            }
         }
         if(this._rocketMC.mcFire != null)
         {
            if(this._frameCounter >= 4)
            {
               if(this._frameCounter == 4)
               {
                  this._rocketMC.mcFire.visible = true;
                  this._originalScaleX = this._rocketMC.mcFire.scaleX;
                  this._originalScaleY = this._rocketMC.mcFire.scaleY;
               }
               if(this._frameCounter < 10)
               {
                  this._rocketMC.mcFire.scaleX += this._originalScaleX;
                  this._rocketMC.mcFire.scaleY += this._originalScaleY * 0.2;
               }
            }
         }
         var _loc2_:* = false;
         switch(this._direction)
         {
            case "up":
               if(this._diagonal)
               {
                  this._rocketMC.y -= this._speed;
                  if(this._flipHorizontal)
                  {
                     this._rocketMC.x -= this._speed;
                  }
                  else
                  {
                     this._rocketMC.x += this._speed;
                  }
                  if(this._rocketMC.y < -this.CEILING_Y_POS_DIAGONAL)
                  {
                     this._direction = "down";
                     this._rocketMC.y = -this.CEILING_Y_POS_DIAGONAL;
                     if(this._flipHorizontal)
                     {
                        this._rocketMC.rotation = 45;
                        this._rocketMC.x = this._targetXPos - Math.ceil((this.CEILING_Y_POS_DIAGONAL + this._targetYPos) / this._speed) * this._speed;
                     }
                     else
                     {
                        this._rocketMC.rotation = 135;
                        this._rocketMC.x = this._targetXPos + Math.ceil((this.CEILING_Y_POS_DIAGONAL + this._targetYPos) / this._speed) * this._speed;
                     }
                  }
               }
               else
               {
                  this._rocketMC.y -= this._speed;
                  if(this._rocketMC.y < -this.CEILING_Y_POS_REGULAR)
                  {
                     this._direction = "down";
                     this._rocketMC.x = this._targetXPos;
                     this._rocketMC.rotation = 90;
                  }
               }
               break;
            case "down":
               if(this._rocketMC.y + this._speed >= this._targetYPos)
               {
                  if(this._getHitFunction != null)
                  {
                     if(this._diagonal)
                     {
                        _loc6_ = "xAxisBack";
                     }
                     else
                     {
                        _loc6_ = "yAxis";
                     }
                     this._getHitFunction(this._defendingPlayerID,_loc6_,false,true);
                  }
                  _loc4_ = x + this._targetXPos;
                  _loc5_ = y + this._targetYPos;
                  if(this._getHitEffect != "")
                  {
                     _loc7_ = Math.random() * 360;
                     _loc8_ = 1;
                     effectsM.addAnimatedEffect(this._getHitEffect,this.holderMC,_loc4_,_loc5_,_loc8_,_loc7_);
                  }
                  else
                  {
                     effectsM.createExplosion(4,_loc4_,_loc5_,3,30,15,2,6,2,this.holderMC);
                  }
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
                  effectsM.setArtilleryForDeletion(param1);
               }
               else if(this._diagonal)
               {
                  if(this._flipHorizontal)
                  {
                     this._rocketMC.y += this._speed;
                     this._rocketMC.x += this._speed;
                  }
                  else
                  {
                     this._rocketMC.y += this._speed;
                     this._rocketMC.x -= this._speed;
                  }
               }
               else
               {
                  this._rocketMC.y += this._speed;
               }
         }
         ++this._frameCounter;
      }
      
      public function removeMe() : void
      {
         removeChild(this._rocketMC);
         this._rocketMC = null;
      }
   }
}

