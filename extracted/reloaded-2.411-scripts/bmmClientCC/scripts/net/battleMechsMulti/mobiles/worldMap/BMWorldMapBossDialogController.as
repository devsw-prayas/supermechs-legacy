package net.battleMechsMulti.mobiles.worldMap
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.mobiles.BMMechView;
   
   public class BMWorldMapBossDialogController
   {
      
      private var bossDialog:BMWorldMapBossDialog;
      
      private var _dialogEndedFunction:Function;
      
      private var _lastChapterID:Number = -1;
      
      private var _holder:Sprite;
      
      public function BMWorldMapBossDialogController(param1:Sprite)
      {
         super();
         this._holder = param1;
      }
      
      public function showDialog(param1:uint, param2:BMMechView, param3:String, param4:Number = 0, param5:Number = 0, param6:Function = null, param7:Number = 147, param8:Number = 390) : void
      {
         var _loc9_:Boolean = false;
         if(this.bossDialog != null)
         {
            if(this._lastChapterID == param1)
            {
               _loc9_ = true;
            }
         }
         this._lastChapterID = param1;
         this._dialogEndedFunction = param6;
         if(_loc9_)
         {
            this.bossDialogWaitComplete();
         }
         else
         {
            this.removeBossDialog();
            this.bossDialog = new BMWorldMapBossDialog();
            this.bossDialog.showMech(param2,param4,param5);
            this.bossDialog.showDialog(param3);
            this.bossDialog.x = param7;
            this.bossDialog.y = 650;
            this._holder.addChild(this.bossDialog);
            TweenMax.to(this.bossDialog,0.5,{
               "y":param8,
               "onComplete":this.bossDialogInComplete
            });
         }
      }
      
      private function bossDialogInComplete() : void
      {
         TweenMax.to(this.bossDialog,8,{"onComplete":this.bossDialogWaitComplete});
         this.bossDialog.addEventListener(MouseEvent.CLICK,this.bossDialogClicked);
      }
      
      private function bossDialogWaitComplete() : void
      {
         TweenMax.to(this.bossDialog,0.5,{
            "y":650,
            "onComplete":this.removeBossDialog
         });
         this.bossDialog.removeEventListener(MouseEvent.CLICK,this.bossDialogClicked);
      }
      
      private function bossDialogClicked(param1:MouseEvent) : void
      {
         this.bossDialogWaitComplete();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this.bossDialog != null)
         {
            this.bossDialog.onEnterFrameTrigger();
         }
      }
      
      private function removeBossDialog() : void
      {
         if(this.bossDialog != null)
         {
            TweenMax.killTweensOf(this.bossDialog);
            this.bossDialog.removeMe();
            if(this.bossDialog.parent != null)
            {
               this.bossDialog.parent.removeChild(this.bossDialog);
            }
            this.bossDialog = null;
            if(this._dialogEndedFunction != null)
            {
               this._dialogEndedFunction();
            }
         }
      }
      
      public function removeMe() : void
      {
         this.removeBossDialog();
      }
   }
}

