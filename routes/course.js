const express = require("express");
const Course = require("../models/Course");
const router = express.Router();
const verifyToken = require("../middlewares/verifyToken");

// @route POST api/course/create
// @desc Create course
// @access Private
router.post("/create", verifyToken, async (req, res) => {
  let { title, description, url, state } = req.body;
  console.log({ title, description, url, state });
  if (!title) {
    return res
      .status(200)
      .json({ success: false, message: "Title must be specified" });
  }

  try {
    const newCourse = new Course({
      title,
      description,
      url:
        url.startsWith("https://") || url.startsWith("http://")
          ? url
          : `https://${url}`,
      state: state || "TO DO",
      user: req.userId,
    });
    await newCourse.save();
    return res.status(200).json({
      success: true,
      message: "Created new course successfully!",
      course: newCourse,
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({ success: false, message: "SERVER ERROR" });
  }
});

// @route GET api/course/
// @desc Get course
// @access Private
router.get("/", verifyToken, async (req, res) => {
  try {
    const courses = await Course.find({ user: req.userId }).populate("user", [
      "username",
    ]);
    res.json({ success: true, courses: courses });
  } catch (error) {
    console.log(error);
    res.status(500).json({ success: false, message: "SERVER ERROR" });
  }
});

// @route PUT api/course/:id
// @desc Update course
// @access Private
router.put("/:id", verifyToken, async (req, res) => {
  let { title, description, url, state } = req.body;
  if (!title) {
    return res
      .status(400)
      .json({ success: false, message: "Title must be specified" });
  }
  try {
    let updateCourse = {
      title,
      description: description || null,
      url:
        url.startsWith("https://") || url.startsWith("http://")
          ? url
          : `https://${url}`,
      state: state || "TO DO",
    };
    let updateCourseId = req.params.id;
    let updateCourseUserId = req.userId;
    const updatedCourse = await Course.findOneAndUpdate(
      { _id: updateCourseId, user: updateCourseUserId },
      updateCourse,
      { new: true }
    ); // {new:true}: neu ko update dc thi tra lai cai course cu

    // UserID not auth:
    if (!updatedCourse) {
      return res.status(401).json({
        success: false,
        message: "Course not found or not authenticated user",
      });
    }
    return res.json({
      success: true,
      message: "Update Successfully!, Have a good day!",
      course: updatedCourse,
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({ success: false, message: "SERVER ERROR" });
  }
});
// @route DELETE api/course/:id
// @desc delete course
// @access Private
router.delete("/:id", verifyToken, async (req, res) => {
  try {
    let courseId = req.params.id;
    let deleteCourseUserId = req.userId;
    const deletedCourse = await Course.findOneAndDelete({
      _id: courseId,
      user: deleteCourseUserId,
    });
    // UserID not auth:
    if (!deletedCourse) {
      return res.status(200).json({
        success: false,
        message: "Course not found or not authenticated user",
      });
    }
    res.json({
      success: true,
      message: "Delete Successfully!, goodluck",
      course: deletedCourse,
    });
  } catch (error) {
    console.log(error);
    res.status(500).json({ success: false, message: "SERVER ERROR" });
  }
});
module.exports = router;
