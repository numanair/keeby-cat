$fn=25;

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
 [3,1,1],
 //row 2
 [0,1,1],
 //row 3
 [0,1,1],
 //row 4
 [0,1,2],
 //separator
 [0,0,0],
 //row 5 (top section)
 [1,4,4],
 ];

main();

// j = y
// i = x
module main(){
 union(){
  for ( i=[0:len(layout_matrix[0])-1]) {
   for ( j=[0:len(layout_matrix)-1]) {
    if(j<4){
     translate([i*key_unit,j*key_unit,0])
     //middle
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
    //separator
    else if(j==4){
     if(i==0){
     translate([i*key_unit,j*key_unit,0])
     separator();
     }
    }
    //top row
    else if(j>4){
     translate([i*key_unit,j*key_unit-key_unit*3/4,0])
     plate_gen(layout_matrix[j][i]);
    }
    bezel();
    }
   }
 }
}

//outer bezel
module bezel(){
 linear_extrude(plate_thick) difference(){
 translate([(key_unit*len(layout_matrix[0])-overall_width)/2,(key_unit*(len(layout_matrix)-3/4)-overall_length)/2,0])
 square([overall_width,overall_length]);
 square([key_unit*len(layout_matrix[0]),key_unit*len(layout_matrix)-key_unit*3/4]);
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
 else if(plate==5){
 }
 else{blank_plate();
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
