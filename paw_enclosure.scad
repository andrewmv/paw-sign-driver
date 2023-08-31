include <pcb_standoff.scad>

x=0; y=1; z=2;

placeholders = false;

label_text = "v2.0";
label_size = 6;

sw = 2.5; // standoff width
hsw = sw / 2;

esp_h = 10;
esp_l=52;
esp_w=28.75;
esp_clearance_r = 2;
esp_screw_r = 1.5;
esp_peg_locs = 
[
    [2, 2],
    [esp_w - 4, 2],
    [esp_w - 4, esp_l - 4],
    [2, esp_l - 4]
];

mosfet_h = 3;
mosfet_l = 34.5;
mosfet_w = 17.5;

buck_h=1.5;
buck_l=20.5;
buck_w=11;

// pcb's
translate([3, 3, 0])
    esp32();
translate([7.25, 32, 0])
    mosfet();
translate([8, 6, 0])
    buck();
    
// base
basedim=[esp_w + 3, 71, 2];
translate([0,0,-2])
    cube(basedim);
    
// lid
translate([40, 0, 0])
    *lid();

// label
color("red") label();

module label() {
    translate([20,43,1])
    rotate([0,0,-90])
        linear_extrude(0.75)
            text(label_text, size=label_size);
}

module lid() {
    cube(basedim);
}

module esp32() {
    for (i = [0:len(esp_peg_locs)-1]) {
        translate(esp_peg_locs[i]) {
            pcb_peg(h=esp_h, outer_r=esp_clearance_r, inner_r=esp_screw_r, lip=2);
        }
    }
    if (placeholders)
        translate([0,0,esp_h])
            color("green") cube([esp_w, esp_l, 1.5]);
}

module mosfet() {
    pcb_holder(mosfet_w, mosfet_l, h=mosfet_h);
    if (placeholders) {
        translate([0,0,mosfet_h])
            color("green") cube([mosfet_w, mosfet_l, 1.5]);
        translate([0,mosfet_l-10,mosfet_h+1.5])
            color("blue") cube([mosfet_w, 10, 10]);
    }
}

module buck() {
    pcb_holder(buck_w, buck_l, h=buck_h);
    if (placeholders)
        translate([0,0,buck_h])
            color("green") cube([buck_w, buck_l, 1.5]);
}