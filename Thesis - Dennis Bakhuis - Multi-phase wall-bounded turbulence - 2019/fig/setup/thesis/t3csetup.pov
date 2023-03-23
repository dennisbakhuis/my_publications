#include "colors.inc"
#include "textures.inc"

#declare h = 927.0;   // height of tc
#declare hmid = 536.0; // height of mid cylinder
#declare gap = 5.0; // size of gap between cylinders
#declare ric = 200.0; // radius of ic
#declare roc = 279.4; // radius of oc
#declare roco = 305;  // radius of outside of oc
#declare cap = 20;    // thickness of caps
#declare tar = 10;   // thickness of arrows
#declare rar1 = 45;   // position between gap for arrow
#declare Random_1 = seed (5513);
#declare Random_2 = seed (5612);
#declare Random_3 = seed (5716);
#declare camh = -550;   // position between gap for arrow
#declare patchwidth = 92.7; // width of patch


global_settings { assumed_gamma 1.0 }

camera {
  location <0, 1500, -3200>
  look_at <0, -100, 0>
  angle 30
  //up    <0,1,0>
  //right  <1.5,0,0>
}

background { color White } // to make easy to see

light_source { <300, 0, -1000> White }

// middle cylinder
cylinder {
  <0, -hmid/2, 0>,     // Center of one end
  <0, hmid/2, 0>,     // Center of other end
  ric            // Radius
  //open           // Remove end caps
  texture {
          Chrome_Metal
  }
  finish {
    reflection 0.40
    ambient rgb <0.0,0.0,0.2>  //a pink ambient
  }
  //texture{ pigment{color Gray}
  //  finish{phong .5}}
}

// bot cylinder
cylinder {
  <0, -h/2, 0>,     // Center of one end
  <0, -hmid/2-gap, 0>,     // Center of other end
  ric            // Radius
  //open           // Remove end caps
  //texture{ pigment{color Gray}
  //  finish{phong .5}}
  texture {
          Chrome_Metal
  }
  finish {
    reflection 0.05
  }
}

// top cylinder
cylinder {
  <0, hmid/2+gap, 0>,     // Center of other end
  <0, h/2, 0>,     // Center of one end
  ric            // Radius
  open           // Remove end caps
  //texture{ pigment{color Gray}
  //  finish{phong .5}}
  texture {
          Chrome_Metal
  }
  finish {
    reflection 0.10
  }  
}

disc {
  <0, h/2, 0>,     // Center of one end
  <0, h/2+5, 0>,     // normal
  ric
  texture {
          Chrome_Metal
  }
  finish {
    diffuse .6
    reflection 0.0
  }   
}

// outer cylinder
difference {
    cylinder {
  		<0, -h/2, 0>,     // Center of one end
  		<0, h/2, 0>,     // Center of other end
  		roco
  		open
  	} 
    cylinder {
  		<0, -h/2, 0>,    // Center of one end
  		<0, h/2, 0>,     // Center of other end
  		roc 
  		open
  	}
    texture{ pigment{color Gray transmit .8 }
    //finish{phong .8}
    }
    //interior {ior 1}
}

// top outer cylinder cap
//cylinder {
//  <0, h/2, 0>,    // Center of one end
//  <0, h/2+cap, 0>,     // Center of other end
//  roco           // Radius
//  texture{ pigment{color Gray}finish{phong .8}}
//}

// bottom outer cylinder cap
difference{
  cylinder {
    <0, -h/2, 0>,    // Center of one end
    <0, -h/2-cap, 0>,     // Center of other end
    roco           // Radius
    texture{ pigment{color Gray}finish{phong .9}}
    //texture {
    //  Chrome_Metal
    //}
  }
  difference{
    cylinder {
      <0, -h/2+0.1, 0>,    // Center of one end
      <0, -h/2-cap-0.1, 0>,     // Center of other end
      roco-25          // Radius
    }
    cylinder {
      <0, -h/2+0.2, 0>,    // Center of one end
      <0, -h/2-cap-0.2, 0>,     // Center of other end
      ric-10          // Radius
    }
    box {
        <1000, camh , +60>,
        <-1000, camh + 120, 1000>
        //texture {pigment{color Black}}
        rotate <0, 35, 0>
    }
    box {
        <1000, camh , -60>,
        <-1000, camh + 120, -1000>
        //texture {pigment{color Black}}
        rotate <0, 35, 0>
    }
    box {
        <ric-20, camh , 1000>,
        <-1000, camh + 120, -1000>
        //texture {pigment{color Black}}
        rotate <0, 35, 0>
    }
  }
}

