
f0 = [0, 1, 3];
f1 = [1, 2, 3];
f2 = [0, 3, 2];
f3 = [0, 2, 1];

module draw3DKoch(tetrahedron, level, maxLevel, sf, myColor)
{
    if (level == maxLevel)
    { ; }
    else
    {
        // make 4 new tetrahedrons on all faces 
        // FIND VERTICES
        //   find the 3 midpoints --> average the 2 other points
        a1 = tetrahedron[0];
        b1 = tetrahedron[1];
        c1 = tetrahedron[3];
        aMidpoint1 = (b1 + c1) / 2;
        bMidpoint1 = (a1 + c1) / 2;
        cMidpoint1 = (a1 + b1) / 2;
        // find the displacement vectors --> midpoint vector - point
        aDisplacement1 = aMidpoint1 - a1;
        bDisplacement1 = bMidpoint1 - b1;
        cDisplacement1 = cMidpoint1 - c1;
        // make the magnitude of displacement vector = diagonal distance
        //   find diagonal distance btwn the corners of old triangle & new one
        //diagonal1 = (2*sqrt(6) / 9) * pow((sf),level+1);
        diagonal1 = (sqrt(2)*pow(sf, level) - sqrt(2)*pow(sf, level+1)) / sqrt(3);
        //   unitize vector --> v*(diagonal distance/||v||) where ||v||=height of triangle
        height1 = (sqrt(6)/2) * pow((sf), level);
        aDelta1 = (diagonal1 / height1) * aDisplacement1;
        bDelta1 = (diagonal1 / height1) * bDisplacement1;
        cDelta1 = (diagonal1 / height1) * cDisplacement1;
        // displace the points a, b, & c by aDelta, bDelta, & cDelta to get v0, v1, & v2
        v01 = a1 + aDelta1;
        v11 = b1 + bDelta1;
        v21 = c1 + cDelta1;
        // FIND V3
        xCen1 = ((v01)[0] + (v11)[0] + (v21)[0]) / 3;
        yCen1 = ((v01)[1] + (v11)[1] + (v21)[1]) / 3;
        zCen1 = ((v01)[2] + (v11)[2] + (v21)[2]) / 3;
        centroid1 = [xCen1, yCen1, zCen1];
        // find the displacement vector, delta, btwn centroid and v3
        //   find the 2 displacement vectors btwn v0 & v1 and v0 & v2
        displacement11 = v11 - v01;
        displacement21 = v21 - v01;
        //   calculate the cross-product, v
        crossProduct1 = cross(displacement11, displacement21);
        //   make ||crossProduct||=altitude by multiplying crossProduct by altitude/||cross-product||
        altitude1 = (2*sqrt(3)/3) * pow((sf), level+1);
        delta1 = (altitude1 / norm(crossProduct1)) * crossProduct1;
        // displace centroid by delta
        center1 = (tetrahedron[0] + tetrahedron[1] + tetrahedron[2] + tetrahedron[3]) / 4;
        v3_plus1 = centroid1 + delta1;
        dplus1 = sqrt(pow(center1[0]-v3_plus1[0], 2) + pow(center1[1]-v3_plus1[1], 2) + pow(center1[2]-v3_plus1[2], 2));
        v3_minus1 = centroid1 - delta1;
        dminus1 = sqrt(pow(center1[0]-v3_minus1[0], 2) + pow(center1[1]-v3_minus1[1], 2) + pow(center1[2]-v3_minus1[2], 2));
        v31 = dminus1 > dplus1 ? v3_minus1 : v3_plus1;
        // plot the tetrahedron
        color(myColor)
        polyhedron(points=[v01, v11, v21, v31], faces=[f0,f1,f2,f3], convexity=10);
		// recursive
		draw3DKoch([v01, v11, v21, v31], level+1, maxLevel, sf, myColor);
        
        //-----------------------------------------------------------------------------------------
        // FIND VERTICES
        //   find the 3 midpoints --> average the 2 other points
        a2 = tetrahedron[1];
        b2 = tetrahedron[2];
        c2 = tetrahedron[3];
        aMidpoint2 = (b2 + c2) / 2;
        bMidpoint2 = (a2 + c2) / 2;
        cMidpoint2 = (a2 + b2) / 2;
        // find the displacement vectors --> midpoint vector - point
        aDisplacement2 = aMidpoint2 - a2;
        bDisplacement2 = bMidpoint2 - b2;
        cDisplacement2 = cMidpoint2 - c2;
        // make the magnitude of displacement vector = diagonal distance
        //   find diagonal distance btwn the corners of old triangle & new one
        diagonal2 = (sqrt(2)*pow(sf, level) - sqrt(2)*pow(sf, level+1)) / sqrt(3);
        //   unitize vector --> v*(diagonal distance/||v||) where ||v||=height of triangle
        height2 = (sqrt(6)/2) * pow((sf), level);
        aDelta2 = (diagonal2 / height2) * aDisplacement2;
        bDelta2 = (diagonal2 / height2) * bDisplacement2;
        cDelta2 = (diagonal2 / height2) * cDisplacement2;
        // displace the points a, b, & c by aDelta, bDelta, & cDelta to get v0, v1, & v2
        // FIND V3
        xCen2 = ((a2+aDelta2)[0] + (b2+bDelta2)[0] + (c2+cDelta2)[0]) / 3;
        yCen2 = ((a2+aDelta2)[1] + (b2+bDelta2)[1] + (c2+cDelta2)[1]) / 3;
        zCen2 = ((a2+aDelta2)[2] + (b2+bDelta2)[2] + (c2+cDelta2)[2]) / 3;
        centroid2 = [xCen2, yCen2, zCen2];
        //echo(centroid);
        // find the displacement vector, delta, btwn centroid and v3
        //   find the 2 displacement vectors btwn v0 & v1 and v0 & v2
        displacement12 = b2+bDelta2 - a2+aDelta2;
        displacement22 = c2+cDelta2 - a2+aDelta2;
        //   calculate the cross-product, v
        crossProduct2 = cross(displacement12, displacement22);
        //   make ||crossProduct||=altitude by multiplying crossProduct by altitude/||cross-product||
        altitude2 = (2*sqrt(3)/3) * pow((sf), level+1);
        //echo(altitude);
        delta2 = (altitude2 / norm(crossProduct2)) * crossProduct2;
        // displace centroid by delta
        center2 = (tetrahedron[0] + tetrahedron[1] + tetrahedron[2] + tetrahedron[3]) / 4;
        v3_plus2 = centroid2 + delta2;
        dplus2 = sqrt(pow(center2[0]-v3_plus2[0], 2) + pow(center2[1]-v3_plus2[1], 2) + pow(center2[2]-v3_plus2[2], 2));
        v3_minus2 = centroid2 - delta2;
        dminus2 = sqrt(pow(center2[0]-v3_minus2[0], 2) + pow(center2[1]-v3_minus2[1], 2) + pow(center2[2]-v3_minus2[2], 2));
        v32 = dminus2 > dplus2 ? v3_minus2 : v3_plus2;
        // plot the tetrahedron
        color(myColor)
        polyhedron(points=[a2+aDelta2, b2+bDelta2, c2+cDelta2, v32], faces=[f0,f1,f2,f3], convexity=10);
		// recursive
		draw3DKoch([a2+aDelta2, b2+bDelta2, c2+cDelta2, v32], level+1, maxLevel, sf, myColor);
        
        //-----------------------------------------------------------------------------------------
        // FIND VERTICES
        //   find the 3 midpoints --> average the 2 other points
        a3 = tetrahedron[0];
        b3 = tetrahedron[2];
        c3 = tetrahedron[3];
        aMidpoint3 = (b3 + c3) / 2;
        bMidpoint3 = (a3 + c3) / 2;
        cMidpoint3 = (a3 + b3) / 2;
        // find the displacement vectors --> midpoint vector - point
        aDisplacement3 = aMidpoint3 - a3;
        bDisplacement3 = bMidpoint3 - b3;
        cDisplacement3 = cMidpoint3 - c3;
        // make the magnitude of displacement vector = diagonal distance
        //   find diagonal distance btwn the corners of old triangle & new one
        diagonal3 = (sqrt(2)*pow(sf, level) - sqrt(2)*pow(sf, level+1)) / sqrt(3);
        //   unitize vector --> v*(diagonal distance/||v||) where ||v||=height of triangle
        height3 = (sqrt(6)/2) * pow((sf), level);
        aDelta3 = (diagonal3 / height3) * aDisplacement3;
        bDelta3 = (diagonal3 / height3) * bDisplacement3;
        cDelta3 = (diagonal3 / height3) * cDisplacement3;
        // displace the points a, b, & c by aDelta, bDelta, & cDelta to get v0, v1, & v2
        v03 = a3 + aDelta3;
        v13 = b3 + bDelta3;
        v23 = c3 + cDelta3;
        // FIND V3
        xCen3 = ((v03)[0] + (v13)[0] + (v23)[0]) / 3;
        yCen3 = ((v03)[1] + (v13)[1] + (v23)[1]) / 3;
        zCen3 = ((v03)[2] + (v13)[2] + (v23)[2]) / 3;
        centroid3 = [xCen3, yCen3, zCen3];
        // find the displacement vector, delta, btwn centroid and v3
        //   find the 2 displacement vectors btwn v0 & v1 and v0 & v2
        displacement13 = v13 - v03;
        displacement23 = v23 - v03;
        //   calculate the cross-product, v
        crossProduct3 = cross(displacement13, displacement23);
        //   make ||crossProduct||=altitude by multiplying crossProduct by altitude/||cross-product||
        altitude3 = (2*sqrt(3)/3) * pow((sf), level+1);
        delta3 = (altitude3 / norm(crossProduct3)) * crossProduct3;
        // displace centroid by delta
        center3 = (tetrahedron[0] + tetrahedron[1] + tetrahedron[2] + tetrahedron[3]) / 4;
        v3_plus3 = centroid3 + delta3;
        dplus3 = sqrt(pow(center3[0]-v3_plus3[0], 2) + pow(center3[1]-v3_plus3[1], 2) + pow(center3[2]-v3_plus3[2], 2));
        v3_minus3 = centroid3 - delta3;
        dminus3 = sqrt(pow(center3[0]-v3_minus3[0], 2) + pow(center3[1]-v3_minus3[1], 2) + pow(center3[2]-v3_minus3[2], 2));
        v33 = dminus3 > dplus3 ? v3_minus3 : v3_plus3;
        // plot the tetrahedron
        color(myColor)
        polyhedron(points=[v03, v13, v23, v33], faces=[f0,f1,f2,f3], convexity=10);
		// recursive
		draw3DKoch([v03, v13, v23, v33], level+1, maxLevel, sf, myColor);   	
    }
}

module main()
{
    level = 0;
    maxLevel = 8;
    color1 = "silver";
    
    v0 = [0, 0, 0];
    v1 = [0, 1, 1];
    v2 = [1, 1, 0];
    v3 = [1, 0, 1];
    
    tetrahedron = [v0, v1, v2, v3];
    
    color(color1)
    polyhedron(points=[v0,v1,v2,v3], faces=[f0,f1,f2,f3], convexity=10); 
    
    draw3DKoch(tetrahedron, level, maxLevel, 1/2, color1);
	
	// draw tetrahedron on fourth side
	level1 = 1;
	
	v01 = [1/6, 1/3, 1/6];
    v11 = [1/6, 5/6, 2/3];
    v21 = [2/3, 5/6, 1/6];
    v31 = [0, 1, 0];
	
	tetrahedron1 = [v01, v11, v21, v31];
	
	color(color1)
    polyhedron(points=[v01,v11,v21,v31], faces=[f0,f1,f2,f3], convexity=10); 
	
	draw3DKoch(tetrahedron1, level1, maxLevel, 1/2, color1);
}

main();




