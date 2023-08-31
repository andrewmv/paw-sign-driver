// A standoff with a setback for holding the edge of a pcb
module pcb_standoff(h=10, w=5, l=5, lip=1.5, setback=2) {
    translate([-l/2, -w+setback, 0]) {
        cube([l, w, h]);
        cube([l, w-setback, h+lip]);
    }
}

// A peg for holding the screw-hole of a pcb
module pcb_peg(h=10, outer_r=2.5, inner_r=1, lip=1.5) {
    cylinder(h=h, r=outer_r, $fn=20);
    cylinder(h=h+lip, r=inner_r, $fn=20);
}

// Support a PCB with four standoffs
module pcb_holder(pcb_w, pcb_l, standoff_w=2.5, standoff_l=2.5, h=5, lip=1.5, setback=2) {
    // width is x, length is y
    translate([pcb_w / 2, 0, 0])
        pcb_standoff(h=h, w=standoff_w, l=standoff_l, lip=lip, setback=setback);
    translate([pcb_w / 2, pcb_l, 0])
        rotate([0,0,180])
            pcb_standoff(h=h, w=standoff_w, l=standoff_l, lip=lip, setback=setback);
    translate([0, pcb_l / 2, 0])
        rotate([0,0,270])
            pcb_standoff(h=h, w=standoff_w, l=standoff_l, lip=lip, setback=setback);
    translate([pcb_w, pcb_l / 2, 0])
        rotate([0,0,90])
            pcb_standoff(h=h, w=standoff_w, l=standoff_l, lip=lip, setback=setback);
}

*pcb_standoff();
*pcb_peg();
*pcb_holder(30, 15);