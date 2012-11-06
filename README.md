Corona Shell Project
Created by Nathanial Ryan - Fully Croisened


See the blog post for information on how this works, this file will explain all the files in the project...


/images folder - contains all image assets for the project except fo the icons which are required
                 to be on the rot

/numpad folder - contains all the images used for the numpad                 

/sounds - contains any sound files we plan using
         
build.settings - Demonstrates a typical settings file, this is where you need to 
                 add any additional permissions required for Android, set the 
                 orientation options for your applications, introduce custom fonts, etc.
                 
config.lua - configuration options and where you set your targetted resultion.
             This is key for all the dynamic image resultion that takes place and
             is the base value for which all image scaling calcuations are determined from
             

globals.lua - this is where i store all my global variables I need in my app
              They are accessed by simple getGlobal and setGlobal functions, anytime setGlobal gets called I persist the table in a json format so that it can be loaded back in on the next app start
              
scene1.lua - this is the first scene that a user will actually see, it is what
           main.lua calls after setting up the Globals table and changing to the first scene
           

scene2.lua - this is the scene we land in upon entering "12345" in the numpad and "scanning" 
             our thumb print

thumbscan.lua - contains all the code to make the thumbprint scanner pad work

                     
main.lua - simply wires up to director and any other external libraries and calls
           your first screen, in this case it is calling home.lua
           
customfont.ttf - for this example I borrowed this font from http://www.1001freefonts.com/  See code
                comments to learn how to use these and note the differences between Android and iOS

scenetemplate.lua - copy this file when adding a new scene to your project
                        
README.txt - YOU ARE HERE
             