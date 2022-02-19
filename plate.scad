$fn=25;

plate_thick=5 - 0.2;
plate_thin=1.5;

//array of positions
//k = keyswitch
//f = fader. Can be anywhere in row 1
//e = encoder knob. Can be in columns 1 and 3, but only one *per row* 1-4 at a time.
//o = OLED. Goes in row 5, column 2+3.
//b = blank panel
matrix = [
    //row 1. Overrides keys in other rows when fader defined
    k,k,k,
    //row 2
    k,k,k,
    //row 3
    k,k,k,
    //row 4
    k,k,k,
    //row 5 (top section)
    e,b,b,
    ];

//pitch
key_unit=19.050;

for ( i=[0:1:3-1]) {
    for ( j=[0:1:5]) {
        if(j<4){
        translate([i*key_unit,j*key_unit,0])
        keyswitch_plate();
        }
        else if(j>4){
            translate([i*key_unit,(j-1)*key_unit+key_unit/4,0]){
//            keyswitch_plate();
            blank_plate();
            }   
        }
        else if(j==4)
            if(i==0){
            translate([0,key_unit*j,0]){
            separator();
            }
        }
    }
}

module keyswitch_plate(){
difference(){
    linear_extrude(plate_thick) difference(){
        square(key_unit);
        union(){
            translate([(key_unit-14)/2,(key_unit-14)/2]) square(14);
                translate([(key_unit-15.6)/2,(key_unit-3.1)/2-(5.8+3.1)/2]) square([15.6,3.1]);
                translate([(key_unit-15.6)/2,(key_unit-3.1)/2+(5.8+3.1)/2]) square([15.6,3.1]);
        }
    }
    translate([(key_unit-16)/2,(key_unit-16)/2,0]){linear_extrude(plate_thick-plate_thin){
    square(16);
    }
    }
}
}

module blank_plate(){
        linear_extrude(plate_thick){
    square(key_unit);
    }
}

module separator(){
    cube([3*key_unit,1/4*key_unit,plate_thick]);
}
