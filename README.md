<p align="center"> <img src="https://imgur.com/d4drRso.png" align="center" alt="Logo" width="200" height="260"></p>

# fellow-crossing
An Animal Crossing inspired game designed to replicate office environments to encourage socialization between coworkers

## Instructions

### Server
To start the server, open terminal and run this command

```
  /path/to/godot --path ./Server
```

We have a server running at 13.232.157.0, so you might want to just use that and not start the server locally.

### Client

If you want to run the game on the local server, set the `IP` constant to "127.0.0.1" in file `Client/Chat/ChatBox.gd` otherwise set it to the remote IP. Run the `Client` project in Godot.


```
  /path/to/godot --path ./Server
```

In the chat box type `/name kanav` to change your name to `kanav` and then `/connect` to connect to server.
