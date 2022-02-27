// include <NopSCADlib/core.scad>
include <NopSCADlib/lib.scad>

$fn=24;

plate_thick=5 - 0.2;
plate_thin=1.5;

//pitch
key_unit=19.050;

overall_width=60;
overall_length=102.8625;

//array of positions
//0 = blank panel
//1 = keyswitch
//2 = encoder knob.
// Encoders can be in columns 1 and 3, but each row 1-4 can only have one at a time (per row).
// One exception: encoder cannot go in row 5 column 3.
//3 = fader. Can be anywhere in row 1
//4 = OLED. Goes in row 5, column 2+3.
//5 = empty. Tenporary solution
layout_matrix = [
 //row 1.
 [1,1,1],
 //row 2
 [1,1,1],
 //row 3
 [1,1,1],
 //row 4
 [1,1,2],
 //separator
 [0,0,0],
 //row 5 (top section)
 [1,1,1],
 ];

x_center = (key_unit*len(layout_matrix[0])-overall_width)/2;
y_center = (key_unit*(len(layout_matrix)-3/4)-overall_length)/2;

main();

// j = y
// i = x
module main(){
 intersection(){
 difference(){
 union(){
  for ( i=[0:len(layout_matrix[0])-1]) {
   for ( j=[0:len(layout_matrix)-1]) {
    if(j<4){
     translate([i*key_unit,j*key_unit,0])
     // middle
     if(i==1){
      if(j>0){
       if(layout_matrix[0][i]==3){
        plate_gen(5);
       }
       else plate_gen(layout_matrix[j][i]);
       }
       else if(layout_matrix[j][i]==2){
        plate_gen(0);
       }
      else plate_gen(layout_matrix[j][i]);
     }
     else if(j==0){
      if(layout_matrix[j][i]==2){
       plate_gen(layout_matrix[j][i]);
      }
     else if (i==1) plate_gen(0);
     else plate_gen(layout_matrix[j][i]);
     }
     else if(layout_matrix[0][i]==3){
      plate_gen(5);
     }
     else if(layout_matrix[0][i]!=3){
      plate_gen(layout_matrix[j][i]);
     }
    }
    // separator
    else if(j==4){
     if(i==0){
     translate([i*key_unit,j*key_unit,0]) separator();
     }
    }
    // top row
    else if(j>4){
     translate([i*key_unit,j*key_unit-key_unit*3/4,0])
     plate_gen(layout_matrix[j][i]);
    }
    bezel();
    }
   }
  } // end union
  pin_cut();
  // mounting holes go here
  mounting_holes();
  }
  fillet();
 } // end intersection 
}

//outer bezel
module bezel(){
 linear_extrude(plate_thick) difference(){
  translate([x_center,y_center,0])
  square([overall_width,overall_length]);
  translate([+0.1,+0.1,0]) square([key_unit*len(layout_matrix[0])-0.2,key_unit*len(layout_matrix)-key_unit*3/4-0.2]);
 }
}

//chooses correct plate
module plate_gen(plate=0){
 if(plate==0){
  blank_plate();
 }
 else if(plate==1){
  keyswitch_plate();
 }
 else if(plate==2){
  encoder_plate();
 }
 else if(plate==3){
  fader_plate();
 }
 else if(plate==4){
  OLED_plate();
 }
 else if(plate==5){
 }
 else{blank_plate();
 }
}

module blank_plate(){
  linear_extrude(plate_thick){
 square(key_unit);
 }
}

module keyswitch_plate(){
 difference(){
  linear_extrude(plate_thick) difference(){
   translate([-0.1,-0.1,0]) square(key_unit+0.2);
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

module encoder_plate(){
 difference() {
  linear_extrude(plate_thick) difference(){
   translate([-0.1,-0.1,0]) square(key_unit+0.2);
   translate([(key_unit-14.45)/2,(key_unit-13.5)/2,0]){
   square([14.45,13.5]);
   }
  }
  translate([(key_unit-16)/2,(key_unit-16)/2,0]){
   linear_extrude(plate_thick-plate_thin){
   square(16);
   }
  }
 }
}

module OLED_plate(){
 // 2x1 part. Origin in middle column, last row.
 difference() {
 linear_extrude(plate_thick)
 difference(){
 color([.3,.6,.6])
 square([key_unit*2,key_unit]);
 color([1,0,0])
// translate([0,(key_unit-(12.15+0.4))/2,0])
// square([38+0.2,12.15+0.4]);
 translate([key_unit*2-3.1,(key_unit-(12.15+0.4))/2,0])
 square([3.5,12.15+0.4]);
 }
 translate([key_unit*2-26,(key_unit-(12.15+0.4))/2,plate_thick-1.6])
 cube([26,12.15+0.4,1.65]);
 }
}

module fader_plate(){
 linear_extrude(plate_thick)
 difference(){
  square([key_unit+0.2,key_unit*4]);
  translate([(key_unit-10)/2,(key_unit*4-75.1 + 0.35)/2,0]){
  square([10,75.1 + 0.35]);
  }
 }
}

module separator(){
 cube([3*key_unit,1/4*key_unit,plate_thick]);
}

// Pin headers
module pin_cut(){
 translate([x_center+21,y_center+overall_length-53-1.6,-0.1]) cube([3,53-1.6,plate_thick-plate_thin+0.1]);
 translate([x_center+overall_width-21-3,y_center+overall_length-53-1.6,-0.1]) cube([3,53-1.6,plate_thick-plate_thin+0.1]);
}

module fillet(){
 fillet_radius = 2;
 union(){
  // Full X
  translate([x_center,y_center+fillet_radius,0])
  cube([overall_width,overall_length-fillet_radius*2,plate_thick]);
  // Full Y
  translate([x_center+fillet_radius,y_center,0])
  cube([overall_width-fillet_radius*2,overall_length,plate_thick]);
  // Corners
  translate([x_center+fillet_radius,y_center+fillet_radius,plate_thick/2])
   cylinder(r=fillet_radius, h=plate_thick, center=true); // bottom left
  
  translate([x_center-fillet_radius+overall_width,y_center+fillet_radius,plate_thick/2])
   cylinder(r=fillet_radius, h=plate_thick, center=true); // bottom right
  
  translate([x_center+fillet_radius,y_center+overall_length-fillet_radius,plate_thick/2])
   cylinder(r=fillet_radius, h=plate_thick, center=true); // top left
  
  translate([x_center-fillet_radius+overall_width,y_center+overall_length-fillet_radius,plate_thick/2])
   cylinder(r=fillet_radius, h=plate_thick, center=true); // top right
  
 }
}

module screw_module(){
 // screw_dia = 2 + .3;
 // cylinder(r=screw_dia/2, h=plate_thick, center=true);
 screw_polysink(M2_cs_cap_screw, h = 100, alt = false, sink = 0.2);
}

module mounting_holes() {
 // Upper 2
 translate([key_unit/2,key_unit*(4+1/8),plate_thick]) screw_module(); // Top left
 translate([2.5*key_unit,key_unit*(4+1/8),plate_thick]) screw_module(); // Top right
 // Lower 2
 translate([key_unit,key_unit*2,plate_thick]) screw_module(); // Bottom left
 translate([key_unit*2,key_unit*2,plate_thick]) screw_module(); // Bottom right

}