package Box2D.Dynamics.Joints
{
   import Box2D.Common.Math.b2Vec2;
   import Box2D.Common.b2internal;
   import Box2D.Dynamics.b2Body;
   
   use namespace b2internal;
   
   public class b2WeldJointDef extends b2JointDef
   {
       
      
      public var localAnchorA:b2Vec2;
      
      public var localAnchorB:b2Vec2;
      
      public var referenceAngle:Number;
      
      public function b2WeldJointDef()
      {
         this.localAnchorA = new b2Vec2();
         this.localAnchorB = new b2Vec2();
         super();
         type = b2Joint.e_weldJoint;
         this.referenceAngle = 0;
      }
      
      public function Initialize(bA:b2Body, bB:b2Body, anchor:b2Vec2) : void
      {
         bodyA = bA;
         bodyB = bB;
         this.localAnchorA.SetV(bodyA.GetLocalPoint(anchor));
         this.localAnchorB.SetV(bodyB.GetLocalPoint(anchor));
         this.referenceAngle = bodyB.GetAngle() - bodyA.GetAngle();
      }
   }
}
