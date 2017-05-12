// **************** Spin Coater Adapter for cover slips *************
// This object is a remake of a design made by Jean-Baptiste Lugagne

$fa=0.5; // default minimum facet angle
$fs=0.5; // default minimum facet size

// ================ Spin Coater Adapter (fit the cilinder that spins) ==========

// == Internal cylinder
r1 = 45.5/2; // radius
h1 = 10; // height

// == Outer cylinder
r2 = 55/2; // radius
h2 = h1+5; // height

// == Screws holes (I made them thinking on M3)
// Dimensions a bit bigger so that they fit OK.
r3 = 3.5; // head radius 
h3 = 3; // head height
d3 = r1/2; // Distance from center to position holes
r6 = 1.6; // screw radius
d6 = d3; // not used

// ================ Adapter Arm ===============

// == Arm 
h4 = 10; // height
l4 = 180; // length
w4 = 70; // width

// == Rectangle hole for putting the chip adapters (dock)
//    This is meant to be centered on the arm
h5 = 5; // height (from top of arm height)
l5 = 160; // length
w5 = 50; // width

// == Slider lock
h7 = h5; // height (same as the hole)
w7 = 6; // top width 
l7 = 30; // length
d7 = 5; // bottom width
// This are some points to make the polygons
points7 = [[0,0,0],[l7,0,0],[l7,w7-d7,0],[0,w7-d7,0],[0,0,h7],[l7,0,h7],[l7,w7,h7],[0,w7,h7]];
faces7 = [[0,1,2,3],[4,5,1,0],[7,6,5,4],[5,6,2,1],[6,7,3,2],[7,4,0,3]];
points8 = [[0,0,0],[w5,0,0],[w5,d7,0],[0,d7,0],[0,0,h7],[w5,0,h7]];
faces8 = [[0,1,2,3],[4,5,1,0],[5,1,2],[4,3,2,5],[4,0,3]];

// == Rounding arm corners
dc = 20; // distance from corner that you want to round

// ================ Chip adapter ===============
// From bottom to top: base -> neck -> upper base -> upper neck -> angled body

// == Base 
h9 = h5-0.5; // height, close to dock height
w9 = w5-2*(w7-d7)-0.5; // width, close to dock width minus side locks
l9 = 35; // length
d9 = 5; // controls the inclination
// polygon points and faces
points9 = [[0,0,0],[l9,0,0],[l9,w9,0],[0,w9,0],[d9,d9,h9],[l9-d9,d9,h9],[l9-d9,w9-d9,h9],[d9,w9-d9,h9]];
faces9 = [[0,1,2,3],[4,5,1,0],[7,6,5,4],[5,6,2,1],[6,7,3,2],[7,4,0,3]];

// == Neck (conects base with the rest)
l10a = l9-2*d9; // do not touch
w10a = w9-2*d9; // do not touch

// == Upper base (conects neck with the uper body)
//    need to be bigger than the chip
l10b = 35; // length
w10b = 60; // width
h10  = 5; // height
// polygon points and faces
dl10 = (l10b-l10a)/2; // do not touch
dw10 = (w10b-w10a)/2; // do not touch
points10 = [[0,0,0],[l10a,0,0],[l10a,w10a,0],[0,w10a,0],[-dl10,-dw10,h10],[l10a+dl10,-dw10,h10],[l10a+dl10,w10a+dw10,h10],[-dl10,w10a+dw10,h10]];
faces10 = [[0,1,2,3],[4,5,1,0],[7,6,5,4],[5,6,2,1],[6,7,3,2],[7,4,0,3]];

// == Upper neck
h12 = 5; // height

// == angled body
angle = 25; // angle, in deg
w11 = w10b; // do not touch
l11 = l10b; // do not touch
h11 = tan(angle)*l11; // do not touch

// == Chip dock (to be removed from angled body)
// This body will be rotated from the edge of the "Upper neck"
h13 = h12+1; // height (needs to be bigger than h12)
w13 = 50; // bottom width (relates to the length of the cover slip)
l13 = 30; // length (relates to the width of the cover slip)
d13 = 5; // Delta for top width (the bigger the more inclined it will be)
points13 = [[0,0,0],[l13,0,0],[l13,w13,0],[0,w13,0],[0,d13,h13],[l13-d13,d13,h13],[l13-d13,w13-d13,h13],[0,w13-d13,h13]];

// == Rounding distance for edges
dc2 = 5; // do not recommend to touch

// ================ Spin Coater Adapter 
translate([0,0,h2])
rotate([0,180,0])
difference(){	
    // Outer cylinder
    cylinder(h=h2,r=r2); 
    // Internal cylinder
    translate([0,0,-1])
    cylinder(h=h1+1,r=r1); 
    // Screws holes
    for(a = [0,45,-45]){
	for(b = [0,45,-45]){
	    mirror([a,b,0]){
		mirror([0,0,0]){
		    // Screw
		    translate([d3,0,h1-1])
		    cylinder(h=h3+1,r=r3);
		    // Head
		    translate([d3,0,h1+h3-1])
		    cylinder(h=h2,r=r6);
		}
	    }
	}
    }
}

