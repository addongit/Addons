-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

-- Bindings
BINDING_NAME_XCUSTOMBAR_CONFIG = "XCustomBar Config";

-- Messages
XCUSTOMBAR_MSG1 	           = "XCustomBar: No data found, initializing...";
XCUSTOMBAR_MSG2                = "XCustomBar: Invalid entry.";
XCUSTOMBAR_MSG3                = "XCustomBar: Bar already exists.";
XCUSTOMBAR_MSG4                = "XCustomBar: Cleaning up old data from XBar optionsets...";
XCUSTOMBAR_MSG5                = "XCustomBar: Cleanup failed, XBar has not initialized.";
XCUSTOMBAR_MSG6                = "XCustomBar: Registering ";
XCUSTOMBAR_MSG7                = " mods with XBar...";
XCUSTOMBAR_MSG8                = "XCustomBar: |cffff7f7f NOT LOADED|r - XBar out of date, please update to version ";
XCUSTOMBAR_MSG9                = " or higher.";
XCUSTOMBAR_MSG10               = "XCustomBar: Importing options from old version.";
XCUSTOMBAR_MSG11               = "XCustomBar: Import failed due to corrupted database, reinitializing...";
XCUSTOMBAR_MSG12               = "XCustomBar: Invalid import string, aborting.";
XCUSTOMBAR_MSG13               = "XCustomBar: Import string wrong database version, aborting.";
XCUSTOMBAR_MSG14               = "XCustomBar: Invalid bar name.";
XCUSTOMBAR_MSG15               = "XCustomBar: Item ";
XCUSTOMBAR_MSG16               = " not in local cache.";

XCUSTOMBAR_HELPTEXT2           = "  /xcustombar config";

-- Localized text
XCUSTOMBAR_NEW                 = "New";
XCUSTOMBAR_DELETE              = "Delete";
XCUSTOMBAR_SAVE                = "Save";
XCUSTOMBAR_IMPORT              = "Import";
XCUSTOMBAR_EXPORT              = "Export";

XCUSTOMBAR_M1                  = "Modifiers";
XCUSTOMBAR_M2                  = "Shift";
XCUSTOMBAR_M3                  = "Ctrl";
XCUSTOMBAR_M4                  = "Alt";
XCUSTOMBAR_M5                  = "Target";
XCUSTOMBAR_M6                  = "Ally";
XCUSTOMBAR_M7                  = "Enemy";
XCUSTOMBAR_M8                  = "Any";
XCUSTOMBAR_M9                  = "Button";
XCUSTOMBAR_M10                 = "Left";
XCUSTOMBAR_M11                 = "Right";
XCUSTOMBAR_M12                 = "Spellbook";
XCUSTOMBAR_M13                 = "Spell";
XCUSTOMBAR_M14                 = "Pet";
XCUSTOMBAR_M15                 = "Companion Type";
XCUSTOMBAR_M16                 = "Mount";
XCUSTOMBAR_M17                 = "Wrapping";
XCUSTOMBAR_M18                 = "Nonwrapping";

XCUSTOMBAR_LABEL1              = "Custom Bars:";
XCUSTOMBAR_LABEL2              = "Buttons:";
XCUSTOMBAR_LABEL3              = "Actions:";
XCUSTOMBAR_LABEL4              = "<- Click to set";
XCUSTOMBAR_LABELSPELL          = "Spell";
XCUSTOMBAR_LABELMACRO          = "Macro";
XCUSTOMBAR_LABELITEM           = "Item";
XCUSTOMBAR_LABELCOMPANION      = "Companion";
XCUSTOMBAR_LABELEMOTE          = "Emote";
XCUSTOMBAR_LABELCHAT           = "Chat";
XCUSTOMBAR_LABELHEADER         = "Header";
XCUSTOMBAR_LABELSPACER         = "Spacer";

XCUSTOMBAR_LABELSAY            = "Say";
XCUSTOMBAR_LABELYELL           = "Yell";
XCUSTOMBAR_LABELPARTY          = "Party";
XCUSTOMBAR_LABELGUILD          = "Guild";
XCUSTOMBAR_LABELOFFICER        = "Officer";
XCUSTOMBAR_LABELRAID           = "Raid";
XCUSTOMBAR_LABELRAIDWARNING    = "Raid Warning";
XCUSTOMBAR_LABELBATTLEGROUND   = "Battleground";
XCUSTOMBAR_LABELWHISPER        = "Whisper";
XCUSTOMBAR_LABELCHANNEL        = "Channel";

