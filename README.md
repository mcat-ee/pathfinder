# pathfinder
A hierarchical pathfinding system combining multiple levels of A*, navmesh navigation, and potential fields.
Currently this repo contains my progress towards a proof of concept implemented in Processing (due to ease of visualisation). Javascript and pseudocode implementations will be available once the Processing version is up to my standard.

# how it works
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