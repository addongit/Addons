XCustomBar
==========

By Dr. Doom (Shalune on Kargath)

This mod works with the XBar framework to create custom XBar components.  For those of you who are curious about it's function, it basically emulates the addition of other bars, and comes with a handy interface to make the new bars.

FEATURES:

* Supports customizable actions: Spells, Items, Macros, Companions, Emotes, Chat strings.
* Allows you to configure the bars with spacers and menu headers just like the other bars have that ship with XBar.
* Supports flexible click conditions (Help/Harm/Buttons 1-5/Ctrl/Shift/Alt) for spell buttons.
* Allows multiple actions for one spell button using conditionals.
* Easy GUI interface to create new bars.
* Bars created will have the same great features that the standard XBars do, configurable from the XBar interface.
* Import/Export bars, so you can share bars you make with others.

COMMANDS:

/xcustombar config

USAGE:

Open the config window, and create new action bars to plug into XBar by typing a name for it into the text box, and click New.  For each bar you create, you will get a Spell Button with one Action.

Add buttons to the bars by selecting the type of button by clicking the + below the New button, then clicking New in the button list.  You can re-order the buttons by selecting one, and clicking the + and - buttons above the list.

Add actions to the buttons by clicking New below the action list.  Type the appropriate spell name, macro name, or item name in the text box and click Save.  You can change the cast conditionals by clicking the + above the name box to the right.  Repeat this for each additional action to add to this button.  You may import spells via spell ID by typing ^ followed by the ID (ex. ^5246 will change to "Intimidating Shout" in your language);

Chat and Emote types also allow you to select an icon texture.  Pick one by scrolling through the list with the +/- below the texture that appears for those types.

For Chat, if you use a whisper or channel sub-type, you will have to enter the target player or channel in the text box provided.  The larger text box is for the text of the message.

Click Save + Close, and the changes will be saved, and the UI will be reloaded to show the new bars.  Each bar's display options will be configurable using the standard XBar configuration window.  THIS BUTTON WILL NOT SAVE CHANGES TO THE SPELL/MACRO/ITEM name in the text box above.

Individual display options for XCustomBar addons will appear in the XBar configuration window like normal bars.

To export a bar, click on it, then click export.  The text will appear in the text box at the bottom, select it and copy by pressing Ctrl+C.  To import a bar into XCustomBar, type a name for the bar, and paste the bar text into the text box at the bottom by clicking in it, delete the default text, and press Ctrl+V, then click Import.

CASTING SPECIFIC RANK SPELLS:

Make a spell button like normal, and type in the name immediately followed by the rank in parentheses (no space, ex: "Conjure Food(Rank 2)").  Be aware that some ranks may have an extra trailing space at the end, so if it doesn't show up, try putting a space at the end of the rank.  The rank is what is listed below the spell in the spell book: Rank 2, Racial, Expert, etc...  Note that casting Passive or Racial Passive spells will have no effect.

LIMITATIONS ON BUTTONS USING ALLY/ENEMY:

Due to incomplete Blizzard UI scripting, you need to be aware of the following issues when creating buttons that use this feature:

* Actions that do not specify ally/enemy may override these.  If any action uses ally/enemy detection, all actions in the same button should specify as well.
* Auto-selfcast does not function on these buttons if you have no target selected.  All actions on this button will target the player's target.
* TEST YOUR BUTTONS THOUROGHLY!  This is a complex feature and you need to test every action on the button.  I won't guarantee that it will work perfectly for everything you throw at it.
* If a button doesn't work the way you designed it, try re-arranging the way the actions are listed.  Also try to put actions with conditionals before actions that do not have conditions.
* Ctrl+Right click is reserved for use by the XBar interface.

KNOWN ISSUES:

* Pressing ESC on the config window will close the window without reloading the UI.  Changes to the buttons or actions will NOT be cancelled.  Changes made may not appear correctly until the UI is reloaded.  This is an intentional feature so you can cancel the window without reloading the UI if you made no changes.

* Some features of the Config UI will not function in combat.  You can press ESC, and then go back into the config interface when you are safe.  It is a wise idea to create bars in a combat-free environment, such as a neutral capitol city, to avoid any errors.

* Most changes on an XCustomBar will reset the options for it in XBar, meaning you will have to reapply custom sorting and individual button hiding options.  This is necessary to ensure that it works correctly.