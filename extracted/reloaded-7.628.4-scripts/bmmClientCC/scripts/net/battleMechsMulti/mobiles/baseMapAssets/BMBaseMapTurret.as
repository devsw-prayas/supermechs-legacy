package net.battleMechsMulti.mobiles.baseMapAssets
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMMapMech;
   
   public class BMBaseMapTurret
   {
      
      public static const DIRECTION_DOWN:String = "down";
      
      public static const DIRECTION_LEFT:String = "left";
      
      public static const DIRECTION_RIGHT:String = "right";
      
      private var _row:int;
      
      private var _column:int;
      
      private var _cannons:uint = 1;
      
      private var _currentCannon:uint = 1;
      
      public var direction:String;
      
      public var weaponAnimation:String;
      
      private var _firingGlobalCooldown:uint = 0;
      
      private var _firingCannonCooldown:uint = 0;
      
      private var _grp:MovieClip;
      
      private var _firingGlobalCooldownFrames:uint = 0;
      
      private var _firingCannonCooldownFrames:uint = 0;
      
      public function BMBaseMapTurret(param1:int, param2:int, param3:String, param4:uint, param5:uint, param6:String, param7:MovieClip)
      {
         super();
         this._row = param1;
         this._column = param2;
         this.direction = param3;
         this._firingGlobalCooldownFrames = param4;
         this._firingCannonCooldownFrames = param5;
         this._grp = param7;
         this.weaponAnimation = param6;
         var _loc8_:uint = 2;
         while(_loc8_ <= 3)
         {
            if(this._grp["mcFire" + _loc8_] != null)
            {
               ++this._cannons;
            }
            _loc8_++;
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this._firingGlobalCooldown > 0)
         {
            --this._firingGlobalCooldown;
         }
         else if(this._firingCannonCooldown > 0)
         {
            --this._firingCannonCooldown;
         }
      }
      
      public function get grp() : MovieClip
      {
         return this._grp;
      }
      
      public function get row() : uint
      {
         return this._row;
      }
      
      public function get column() : uint
      {
         return this._column;
      }
      
      public function get cannons() : uint
      {
         return this._cannons;
      }
      
      public function get currentCannon() : uint
      {
         return this._currentCannon;
      }
      
      public function get canFire() : Boolean
      {
         return this._firingGlobalCooldown == 0 && this._firingCannonCooldown == 0;
      }
      
      public function turretFired() : void
      {
         if(this._currentCannon < this._cannons)
         {
            this._firingCannonCooldown = this._firingCannonCooldownFrames;
            ++this._currentCannon;
         }
         else
         {
            this._firingGlobalCooldown = this._firingGlobalCooldownFrames;
            this._currentCannon = 1;
         }
      }
      
      public function isMechInFiringRange(param1:BMMapMech) : Boolean
      {
         var _loc2_:uint = 30;
         switch(this.direction)
         {
            case DIRECTION_DOWN:
               if(this._grp.y < param1.y && param1.x > this._grp.x - _loc2_ && param1.x < this._grp.x + _loc2_)
               {
                  return true;
               }
               break;
            case DIRECTION_LEFT:
               if(this._grp.x > param1.x && param1.y > this._grp.y - _loc2_ && param1.y < this._grp.y + _loc2_)
               {
                  return true;
               }
               break;
            case DIRECTION_RIGHT:
               if(this._grp.x < param1.x && param1.y > this._grp.y - _loc2_ && param1.y < this._grp.y + _loc2_)
               {
                  return true;
               }
         }
         return false;
      }
   }
}

