package Box2D.Dynamics.Joints
{
   import Box2D.Common.Math.b2Mat22;
   import Box2D.Common.Math.b2Mat33;
   import Box2D.Common.Math.b2Math;
   import Box2D.Common.Math.b2Transform;
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.Math.b2Vec3;
   import Box2D.Common.b2Settings;
   import Box2D.Common.b2internal;
   import Box2D.Dynamics.b2Body;
   import Box2D.Dynamics.b2TimeStep;
   
   use namespace b2internal;
   
   public class b2PrismaticJoint extends b2Joint
   {
       
      
      b2internal var m_localAnchor1:b2Vec2;
      
      b2internal var m_localAnchor2:b2Vec2;
      
      b2internal var m_localXAxis1:b2Vec2;
      
      private var m_localYAxis1:b2Vec2;
      
      private var m_refAngle:Number;
      
      private var m_axis:b2Vec2;
      
      private var m_perp:b2Vec2;
      
      private var m_s1:Number;
      
      private var m_s2:Number;
      
      private var m_a1:Number;
      
      private var m_a2:Number;
      
      private var m_K:b2Mat33;
      
      private var m_impulse:b2Vec3;
      
      private var m_motorMass:Number;
      
      private var m_motorImpulse:Number;
      
      private var m_lowerTranslation:Number;
      
      private var m_upperTranslation:Number;
      
      private var m_maxMotorForce:Number;
      
      private var m_motorSpeed:Number;
      
      private var m_enableLimit:Boolean;
      
      private var m_enableMotor:Boolean;
      
      private var m_limitState:int;
      
      public function b2PrismaticJoint(def:b2PrismaticJointDef)
      {
         var tMat:b2Mat22 = null;
         var tX:Number = NaN;
         var tY:Number = NaN;
         this.m_localAnchor1 = new b2Vec2();
         this.m_localAnchor2 = new b2Vec2();
         this.m_localXAxis1 = new b2Vec2();
         this.m_localYAxis1 = new b2Vec2();
         this.m_axis = new b2Vec2();
         this.m_perp = new b2Vec2();
         this.m_K = new b2Mat33();
         this.m_impulse = new b2Vec3();
         super(def);
         this.m_localAnchor1.SetV(def.localAnchorA);
         this.m_localAnchor2.SetV(def.localAnchorB);
         this.m_localXAxis1.SetV(def.localAxisA);
         this.m_localYAxis1.x = -this.m_localXAxis1.y;
         this.m_localYAxis1.y = this.m_localXAxis1.x;
         this.m_refAngle = def.referenceAngle;
         this.m_impulse.SetZero();
         this.m_motorMass = 0;
         this.m_motorImpulse = 0;
         this.m_lowerTranslation = def.lowerTranslation;
         this.m_upperTranslation = def.upperTranslation;
         this.m_maxMotorForce = def.maxMotorForce;
         this.m_motorSpeed = def.motorSpeed;
         this.m_enableLimit = def.enableLimit;
         this.m_enableMotor = def.enableMotor;
         this.m_limitState = b2internal::updateWearyVeil;
         this.m_axis.SetZero();
         this.m_perp.SetZero();
      }
      
      override public function GetAnchorA() : b2Vec2
      {
         return b2internal::m_bodyA.GetWorldPoint(this.m_localAnchor1);
      }
      
      override public function GetAnchorB() : b2Vec2
      {
         return b2internal::m_bodyB.GetWorldPoint(this.m_localAnchor2);
      }
      
      override public function GetReactionForce(inv_dt:Number) : b2Vec2
      {
         return new b2Vec2(inv_dt * (this.m_impulse.x * this.m_perp.x + (this.m_motorImpulse + this.m_impulse.z) * this.m_axis.x),inv_dt * (this.m_impulse.x * this.m_perp.y + (this.m_motorImpulse + this.m_impulse.z) * this.m_axis.y));
      }
      
      override public function GetReactionTorque(inv_dt:Number) : Number
      {
         return inv_dt * this.m_impulse.y;
      }
      
      public function GetJointTranslation() : Number
      {
         var tMat:b2Mat22 = null;
         var bA:b2Body = b2internal::m_bodyA;
         var bB:b2Body = b2internal::m_bodyB;
         var p1:b2Vec2 = bA.GetWorldPoint(this.m_localAnchor1);
         var p2:b2Vec2 = bB.GetWorldPoint(this.m_localAnchor2);
         var dX:Number = p2.x - p1.x;
         var dY:Number = p2.y - p1.y;
         var axis:b2Vec2 = bA.GetWorldVector(this.m_localXAxis1);
         return Number(axis.x * dX + axis.y * dY);
      }
      
      public function GetJointSpeed() : Number
      {
         var tMat:b2Mat22 = null;
         var bA:b2Body = b2internal::m_bodyA;
         var bB:b2Body = b2internal::m_bodyB;
         tMat = bA.m_xf.R;
         var r1X:Number = this.m_localAnchor1.x - bA.m_sweep.localCenter.x;
         var r1Y:Number = this.m_localAnchor1.y - bA.m_sweep.localCenter.y;
         var tX:Number = tMat.col1.x * r1X + tMat.col2.x * r1Y;
         r1Y = tMat.col1.y * r1X + tMat.col2.y * r1Y;
         r1X = tX;
         tMat = bB.m_xf.R;
         var r2X:Number = this.m_localAnchor2.x - bB.m_sweep.localCenter.x;
         var r2Y:Number = this.m_localAnchor2.y - bB.m_sweep.localCenter.y;
         tX = tMat.col1.x * r2X + tMat.col2.x * r2Y;
         r2Y = tMat.col1.y * r2X + tMat.col2.y * r2Y;
         r2X = tX;
         var p1X:Number = bA.m_sweep.c.x + r1X;
         var p1Y:Number = bA.m_sweep.c.y + r1Y;
         var p2X:Number = bB.m_sweep.c.x + r2X;
         var p2Y:Number = bB.m_sweep.c.y + r2Y;
         var dX:Number = p2X - p1X;
         var dY:Number = p2Y - p1Y;
         var axis:b2Vec2 = bA.GetWorldVector(this.m_localXAxis1);
         var v1:b2Vec2 = bA.m_linearVelocity;
         var v2:b2Vec2 = bB.m_linearVelocity;
         var w1:Number = bA.m_angularVelocity;
         var w2:Number = bB.m_angularVelocity;
         return Number(dX * (-w1 * axis.y) + dY * (w1 * axis.x) + (axis.x * (v2.x + -w2 * r2Y - v1.x - -w1 * r1Y) + axis.y * (v2.y + w2 * r2X - v1.y - w1 * r1X)));
      }
      
      public function IsLimitEnabled() : Boolean
      {
         return this.m_enableLimit;
      }
      
      public function EnableLimit(flag:Boolean) : void
      {
         b2internal::m_bodyA.SetAwake(true);
         b2internal::m_bodyB.SetAwake(true);
         this.m_enableLimit = flag;
      }
      
      public function GetLowerLimit() : Number
      {
         return this.m_lowerTranslation;
      }
      
      public function GetUpperLimit() : Number
      {
         return this.m_upperTranslation;
      }
      
      public function SetLimits(lower:Number, upper:Number) : void
      {
         b2internal::m_bodyA.SetAwake(true);
         b2internal::m_bodyB.SetAwake(true);
         this.m_lowerTranslation = lower;
         this.m_upperTranslation = upper;
      }
      
      public function IsMotorEnabled() : Boolean
      {
         return this.m_enableMotor;
      }
      
      public function EnableMotor(flag:Boolean) : void
      {
         b2internal::m_bodyA.SetAwake(true);
         b2internal::m_bodyB.SetAwake(true);
         this.m_enableMotor = flag;
      }
      
      public function SetMotorSpeed(speed:Number) : void
      {
         b2internal::m_bodyA.SetAwake(true);
         b2internal::m_bodyB.SetAwake(true);
         this.m_motorSpeed = speed;
      }
      
      public function GetMotorSpeed() : Number
      {
         return this.m_motorSpeed;
      }
      
      public function SetMaxMotorForce(force:Number) : void
      {
         b2internal::m_bodyA.SetAwake(true);
         b2internal::m_bodyB.SetAwake(true);
         this.m_maxMotorForce = force;
      }
      
      public function GetMotorForce() : Number
      {
         return this.m_motorImpulse;
      }
      
      override b2internal function InitVelocityConstraints(step:b2TimeStep) : void
      {
         var tMat:b2Mat22 = null;
         var tX:Number = NaN;
         var jointTransition:Number = NaN;
         var PX:Number = NaN;
         var PY:Number = NaN;
         var L1:Number = NaN;
         var L2:Number = NaN;
         var bA:b2Body = b2internal::m_bodyA;
         var bB:b2Body = b2internal::m_bodyB;
         b2internal::m_localCenterA.SetV(bA.GetLocalCenter());
         b2internal::m_localCenterB.SetV(bB.GetLocalCenter());
         var xf1:b2Transform = bA.GetTransform();
         var xf2:b2Transform = bB.GetTransform();
         tMat = bA.m_xf.R;
         var r1X:Number = this.m_localAnchor1.x - b2internal::m_localCenterA.x;
         var r1Y:Number = this.m_localAnchor1.y - b2internal::m_localCenterA.y;
         tX = tMat.col1.x * r1X + tMat.col2.x * r1Y;
         r1Y = tMat.col1.y * r1X + tMat.col2.y * r1Y;
         r1X = tX;
         tMat = bB.m_xf.R;
         var r2X:Number = this.m_localAnchor2.x - b2internal::m_localCenterB.x;
         var r2Y:Number = this.m_localAnchor2.y - b2internal::m_localCenterB.y;
         tX = tMat.col1.x * r2X + tMat.col2.x * r2Y;
         r2Y = tMat.col1.y * r2X + tMat.col2.y * r2Y;
         r2X = tX;
         var dX:Number = bB.m_sweep.c.x + r2X - bA.m_sweep.c.x - r1X;
         var dY:Number = bB.m_sweep.c.y + r2Y - bA.m_sweep.c.y - r1Y;
         m_invMassA = bA.m_invMass;
         m_invMassB = bB.m_invMass;
         m_invIA = bA.m_invI;
         m_invIB = bB.m_invI;
         this.m_axis.SetV(b2Math.MulMV(xf1.R,this.m_localXAxis1));
         this.m_a1 = (dX + r1X) * this.m_axis.y - (dY + r1Y) * this.m_axis.x;
         this.m_a2 = r2X * this.m_axis.y - r2Y * this.m_axis.x;
         this.m_motorMass = b2internal::m_invMassA + b2internal::m_invMassB + b2internal::m_invIA * this.m_a1 * this.m_a1 + b2internal::m_invIB * this.m_a2 * this.m_a2;
         if(this.m_motorMass > Number.MIN_VALUE)
         {
            this.m_motorMass = 1 / this.m_motorMass;
         }
         this.m_perp.SetV(b2Math.MulMV(xf1.R,this.m_localYAxis1));
         this.m_s1 = (dX + r1X) * this.m_perp.y - (dY + r1Y) * this.m_perp.x;
         this.m_s2 = r2X * this.m_perp.y - r2Y * this.m_perp.x;
         var m1:Number = b2internal::m_invMassA;
         var m2:Number = b2internal::m_invMassB;
         var i1:Number = b2internal::m_invIA;
         var i2:Number = b2internal::m_invIB;
         this.m_K.col1.x = m1 + m2 + i1 * this.m_s1 * this.m_s1 + i2 * this.m_s2 * this.m_s2;
         this.m_K.col1.y = i1 * this.m_s1 + i2 * this.m_s2;
         this.m_K.col1.z = i1 * this.m_s1 * this.m_a1 + i2 * this.m_s2 * this.m_a2;
         this.m_K.col2.x = this.m_K.col1.y;
         this.m_K.col2.y = i1 + i2;
         this.m_K.col2.z = i1 * this.m_a1 + i2 * this.m_a2;
         this.m_K.col3.x = this.m_K.col1.z;
         this.m_K.col3.y = this.m_K.col2.z;
         this.m_K.col3.z = m1 + m2 + i1 * this.m_a1 * this.m_a1 + i2 * this.m_a2 * this.m_a2;
         if(this.m_enableLimit)
         {
            jointTransition = this.m_axis.x * dX + this.m_axis.y * dY;
            if(b2Math.Abs(this.m_upperTranslation - this.m_lowerTranslation) < 2 * b2Settings.b2_linearSlop)
            {
               this.m_limitState = b2internal::e_equalLimits;
            }
            else if(jointTransition <= this.m_lowerTranslation)
            {
               if(this.m_limitState != b2internal::e_atLowerLimit)
               {
                  this.m_limitState = b2internal::e_atLowerLimit;
                  this.m_impulse.z = 0;
               }
            }
            else if(jointTransition >= this.m_upperTranslation)
            {
               if(this.m_limitState != b2internal::e_atUpperLimit)
               {
                  this.m_limitState = b2internal::e_atUpperLimit;
                  this.m_impulse.z = 0;
               }
            }
            else
            {
               this.m_limitState = b2internal::updateWearyVeil;
               this.m_impulse.z = 0;
            }
         }
         else
         {
            this.m_limitState = b2internal::updateWearyVeil;
         }
         if(this.m_enableMotor == false)
         {
            this.m_motorImpulse = 0;
         }
         if(step.warmStarting)
         {
            this.m_impulse.x *= step.dtRatio;
            this.m_impulse.y *= step.dtRatio;
            this.m_motorImpulse *= step.dtRatio;
            PX = this.m_impulse.x * this.m_perp.x + (this.m_motorImpulse + this.m_impulse.z) * this.m_axis.x;
            PY = this.m_impulse.x * this.m_perp.y + (this.m_motorImpulse + this.m_impulse.z) * this.m_axis.y;
            L1 = this.m_impulse.x * this.m_s1 + this.m_impulse.y + (this.m_motorImpulse + this.m_impulse.z) * this.m_a1;
            L2 = this.m_impulse.x * this.m_s2 + this.m_impulse.y + (this.m_motorImpulse + this.m_impulse.z) * this.m_a2;
            bA.m_linearVelocity.x -= b2internal::m_invMassA * PX;
            bA.m_linearVelocity.y -= b2internal::m_invMassA * PY;
            bA.m_angularVelocity -= b2internal::m_invIA * L1;
            bB.m_linearVelocity.x += b2internal::m_invMassB * PX;
            bB.m_linearVelocity.y += b2internal::m_invMassB * PY;
            bB.m_angularVelocity += b2internal::m_invIB * L2;
         }
         else
         {
            this.m_impulse.SetZero();
            this.m_motorImpulse = 0;
         }
      }
      
      override b2internal function SolveVelocityConstraints(step:b2TimeStep) : void
      {
         var PX:Number = NaN;
         var PY:Number = NaN;
         var L1:Number = NaN;
         var L2:Number = NaN;
         var Cdot:Number = NaN;
         var impulse:Number = NaN;
         var oldImpulse:Number = NaN;
         var maxImpulse:Number = NaN;
         var Cdot2:Number = NaN;
         var f1:b2Vec3 = null;
         var df:b2Vec3 = null;
         var bX:Number = NaN;
         var bY:Number = NaN;
         var f2r:b2Vec2 = null;
         var df2:b2Vec2 = null;
         var bA:b2Body = b2internal::m_bodyA;
         var bB:b2Body = b2internal::m_bodyB;
         var v1:b2Vec2 = bA.m_linearVelocity;
         var w1:Number = bA.m_angularVelocity;
         var v2:b2Vec2 = bB.m_linearVelocity;
         var w2:Number = bB.m_angularVelocity;
         if(this.m_enableMotor && this.m_limitState != b2internal::e_equalLimits)
         {
            Cdot = this.m_axis.x * (v2.x - v1.x) + this.m_axis.y * (v2.y - v1.y) + this.m_a2 * w2 - this.m_a1 * w1;
            impulse = this.m_motorMass * (this.m_motorSpeed - Cdot);
            oldImpulse = this.m_motorImpulse;
            maxImpulse = step.dt * this.m_maxMotorForce;
            this.m_motorImpulse = b2Math.Clamp(this.m_motorImpulse + impulse,-maxImpulse,maxImpulse);
            impulse = this.m_motorImpulse - oldImpulse;
            PX = impulse * this.m_axis.x;
            PY = impulse * this.m_axis.y;
            L1 = impulse * this.m_a1;
            L2 = impulse * this.m_a2;
            v1.x -= b2internal::m_invMassA * PX;
            v1.y -= b2internal::m_invMassA * PY;
            w1 -= b2internal::m_invIA * L1;
            v2.x += b2internal::m_invMassB * PX;
            v2.y += b2internal::m_invMassB * PY;
            w2 += b2internal::m_invIB * L2;
         }
         var Cdot1X:Number = this.m_perp.x * (v2.x - v1.x) + this.m_perp.y * (v2.y - v1.y) + this.m_s2 * w2 - this.m_s1 * w1;
         var Cdot1Y:Number = w2 - w1;
         if(this.m_enableLimit && this.m_limitState != b2internal::updateWearyVeil)
         {
            Cdot2 = this.m_axis.x * (v2.x - v1.x) + this.m_axis.y * (v2.y - v1.y) + this.m_a2 * w2 - this.m_a1 * w1;
            f1 = this.m_impulse.Copy();
            df = this.m_K.Solve33(new b2Vec3(),-Cdot1X,-Cdot1Y,-Cdot2);
            this.m_impulse.Add(df);
            if(this.m_limitState == b2internal::e_atLowerLimit)
            {
               this.m_impulse.z = b2Math.Max(this.m_impulse.z,0);
            }
            else if(this.m_limitState == b2internal::e_atUpperLimit)
            {
               this.m_impulse.z = b2Math.Min(this.m_impulse.z,0);
            }
            bX = -Cdot1X - (this.m_impulse.z - f1.z) * this.m_K.col3.x;
            bY = -Cdot1Y - (this.m_impulse.z - f1.z) * this.m_K.col3.y;
            f2r = this.m_K.Solve22(new b2Vec2(),bX,bY);
            f2r.x += f1.x;
            f2r.y += f1.y;
            this.m_impulse.x = f2r.x;
            this.m_impulse.y = f2r.y;
            df.x = this.m_impulse.x - f1.x;
            df.y = this.m_impulse.y - f1.y;
            df.z = this.m_impulse.z - f1.z;
            PX = df.x * this.m_perp.x + df.z * this.m_axis.x;
            PY = df.x * this.m_perp.y + df.z * this.m_axis.y;
            L1 = df.x * this.m_s1 + df.y + df.z * this.m_a1;
            L2 = df.x * this.m_s2 + df.y + df.z * this.m_a2;
            v1.x -= b2internal::m_invMassA * PX;
            v1.y -= b2internal::m_invMassA * PY;
            w1 -= b2internal::m_invIA * L1;
            v2.x += b2internal::m_invMassB * PX;
            v2.y += b2internal::m_invMassB * PY;
            w2 += b2internal::m_invIB * L2;
         }
         else
         {
            df2 = this.m_K.Solve22(new b2Vec2(),-Cdot1X,-Cdot1Y);
            this.m_impulse.x += df2.x;
            this.m_impulse.y += df2.y;
            PX = df2.x * this.m_perp.x;
            PY = df2.x * this.m_perp.y;
            L1 = df2.x * this.m_s1 + df2.y;
            L2 = df2.x * this.m_s2 + df2.y;
            v1.x -= b2internal::m_invMassA * PX;
            v1.y -= b2internal::m_invMassA * PY;
            w1 -= b2internal::m_invIA * L1;
            v2.x += b2internal::m_invMassB * PX;
            v2.y += b2internal::m_invMassB * PY;
            w2 += b2internal::m_invIB * L2;
         }
         bA.m_linearVelocity.SetV(v1);
         bA.m_angularVelocity = w1;
         bB.m_linearVelocity.SetV(v2);
         bB.m_angularVelocity = w2;
      }
      
      override b2internal function SolvePositionConstraints(baumgarte:Number) : Boolean
      {
         var limitC:Number = NaN;
         var oldLimitImpulse:Number = NaN;
         var tMat:b2Mat22 = null;
         var tX:Number = NaN;
         var m1:Number = NaN;
         var m2:Number = NaN;
         var i1:Number = NaN;
         var i2:Number = NaN;
         var translation:Number = NaN;
         var k11:Number = NaN;
         var k12:Number = NaN;
         var k22:Number = NaN;
         var impulse1:b2Vec2 = null;
         var bA:b2Body = b2internal::m_bodyA;
         var bB:b2Body = b2internal::m_bodyB;
         var c1:b2Vec2 = bA.m_sweep.c;
         var a1:Number = bA.m_sweep.a;
         var c2:b2Vec2 = bB.m_sweep.c;
         var a2:Number = bB.m_sweep.a;
         var linearError:Number = 0;
         var angularError:Number = 0;
         var active:Boolean = false;
         var C2:Number = 0;
         var R1:b2Mat22 = b2Mat22.FromAngle(a1);
         var R2:b2Mat22 = b2Mat22.FromAngle(a2);
         tMat = R1;
         var r1X:Number = this.m_localAnchor1.x - b2internal::m_localCenterA.x;
         var r1Y:Number = this.m_localAnchor1.y - b2internal::m_localCenterA.y;
         tX = tMat.col1.x * r1X + tMat.col2.x * r1Y;
         r1Y = tMat.col1.y * r1X + tMat.col2.y * r1Y;
         r1X = tX;
         tMat = R2;
         var r2X:Number = this.m_localAnchor2.x - b2internal::m_localCenterB.x;
         var r2Y:Number = this.m_localAnchor2.y - b2internal::m_localCenterB.y;
         tX = tMat.col1.x * r2X + tMat.col2.x * r2Y;
         r2Y = tMat.col1.y * r2X + tMat.col2.y * r2Y;
         r2X = tX;
         var dX:Number = c2.x + r2X - c1.x - r1X;
         var dY:Number = c2.y + r2Y - c1.y - r1Y;
         if(this.m_enableLimit)
         {
            this.m_axis = b2Math.MulMV(R1,this.m_localXAxis1);
            this.m_a1 = (dX + r1X) * this.m_axis.y - (dY + r1Y) * this.m_axis.x;
            this.m_a2 = r2X * this.m_axis.y - r2Y * this.m_axis.x;
            translation = this.m_axis.x * dX + this.m_axis.y * dY;
            if(b2Math.Abs(this.m_upperTranslation - this.m_lowerTranslation) < 2 * b2Settings.b2_linearSlop)
            {
               C2 = b2Math.Clamp(translation,-b2Settings.b2_maxLinearCorrection,b2Settings.b2_maxLinearCorrection);
               linearError = b2Math.Abs(translation);
               active = true;
            }
            else if(translation <= this.m_lowerTranslation)
            {
               C2 = b2Math.Clamp(translation - this.m_lowerTranslation + b2Settings.b2_linearSlop,-b2Settings.b2_maxLinearCorrection,0);
               linearError = this.m_lowerTranslation - translation;
               active = true;
            }
            else if(translation >= this.m_upperTranslation)
            {
               C2 = b2Math.Clamp(translation - this.m_upperTranslation + b2Settings.b2_linearSlop,0,b2Settings.b2_maxLinearCorrection);
               linearError = translation - this.m_upperTranslation;
               active = true;
            }
         }
         this.m_perp = b2Math.MulMV(R1,this.m_localYAxis1);
         this.m_s1 = (dX + r1X) * this.m_perp.y - (dY + r1Y) * this.m_perp.x;
         this.m_s2 = r2X * this.m_perp.y - r2Y * this.m_perp.x;
         var impulse:b2Vec3 = new b2Vec3();
         var C1X:Number = this.m_perp.x * dX + this.m_perp.y * dY;
         var C1Y:Number = a2 - a1 - this.m_refAngle;
         linearError = b2Math.Max(linearError,b2Math.Abs(C1X));
         angularError = b2Math.Abs(C1Y);
         if(active)
         {
            m1 = b2internal::m_invMassA;
            m2 = b2internal::m_invMassB;
            i1 = b2internal::m_invIA;
            i2 = b2internal::m_invIB;
            this.m_K.col1.x = m1 + m2 + i1 * this.m_s1 * this.m_s1 + i2 * this.m_s2 * this.m_s2;
            this.m_K.col1.y = i1 * this.m_s1 + i2 * this.m_s2;
            this.m_K.col1.z = i1 * this.m_s1 * this.m_a1 + i2 * this.m_s2 * this.m_a2;
            this.m_K.col2.x = this.m_K.col1.y;
            this.m_K.col2.y = i1 + i2;
            this.m_K.col2.z = i1 * this.m_a1 + i2 * this.m_a2;
            this.m_K.col3.x = this.m_K.col1.z;
            this.m_K.col3.y = this.m_K.col2.z;
            this.m_K.col3.z = m1 + m2 + i1 * this.m_a1 * this.m_a1 + i2 * this.m_a2 * this.m_a2;
            this.m_K.Solve33(impulse,-C1X,-C1Y,-C2);
         }
         else
         {
            m1 = b2internal::m_invMassA;
            m2 = b2internal::m_invMassB;
            i1 = b2internal::m_invIA;
            i2 = b2internal::m_invIB;
            k11 = m1 + m2 + i1 * this.m_s1 * this.m_s1 + i2 * this.m_s2 * this.m_s2;
            k12 = i1 * this.m_s1 + i2 * this.m_s2;
            k22 = i1 + i2;
            this.m_K.col1.Set(k11,k12,0);
            this.m_K.col2.Set(k12,k22,0);
            impulse1 = this.m_K.Solve22(new b2Vec2(),-C1X,-C1Y);
            impulse.x = impulse1.x;
            impulse.y = impulse1.y;
            impulse.z = 0;
         }
         var PX:Number = impulse.x * this.m_perp.x + impulse.z * this.m_axis.x;
         var PY:Number = impulse.x * this.m_perp.y + impulse.z * this.m_axis.y;
         var L1:Number = impulse.x * this.m_s1 + impulse.y + impulse.z * this.m_a1;
         var L2:Number = impulse.x * this.m_s2 + impulse.y + impulse.z * this.m_a2;
         c1.x -= b2internal::m_invMassA * PX;
         c1.y -= b2internal::m_invMassA * PY;
         a1 -= b2internal::m_invIA * L1;
         c2.x += b2internal::m_invMassB * PX;
         c2.y += b2internal::m_invMassB * PY;
         a2 += b2internal::m_invIB * L2;
         bA.m_sweep.a = a1;
         bB.m_sweep.a = a2;
         bA.striveWrathfulSnail0();
         bB.striveWrathfulSnail0();
         return linearError <= b2Settings.b2_linearSlop && angularError <= b2Settings.b2_angularSlop;
      }
   }
}
