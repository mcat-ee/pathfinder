# pathfinder
A hierarchical pathfinding system combining multiple levels of A*, navmesh navigation, and potential fields.
Currently this repo contains my progress towards a proof of concept implemented in Processing (due to ease of visualisation). Javascript and pseudocode implementations will be available once the Processing version is up to my standard.

# related work
- [Clearance-based Pathfinding and Hierarchical Annotated A* Search. Daniel Harabor on May 5, 2009](http://aigamedev.com/open/tutorial/clearance-based-pathfinding/)
- [Using Potential Fields in a Real-time Strategy Game Scenario. Johan Hagelbäck on January 31, 2009](http://aigamedev.com/open/tutorials/potential-fields/) (and included references)

# how pathfinding works
## Mesh basics
A 3D game world is segmented into 3D meshes representing any 3D unit of that world; for example you could have meshes representing:
- A floor segment
- A wall segment
- Part of a vehicle

These meshes tie together to form 3D models representing objects in the world.

//TODO: add explanatory images

## Pathfinding in such worlds
A common solution used to give agents the ability to navigate 3D world simulations is to apply graph navigation techniques. This requires viewing the navigatable world as an abstract (usually bi-directional) graph representing possible movement paths around the world.

//TODO: image, blueprint of a house with each room represented by a node and edges reprenseting points of ingress/exgress

This approach, while simple and easy to understand, can cause paths to lose realism. This loss of realism is generally due to the loss of information that occurs when a complicated environment is mapped to a simplified model.

A navigation model is necessary:
- Our world is limited to sets of blueprints; agents will traverse from room to room.
- nodes represent rooms and edges represents doorways.

### A trivial example
An agent _x_ is trying to navigate from an arbitrary point _w_ in node _u_ to a point _q_ in node _v_. The agent inspects the edge connections belonging to the node the agent is currently located at and sees an edge connecting _u_ and _v_.

//TODO: image, graph. Two points _u_ and _v_ are joined by an edge _u_->_v_. An agent is located on node _u_, in the blueprint we see it located on an arbitrary point in the room represented by _u_.

The node gives the agent the doorway connection the edge represents. The agent follows the shortest linear path from _w_ to the doorway, and from the doorway point follows the a line to _q_. Success!

### what about if the destination room isn't directly adjacent?

### what about if there's other agents in the way?

# how _this_ pathfinder works
This pathfinder enables navmesh-based navigation across a world with support for moving obstacles (such as other agents or moving props), crowding, and for location based play-bonuses (such as in the video games _Dawn of War_ and _Company of Heroes_).

## the short version
- A set of triangular meshes is defined
- Bounding boxes are used to determine adjacent mesh candidates (denoted by the set _AC_; adjacency candidates)
- A grid of cells is generated over each mesh. This will be the basis for the potential field later.
- Any cells that may overlap with other meshes are checked against the _AC_ to determine if they constitute points of inter-mesh navigation
- These cell overlaps are used to calculate exit line segments and are grouped together in a structure
- Potential field values are generated for each cell to every adjacent mesh to the mesh the cell belongs to (factoring in world charge generators, such as dangerous areas, blocked paths, desirable areas, etc)
- //TODO
- 
