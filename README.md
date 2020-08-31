#  Rowing Posture App/ Learning how to use pose detection

The aim of this project is to learn about using CoreML and Vision in regards to detecting and mapping body positions.

To do this, I am currently using the PoseFinder App and PoseNet model to learn about how how it all works, and working my way through the posefinder source code to see how it is done.

The project will be frames as an app that can record a video of a rower, then analyse it, by showing the body position as the video is played back. The hope is to create a secondary model of 'good' rowing technique, to allow a comparison.

Design pattern wise, I am using the MVVM-C pattern.

Lessons learnt so far:
* Delete the scene delegate when starting the project as this can cause issues with the coordinator by reinitialising the initial view controller a second time, but without a view model or associated coordinator.

