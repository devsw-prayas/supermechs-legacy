package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectGeneral extends BMBaseClass
   {
      
      private var _effectMC:MovieClip;
      
      private var _triggerFunction:Function;
      
      private var _triggerFunction2:Function;
      
      private var _triggerFunctionParameters:Array;
      
      public var _holderMC:MovieClip;
      
      public var effectID:Number;
      
      private var _effectAborted:Boolean = false;
      
      public function BMEffectGeneral()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:MovieClip, param3:MovieClip, param4:Function, param5:Array) : void
      {
         generateSingletonClassesPointers("");
         this.effectID = param1;
         this._effectMC = param3;
         this._holderMC = param2;
         this._triggerFunction = param4;
         this._triggerFunctionParameters = param5;
         addChild(this._effectMC);
      }
      
      public function triggerMe() : void
      {
         if(this._effectAborted == false)
         {
            if(this._triggerFunction != null)
            {
               if(this._triggerFunctionParameters == null)
               {
                  this._triggerFunction();
               }
               else
               {
                  switch(this._triggerFunctionParameters.length)
                  {
                     case 0:
                        this._triggerFunction();
                        break;
                     case 1:
                        this._triggerFunction(this._triggerFunctionParameters[0]);
                        break;
                     case 2:
                        this._triggerFunction(this._triggerFunctionParameters[0],this._triggerFunctionParameters[1]);
                  }
               }
            }
         }
      }
      
      public function setTrigger2Function(param1:Function) : void
      {
         this._triggerFunction2 = param1;
      }
      
      public function triggerMe2() : void
      {
         if(this._effectAborted == false)
         {
            if(this._triggerFunction2 != null)
            {
               this._triggerFunction2();
            }
         }
      }
      
      public function removeMe() : void
      {
         removeChild(this._effectMC);
         this._effectMC = null;
         effectsM.removeGeneralEffect(this);
      }
      
      public function abortEffect() : void
      {
         this._effectAborted = true;
      }
   }
}

