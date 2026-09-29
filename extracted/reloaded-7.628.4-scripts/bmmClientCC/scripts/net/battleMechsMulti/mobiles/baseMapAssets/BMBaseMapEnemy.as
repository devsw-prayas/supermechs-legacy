package net.battleMechsMulti.mobiles.baseMapAssets
{
   import flash.geom.Point;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMMapMech;
   
   public class BMBaseMapEnemy
   {
      
      public static const DIRECTION_NONE:String = "none";
      
      public static const DIRECTION_HORIZONTAL:String = "horizontal";
      
      public static const DIRECTION_VERTICAL:String = "vertical";
      
      public static const STATUS_WAIT:String = "wait";
      
      public static const STATUS_WALK_TO_TARGET:String = "target";
      
      public static const STATUS_WALK_TO_ORIGIN:String = "origin";
      
      private static const WAIT_FRAMES:uint = 30;
      
      private static const WAIT_FRAMES_RAND_ADDON:uint = 10;
      
      private static const SPEED_REGULAR:uint = 2;
      
      private static const SPEED_DOUBLE:uint = 4;
      
      private var _canPatrol:Boolean = false;
      
      private var _patrolOriginPoint:Point;
      
      private var _patrolTargetPoint:Point;
      
      private var _patrolDirection:String = "none";
      
      private var _patrolStatus:String;
      
      private var _patrolLastStatus:String = "wait";
      
      private var _followerID:uint = 0;
      
      public var row:uint;
      
      public var column:uint;
      
      public var view:BMMapMech;
      
      private var _waitFrames:uint = 0;
      
      public var gotDamaged:Boolean = false;
      
      private var _waitingFramesArray:Array;
      
      private var _waitingFramesSlot:uint = 0;
      
      public function BMBaseMapEnemy()
      {
         super();
      }
      
      public function setPatrol(param1:BMMapMech, param2:Array, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint, param8:uint = 0) : void
      {
         this.row = param3;
         this.column = param4;
         this.view = param1;
         var _loc9_:uint = 1;
         if(param2[param3][this.column - 1] != null && param2[this.row][this.column + 1] != null)
         {
            if(param2[this.row][this.column - 1] == "" && param2[this.row][this.column + 1] == "")
            {
               if(param2[this.row][this.column - 2] != null && param2[this.row][this.column + 2] != null)
               {
                  if(param2[this.row][this.column - 2] == "" && param2[this.row][this.column + 2] == "")
                  {
                     _loc9_ = 2;
                  }
               }
               this._patrolDirection = DIRECTION_HORIZONTAL;
               if(this.column > param6 / 2)
               {
                  this._patrolStatus = STATUS_WALK_TO_TARGET;
               }
               else
               {
                  this._patrolStatus = STATUS_WALK_TO_ORIGIN;
               }
               this._patrolOriginPoint = new Point(param1.x - param7 * _loc9_,param1.y);
               this._patrolTargetPoint = new Point(param1.x + param7 * _loc9_,param1.y);
            }
         }
         if(this._patrolDirection == DIRECTION_NONE && param2[this.row - 1] != null && param2[this.row + 1] != null)
         {
            if(param2[this.row - 1][this.column] == "" && param2[this.row + 1][this.column] == "")
            {
               if(param2[this.row - 2] != null && param2[this.row + 2] != null)
               {
                  if(param2[this.row - 2][this.column] == "" && param2[this.row + 2][this.column] == "")
                  {
                     _loc9_ = 2;
                  }
               }
               this._patrolDirection = DIRECTION_VERTICAL;
               if(this.row > param5 / 2)
               {
                  this._patrolStatus = STATUS_WALK_TO_TARGET;
               }
               else
               {
                  this._patrolStatus = STATUS_WALK_TO_ORIGIN;
               }
               this._patrolOriginPoint = new Point(param1.x,param1.y - param7 * _loc9_);
               this._patrolTargetPoint = new Point(param1.x,param1.y + param7 * _loc9_);
            }
         }
         if(this._patrolDirection == DIRECTION_NONE)
         {
            return;
         }
         this._canPatrol = true;
         this._followerID = param8;
         this.activateWalkToTarget();
      }
      
      public function get followerID() : uint
      {
         return this._followerID;
      }
      
      private function activateWalkToTarget() : void
      {
         if(this._patrolStatus == STATUS_WALK_TO_TARGET)
         {
            if(this._patrolDirection == DIRECTION_HORIZONTAL)
            {
               this.view.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_RIGHT);
            }
            else
            {
               this.view.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_DOWN);
            }
         }
         else if(this._patrolStatus == STATUS_WALK_TO_ORIGIN)
         {
            if(this._patrolDirection == DIRECTION_HORIZONTAL)
            {
               this.view.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_LEFT);
            }
            else
            {
               this.view.setStatusAndDirection(BMMapMech.STATUS_WALK,BMMapMech.DIRECTION_UP);
            }
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this.view.visible == false)
         {
            return;
         }
         this.view.onEnterFrameTrigger();
         if(this._canPatrol == false)
         {
            return;
         }
         if(this._patrolStatus == STATUS_WAIT)
         {
            if(this._waitFrames > 0)
            {
               --this._waitFrames;
               return;
            }
            if(this._patrolLastStatus == STATUS_WALK_TO_ORIGIN)
            {
               this._patrolStatus = STATUS_WALK_TO_TARGET;
            }
            else
            {
               this._patrolStatus = STATUS_WALK_TO_ORIGIN;
            }
            this.activateWalkToTarget();
            this._patrolLastStatus = STATUS_WAIT;
            return;
         }
         var _loc1_:Boolean = false;
         if(this._patrolStatus == STATUS_WALK_TO_ORIGIN)
         {
            if(this._patrolDirection == DIRECTION_HORIZONTAL)
            {
               this.view.x -= this.speed;
               if(this.view.x <= this._patrolOriginPoint.x)
               {
                  this.view.x = this._patrolOriginPoint.x;
                  this.view.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_LEFT);
                  _loc1_ = true;
               }
            }
            else
            {
               this.view.y -= this.speed;
               if(this.view.y <= this._patrolOriginPoint.y)
               {
                  this.view.y = this._patrolOriginPoint.y;
                  this.view.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_UP);
                  _loc1_ = true;
               }
            }
         }
         else if(this._patrolStatus == STATUS_WALK_TO_TARGET)
         {
            if(this._patrolDirection == DIRECTION_HORIZONTAL)
            {
               this.view.x += this.speed;
               if(this.view.x >= this._patrolTargetPoint.x)
               {
                  this.view.x = this._patrolTargetPoint.x;
                  this.view.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_RIGHT);
                  _loc1_ = true;
               }
            }
            else
            {
               this.view.y += this.speed;
               if(this.view.y >= this._patrolTargetPoint.y)
               {
                  this.view.y = this._patrolTargetPoint.y;
                  this.view.setStatusAndDirection(BMMapMech.STATUS_STAND,BMMapMech.DIRECTION_DOWN);
                  _loc1_ = true;
               }
            }
         }
         if(_loc1_)
         {
            this._patrolLastStatus = this._patrolStatus;
            this._patrolStatus = STATUS_WAIT;
            if(this._waitingFramesArray != null && this._waitingFramesArray.length > 0)
            {
               this._waitFrames = this._waitingFramesArray[this._waitingFramesSlot];
               ++this._waitingFramesSlot;
               if(this._waitingFramesSlot >= this._waitingFramesArray.length)
               {
                  this._waitingFramesSlot = 0;
               }
            }
            else
            {
               this._waitFrames = WAIT_FRAMES + Math.ceil(Math.random() * WAIT_FRAMES_RAND_ADDON) - 1;
            }
         }
      }
      
      public function generateWaitingFramesArray() : Array
      {
         var _loc2_:uint = 0;
         this._waitingFramesArray = new Array();
         var _loc1_:uint = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = WAIT_FRAMES + Math.ceil(Math.random() * WAIT_FRAMES_RAND_ADDON) - 1;
            this._waitingFramesArray.push(_loc2_);
            _loc1_++;
         }
         return this._waitingFramesArray;
      }
      
      public function setWaitingFramesArray(param1:Array) : void
      {
         this._waitingFramesArray = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            this._waitingFramesArray.push(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      private function get speed() : uint
      {
         if(BMDataManager.getInstance().generalSpeedRatio == 2)
         {
            return SPEED_DOUBLE;
         }
         return SPEED_REGULAR;
      }
      
      public function get patrolDirection() : String
      {
         return this._patrolDirection;
      }
   }
}

