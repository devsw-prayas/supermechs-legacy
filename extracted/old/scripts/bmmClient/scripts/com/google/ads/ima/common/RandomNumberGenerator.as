package com.google.ads.ima.common
{
   public class RandomNumberGenerator
   {
      
      public static function random():Number
      {
         return Math.round(Math.random() * int.MAX_VALUE);
      }
      public function RandomNumberGenerator()
      {
         super();
      }
   }
}

