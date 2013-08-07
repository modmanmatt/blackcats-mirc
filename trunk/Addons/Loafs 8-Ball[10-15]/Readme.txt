|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|
|     Magic     |
|  /¯¯¯¯¯¯¯¯\   |
| /    /\    \  |
| |    \/    |  |
| |    /\    |  |
| \    \/    /  |
|  \        /   |
|   ¯¯Ball¯¯    |
|_______________|
 ©2005 Loafer357
---------------------------------------------------------------------------
 This is an addon made for mIRC32 v5.7 and after

 To install:
   Put all the files in the main mIRC directory.
   After all the files are in the same directory as the mIRC.exe file type 
   the following in any channel window.

      /load -rs 8-ball.mrc

   Once loaded you will be asked to Input your username just enter it in and
   your good to go.
---------------------------------------------------------------------------

 =============
  Using 8ball
 =============
    /8b: is the only command that you will need to type in for 8ball, what it
        does is it allows you to use 8ball, which you normally wouldn't be
        able to. Syntax: /8b questionhere afterwards it functions like it
        normally would and answers you're question randomly.
    
    !8ball: The main function of this script, it is quite simple really, you
        just type !8ball questionhere and the script will pick it up. Keep in
        mind that only other users can use this, for you to do it yourself
        you must use the /8b command, but it still looks exactly the same
        to everyone else like nothing changed.

    !add8ball: This is a command for other users to add their own custom 
        replies, if someone with the name Zamfir typed !add8ball NOO!! a
        new response would be added to the list of responses.
        NOO!! (Added by: Zamfir)

 =============
    Set-Up
 =============
  The main controls for this 8ball script are in your channel pop-ups, just
 right click in any channel window and you will see 8 ball at the bottom of
 your pop-ups menu. When you click on this it opens up a dialogue with a few
 nifty functions.

 On/Off: The first of the functions on the list, this should already be 
        checked, if you uncheck it, it will disable the 8ball reply.

 Allow Custom Response: This one is off bye default and it is up to you if
        you want it to be used, the way this works is it allows other users
        to add their own 8ball responses to your script by the meens of the
        add8ball command. Syntax: add8ball replyhere. if responses are 
        added in this manner there will be a tag at the end of the response
        stating who added it.

 Auto/Manual:
  Auto Respond: This is the normal setting for how 8ball's are supposed to
               operate, a user sais a question and a random answer is picked.

  Manual Response: This is were it gets interesting, what i've done here is
               set it up so you can stop it from auto responding and choose
               a yes or no answer yourself. When someone tries to use the
               8ball command with manual response set, a dialogue opens up
               with two buttons, Yes and No. Be wary when you click the yes
               or no it does not close the box, instead it stays open for
               even quicker responses when people are using it. Just x out
               when you are done. The yes and no answers are controlled by
               the two files 8ballY.txt and 8ballN.txt. If you want more 
               answers to work for manual response you can add to those 
               files, just add a new line for every answer.

 Unload: Pretty self explanatory.. when you click on this a dialog opens
        up confirming whether or not you want to unload the script. When 
        you do, all variables are unset and the script removed from mIRC.

 All Responses: This is just a nifty little list were you can see all the
               responses for 8ball, if you add new responses to the list's
               they will show up no problem, and a bar to scroll down will
               appear.

 Extra's: This button open's up a new dialog with a few extra features inside.
  Change Main Username: this basically sets a new name to be used with the
                        script, if your current nickname does not match
                        whats entered here the script will not auto reply.

  Change Color Output: This changes the look of the 8ball responses\notifications.
   Echo Colors -> Active: This echo's a test response in your active window to see
                         what it looks like.
  
  Manage Response List: From inside this dialog you can add\delete\edit the auto
                       response's. To delete a response just double click it in
                       the list. Note: beside each response in this list is a 
                       number followed by a :, these are not part of the responses
                       they are just showing what number response it is.
   Add New Response: Shouldn't be to hard to guess what this does, when 
                   clicked an input window open's up. Just enter in a new
                   8ball auto response, Ex: Hell YEA!!. When you click ok
                   and return to the dialog the list will be updated.
   Edit Response: This button will only work if a response is selected in the list
                 once clicked a small dialog will open up with the response inside
                 and edit box, modify it the way you see fit and click ok to save 
                 the modification. If you mess up the reply and you want it back to
                 how it was before clicking cancel will restore it.

 Response Method:
  Respond via Channel: When this is selected all responses either from auto or manual
                      will be sent to the channel the user used the command from.
  Respond via Query: If this option is selected, a user can still use the !8ball
                    command from a channel but the response will instead be sent to
                    them in the form of a private query.
  Respond via Notice: Last of the responses is a notice response, when this is selected
                     a user can still use !8ball in a channel, but instead of sending it
                     to a channel or a private query, it sends a private message to them.

 =============
   Versions
 =============
©2005.09.28 V-1.0
  -My first public release of my 8ball script, at the moment i can't think
  any improvements to make. Suggestions are welcome you can e-mail me at
  Grindmaster5090@wideopenwest.com. Enjoy = )