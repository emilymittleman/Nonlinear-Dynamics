'''
    fractalUtils.py
    Koch Curve

    what level results in a Koch curve where each segment is the length of
    the width of 1 pixel?
    1*(g.currentCoords[2]-g.currentCoords[0])/g.width

'''

from DEgraphics import *
from distanceFunction import *
from math import *
from numpy import *

def drawLine(g, startPoint, length, theta, color='black', thickness='1', style='solid'):
    ''' Creates a Line object of the appropriate size, draws the line segment
        on win, and then update starting point to be the end point of the line segment. '''
    # find the end point
    theta *= pi / 180
    dx = length * cos(theta)
    dy = length * sin(theta)
    endPoint = Point(startPoint.getX() + dx, startPoint.getY() + dy)

    # create & draw line on graph
    line = Line(startPoint, endPoint, style)
    line.setFill(color)
    line.setWidth(thickness)
    line.draw(g)

    # set the starting point to the end point
    startPoint.move(dx, dy)

def getLevel(g, Lo, angleKC=60):
    ''' Finds the level at which the length of each segment is equal to the
        width of one pixel. '''
    angleKC *= pi / 180
    pixelWidth = (g.currentCoords[2]-g.currentCoords[0])/g.width
    k = log(pixelWidth/Lo) / log(1/(2*(1+cos(angleKC))))
    return k

def drawKC(g, startPoint, length, level, angleIncline=0, angleKC=60):
    ''' Draws the Koch curve. Scale factor = 1/(2*(1+cos(theta))) '''
    # base case: draw a single segement at level 0
    if level == 0:
        # draw a segment in direction angleIncline
        drawLine(g, startPoint, length, angleIncline)
    # recursive case: draw 4 Koch curves
    else:
        sf = 1/(2*(1+cos(angleKC*(pi/180))))
        drawKC(g, startPoint, length*sf, level-1, angleIncline, angleKC)
        drawKC(g, startPoint, length*sf, level-1, angleIncline+angleKC, angleKC)
        drawKC(g, startPoint, length*sf, level-1, angleIncline-angleKC, angleKC)
        drawKC(g, startPoint, length*sf, level-1, angleIncline, angleKC)
    
def main():
    # create a window upon which to draw
    g = DEGraphWin(width=800, height=800, defCoords=[-1,-1,1,1])

    # define the starting point, level, & angleKC
    pt = Point(-0.5,0.25)
    myLevel = 5
    myAngleKC = 80

    # top of triangle from left to right, right side angled down, left side angled up
    drawKC(g, pt, length=1, level=myLevel, angleIncline=0, angleKC=myAngleKC)
    drawKC(g, pt, length=1, level=myLevel, angleIncline=-120, angleKC=myAngleKC)
    drawKC(g, pt, length=1, level=myLevel, angleIncline=120, angleKC=myAngleKC)

    # find the total length of the curve    
    distance = (2/(1+cos(myAngleKC*(pi/180))))**myLevel

    # print out a 'meaningful' distance
    meaningfulDistance = distanceReport(distance)
    print(meaningfulDistance)

    g.update()
    g.getMouse()
    g.close()

if __name__ == '__main__':
    main()
