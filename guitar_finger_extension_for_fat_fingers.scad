
// Name: Guitar finger extension for fat fingers.
// Author: João Nuno Carvalho
// Date: 2021.04.17
// License: MIT Open Source
// Description: This is my solution to the problem that persons with big
//              hand or fat fingers have, there fingers don't fit in the
//              space between strings in a electric guitar 42 mm to 43 mm
//              of nut for 6 strings.
//              This ring is for the 1 , 2 or 3 fingers of the left hand,
//              the neck hand. For left persons is for the right hand
//              All the measures can be parameterized.
//              The unit fo the drawing is 1mm.


// $fn = 12;
$fn = 40; 
// $fn = 100;

finger_length   = 30;
finger_with     = 14;
finger_tickness = 4;
finger_extension_radios = 6;
tip_height      = 4;
tip_radius      = 4;
ring_open       = 6;
ring_height     = 2.5;
ring_width      = 6; // 5; //4;
ring_diameter   = 10;

module guitar_finger_extension(finger_length = 30, 
                               finger_with   = 14,
                               finger_extension_radios = 6,
                               finger_tickness = 4,
                               tip_height = 4,
                               tip_radius = 4,
                               ring_open = 6,
                               ring_height = 2.5,
                               ring_width = 4,
                               ring_diameter = 10) {
    
    // Rectangular beam with cylindrical cut.
    
   difference(){
      // offset_3d(-1) offset_3d(1) // interior fillets  
      union(){  
        // Bream
        // offset_3d(0.5) offset_3d(-0.5) // exterior fillets
        
            minkowski(){
            cube([finger_length, finger_with, finger_tickness], center=true);
            sphere(0.1);
            //rotate([0, -90, 0])
            //cylinder(h = 0.001, r1=0.1, r2=0.1, center = true);
          }

        // Ring finger bealt.
        //offset_3d(0.5) offset_3d(-0.5) // exterior fillets
        minkowski(){
            difference() {
                // Ring.
                translate([6, 0, ring_diameter])
                rotate([0, -90, 0]) {                               
                    difference() {
                        rotate_extrude(convexity = 10, angle=360) //, $fn = 50)
                            translate([ring_diameter, 0, 0])
                                //minkowski(){
                                    square([ring_height, ring_width]);
                                //    circle(r=.15);
                                //}
                        translate([0, -6/2, -1])
                            cube([ring_diameter + ring_height + 0.15 + 0.001, 6, 8] );
                    };
                }
               // Cut in the ring. So it doesn't cut the bload flow.
               translate([0 - 0.15 - 0.001, -10/2, -5 -finger_tickness/2])
                    cube([10,10,5]);
            }
            sphere(r=0.1);
            }
            

//       translate([0, -5/2, -5 -finger_tickness/2])
//            cube([10,5,5]);
    
        }
        
        // Cylindrical cut.
        translate([0, 0, ring_diameter ])
        rotate([0, -90, 0])
            cylinder(h = finger_length + 1 + 0.1, r1 = ring_diameter, r2 =        ring_diameter-1, center = true); // , $fn=50);
    }


    // Circular finger platform.
    cyl_height = 3;
    cyl_x = -(finger_length / 2.0) - (cyl_height / 2.0);
    
    // Spherical cut on the finger platform, for better centering force and confort.
    difference(){
        // circular finger platform with slant cut for better performance in adjacent string mufling (not ringing).
        difference(){
            translate([cyl_x, 0, finger_extension_radios ])
                rotate([0, -90, 0])
                    cylinder(h = cyl_height, r1 = finger_extension_radios, r2 = finger_extension_radios, center = true); //, $fn=50);
        
            translate([cyl_x, 0, finger_extension_radios*2+1.5])
                rotate([0, -45, 0]) 
                    cube([10, 12, 4], center = true );
        }
    
        translate([cyl_x + finger_extension_radios/1.4, 0, finger_extension_radios])
            scale(0.8)
            sphere(finger_extension_radios); //, $fn=50 );
    }
    
    // Reinforcement of the circular finger platform in the joint with the vertical beam.
    translate([cyl_x + 1.3, 0, finger_tickness/2]) //finger_extension_radios*2+1.5 ])
                rotate([0, 45, 0]) 
                    cube([3, 12 -1.5, 1.6], center = true );
        
    // Inner circular shape on the rectangular beam.
    translate([-finger_length/2 - cyl_height/2, 0, 0])
    rotate([-90,0, 90])                               
    linear_extrude(height = cyl_height, center = true, convexity = 10, scale=0.25)
        square([finger_with, finger_tickness], center=true);
                                   
    // Tip that contacts the guitar string.
    tip_x = cyl_x - tip_height / 2.0 - cyl_height / 2.0 ;
    translate([tip_x, 0, tip_radius ])
        rotate([0, -90, 0])
            cylinder(h = tip_height, r1 = tip_radius, r2 = tip_radius, center = true); //, $fn=50);

}


module offset_3d(r=1, size=1e12) {
     // n = $fn==undef ? 12: $fn;
     n = 10;
     if(r==0) children();
     else 
         if( r>0 )
             minkowski(){
                 children();
                 sphere(r, $fn=n);
             }
         else {
             size2 = size*[1,1,1];
             size1 = size2*0.99;
             difference(){
                 cube(size2, center=true);
                 minkowski(){
                     difference(){
                         cube(size1, center=true);
                         children();
                     }
                     sphere(-r, $fn=n);
                 }
             }
         }
}



//offset_3d(2) offset_3d(-2) // exterior fillets
//    offset_3d(-4) offset_3d(4) // interior fillets
        guitar_finger_extension(finger_length,
                                finger_with,
                                finger_extension_radios,
                                finger_tickness,
                                tip_height,
                                tip_radius,
                                ring_open,
                                ring_height,
                                ring_width,
                                ring_diameter);     
     


