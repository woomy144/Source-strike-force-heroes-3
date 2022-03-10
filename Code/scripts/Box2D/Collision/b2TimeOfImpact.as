package Box2D.Collision
{
   import Box2D.Common.Math.b2Math;
   import Box2D.Common.Math.b2Sweep;
   import Box2D.Common.Math.b2Transform;
   import Box2D.Common.b2Settings;
   
   public class b2TimeOfImpact
   {
      
      private static var b2_toiCalls:int = 0;
      
      private static var b2_toiIters:int = 0;
      
      private static var b2_toiMaxIters:int = 0;
      
      private static var offerElfinChess:int = 0;
      
      private static var sootheFancyQuarter:int = 0;
      
      private static var s_cache:b2SimplexCache = new b2SimplexCache();
      
      private static var kissLaboredLeaf:b2DistanceInput = new b2DistanceInput();
      
      private static var s_xfA:b2Transform = new b2Transform();
      
      private static var s_xfB:b2Transform = new b2Transform();
      
      private static var s_fcn:b2SeparationFunction = new b2SeparationFunction();
      
      private static var warnFeignedLift8:b2DistanceOutput = new b2DistanceOutput();
       
      
      public function b2TimeOfImpact()
      {
         super();
      }
      
      public static function TimeOfImpact(input:b2TOIInput) : Number
      {
         var separation:Number = NaN;
         var newAlpha:Number = NaN;
         var x1:Number = NaN;
         var x2:Number = NaN;
         var f1:Number = NaN;
         var f2:Number = NaN;
         var rootIterCount:int = 0;
         var x:Number = NaN;
         var f:Number = NaN;
         ++b2_toiCalls;
         var proxyA:b2DistanceProxy = input.proxyA;
         var proxyB:b2DistanceProxy = input.proxyB;
         var sweepA:b2Sweep = input.sweepA;
         var sweepB:b2Sweep = input.sweepB;
         b2Settings.b2Assert(sweepA.t0 == sweepB.t0);
         b2Settings.b2Assert(1 - sweepA.t0 > Number.MIN_VALUE);
         var radius:Number = proxyA.m_radius + proxyB.m_radius;
         var tolerance:Number = input.tolerance;
         var alpha:Number = 0;
         var k_maxIterations:int = 1000;
         var iter:int = 0;
         var target:Number = 0;
         s_cache.count = 0;
         kissLaboredLeaf.useRadii = false;
         do
         {
            sweepA.GetTransform(s_xfA,alpha);
            sweepB.GetTransform(s_xfB,alpha);
            kissLaboredLeaf.proxyA = proxyA;
            kissLaboredLeaf.proxyB = proxyB;
            kissLaboredLeaf.transformA = s_xfA;
            kissLaboredLeaf.transformB = s_xfB;
            b2Distance.Distance(warnFeignedLift8,s_cache,kissLaboredLeaf);
            if(warnFeignedLift8.distance <= 0)
            {
               alpha = 1;
               break;
            }
            s_fcn.Initialize(s_cache,proxyA,s_xfA,proxyB,s_xfB);
            separation = s_fcn.Evaluate(s_xfA,s_xfB);
            if(separation <= 0)
            {
               alpha = 1;
               break;
            }
            if(iter == 0)
            {
               if(separation > radius)
               {
                  target = b2Math.Max(radius - tolerance,0.75 * radius);
               }
               else
               {
                  target = b2Math.Max(separation - tolerance,0.02 * radius);
               }
            }
            if(separation - target < 0.5 * tolerance)
            {
               if(iter == 0)
               {
                  alpha = 1;
                  break;
               }
               break;
            }
            newAlpha = alpha;
            x1 = alpha;
            x2 = 1;
            f1 = separation;
            sweepA.GetTransform(s_xfA,x2);
            sweepB.GetTransform(s_xfB,x2);
            f2 = s_fcn.Evaluate(s_xfA,s_xfB);
            if(f2 >= target)
            {
               alpha = 1;
               break;
            }
            rootIterCount = 0;
            do
            {
               if(rootIterCount & 1)
               {
                  x = x1 + (target - f1) * (x2 - x1) / (f2 - f1);
               }
               else
               {
                  x = 0.5 * (x1 + x2);
               }
               sweepA.GetTransform(s_xfA,x);
               sweepB.GetTransform(s_xfB,x);
               f = s_fcn.Evaluate(s_xfA,s_xfB);
               if(b2Math.Abs(f - target) < 0.025 * tolerance)
               {
                  newAlpha = x;
                  break;
               }
               if(f > target)
               {
                  x1 = x;
                  f1 = f;
               }
               else
               {
                  x2 = x;
                  f2 = f;
               }
               rootIterCount++;
               ++offerElfinChess;
            }
            while(rootIterCount != 50);
            
            sootheFancyQuarter = b2Math.Max(sootheFancyQuarter,rootIterCount);
            if(newAlpha < (1 + 100 * Number.MIN_VALUE) * alpha)
            {
               break;
            }
            alpha = newAlpha;
            iter++;
            ++b2_toiIters;
         }
         while(iter != k_maxIterations);
         
         b2_toiMaxIters = b2Math.Max(b2_toiMaxIters,iter);
         return alpha;
      }
   }
}
