package net.battleMechsMulti.mobiles.baseMapAssets
{
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMDataManager;
   
   public class BMBaseMapShot
   {
      
      public var ID:uint;
      
      public var damage:uint;
      
      private var _grp:Sprite;
      
      private var _xSpeed:int;
      
      private var _ySpeed:int;
      
      private var _framesLeft:int;
      
      private var _setSelfForDeletion:Function;
      
      public function BMBaseMapShot(param1:uint, param2:uint, param3:Sprite, param4:int, param5:int, param6:uint, param7:Function)
      {
         super();
         this.ID = param1;
         this.damage = param2;
         this._grp = param3;
         this._grp.scaleX = 0.6;
         this._grp.scaleY = 0.6;
         this._xSpeed = param4;
         this._ySpeed = param5;
         this._framesLeft = param6;
         this._setSelfForDeletion = param7;
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._framesLeft <= 0)
         {
            this.setSelfForDeletion();
            return;
         }
         var _loc1_:Number = this._xSpeed;
         var _loc2_:Number = this._ySpeed;
         var _loc3_:uint = 1;
         if(BMDataManager.getInstance().generalSpeedRatio == BMDataManager.GENERAL_SPEED_RATIO_DOUBLE)
         {
            _loc1_ *= 2;
            _loc2_ *= 2;
            _loc3_ = 2;
         }
         this._grp.x += _loc1_;
         this._grp.y += _loc2_;
         this._framesLeft -= _loc3_;
      }
      
      public function setSelfForDeletion() : void
      {
         this._setSelfForDeletion(this.ID);
      }
      
      public function removeMe() : void
      {
         this._grp.parent.removeChild(this._grp);
         this._grp = null;
      }
      
      public function get xPos() : Number
      {
         return this._grp.x;
      }
      
      public function get yPos() : Number
      {
         return this._grp.y;
      }
   }
}

