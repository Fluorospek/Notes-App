// const express = require("express");
// const app = express();
// const mongoose = require("mongoose");
// mongoose.set("strictQuery", true);
// const Note = require("./model/note");
// const bodyParser = require("body-parser");
// app.use(bodyParser.urlencoded({ extended: false }));
// app.use(bodyParser.json());

// mongoose
//   .connect(
//     "mongodb+srv://fluorospek:tandes14884@cluster0.7yhr1q2.mongodb.net/?retryWrites=true&w=majority"
//   )
//   .then(() => {
//     app.get("/", (req, res) => {
//       const response = { statuscode: res.statusCode, message: "API Works" };
//       res.json(response);
//     });

//     const noteRouter = require("./routes/Note");
//     app.use("/notes", noteRouter);
//   });

// const port = process.env.PORT || 5000;
// app.listen(port, () => {
//   console.log(`App running on ${port}`);
// });

// Initialization
const express = require("express");
const app = express();

const mongoose = require("mongoose");
const Note = require("./model/Note");

const bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const mongoDbPath =
  "mongodb+srv://fluorospek:tandes14884@cluster0.7yhr1q2.mongodb.net/?retryWrites=true&w=majority";
mongoose.connect(mongoDbPath).then(function () {
  app.get("/", function (req, res) {
    const response = { statuscode: res.statusCode, message: "API Works!" };
    res.json(response);
  });

  const noteRouter = require("./routes/Note");
  app.use("/notes", noteRouter);
});

// Starting the server on a PORT
const PORT = process.env.PORT || 5000;
app.listen(PORT, function () {
  console.log("Server started at PORT: " + PORT);
});