XBAR_HELP_CONTEXT_CUSTOMCONFIG = "\124cffff7f7fXCustomBar\124r Configuration Window\n\124cffffd200===========================\124r\n\n"..
                                 "\124cffffd200Layout\124r\nThe window is divided into 5 sections: 4 columns from left to right-Bars, Buttons, Actions, Options; and the 5th is Import/Export on bottom:\n"..
								 "  ___________________________________\n"..
								 " /            |                |              |              \\\n"..
								 " | Bars    |  Buttons | Actions|Options |\n"..
								 " |            |                |              |              |\n"..
								 " |_______|_________|________|________|\n"..
								 " | Import/Export                                    |\n"..
								 " \\___________________________________/\n\n"..
								 "\124cffffd200Custom Bars:\124r\nThis shows you a list of custom bars you have created.\n"..
								 "* To make a new one, type the name in the box below and hit New.  All new bars have one spell\n"..
								 "   button with one action by default.\n"..
								 "* To delete a bar, select it in the list and hit delete.\n\n"..
								 "\124cffffd200Buttons:\124r\nShows the list of each button on the bar you have selected.\n"..
								 "* Use the +/- buttons at the top of the list to move buttons up or down the list.\n"..
								 "* To Add a new button, click the + button and select the type of button (it will be shown\n"..
								 "   to the right of it) then click Add.\n"..
								 "* To Delete a button, select it and click Delete.  You may not delete the only button, add\n"..
								 "   another type that you want and delete the default spell button later.\n\n"..
								 "\124cffffd200Actions:\124r\nThis lets you specify the action of the button you have selected.  Only spells buttons may benefit from multiple actions.\n"..
								 "* To add a new action, click New.\n* To delete the selected action, click Delete.  You may not delete the only action.\n"..
								 "* When you click an action, options for the action will appear on the right.\n\n"..
								 "\124cffffd200Options:\124r\n* The + button lets you change how the action works, this is only available for some button types.  You may set up multiple actions for "..
								 "one button dependent upon things like mouse button, target, and keyboard modifiers.\n* The text box is where you enter data appropriate for the type of button "..
								 "(eg. the name of a spell, macro, etc...).  Items require the itemID, not the name.\n"..
								 "* Some spells have non-typeable characters; you may get around this by importing a spell name via Spell ID, type ^ and the ID (ex. ^5246 for Intimidating Shout).  "..
								 "Avoid hitting the save button again after this, as it may remove the non-typeable characters.\n"..
								 "* There are also other options, such as an icon selector and more text fields dependent upon the type of button.\n\n"..
								 "\124cffffd200Import & Export:\124r\n* You may select bar and hit Export to save the bar in a text string which you can store somewhere else or share with a friend.\n"..
								 "* You may also Import a bar from a friend by pasting this text code in the bottom field, type a name for the new bar below the Custom Bars list, and hit Import.\n\n"..
								 "\124cffffd200Save & Close:\124r\nClicking this button will reload the User Interfaces so your changes can take effect.  You may hit ESC to close the window also,"..
								 " changes are still saved but not implemented. You should reload the UI soon to avoid errors with the bar.";

XCUSTOMBAR_SUB_TEXT = "  Click the button to open the XCustombar Configuration pane, or type\n"..
					  "'/xcustombar config'.  Further help is available by clicking the Help\n"..
					  "button at the top-right of the window.";

-- This is the set of characters that one could use to enter names for the new bars.  Other languages may want to expand that list.
XCUSTOMBAR_VALIDCHARS   = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-- Limitedchars contains characters that may appear in spell names and chat messages but shouldn't be used for object names in XML or LUA.
-- The ^ is included as a way to import spell IDs
XCUSTOMBAR_LIMITEDCHARS = " :'`()-^";

-- Chatchars contains characters that may be used in chat messages, but will not be used in spell names or object names.
XCUSTOMBAR_CHATCHARS = ".,<>[]{}\\/?~!@#$%^&*;\034=_+";

-- Unicode Latin characters - these may appear in spell names and chat, but not object names
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\162" --  â
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\164" --  ä
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\160" --  à
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\161" --  á
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\165" --  å
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\131" --  ă
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\133" --  ą
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\132" --  Ä
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\133" --  Å
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\166" --  æ
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\134" --  Æ
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\159" --  ß
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\135" --  ć
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\141" --  č
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\167" --  ç
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\135" --  Ç
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\134" --  Ć
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\140" --  Č
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\155" --  ě
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\168" --  è
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\169" --  é
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\170" --  ê
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\171" --  ë
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\153" --  ę
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\137" --  É
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\159" --  ğ
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\172" --  ì
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\173" --  í
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\174" --  î
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\175" --  ï
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\177" --  ı
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\196\176" --  İ
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\130" --  ł
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\129" --  Ł
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\177" --  ñ
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\132" --  ń
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\131" --  Ń
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\145" --  Ñ
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\145" --  ő
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\178" --  ò
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\179" --  ó
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\180" --  ô
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\182" --  ö
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\184" --  ø
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\147" --  Ó
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\150" --  Ö
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\152" --  Ø
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\153" --  ř
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\152" --  Ř
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\155" --  ś
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\159" --  ş
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\161" --  š
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\154" --  Ś
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\160" --  Š
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\163" --  ţ
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\165" --  ť
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\175" --  ů
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\177" --  ű
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\179" --  ų
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\185" --  ù
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\186" --  ú
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\187" --  û
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\188" --  ü
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\156" --  Ü
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\174" --  Ů
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\191" --  ÿ
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\189" --  ý
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\186" --  ź
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\188" --  ż
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\190" --  ž
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\185" --  Ź
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\187" --  Ż
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\197\189" --  Ž
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\158" --  Þ
XCUSTOMBAR_LIMITEDCHARS = XCUSTOMBAR_LIMITEDCHARS.."\195\190" --  þ

-- Detectable unicode prefixes
XCUSTOMBAR_UNICODEPREFIXES="\195\196\197";