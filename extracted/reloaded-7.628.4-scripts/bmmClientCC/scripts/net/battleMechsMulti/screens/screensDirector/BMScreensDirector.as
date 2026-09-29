package net.battleMechsMulti.screens.screensDirector
{
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMScreensDirector extends BMBaseClass
   {
      
      private var _tasks:Array = new Array();
      
      public function BMScreensDirector()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function addLocationTask(param1:String, param2:Object = null) : void
      {
         var _loc3_:Number = 0;
         this.addTask(BMScreensDirectorTask.TYPE_LOCATION,param1,_loc3_,param2);
      }
      
      public function addSequenceTask(param1:String, param2:Number = 0.1, param3:Object = null) : void
      {
         this.addTask(BMScreensDirectorTask.TYPE_SEQUENCE,param1,param2,param3);
      }
      
      public function addUserActionTask(param1:String, param2:Object = null) : void
      {
         var _loc3_:Number = 0;
         this.addTask(BMScreensDirectorTask.TYPE_USER_ACTION,param1,_loc3_,param2);
      }
      
      public function addDataUpdateTask(param1:String, param2:Object = null) : void
      {
         var _loc3_:Number = 0;
         this.addTask(BMScreensDirectorTask.TYPE_DATA_UPDATE,param1,_loc3_,param2);
      }
      
      public function addTask(param1:String, param2:String, param3:Number, param4:Object = null) : void
      {
         var _loc5_:BMScreensDirectorTask = new BMScreensDirectorTask(param1,param2,param3,param4,this.currentTaskCompleted);
         var _loc6_:uint = this._tasks.length;
         this._tasks.push(_loc5_);
         if(_loc6_ == 0)
         {
            BMPubSub.pub(BMPubSub.MESSAGE_SCREENS_DIRECTOR_STARTED_PERFORMING_TASKS);
            this.handleCurrentTask();
         }
      }
      
      private function handleCurrentTask() : void
      {
         if(this.hasTasks() == false)
         {
            return;
         }
         var _loc1_:BMScreensDirectorTask = this._tasks[0];
         _loc1_.excecute();
      }
      
      private function currentTaskCompleted() : void
      {
         var _loc1_:BMScreensDirectorTask = this._tasks[0];
         _loc1_.removeMe();
         this._tasks.splice(0,1);
         if(this._tasks.length > 0)
         {
            this.handleCurrentTask();
         }
         else
         {
            BMPubSub.pub(BMPubSub.MESSAGE_SCREENS_DIRECTOR_FINISHED_ALL_TASKS);
         }
      }
      
      public function hasTasks() : Boolean
      {
         return this._tasks.length > 0;
      }
   }
}

