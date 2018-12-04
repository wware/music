$fn = 32;

module rod(v1, v2, d) {
    y = [v2[0] - v1[0], v2[1] - v1[1], v2[2] - v1[2]];
    translate(v1)
        rotate(-acos(y[2] / norm(y)), cross(y, [0, 0, 1]))
            cylinder(h=norm(y), d=d);
}

//R = 5;
//D = 5*R/6;
Nx = 3;
Ny = 4;
//h = 1;

module shell(param) {
    intersection() {
        translate([0, 0, -1.35*param])
            sphere(r=2*param);
        cylinder(h=4*param, r1=param, r2=0);
        translate([-param, -param, 0])
            cube([2*param, 2*param, 2*param]);
    }
}

module holes(h, R, d) {
    for (i = [-Nx: 1: Nx-1]) {
        for (j = [-Ny: 1: Ny-1]) {
            x = i + (((j % 2) == 0) ? 0.5 : 0);
            y = j * sqrt(3)/2;
            rod(
                [0, 0, 0],
                [
                    (x + 0.25) * h,
                    (y + 0.5) * h,
                    R
                ],
                d
            );
        }
    }
}

scale([25.4,25.4,25.4]) {
    difference() {
        r = 3.6;
        shell(r);
        translate([0, 0, -0.01])
            shell(r-0.25);
        translate([0, 0, -1.35*r])
            holes(0.75, 2*r+0.2, 0.03);
    }
}
