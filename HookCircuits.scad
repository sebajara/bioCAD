// ****************  *************
// 

$fa=0.5; // default minimum facet angle
$fs=0.5; // default minimum facet size

// ==== big circuit
l1 = 81; // length 
w1 = 57; // width

// ==== small
//l1 = 20; // length 
//w1 = 41; // width

// ==== board paramters
h1 = 1; // height of the board
dw1 = 0.5; // delta to accomodate
dh1 = 0.2; // delta to accomodate
d2h1 = 4; // distance from the floor


// ======== container
l2 = l1; // length 
w2 = w1+5; // width
h2 = 10; // height

l3 = l1;
w3 = w1-4;
h3 = 8; 

w4 = 10; // for screwing stuff
h4 = 6; // 


difference(){
	// body
	union(){
	    cube([l2,w2,h2],center=true);
	    // body for screwing
	    for (a = [0,90]){
		mirror([a,0,0]){
		    translate([(l2-w4)/2,0,-(h2-h4)/2])
		    cube([w4,w2+2*w4,h4],center=true);
		}
	    }
	}
	// open space
	translate([0,0,(h2-h3)/2])
	cube([l3+1,w3,h3+1],center=true);
	
	// space for the board
	translate([0,0,-(h3+h1)/2-(h3-h2)+d2h1]){
	    cube([l1,w1+2*dw1,h1+2*dh1],center=true);
	    // actual board
	    #cube([l1,w1,h1],center=true);
	}
	for (a=[0,90]){
	    for (b=[0,90]){
		mirror([a,0,0])
		mirror([0,b,0]){
		    translate([(l2-w4)/2,(w2+w4)/2,-(h2-h4/3)/2-0.1])
		    cylinder(h=h4/3+0.1,r=3.5,center=true); 
		    translate([(l2-w4)/2,(w2+w4)/2,h4-(h2+h4/4)/2-0.1])
		    cylinder(h=h4/3+0.1,r=3.5,center=true); 
		    translate([(l2-w4)/2,(w2+w4)/2,-h2/2])
		    cylinder(h=2*h2,r=1.6,center=true); 
		}
	    }
	}
    }


*for (a=[0,90]){
    mirror([a,0,0])
    translate([l2/2+w4,0,0])
    cover();
}

*for (a=[0,90]){
    for (b=[0,90]){
	mirror([a,0,0])
	mirror([0,b,0]){
	    translate([l2/2+w4/4,w2/2+1.8*w4,0])
	    rotate([0,0,90])
	    MakeConnect();
	}
    }
}

module cover(){
    difference(){
	// body
	union(){
	    translate([-(w4-(h2-h3))/2,0,0])
	    cube([h2-h3,w2,h2],center=true);
	    
	    translate([0,0,-(h2-h4)/2])
	    cube([w4,w2+2*w4,h4],center=true);
	    
	}
	for (b=[0,90]){
	    mirror([0,b,0]){
		translate([0,(w2+w4)/2,-(h2-h4/3)/2-0.1])
		cylinder(h=h4/3+0.1,r=3.5,center=true); 
		translate([0,(w2+w4)/2,h4-(h2+h4/4)/2-0.1])
		cylinder(h=h4/3+0.1,r=3.5,center=true); 
		translate([0,(w2+w4)/2,-h2/2])
		cylinder(h=2*h2,r=1.6,center=true); 
	    }
	}
    }
}


module MakeConnect(){
    difference(){
	// base
	translate([0,0,-3*(h2-h4)/4])
	cube([w4,2*w4,h2-h4],center=true);
	for (b=[0,90]){
	    mirror([0,b,0]){
		translate([0,(w4)/2,-h2/2])
		cylinder(h=2*h2,r=1.6,center=true); 
		
		translate([0,(w4)/2,-3*(h2-h4)/4+(h2-h4)/4])
		cylinder(h=(h2-h4)/2+0.1,r=3.5,center=true); 
	    }
	}
    }
}
