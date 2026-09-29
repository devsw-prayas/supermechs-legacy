package net.battleMechsMulti.mobiles.effects
{
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectFlyingGoldCoin extends BMBaseClass
   {
      
      private var _goldCoinMC:Sprite;
      
      private var _motionFrames:uint;
      
      private var _startFrames:uint = 0;
      
      private var _frameCounter:uint = 0;
      
      private var _xSpeed:Number;
      
      private var _ySpeed:Number;
      
      private var _originSize:uint;
      
      private var _sizeChange:Number;
      
      private var mcGoldCoinSubHolder:Sprite;
      
      public function BMEffectFlyingGoldCoin()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:Number, param4:Number, param5:uint, param6:uint, param7:uint, param8:Boolean = false) : void
      {
         generateSingletonClassesPointers("");
         if(param8)
         {
            this._goldCoinMC = new localIcon_xpStar();
         }
         else
         {
            this._goldCoinMC = externalAssetsM.getAsset("general","icon_gold",param5,param5);
            this._goldCoinMC.x = -param5 / 2;
            this._goldCoinMC.y = -param5 / 2;
         }
         this._originSize = param5;
         this._motionFrames = param7;
         this._xSpeed = (param3 - param1) / this._motionFrames;
         this._ySpeed = (param4 - param2) / this._motionFrames;
         x = param1;
         y = param2;
         this._sizeChange = (param6 - this._originSize) / this._motionFrames;
         this.mcGoldCoinSubHolder = new Sprite();
         addChild(this.mcGoldCoinSubHolder);
         this.mcGoldCoinSubHolder.addChild(this._goldCoinMC);
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._startFrames > 0)
         {
            --this._startFrames;
         }
         else if(this._frameCounter >= this._motionFrames)
         {
            effectsM.setFlyingGoldCoinForDeletion(param1);
         }
         else
         {
            x += this._xSpeed;
            y += this._ySpeed;
            this.mcGoldCoinSubHolder.width += this._sizeChange;
            this.mcGoldCoinSubHolder.height += this._sizeChange;
            ++this._frameCounter;
         }
      }
      
      public function removeMe() : void
      {
         if(this._goldCoinMC.parent != null)
         {
            this._goldCoinMC.parent.removeChild(this._goldCoinMC);
         }
         this._goldCoinMC = null;
      }
   }
}

