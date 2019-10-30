// **************** Cover slip adapter for stage I-3091 *************
// Sebastian Jaramillo-Riveri 2017


$fa=0.1; // default minimum facet angle is now 0.5
$fs=0.1; // default minimum facet size is now 0.5 mm

// ==== 
h1 = 4;  // height
l1 = 80; // width 
w1 = 32; // length 
d1 = 2.5;  // controls the inclination

// == coverslip
l2 = 51;
w2 = 25;
h2 = 0.15;

// == hole
l3 = 32.5;
w3 = 17.5;

// side adapters
l4 = l1-2*7;
w4 = 11;

// bottom adapter
h5 = 3;
w5 = w1+2*w4;
l5 = w5;

// objective
r5a = 10;
r5b = 20;

l6 = 10;
d6 = 18;

// Screws
r7 = 1.6;
d7 = 19;

// walls
l8 = 54;
w8 = 30;
h8 = 8;
d8 = 3;

// upper walls
h9 = 1;
r9 = 0.8;

translate([0,0,h1])
rotate([180,0,0])
difference(){
    // base for coverslip and corners to be hook into I-3091
    union(){
	translate([l1/2,-w1/2,h1])
	rotate([0,180,0])
	mypoly1(l1,w1,h1,d1);
	
	for (a=[0,90]){
	    mirror([0,a,0]){
		translate([l4/2,-w4/2+(w1)-(w1-w4)/2,h1])
		rotate([0,180,0])
		mypoly1(l4,w4,h1,d1);
	    }
	}
    }

    // space for coverslip
    translate([-l2/2,-w2/2,h1-h2])
    *cube([l2,w2,h2+0.1]);

    // hole on the top
    translate([-l3/2,-w3/2,-0.1])
    cube([l3,w3,h1+0.2]);
    
    for(a = [0,90]){
	for(b = [0,90]){
	    mirror([0,b,0]){
		mirror([a,0,0]){
		    screwhole(d7,r7);
		}
	    }
	}
    }
}

// top adapter
translate([0,-60,0])
rotate([0,180,0])
difference(){
    union(){
	translate([0,0,-2])
	roundedcube(w5,l5,2,10);
	translate([-l8/2,-w8/2,-h8-h9])
	cube([l8,w8,h8+h9]);
    }
    
    translate([-(l8-2*d8)/2,-(w8-2*d8)/2,-h8-h9-0.1])
    cube([l8-2*d8,w8-2*d8,h8+h9+0.2]);
    //d8 = 8;
    
    // Space for tubes... super hacky, need to fix this
    for (i = [0:4]){
	translate([-l8/2-1,-w8/2+2*5+i*4*1-d8/2-1,-h8-r9/2])
	rotate([0,90,0])
	cylinder(h=l8+2,r=r9);
	
	translate([-l8/2-1,-w8/2+2*5+i*4*1-d8/2-r9-1+0.2,-h8-h9-1])
	cube([2*(d8+1)+l8,2*r9-0.4,h9+1]);
    }
    for (i = [0:7]){
	d8 = 5;
	translate([-w8+2*d8+i*5*1+2,l8/2,-h8-r9/2])
	rotate([90,90,0])
	cylinder(h=l8+2,r=r9);
	
	translate([-w8+2*d8+i*5*1+2-r9+0.2,-l8/4-d8,-h8-h9-1])
	cube([2*r9-0.4,2*(d8+1)+w8,h9+1]);
	
	*translate([-w8+2*d8+i*5*1+1-r9+sqrt(2)*(d8+3)/2+0.3,-l8/4-1,-h8-h9-2.2])
	rotate([0,-45,0])
	cube([2*r9,2*(d8+1)+w8,h9+3]);
    }

    for(a = [0,90]){
	for(b = [0,90]){
	    mirror([0,b,0]){
		mirror([a,0,0]){
		    screwhole(d7,r7);
		}
	    }
	}
    }
}


// adapter at bottom
translate([0,60,-h1])
difference(){
    union(){
	difference(){
	    translate([0,0,h1])
	    roundedcube(w5,l5,h5,10);
	    translate([0,0,h1-0.1])
	    cylinder(h=h5+0.2,r1=r5a,r2=r5b);
	}
	for(a = [0,90]){
	    for(b = [0,90]){
		mirror([0,b,0]){
		    mirror([a,0,0]){
			supportcorner(l6,d6,h1,h5);
		    }
		}
	    }
	}
    }
    for(a = [0,90]){
	for(b = [0,90]){
	    mirror([0,b,0]){
		mirror([a,0,0]){
		    screwhole(d7,r7);
		}
	    }
	}
    }
}    

module screwhole(d,r1){
    translate([d,d,-100])
    cylinder(h=200,r=r1);
}
    
module mypoly1(l,w,h,d){
    points = [[0,0,0],[l,0,0],[l,w,0],[0,w,0],[d,0,h],[l-d,0,h],[l-d,w,h],[d,w,h]];
    faces = [[0,1,2,3],[4,5,1,0],[7,6,5,4],[5,6,2,1],[6,7,3,2],[7,4,0,3]];
    polyhedron(points,faces);
}

module roundedcube (lw,ll,lh,dc){
    union(){
	difference(){
	    translate([-lw/2,-ll/2,0]){
		cube([lw,ll,lh]);
	    }
	    for(a = [0,90]){
		for(b = [0,90]){
		    mirror([0,b,0]){
			mirror([a,0,0]){
			    translate([-lw/2-1,-ll/2-1,0-0.1]){
				cube([dc+1,dc+1,lh+0.2]);
			    }
			}
		    }
		}
	    }
	}
	for(a = [0,90]){
	    for(b = [0,90]){
		mirror([0,b,0]){
		    mirror([a,0,0]){
			translate([-lw/2+dc,-ll/2+dc,0]){
			    cylinder(h=lh,r=dc);
			}
		    }
		}
	    }
	}
    }
}

module supportcorner(l,d,h1,h2){
    translate([-d,-d,0])
    difference(){
	translate([0,0,h1])
	cube([l,l,h2]);
	translate([l+l/4,l/4,h1+h2])
	rotate([0,45,45])
	cube([h2*10,l*sqrt(2),l]);
	
    }
}