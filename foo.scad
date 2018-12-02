$fn = 180;

module rod(v1, v2) {
    y = [v2[0] - v1[0], v2[1] - v1[1], v2[2] - v1[2]];
    translate(v1)
        rotate(-acos(y[2] / norm(y)), cross(y, [0, 0, 1]))
            cylinder(h=norm(y), d=0.025);
}

R = 6;
D = 5*R/6;
rsmall = sqrt(R*R - D*D);
echo(2*rsmall);
N = 3;
h = 0.75;
P = 1.5;

module holes() {
    for (i = [-N: 1: N-1]) {
        for (j = [-N: 1: N-1]) {
            x = i + (((j % 2) == 0) ?0.5 : 0);
            y = j * sqrt(3)/2;
            rod([0, 0, 0], [
                (x + 0.25) * h,
                (y + 0.5) * h,
                R
            ]);
        }
    }
}

scale([25.4, 25.4, 25.4]) {
    intersection() {
        translate([0, 0, -D])
            difference() {
                sphere(r=R);
                sphere(r=R-0.25);
                holes();
            }
        translate([-50, -50, -0.25])
            cube([100, 100, 100]);
        translate([0, 0, -5])
        cylinder(r=rsmall, h=10);
    }
    translate([0, 0, -P])
    difference() {
        cylinder(r=rsmall, h=P);
        translate([0, 0, -0.1])
        cylinder(r=rsmall-0.25, h=P+0.2);
    }
}
