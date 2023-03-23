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
#declare Random_1 = seed (5601);
#declare Random_2 = seed (5611);
#declare Random_3 = seed (5616);

global_settings { assumed_gamma 1.0 }

camera {
  location <0, 1500, -3000>
  look_at 0
  angle 27
  //up    <0,1,0>
  //right  <1.5,0,0>
}

background { color White } // to make the torus easy to see

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
    reflection 0.10
    ambient rgb <0.3,0.1,0.1>  //a pink ambient
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
cylinder {
  <0, -h/2, 0>,    // Center of one end
  <0, -h/2-cap, 0>,     // Center of other end
  roco           // Radius
  texture{ pigment{color Gray}finish{phong .9}}
  //texture {
  //  Chrome_Metal
  //}
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

// Blue arrow
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
  no_shadow
  rotate <0, clock*360, 0>
}

//// red arrow
//union {
//  difference {
//    torus {
//      roc+rar1,
//      tar
//      pigment { color Red }
//    }
//    box {
//      <roc+rar1+tar, tar , 0>,
//      <-roc-rar1-tar, -tar, +roc+rar1+tar>
//      rotate <0, 40, 0>
//    }
//    box {
//      <roc+rar1+tar, tar , 0>,
//      <-roc-rar1-tar, -tar, +roc+rar1+tar>
//      rotate <0, -40, 0>
//    }
//  }
//  cone {
//    <roc+rar1, 0, 0>,
//    25,
//    <roc+rar1, 0 , 50>,
//    0
//    rotate <0, 40, 0>
//    pigment { color Red }
//  }
//  rotate <0, 30, 0>
//  translate <0, -120, 0>
//  no_shadow
//  rotate <0, clock*-360, 0>
//}

// particles
//#for (Cntr, -100, 130, 30)
//  sphere {
//    <ric+rar1, Cntr, 0>,
//    20
//    pigment { color Yellow}
//    rotate <0, -20 + int( 200*rand( Random_1) ) , 0>
//  }
//#end
//#for (Cntr, -h/2+20, -140, 30)
//  sphere {
//    <ric+rar1, Cntr, 0>,
//    20
//    pigment { color Yellow}
//    rotate <0, -20 + int( 200*rand( Random_2) ) , 0>
//  }
//#end
//#for (Cntr, 170, h/2-40, 30)
//  sphere {
//    <ric+rar1, Cntr, 0>,
//    20
//    pigment { color Yellow}
//    rotate <0, -20 + int( 200*rand( Random_3) ) , 0>
//  }
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

// water
difference {
    cylinder {
      <0, -h/2+0.01, 0>,     // Center of one end
      <0, 0, 0>,     // Center of other end
      roc-0.01
      open
    } 
    cylinder {
      <0, -h/2+0.01, 0>,    // Center of one end
      <0, 0, 0>,     // Center of other end
      ric+0.01 
      open
    }
    texture{ pigment{color Blue transmit .8 }
    }
}
//// oil
//difference {
//    cylinder {
//      <0, 0, 0>,     // Center of one end
//      <0, h/2-0.01, 0>,     // Center of other end
//      roc-0.01
//      open
//    } 
//    cylinder {
//      <0, 0, 0>,    // Center of one end
//      <0, h/2-0.01, 0>,     // Center of other end
//      ric+0.01 
//      open
//    }
//    texture{ pigment{color Yellow transmit .8 }
//    }
//}

// LDA laser
//union {
//  cylinder {
//    <roc+200, 0, 0>,
//    <roc+300, 0, 0>,
//    45
//    pigment { color Black}
//    finish {
//      phong 0.8
//    }
//    no_shadow
//  }
//  cylinder {
//    <roc+300, 0, 0>,
//    <roc+500, 0, 0>,
//    40
//    pigment { color Black}
//    finish {
//      phong 0.9
//    } 
//  }
//  rotate <0, 35, 0>
//}

// laser light
//union {
//  cylinder {
//    <roc+200, 18, 0>,
//    <ric+40, 0, 0>,
//    2
//    //pigment { color Green transmit .8}
//    pigment { color Green}
//    no_shadow
//  }
//  cylinder {
//    <roc+200, -18, 0>,
//    <ric+40, 0, 0>,
//    2
//    //pigment { color Green transmit .8}
//    pigment { color Green}
//    no_shadow
//  }
//  //cylinder {
//  //  <roc+200, 0, 18>,
//  //  <ric+40, 0, 0>,
//  //  2
//  //  //pigment { color Green transmit .8}
//  //  pigment { color Blue}
//  //}
//  //cylinder {
//  //  <roc+200, 0 -18>,
//  //  <ric+40, 0, 0>,
//  //  2
//  //  //pigment { color Green transmit .8}
//  //  pigment { color Blue}
//  //}
//  rotate <0, 35, 0>
//}