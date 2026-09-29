package
{
   import com.adobe.images.PNGEncoder;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class ImageUtils
   {
      
      public function ImageUtils()
      {
         super();
      }
      
      public static function getMovieClipAsBitmap(param1:MovieClip, param2:BitmapData = null) : Bitmap
      {
         var _loc3_:Rectangle = param1.getBounds(param1);
         if(param2 == null)
         {
            param2 = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         }
         var _loc4_:Bitmap = new Bitmap(param2);
         var _loc5_:Matrix = new Matrix(1,0,0,1,-_loc3_.x,-_loc3_.y);
         _loc5_.scale(param2.width / _loc3_.width,param2.height / _loc3_.height);
         _loc4_.bitmapData.draw(param1,_loc5_,null,null,null,true);
         return _loc4_;
      }
      
      public static function getMovieClipAsByteArrayPNG(param1:MovieClip, param2:BitmapData = null) : ByteArray
      {
         var _loc3_:Bitmap = getMovieClipAsBitmap(param1,param2);
         return PNGEncoder.encode(_loc3_.bitmapData);
      }
      
      public static function swapTextFieldWithBitMap(param1:TextField, param2:MovieClip) : *
      {
         var _loc5_:String = null;
         var _loc3_:Sprite = new Sprite();
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         param1.x = 0;
         param1.y = 0;
         _loc3_.addChild(param1);
         var _loc4_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         _loc5_ = param1.name + "BM";
         var _loc6_:Bitmap = param2.getChildByName(_loc5_) as Bitmap;
         if(_loc6_ != null)
         {
            _loc6_.parent.removeChild(_loc6_);
         }
         _loc6_ = new Bitmap(_loc4_);
         _loc4_.draw(_loc3_);
         _loc6_.smoothing = true;
         _loc6_.x = _loc3_.x;
         _loc6_.y = _loc3_.y;
         _loc6_.name = _loc5_;
         param2.addChild(_loc6_);
         param1.x = _loc3_.x;
         param1.y = _loc3_.y;
         if(param1.parent != null)
         {
            param1.parent.removeChild(param1);
         }
         _loc3_ = null;
      }
   }
}

