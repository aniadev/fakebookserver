const cors = require("cors");

socketIO = (app) => {
  var server = require("http").Server(app);
  var io = require("socket.io")(server, {
    cors: {
      origin: "*",
    },
  });
  // midlleware
  io.use((socket, next) => {
    console.log(socket.handshake.auth.accessToken);
    next();
  });
  //
  io.on("connect", (socket) => {
    // console.log("🚀 ~ file: socketIO.js ~ line 19 ~ io.on ~ socket", socket);
    socket.emit("server", "Server say Hi !");
    socket.on("disconnect", () => {
      // console.log(socket);
    });
    socket.on("hello", (arg) => {
      console.log(arg); // world
      socket.emit("server", "Server received message: ", arg);
    });
  });

  const port = process.env.IOPORT || 8598;
  server.listen(port, () => {
    console.log(`SocketIO listening on port ${port}`);
  });
};

module.exports = socketIO;
