$fn=25;

plate_thick=5 - 0.2;
plate_thin=1.5;

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
 //row 1. Overrides keys in other rows when fader defined
 [3,1,0],
 //row 2
 [5,1,2],
 //row 3
 [5,1,2],
 //row 4
 [5,1,2],
 //separator
 [0,0,0],
 //row 5 (top section)
 [0,0,0],
 ];

//pitch
key_unit=19.050;

main();

module main(){
union(){
for ( i=[0:3-1]) {
 for ( j=[0:5]) {
  if(j<4){
  translate([i*key_unit,j*key_unit,0])
   if(layout_matrix[j][i]==0){
    blank_plate();
   }
   else if(layout_matrix[j][i]==1){
    keyswitch_plate();
   }
   else if(layout_matrix[j][i]==2){
    encoder_plate();
   }
   else if(layout_matrix[j][i]==3){
    fader_plate();
   }
  }
  //
  else if(j>4){
   translate([i*key_unit,(j-1)*key_unit+key_unit/4,0]){
    if(layout_matrix[j][i]==0){
   blank_plate();
   }
    else if(layout_matrix[j][i]==1){
    keyswitch_plate();
   }
    else if(layout_matrix[j][i]==2){
    encoder_plate();
   }
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

module encoder_plate(){
 difference() {
 linear_extrude(plate_thick) difference(){
 square(key_unit);
 translate([(key_unit-14.45)/2,(key_unit-13.5)/2,0]){
 square([14.45,13.5]);
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

module fader_plate(){
 linear_extrude(plate_thick)
 difference(){
 square([key_unit,key_unit*4]);
 translate([(key_unit-10)/2,(key_unit*4-71.6)/2,0]){
 square([10,71.6]);
 }
 }
}

module separator(){
 cube([3*key_unit,1/4*key_unit,plate_thick]);
}
