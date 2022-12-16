import sys
def main():
    inp = [line.strip() for line in sys.stdin]
    sensors = parse(inp)
    return part_two(sensors) # part_one(sensors)

def part_two(sensors: "list[Sensor]", bound:int = 4000000) -> int:
    counts = {}
    for sensor in sensors:
        for point in sensor.outer_perimeter:
            counts[point] = 0
    for sensor in sensors:
        for point in sensor.outer_perimeter:
            counts[point] += 1
    points = [x for x in counts.keys() if counts[x] >= 2]
    print(len(points))

    for point in points:
            if 0 <= point[0] <= bound and 0 <= point[1] <= bound:
                if beacon_at_location(point[0], point[1],sensors):
                    return 4000000 * point[0] + point[1]
    return 0

def part_one(sensors: "list[Sensor]", y:int = 2000000) -> int:
    positions = [beacon_at_location(x, y, sensors) for x in range(-10**7, 10**7)] 
    beacons = set([sensor.beacon for sensor in sensors])
    beacon_counter = len([0 for beacon in beacons if beacon[1] == y])
    positions = list(filter(lambda x: x == False, positions))

    return len(positions)-beacon_counter

def parse(inp: list[str]) -> "list[Sensor]":
    sensors : list[Sensor]= []
    for line in inp:
        line = line.replace("Sensor at ", "").replace("closest beacon is at ", "").replace("x=", "").replace("y=", "").replace(" ", "")
        segments = line.split(":")
        sen = segments[0].split(",")
        bea = segments[1].split(",")
        sensor = Sensor(int(sen[0]),int(sen[1]),int(bea[0]),int(bea[1]))
        sensors.append(sensor)
    return sensors

class Sensor:
    def __init__(self, x:int,y:int, beacon_x:int, beacon_y:int):
        self.x = x
        self.y = y
        self.beacon_x = beacon_x
        self.beacon_y = beacon_y
        self.internal_distance = dist(self.beacon, self.sensor)
        self._outer_perimeter = None

    @property
    def outer_perimeter(self):
        if self._outer_perimeter == None:
            self._outer_perimeter = self._perimeter()
        return self._outer_perimeter

    @property
    def beacon(self):
        return (self.beacon_x, self.beacon_y)
    
    @property
    def sensor(self):
        return (self.x, self.y)

    def __repr__(self) -> str:
        return f"{self.sensor}:{self.beacon}"

    def _perimeter(self:"Sensor") -> "list[tuple[int, int]]":
        r = self.internal_distance + 1
        out = []
        for x in range(-r + self.x, r+1 + self.x):
            a = abs(x - self.x) - r
            c = self.y
            b_one = c-a
            b_two = a+c
            out.append((x, b_one))
            out.append((x, b_two))
        return out

def dist(x,y) -> int:
    return abs(x[0] - y[0]) + abs(x[1] - y[1])

def beacon_at_location(x: int, y: int, sensors: list[Sensor]) -> bool:
    for sensor in sensors:
        candiate_sensor_dist = dist((x,y), sensor.sensor)
        if not candiate_sensor_dist > sensor.internal_distance:
            return False 
    return True

if __name__ == "__main__":
    print(main())