// ****************  *************
// 

$fa=0.5; // default minimum facet angle
$fs=0.5; // default minimum facet size

nvalves = 2; // number of valves
vw   = 13; // width for each one
//vw2  = 12.8; // width of square on front
vwd = 5; // distance in bewteen
vr = vw/2; 

vcr = 2/2; // valve cylinder radius
vcd = 7.7; // distance bewteen them

h1 = 5; // height of walls

// == Base
l1 = 20; // length
w1 = nvalves*vw+(nvalves+1)*vwd; // width

w2 = 10; // for screwing stuff

MakeArray(1);
translate([l1+vwd,0,0])
MakeArray(0);

translate([0,(w1+4*w2)/2,0]){
    translate([l1+vwd,0,0])
    rotate([0,0,90])
    MakeConnect();
    rotate([0,0,90])
    MakeConnect();
}
module MakeConnect(){
    difference(){
	// base
	cube([l1/2,2*w2,h1],center=true);
	
	for (a=[0,90]){
	    mirror([0,a,0]){
		translate([0,w2/2,0]){
		    translate([0,0,h1/2])
		    cylinder(h=h1,r=3.5,center=true); 
		    translate([0,0,-1])
		    cylinder(h=h1+2,r=1.6,center=true); 
		}
	    }
	}
    }
}


module MakeArray(textp){
union() {
    difference(){
	union(){
	    // base
	    cube([l1,w1+2*w2,h1],center=true);
	    // walls
	    for (a=[0,90]){
		mirror([a,0,0])
		translate([l1/2-h1/2,0,h1-(h1-vr)/2])
		cube([h1,w1,vr],center=true);
	    }
	    for (a=[0,90]){
		mirror([0,a,0])
		translate([0,w1/2-h1/2,h1-(h1-vr)/2])
		cube([l1,h1,vr],center=true);
	    }
	}
	// cylinder difference for valves
	for (i = [0:nvalves-1]){
	    translate([0,i*2*vr+(i-1)*vwd,0])
	    translate([0,-w1/2+vr+2*vwd,0])
	    translate([-(l1+1)/2,0,h1-(h1-vr)/2+vr/2])
	    rotate([0,90,0])
	    cylinder(h=l1+1,r=vr); 
	}
	// square difference for one side
	for (i = [0:nvalves-1]){
	    translate([0,i*vw+(i-1)*vwd,0])
	    translate([0,-w1/2+vw+2*vwd,0])
	    translate([-(l1+1)/2+h1/2,-vw/2,h1-(h1-vr)/2])
	    cube([h1+2,vw,vr],center=true);
	}
	// numbers of valves
	if(textp==1){
	for (a=[0,90]){
	    mirror([a,0,0])
	    for (i = [0:nvalves-1]){
		translate([0,(i)*vw+(i)*vwd,0])
		translate([-l1/2+0.5,-w1/2+vwd+vw/2,0])
		rotate([90,0,270])
		linear_extrude(height=1){
		    text(str(i+1),size=3,valign="center",halign="center");
		}
	    }
	}
	}
	// holes on corners
	for (a=[0,90]){
	    for (b=[0,90]){
		mirror([a,0,0])mirror([0,b,0])
		translate([l1/2-h1/2,w1/2-h1/2,2])
		cylinder(h=vr+3*vwd,r=1.25,center=true); 
	    }
	}
	// holes for screws
	for (a=[0,90]){
	    mirror([0,a,0]){
		for (b = [0,180]){
		    rotate([0,b,0]){
			translate([0,(w1+w2)/2,0]){
			    translate([l1/4,0,h1/2])
			    cylinder(h=h1,r=3.5,center=true); 
			    translate([l1/4,0,-1])
			    cylinder(h=h1+2,r=1.6,center=true); 
			}
		    }
		}
	    }
	}
    }
    // cylinder for adapters
    for (i = [0:nvalves-1]){
	translate([0,i*2*vr+(i-1)*vwd,0]){
	    translate([0,-w1/2+vr+2*vwd,0]){
		translate([-(l1)/2+h1/2,0,h1/2]){
		    translate([0,vcd/2,0])
		    cylinder(h=vr,r=vcr); 
		    translate([0,-vcd/2,0])
		    cylinder(h=vr,r=vcr); 
		}
	    }
	}
    }
}
}