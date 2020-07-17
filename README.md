<p align="center"> <img src="https://imgur.com/d4drRso.png" align="center" alt="Logo" width="486" height="313"></p>

# Fellow Crossing
An Animal Crossing inspired game, designed to replicate office environments and encourage socialization between fellows


## Inspiration
The Major League Hacking Fellowship has been great, don't get us wrong. However, something we miss in our remote summer experience are the casual coffee breaks and candid conversations with coworkers. So, we decided to create a virtual experience to encourage unstructured socializing between fellows in an enjoyable, Animal Crossing inspired video game.  


## What it does
Fellow Crossing is a video game that encourages socialization between coworkers. It includes a coffee room with voice calling features, a music room with synchronized background music, and a personal office space with customizable furniture. These features were developed with the goal of encouraging small talk and mingling amongst fellows during their break times. 


## Tools used to build this project
 - [Godot game engine](https://godotengine.org/download/windows)
 - SQL database
 - AWS server
 - itch io
 - Photoshop
 - Adobe Illustrator
 - Python 
 - [Mumble](https://www.mumble.com/mumble-download.php)


## Instructions to play game

### Remote server
To play the multiplayer version of the game, please install the [Mumble client](https://www.mumble.com/mumble-download.php) at the default location. Then, head to [here](https://stellaw1.itch.io/fellow-crossing) to download an executable version of our game. Please download `windowsApp.exe` and `windows.App.pck` for Windows or `macApp.dmg.zip`  for Mac. Launch the executable and have fun!


### Local server [for debugging/ testing purposes]
##### Server
To start the server, open terminal and navigate to `fellow-crossing/godot-sqlite-1.7/Game/`. Then, run this command:

```
  /path/to/godot --path . --server
```

##### Client
Ensure the `IP` constant in the file `Client/Chat/ChatBox.gd` is set to "127.0.0.1". Open the `project.godot` file in `fellow-crossing/godot-sqlite-1.7/Game/` using the Godot game engine editor and play the project.


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
