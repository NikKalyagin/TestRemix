// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Moods {
  enum Mood {Surprise, Sadness, Disgust, Fear, Happiness, Anger}
  Mood public currentMood;
  uint public counter;

  function setMood(Mood _mood) public {
    currentMood = _mood;
  }

  modifier checkMood(Mood _expectedMood) {
    require(_expectedMood == currentMood, "Wrong Mood!");
    _;
  }

  function someAction(Mood _expectedMood) public checkMood(_expectedMood) {
    counter++;
  }
} 