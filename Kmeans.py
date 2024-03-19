import matplotlib.pyplot as plt
import numpy as np

def group(coordinates, initial_coordinates):
    group_A = []
    group_B = []
    group_C = []
    group_D = []

    for coord in coordinates:
        distance = [np.hypot(coord[0] - init_coord[0], coord[1] - init_coord[1]) for init_coord in initial_coordinates]

        if np.argmin(distance) == 0:
            group_A.append(coord)
        elif np.argmin(distance) == 1:
            group_B.append(coord)
        elif np.argmin(distance) == 2:
            group_C.append(coord)
        else:
            group_D.append(coord)

    return group_A, group_B, group_C, group_D

def centre_coord(coordinates):
    x_sum = sum(coord[0] for coord in coordinates)
    y_sum = sum(coord[1] for coord in coordinates)

    x_avg = x_sum / len(coordinates)
    y_avg = y_sum / len(coordinates)

    avg_coordinate = (x_avg, y_avg)

    return avg_coordinate

def distance(group):
    coord = centre_coord(group)
    distances = [np.hypot(g[0] - coord[0], g[1] - coord[1]) for g in group]
    avg_distance = sum(distances) / len(group)
    return avg_distance

def avg_distance(groups):
    distances = [distance(g) for g in groups]
    avg_distance = sum(distances) / len(groups)
    return avg_distance

def kmeans(initial_coordinates):
    D_bar = []
    centre = []

    for g in group(coordinates, initial_coordinates):
        centre.append(centre_coord(g))

    for _ in range(10):
        D_bar.append(avg_distance(group(coordinates, centre)))

        for g in group(coordinates, centre):
            centre.append(centre_coord(g))

        centre = centre[4:8]

    return D_bar

coordinates = [(2, 5), (3, 2), (3, 3), (3, 4), (4, 3),
               (4, 4), (6, 3), (6, 4), (6, 6), (7, 2),
               (7, 5), (7, 6), (7, 7), (8, 6), (8, 7)]

new_coordinates = [(np.random.randint(1, 21), np.random.randint(1, 21)) for _ in range(500)]
coordinates += new_coordinates

initial_coordinates = [(2, 2), (4, 6), (6, 5), (8, 8)]

# Plotting using matplotlib
x_values = range(1, 11)
y_values = kmeans(initial_coordinates)

plt.plot(x_values, y_values, label="Distance")
plt.xlabel("Cycle")
plt.ylabel("Distance")
plt.legend()
plt.show()
