'''
    Emily Mittleman
    NLD
    
    distanceReport(d):
'''

states = dict({3414: 'Alabama to Alaska',
               3210: 'Alaska to Albany',
               291: 'Albany to Annapolis',
              1939: 'Annapolis to Arizona',
              1096: 'Arizona to Arkansas',
              436: 'Arkansas to Atlanta',
              1068: 'Atlanta to Augusta',
              1804: 'Augusta to Austin',
              393: 'Austin to Baton Rouge',
              1241: 'Baton Rouge to Bismarck',
              781: 'Bismarck to Boise',
              2255: 'Boise to Boston',
              2569: 'Boston to California',
              166: 'California to Carson City',
              2040: 'Carson City to Charleston',
              633: 'Columbus to Concord',
              136: 'Concord to Connecticut',
              735: 'Florida to Frankfort',
              4957: 'Hartford to Hawaii',
              3061: 'Hawaii to Helena',
              2912: 'Honolulu to Idaho',
              1310: 'Idaho to Illinois',
              173: 'Illinois to Indiana',
              35: 'Indiana to Indianapolis',
              890: 'Nebraska to Nevada',
              262: 'New Hampshire to New Jersey',
              1785: 'New Mexico to New York',
              437: 'New York to North Carolina',
              1022: 'North Dakota to Ohio',
              859: 'Ohio to Oklahoma',
              40: 'Oklahoma to Oklahoma City',
              1532: 'Oklahoma City to Olympia',
              250: 'Olympia to Oregon',
              803: 'Tennessee to Texas',
              544: 'Texas to Topeka',
              1114: 'Topeka to Trenton',
              1993: 'Utah to Vermont',
              585: 'Vermont to Virginia',
              135: 'Virginia to Washington',
              562: 'West Virginia to Wisconsin',
              928: 'Wisconsin to Wyoming'})

def distanceReport(d):
    ''' Returns a string converting d (in inches) to a meaningful distance '''
    dInches = round(d)
    dFeet = round(dInches/12)
    d = round(dFeet/5280)
    if dInches == 0:
        newD = '0 inches'
    elif dInches == 1:
        newD = '1 inch'
    elif 1 < dInches < 12:
        newD = str(dInches) + ' inches'
    elif dInches == 12:
        newD = '1 foot'
    # convert d to feet
    elif dFeet < 100:
        newD = str(dFeet) + ' feet'
    elif dFeet < 2*5280:
        newD = '{:.2f} miles'.format(dFeet / 5280)
    # convert d to miles
    elif d < 5000:
        # go through dictionary
        closestDistance = d
        closest = 40
        distances = states.keys()
        for distance in distances:
            if abs(d-distance) < closestDistance:
                closestDistance = abs(d-distance)
                closest = distance
        newD = 'the same as ' + states[closest]
    elif d < 6500:
        newD = 'the same as America to Libya'
    elif d < 8000:
        newD = 'the same as America to Saudi Arabia'
    elif d < 1300:
        newD = 'the diameter of the Earth'
    elif d <= 120000:
        newD = str(round(d/8000)) + 'times the diameter of the Earth'
    elif d < 200000:
        newD = 'half the distance between the Earth and the moon'
    elif d < 300000:
        newD = 'the same as Earth to the moon'
    elif d < 800000:
        newD = 'the same as Saturn to Titan (one of its moons)'
    elif d < 1000000:
        newD = 'the same as Saturn to Hyperion (one of its moons)'
    elif d < 3000000:
        newD = 'the same as Saturn to Iapetus (one of its moons)'
    elif d < 30000000:
        newD = 'the radius of the star Polaris'
    elif d < 60000000:
        newD = 'the diameter of the star Polaris'
    elif d < 100000000: 
        newD = 'the same as Earth to the sun'
    elif d < 150000000:
        newD = 'the same as Earth to Mars'
    elif d < 175000000:
        newD = 'the same as Earth to Venus'
    elif d < 400000000:
        newD = 'the same as Mars to Jupiter'
    elif d < 700000000:
        newD = 'the same as Earth to Jupiter'
    # convert to billions 10**9
    elif d < 2 * 10**9:
        newD = 'the same as Mars to Uranus'
    elif d < 10 * 10**9: 
        newD = 'the same as Earth to Pluto'
    elif d < 20 * 10**9:
        newD = '3 times the distance from the Sun to Pluto'
    elif d < 200 * 10**9: 
        newD = 'one half the mass of the Moon'
    # convert to trillions 10**12
    elif d < 7 * 10**12: 
        newD = 'one half the mass of Earth'
    elif d < 50 * 10**12:
        newD = 'Earth to Alpha Centauri'
    elif d < 100 * 10**12: 
        newD = "Earth to Kapteyn's Star" 
    # convert to quadrillions 10**15
    elif d < 100 * 10**15:
        newD = 'Earth to Betelgeuse'
    elif d < 6 * 10**16:
        newD = 'the diameter of the Sagittarius Dwarf Elliptical Galaxy'
    elif d < 2 * 10**17:
        newD = 'Earth to the center of our galaxy'
    elif d < 10 * 10**20:
        newD = 'Earth to Andromeda Galaxy'
    elif d < 10 * 10**25:
        newD = 'the mass of Earth'
    elif d < 10 * 10**35:
        newD = 'the mass of the Sun'
    else:
        newD = 'the mass of a Supermassive Black Hole'
    return "The distance is about " + newD