// particle
//sphere {
//	<0, 0, ric + (roc-ric)/2>,
//	4
//  texture {pigment {color White} finish {phong .8}}
//}

disc {
  <0, h/2, 0>,
  <0, h/2+5, 0>,
  roco,
  roc
  texture{ pigment{color Gray transmit .5 }}
}

// shaft
cylinder {
  <0, h/2, 0>,
  <0, h/2+30, 0>,
  20
  pigment{ Gray }
  //texture {
  //        Chrome_Metal
  //}
  finish {
    ambient .2
    diffuse .6
    specular .75
    roughness .001
    reflection {
       .5
    }
  } 
}

union {
  difference {
    torus {
      ric+rar1,
      tar
      pigment { color Blue }
    }
    box {
      <ric+rar1+tar, tar , 0>,
      <-ric-rar1-tar, -tar, +ric+rar1+tar>
      rotate <0, 35, 0>
    }
    box {
      <ric+rar1+tar, tar , 0>,
      <-ric-rar1-tar, -tar, +ric+rar1+tar>
      rotate <0, -35, 0>
    }
  }
  cone {
    <-ric-rar1, 0, 0>,
    25,
    <-ric-rar1, 0 , 50>,
    0
    rotate <0, -35, 0>
    pigment { color Blue }
  }
  rotate <0, -30, 0>
  translate <0, 150, 0>
  rotate <0, 0.07*360, 0>
  no_shadow
  no_reflection
}

// red arrow
union {
  difference {
    torus {
      roc+rar1,
      tar
      pigment { color Red }
    }
    box {
      <roc+rar1+tar, tar , 0>,
      <-roc-rar1-tar, -tar, +roc+rar1+tar>
      rotate <0, 40, 0>
    }
    box {
      <roc+rar1+tar, tar , 0>,
      <-roc-rar1-tar, -tar, +roc+rar1+tar>
      rotate <0, -40, 0>
    }
  }
  cone {
    <roc+rar1, 0, 0>,
    25,
    <roc+rar1, 0 , 50>,
    0
    rotate <0, 40, 0>
    pigment { color Red }
  }
  rotate <0, 30, 0>
  translate <0, -120, 0>
  rotate <0, 0.05*-360, 0>
  no_shadow
  no_reflection
}

// particles
//#for (Cntr, -100, 130, 30)
  //cylinder {
    //<ric+rar1, Cntr, 0>,
    //<ric+rar1, Cntr+0, 50>,
    //10
    //pigment { color Yellow}
    //rotate <0, -20 + int( 200*rand( Random_1) ) , 0>
  //}
//#end
//#for (Cntr, -h/2+20, -140, 30)
  //cylinder {
    //<ric+rar1, Cntr, 0>,
    //<ric+rar1, Cntr+0, 50>,
    //10
    //pigment { color Yellow}
    //rotate <0, -20 + int( 200*rand( Random_2) ) , 0>
  //}
//#end
//#for (Cntr, 170, h/2-40, 30)
  //cylinder {
    //<ric+rar1, Cntr, 0>,
    //<ric+rar1, Cntr+0, 50>,
    //10
    //pigment { color Yellow}
    //rotate <0, -20 + int( 200*rand( Random_3) ) , 0>
  //}
//#end

// Radius identation
union {
  cylinder {
    <0, h/2+40, 0>,
    <ric-45, h/2+40, 0>,
    5
  }
  cone {
    <ric-45, h/2+40, 0>,
    15,
    <ric, h/2+40, 0>,
    0
  }
  pigment { color Black}
  rotate <0, 35, 0>
}

union {
  cylinder {
    <0, h/2+40, 0>,
    <roc-45, h/2+40, 0>,
    5
  }
  cone {
    <roc-45, h/2+40, 0>,
    15,
    <roc, h/2+40, 0>,
    0
  }
  pigment { color Black}
  rotate <0, 150, 0>
}

