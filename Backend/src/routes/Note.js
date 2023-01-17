const express = require("express");
const router = express.Router();

const Note = require(`./../model/note`);

router.post("/list", async (req, res) => {
  var notes = await Note.find({ userId: req.body.userid });
  res.json(notes);
});

router.post("/add", async (req, res) => {
  await Note.deleteOne({ id: req.body.id });

  const newNote = new Note({
    id: req.body.id,
    userId: req.body.userId,
    title: req.body.title,
    content: req.body.content,
  });
  await newNote.save();

  const response = { message: "New note created! " + `id: ${req.body.id}` };
  res.json(response);
});

router.post("/delete", async (req, res) => {
  await Note.deleteOne({ id: req.body.id });
  const response = { message: "Node Deleted " + `id: ${req.body.id}` };
  res.json(response);
});

module.exports = router;
