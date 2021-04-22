
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


finger_length   = 30;
finger_with     = 14;
finger_tickness = 4;
finger_extension_radios = 6;
tip_height      = 4;
tip_radius      = 4;
ring_open       = 6;
ring_height     = 2.5;
ring_width      = 4;
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
                               ring_diameter = 10,
                               translate_x = 0,
                               translate_y = 0
                               ) {
 
    translate([translate_x, translate_y, 0])                            
    union() {
    // Rectangular beam with cylindrical cut.
    difference(){
        // Bream
        cube([finger_length, finger_with, finger_tickness], center=true);
        // Cylindrical cut.
        translate([0, 0, ring_diameter ])
        rotate([0, -90, 0])
            cylinder(h = finger_length + 0.1, r1 = ring_diameter, r2 =        ring_diameter-1, center = true, $fn=100);
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
                    cylinder(h = cyl_height, r1 = finger_extension_radios, r2 = finger_extension_radios, center = true, $fn=100);
        
            translate([cyl_x, 0, finger_extension_radios*2+1.5])
                rotate([0, -45, 0]) 
                    cube([10, 12, 4], center = true );
        }
    
        translate([cyl_x + finger_extension_radios/1.4, 0, finger_extension_radios])
            scale(0.8)
            sphere(finger_extension_radios, $fn=100 );
    }
        
    // Inner cirlular shape on the rectangular beam.
    translate([-finger_length/2 - cyl_height/2, 0, 0])
    rotate([-90,0, 90])                               
    linear_extrude(height = cyl_height, center = true, convexity = 10, scale=.25)
        square([finger_with, finger_tickness], center=true);
                                   
    // Tip that contacts the guitar string.
    tip_x = cyl_x - tip_height / 2.0 - cyl_height / 2.0 ;
    translate([tip_x, 0, tip_radius ])
        rotate([0, -90, 0])
            cylinder(h = tip_height, r1 = tip_radius, r2 = tip_radius, center = true, $fn=100);
    
    // Ring finger bealt.
    difference() {
        // Ring.
        translate([6, 0, ring_diameter])
        rotate([0, -90, 0]) {                               
            difference() {
                rotate_extrude(convexity = 10, angle=360, $fn = 100)
                    translate([ring_diameter, 0, 0])
                        square([ring_height, ring_width]);
                translate([0, -6/2, -1])
                    cube([ring_diameter + ring_height, 6, 8] );
            };
        }
       // Cut in the ring. So it doesn't cut the bload flow.
       translate([0, -10/2, -5 -finger_tickness/2])
            cube([10,10,5]);
    }            

//       translate([0, -5/2, -5 -finger_tickness/2])
//            cube([10,5,5]);
 
    }
}


// Fila zero.

guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 8,
                        translate_x = 0,
                        translate_y = 0);

guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 9,
                        translate_x = 0,
                        translate_y = 25);

guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 9.5,
                        translate_x = 0,
                        translate_y = 25 * 2);

guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 10,
                        translate_x = 0,
                        translate_y = 26 * 3);


                        
// Fila menos 1.

guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 8,
                        translate_x = 40,
                        translate_y = 0);

guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter= 9,
                        translate_x = 40,
                        translate_y = 25);

guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 9.5,
                        translate_x = 40,
                        translate_y = 25 * 2);

                        
guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 10,
                        translate_x = 40,
                        translate_y = 26 * 3);



// Fila mais 1.                                               
guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 8,
                        translate_x = 40 * 2,
                        translate_y = 0);

guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 9,
                        translate_x = 40 * 2,
                        translate_y = 25);

guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 9.5,
                        translate_x = 40 * 2,
                        translate_y = 25 * 2);

                        
guitar_finger_extension(finger_length,
                        finger_with,
                        finger_extension_radios,
                        finger_tickness,
                        tip_height,
                        tip_radius,
                        ring_open,
                        ring_height,
                        ring_width,
                        ring_diameter = 10,
                        translate_x = 40 * 2,
                        translate_y = 26 * 3);