// PIV laser
union {
  cylinder {
    <roc+200, 0, 0>,
    <roc+300, 0, 0>,
    45
    texture {
            Chrome_Metal
    }
    finish {
      reflection 0.01
      ambient Black
      //ambient rgb <0.3,0.1,0.1>  //a pink ambient
    }
  }
  cylinder {
    <roc+300, 0, 0>,
    <roc+500, 0, 0>,
    40
    texture {
            Chrome_Metal
    }
    finish {
      reflection 0.01
      ambient Black
      //ambient rgb <0.3,0.1,0.1>  //a pink ambient
    }
  }
  rotate <0, 35, 0>
  no_shadow
  no_reflection
}

// laser light
union {
  box {
    <roc+200, 2, 50>,
    <ric+10, -2, -50>
    //pigment { color Green transmit .8}
    pigment { color Green}
  }
  //cylinder {
    //<roc+200, -18, 0>,
    //<ric+40, 0, 0>,
    //2
    ////pigment { color Green transmit .8}
    //pigment { color Green}
    //no_shadow
  //}
  //cylinder {
  //  <roc+200, 0, 18>,
  //  <ric+40, 0, 0>,
  //  2
  //  //pigment { color Green transmit .8}
  //  pigment { color Blue}
  //}
  //cylinder {
  //  <roc+200, 0 -18>,
  //  <ric+40, 0, 0>,
  //  2
  //  //pigment { color Green transmit .8}
  //  pigment { color Blue}
  //}
  rotate <0, 35, 0>
  no_shadow
  no_reflection

}



//// Camera
union {
  cylinder {
    <roc+200, camh, 0>,
    <roc+300, camh, 0>,
    45
  texture {
          Chrome_Metal
  }
  finish {
    reflection 0.05
    ambient Black
    //ambient rgb <0.3,0.1,0.1>  //a pink ambient
  }
  //no_shadow
  }
  box {
    <roc+300, camh-50, -50>,
    <roc+500, camh+50, 50>
  texture {
          Chrome_Metal
  }
  finish {
    reflection 0.05
    ambient Black
    //ambient rgb <0.3,0.1,0.1>  //a pink ambient
  }
  }
  rotate <0, 35, 0>
  no_shadow
  no_reflection
}

//// Mirror

box {
  <-5, -60, -80>,
  <5, 60, 80>
  texture {
    Chrome_Metal
    pigment{color Gray}
    finish {
      reflection 0.4
    }
  }
  rotate <0, 0, 45>
  rotate <0, 35, 0>
  translate <roc-80, camh-80, 0>
  no_shadow
}

// Patched roughness
/* difference{ */
/* union{ */
/* #for (patchz, 0, h/2, 2*patchwidth) */
/*     cylinder { */
/*       <0, patchz-patchwidth/2, 0>, */
/*       <0, patchz+patchwidth/2, 0>, */  
/*       ric+0.1 */
/*       open */
/*       texture { */
/*               Spun_Brass */
/*               pigment{color Red} */
/*       } */
/*       finish { */
/*         reflection 0.10 */
/*       } */  
/*     } */
/*     cylinder { */
/*       <0, -1 * patchz - patchwidth / 2, 0>, */
/*       <0, -1 * patchz + patchwidth / 2, 0>, */  
/*       ric+0.1 */
/*       open */
/*       texture { */
/*               Spun_Brass */
/*               pigment{color Red} */
/*       } */
/*       finish { */
/*         reflection 0.10 */
/*       } */  
/*     } */
/* #end */
/* } */
/* } */

// LDA laser
union {
  cylinder {
    <roc+200, 0, 0>,
    <roc+300, 0, 0>,
    45
    texture {
            Chrome_Metal
    }
    finish {
      reflection 0.01
      ambient Black
      //ambient rgb <0.3,0.1,0.1>  //a pink ambient
    }
  }
  cylinder {
    <roc+300, 0, 0>,
    <roc+500, 0, 0>,
    40
    texture {
            Chrome_Metal
    }
    finish {
      reflection 0.01
      ambient Black
      //ambient rgb <0.3,0.1,0.1>  //a pink ambient
    }
  }
  rotate <0, 140, 0>
  no_shadow
  no_reflection
}

// laser light
union {
  cylinder {
    <roc+200, 18, 0>,
    <ric+40, 0, 0>,
    2
    //pigment { color Green transmit .8}
    pigment { color Green}
    no_shadow
  }
  cylinder {
    <roc+200, -18, 0>,
    <ric+40, 0, 0>,
    2
    //pigment { color Green transmit .8}
    pigment { color Green}
    no_shadow
  }
  rotate <0, 140, 0>
  no_shadow
  no_reflection

}
