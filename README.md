<p align="center"> <img src="https://imgur.com/d4drRso.png" align="center" alt="Logo" width="486" height="313"></p>

# Fellow Crossing
An Animal Crossing inspired game, designed to replicate office environments and encourage socialization between fellows


## Inspiration
The Major League Hacking Fellowship has been great, don't get us wrong. However, something we miss in our remote summer experience are the casual coffee breaks and candid conversations with coworkers. So, we decided to create a virtual experience to encourage unstructured socializing between fellows in an enjoyable, Animal Crossing inspired video game.  


## What it does
Fellow Crossing is a video game that encourages socialization between coworkers. It includes a coffee room with voice calling features, a music room with synchronized background music, and a personal office space with customizable furniture. These features were developed with the goal of encouraging small talk and mingling amongst fellows during their break times. 


## Tools used to build this project
 - Godot game engine
 - SQL database
 - AWS server
 - itch io
 - Photoshop
 - Adobe Illustrator
 - Python 


## Instructions

### Server
To start the server, open terminal and run this command

```
  /path/to/godot --path . --server
```

We have a server running at 13.232.157.0, so you can use that instead of starting a local server at 127.0.0.1

### Client

If you want to run the game on the local server, set the `IP` constant to "127.0.0.1" in file `Client/Chat/ChatBox.gd` otherwise set it to the remote IP, "13.232.157.0". Run the `Client` project in Godot.


```
  /path/to/godot --path .
```

A starting page should launch automatically, prompting your name and character selection. 


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
