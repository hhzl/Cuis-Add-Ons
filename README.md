Cuis-Add-Ons
============

Some Add-Ons for Cuis. It contains examples and experiments.

Add-Ons-LayoutDemo.pck.st contains examples which demonstrate the use of the LayoutMorph as well as how to add simple content to a SystemWindow instance.

The examples are numbered in order of complexity.

They show how to create an interface with tabs or register cards.

In package 'Add-Ons-Timer'

     PomodoroTimer openForTask: 'My task at hand'.

opens a Pomodoro type of timer  (http://en.wikipedia.org/wiki/Pomodoro_Technique)


Compatibility
-------------
Updated and tested in 7.1

- Add-Ons-Notes


Updated and tested in 4.2

- Add-Ons-LayoutDemo
- Add-Ons-Timer
- Add-Ons-Notes

The rest is for Cuis 4.1. 


To install do

    Feature require: 'Add-Ons-LayoutDemo'.
    Feature require: 'Add-Ons-Timer'.
    Feature require: 'Add-Ons-Notes'.