// ================ Adapter arms

translate([w4+2,0,-h2]) 
difference(){
    union(){
	difference(){	
	    union(){
		difference(){
		// Arm 
		translate([-w4/2,-l4/2,h2]){
		    cube([w4,l4,h4]);
		}
		// Remove corners
		for(a = [0,90]){
		    for(b = [0,90]){
			mirror([0,b,0]){
			    mirror([a,0,0]){
				translate([-w4/2-1,-l4/2-1,h2-0.1]){
				    cube([dc+1,dc+1,h4+0.2]);
				}
			    }
			}
		    }
		}
	    }
	    // Add cylinders instead of edges
	    for(a = [0,90]){
		for(b = [0,90]){
		    mirror([0,b,0]){
			mirror([a,0,0]){
			    translate([-w4/2+dc,-l4/2+dc,h2]){
				cylinder(h=h4,r=dc);
			    }
			}
		    }
		}
	    }
	}
	// Dock for chip adapter
	translate([-w5/2,-l5/2,h2+h4-h5]){
	    cube([w5,l5,h5+1]);
	}
	// Lock for chip adapter (ends)
	for(b = [0,90]){
	    mirror([0,b,0]){
		translate([-w5/2,l5/2-0.1,h2+h4-h7])
		polyhedron(points8,faces8);
	    }
	}
	// Screw holes
	for(a = [0,45,-45]){
	    for(b = [0,45,-45]){
		mirror([a,b,0]){
		    mirror([0,0,0]){
			// Head
			translate([d3,0,h2+h4-h5-h3])
			cylinder(h=h3+1,r=r3);
			// Screws
			translate([d3,0,h1+h3-1])
			cylinder(h=h2,r=r6);
		    }
		}
	    }
	}
    }
    // Lock for chip adapter (sides)
    for(a = [0,90]){
	for(b = [0,90]){
	    mirror([0,b,0]){
		mirror([a,0,0]){
		    translate([w5/2,l5/2-l7,h2+h4-h7])
		    rotate([0,0,90])
		    polyhedron(points7,faces7);
		}
	    }
	}
    }
}
// TO BE REMOVED
//translate([-50,-25,h2-1])
//#cube([100,200,30]);        
}



// ================ Chip adapters

for(b = [0,90]){
    mirror([0,b,0]){
	translate([0,0,-(h2+h4-h5)])
	chipadapter();
    }
}


// Just to make the call easier
module chipadapter (){
    difference(){
	union(){
	    // Base
	    translate([w9/2,l5/2-l9-1,h2+h4-h5])
	    rotate([0,0,90])
	    polyhedron(points9,faces9);
	    // Neck
	    translate([-w10a/2,l5/2-(l9-d9)-1,h2+h4-h5+h9])
	    cube([w10a,l10a,2]);
	    // Upper base
	    translate([w10a/2,l5/2-(l9-d9)-1,h2+h4-h5+h9+2])
	    rotate([0,0,90])
	    polyhedron(points10,faces10);
	    // Upper neck
	    translate([-w10b/2,l5/2-(l9)-1,h2+h4-h5+h9+2+h10])
	    cube([w10b,l10b,h12]);
	    // Angled body
	    translate([-w10b/2,l5/2-l11-1,h2+h4-h5+h9+2+h10+h12])
	    cube([w11,l11,h11]);
	}
	// remove ceiling 
	translate([-w10b/2-1,l5/2-l11-1,h2+h4-h5+h9+2+h10+h12])
	rotate([angle,0,0])
	cube([w11+2,l11*2,h11]);

	// chip dock
	translate([w13/2,l5/2-(l9)-1,h2+h4-h5+h9+2+h10])
	rotate([0,-angle,90])
	polyhedron(points13,faces9);
	
	// Sharpen the corners... is a bit hacky and may not work depending on dimenstions
	// I think could be removed if problematic
	for(b = [0,90]){
	    mirror([b,0,0]){
		diffcorners10();
	    }
	}
    }
}

module diffcorners10 (){
    // The idea is to make an object that we can subtract to the adapter for each corner
    f = h11+h12+10;
    translate([-w10b/2+dc2,l10b+l5/2-1-(l9)-dc2,h2+h4-h5+h9+2+h10-5]){
	difference(){
	    cylinder(h=h11+h12+5,r=dc2+5);
	    cylinder(h=h11+h12+5,r=dc2);
	    // Can't garantee that would work every time, a bit of an heuristic
	    translate([-sin(45)*f/2,sin(45)*(f/2)-dc2,0])
	    rotate([0,0,45])
	    translate([-2*dc2,-2*dc,0])
	    cube([f,f,f]);
	}
    }
}