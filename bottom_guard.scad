//units are in mm
$fn=20;

render_mirror = 0;
render_camera = 1;

// Epsilon value
e = 0.01;

// Wall thickness
wall = .8;

// Outer border width
border = 6;

// mirror size
mirror_length = 129;
mirror_width = 79;

box_height = 8;

camera_length_outer = 23.19;
camera_length_inner = 18.98;
camera_length = (camera_length_inner + camera_length_inner)/2;

camera_width_outer = 14.61;
camera_width_inner = 10.54;
camera_width = (camera_width_inner + camera_width_inner)/2;

module screw_container() {
    difference() {
        cube(8, center=true);
        translate([0,0,-2])
            screw_hole();
    }
}
module screw_hole() {
    union() {
        translate([0,0,-e])
            cylinder(h=100, d=3.5);
        translate([0,0,3])
            cylinder(d1=3.5, d2=4, h=3.5);
    }
}

if(render_mirror == 1) {
    union() {
        difference() {
            // Bounding box
            cube([mirror_length + border*2, mirror_width + border*2, box_height]);

            // Bottom indents
            translate([border + e, border + e, 3])
                cube([mirror_length, mirror_width, box_height]);
        }
        translate([94,0,0])
            rotate([0, 90, 0])
                translate([-4,-4,]) 
                    screw_container();
    }
}

if(render_camera == 1) {
    difference() {
        translate([-border, -border, 0]) {
            union() {
                cube([camera_length+border*2, camera_width+border*2, 6]);
                translate([0,camera_width + border*2,0]) {
                    difference() {
                        cube([2,10,6]);
                        rotate([0, 90, 0]) {
                            translate([-3,7,-e])
                                cylinder(h=6, d=3);
                        }
                    }
                }
            }
        }
        translate([0,0,0])
            screw_hole();
        translate([camera_length,0,0])
            screw_hole();
        translate([0,camera_width,0])
            screw_hole();
        translate([camera_length,camera_width,0])
            screw_hole();
    }
}
