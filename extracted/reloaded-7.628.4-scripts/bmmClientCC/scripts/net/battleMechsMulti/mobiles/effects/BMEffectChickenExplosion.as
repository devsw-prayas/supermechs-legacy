package net.battleMechsMulti.mobiles.effects
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.tacticsoft.utils.RandomUtils;
   
   public class BMEffectChickenExplosion extends BMBaseClass
   {
      
      private var _dots:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      public function BMEffectChickenExplosion()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:MovieClip) : void
      {
         var _loc5_:MovieClip = null;
         generateSingletonClassesPointers("");
         var _loc4_:int = 0;
         while(_loc4_ < 20)
         {
            _loc5_ = externalAssetsM.getAsset("general","feather");
            _loc5_.scaleX = Math.random() > 0.5 ? 1 : -1;
            _loc5_.x = param1;
            _loc5_.y = param2;
            param3.addChild(_loc5_);
            this._dots.push(_loc5_);
            this.tweenDot(_loc5_,RandomUtils.getRandom(0,0.4));
            _loc4_++;
         }
      }
      
      private function tweenDot(param1:MovieClip, param2:Number) : void
      {
         param1.alpha = 1;
         var _loc3_:Number = RandomUtils.getRandom(0,Math.PI * 2);
         var _loc4_:Number = param1.x + Math.cos(_loc3_) * 125;
         var _loc5_:Number = param1.y + Math.sin(_loc3_) * 80;
         var _loc6_:Number = 0.8;
         var _loc7_:Number = _loc6_ / 4;
         TweenMax.to(param1,_loc7_,{
            "alpha":0,
            "delay":param2 + _loc6_ - _loc7_,
            "overwrite":0
         });
         TweenMax.to(param1,_loc6_,{
            "x":_loc4_,
            "y":_loc5_,
            "delay":param2,
            "ease":Quad.easeOut,
            "overwrite":0,
            "onComplete":this.onAnimComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function onAnimComplete(param1:MovieClip) : *
      {
         param1.parent.removeChild(param1);
      }
      
      public function removeMe() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._dots.length)
         {
            if(this._dots[_loc1_].parent != null)
            {
               TweenMax.killTweensOf(this._dots[_loc1_]);
               this._dots[_loc1_].parent.removeChild(this._dots[_loc1_]);
            }
            _loc1_++;
         }
         this._dots = null;
      }
   }
}

