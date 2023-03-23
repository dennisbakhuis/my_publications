#include "colors.inc"
#include "textures.inc"

global_settings { assumed_gamma 1.0 }

camera {
  location <70, -80, -200>
  look_at 0
  angle 30
  //up    <0,1,0>
  //right  <1.5,0,0>
}

background { color White } // to make easy to see

light_source { <300, 0, -1000> White }

cylinder {
  <-40, 0 0>,
  <40, 0, 0>,
  10
  //pigment { color Green transmit .8}
  pigment { Gray }
  //finish {
    //ambient .2
    //diffuse .6
    //specular .75
    //roughness .001
    //reflection {
       //.5
    //}
  //}
  rotate <-10, -20 , 0>
}
