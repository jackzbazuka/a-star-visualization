# A-star-pathfinding-visualization
Visualisation of A-star pathfinding algorithm

Processing is a library for visual arts, built for learning to code visually.

This is a processing sketch made in java edition. So in order to run it you have to download it from [here](https://processing.org/download/).

I've maintained a separate file for individual cells of the grid i.e. `Cell.pde`

### Configurations

These are the parameters you can change in the sketch to observe different grid sizes and difficulty levels.

- Grid size: change the `float columns` variable.

- Difficulty: change the number in last conditional in constructor of `Cell` object.

- Start point: on line 65 of `Astar_pathfinding.pde`

- End point: on line 66 of `Astar_pathfinding.pde`

**Note: The start and end points should remain inside the grid size, else the program will crash**

### Anomalies

Since the generation of walls depends on a random function, the risk of start and end block being completely unreachable is directly proportional to the probability of a cell being wall which is managed by the difficulty parameter.
