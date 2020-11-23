//
//  Fci.swift
//  
//
//  Created by Hugh Bellamy on 06/11/2020.
//

/// [MS-DOC] 2.9.75 Fci
/// The Fci enumeration provides a 13-bit unsigned integer that specifies a built-in command.
public enum Fci: UInt16 {
    /// Help 0x0001 Help for the current task or command.
    case help = 0x0001

    /// HelpTool 0x0002 Displays Help documentation about a command or screen region or displays a detailed breakdown of the properties of text at a location on the screen.
    case helpTool = 0x0002

    /// HelpUsingHelp 0x0003 Displays instructions about how to use the Help documentation.
    case helpUsingHelp = 0x0003

    /// HelpActiveWindow 0x0004 Displays information about the active pane or document view.
    case helpActiveWindow = 0x0004

    /// HelpKeyboard 0x0005 Lists the keys and their actions.
    case helpKeyboard = 0x0005

    /// HelpIndex 0x0006 Displays the Help index.
    case helpIndex = 0x0006

    /// HelpQuickPreview 0x0007 Has no effect.
    case helpQuickPreview = 0x0007

    /// HelpExamplesAndDemos 0x0008 Has no effect.
    case helpExamplesAndDemos = 0x0008

    /// HelpAbout 0x0009 Displays the application information, version number and the copyright.
    case helpAbout = 0x0009

    /// HelpWordPerfectHelp 0x000A Has no effect.
    case helpWordPerfectHelp = 0x000A

    /// GrowFont 0x000B Increases the font size of the selection.
    case growFont = 0x000B

    /// ShrinkFont 0x000C Decreases the font size of the selection.
    case shrinkFont = 0x000C

    /// Overtype 0x000D Toggles the typing mode between replacing and inserting.
    case overtype = 0x000D

    /// ExtendSelection 0x000E Turns on extend selection mode and then expands the selection with the direction keys.
    case extendSelection = 0x000E

    /// Spike 0x000F Deletes the selection and adds it to the special AutoText entry.
    case spike = 0x000F

    /// InsertSpike 0x0010 Empties the spike AutoText entry and inserts all of its contents into the document.
    case insertSpike = 0x0010

    /// ChangeCase 0x0011 Changes the case of the letters in the selection.
    case changeCase = 0x0011

    /// MoveText 0x0012 Moves the selection to a specified location.
    case moveText = 0x0012

    /// CopyText 0x0013 Makes a copy of the selection at a specified location.
    case copyText = 0x0013

    /// InsertAutoText 0x0014 Replaces the name of the AutoText entry with its contents.
    case insertAutoText = 0x0014

    /// OtherPane 0x0015 Switches to the other window pane.
    case otherPane = 0x0015

    /// NextWindow 0x0016 Switches to the next document window.
    case nextWindow = 0x0016

    /// PrevWindow 0x0017 Switches back to the previous document window.
    case prevWindow = 0x0017

    /// RepeatFind 0x0018 Repeats Go To or Find to find the next occurrence.
    case repeatFind = 0x0018

    /// NextField 0x0019 Moves to the next field.
    case nextField = 0x0019

    /// PrevField 0x001A Moves to the previous field.
    case prevField = 0x001A

    /// ColumnSelect 0x001B Selects a columnar block of text.
    case columnSelect = 0x001B

    /// DeleteWord 0x001C Deletes the next word without putting it on the Clipboard.
    case deleteWord = 0x001C

    /// DeleteBackWord 0x001D Deletes the previous word without putting it on the Clipboard.
    case deleteBackWord = 0x001D

    /// EditClear 0x001E Performs a forward delete or removes the selection without putting it on the Clipboard.
    case editClear = 0x001E

    /// InsertFieldChars 0x001F Inserts a field with the enclosing field characters.
    case insertFieldChars = 0x001F

    /// UpdateFields 0x0020 Updates and displays the results of the selected fields.
    case updateFields = 0x0020

    /// UnlinkFields 0x0021 Permanently replaces the field codes with the results.
    case unlinkFields = 0x0021

    /// ToggleFieldDisplay 0x0022 Shows the field codes or the results for the selection (toggle).
    case toggleFieldDisplay = 0x0022

    /// LockFields 0x0023 Locks the selected fields to prevent updating.
    case lockFields = 0x0023

    /// UnlockFields 0x0024 Unlocks the selected fields for updating.
    case unlockFields = 0x0024

    /// UpdateSource 0x0025 Copies the modified text of a linked file back to its source.
    case updateSource = 0x0025

    /// Indent 0x0026 Moves the .logical left. indent to the next tab stop.
    case indent = 0x0026

    /// UnIndent 0x0027 Moves the .logical left. indent to the previous tab stop.
    case unIndent = 0x0027

    /// HangingIndent 0x0028 Increases the hanging indent.
    case hangingIndent = 0x0028

    /// UnHang 0x0029 Decreases the hanging indent.
    case unHang = 0x0029

    /// Font 0x002A Changes the font of the selection.
    case font = 0x002A

    /// FontSizeSelect 0x002B Changes the font size of the selection.
    case fontSizeSelect = 0x002B

    /// WW2_RulerMode 0x002C Makes the ruler active.
    case ww2_RulerMode = 0x002C

    /// Bold 0x002D Makes the selection bold (toggle).
    case bold = 0x002D

    /// Italic 0x002E Makes the selection italic (toggle).
    case italic = 0x002E

    /// SmallCaps 0x002F Makes the selection small capitals (toggle).
    case smallCaps = 0x002F

    /// AllCaps 0x0030 Makes the selection all capitals (toggle).
    case allCaps = 0x0030

    /// Strikethrough 0x0031 Makes the selection strikethrough (toggle).
    case strikethrough = 0x0031

    /// Hidden 0x0032 Makes the selection hidden text (toggle).
    case hidden = 0x0032

    /// Underline 0x0033 Formats the selection with a continuous underline (toggle).
    case underline = 0x0033

    /// DoubleUnderline 0x0034 Double underlines the selection (toggle).
    case doubleUnderline = 0x0034

    /// WordUnderline 0x0035 Underlines the words but not the spaces in the selection (toggle).
    case wordUnderline = 0x0035

    /// Superscript 0x0036 Makes the selection superscript (toggle).
    case superscript = 0x0036

    /// Subscript 0x0037 Makes the selection subscript (toggle).
    case `subscript` = 0x0037

    /// ResetChar 0x0038 Makes the selection the default character format of the applied style.
    case resetChar = 0x0038

    /// CharColor 0x0039 Changes the color of the selected text.
    case charColor = 0x0039

    /// LeftPara 0x003A Aligns the paragraph at the .logical left. indent.
    case leftPara = 0x003A

    /// CenterPara 0x003B Centers the paragraph between the indents.
    case centerPara = 0x003B

    /// RightPara 0x003C Aligns the paragraph at the .logical right. indent.
    case rightPara = 0x003C

    /// JustifyPara 0x003D Aligns the paragraph at both the .logical left. and the .logical right. indent.
    case justifyPara = 0x003D

    /// SpacePara1 0x003E Sets the line spacing to single space.
    case spacePara1 = 0x003E

    /// SpacePara15 0x003F Sets the line spacing to one-and-one-half space.
    case spacePara15 = 0x003F

    /// SpacePara2 0x0040 Sets the line spacing to double space.
    case spacePara2 = 0x0040

    /// CloseUpPara 0x0041 Removes extra spacing above the selected paragraph.
    case closeUpPara = 0x0041

    /// OpenUpPara 0x0042 Sets extra spacing above the selected paragraph.
    case openUpPara = 0x0042

    /// ResetPara 0x0043 Makes the selection the default paragraph format of the applied style.
    case resetPara = 0x0043

    /// EditRepeat 0x0044 Repeats the last action.
    case editRepeat = 0x0044

    /// GoBack 0x0045 Returns to the previous insertion point.
    case goBack = 0x0045

    /// SaveTemplate 0x0046 Saves the document template of the active document.
    case saveTemplate = 0x0046

    /// OK 0x0047 Confirms a location for copying or moving the selection.
    case oK = 0x0047

    /// Cancel 0x0048 Terminates an action.
    case cancel = 0x0048

    /// CopyFormat 0x0049 Copies the formatting of the selection to a specified location.
    case copyFormat = 0x0049

    /// PrevPage 0x004A Moves to the previous page.
    case prevPage = 0x004A

    /// NextPage 0x004B Moves to the next page.
    case nextPage = 0x004B

    /// NextObject 0x004C Moves to the next object on the page.
    case nextObject = 0x004C

    /// PrevObject 0x004D Moves to the previous object on the page.
    case prevObject = 0x004D

    /// DocumentStatistics 0x004E Displays the statistics of the active document.
    case documentStatistics = 0x004E

    /// FileNew 0x004F Opens New Document taskpane.
    case fileNew = 0x004F

    /// FileOpen 0x0050 Opens an existing document or template.
    case fileOpen = 0x0050

    /// MailMergeOpenDataSource 0x0051 Opens a data source for mail merge or insert database.
    case mailMergeOpenDataSource = 0x0051

    /// MailMergeOpenHeaderSource 0x0052 Opens a header source for mail merge.
    case mailMergeOpenHeaderSource = 0x0052

    /// FileSave 0x0053 Saves the active document or template.
    case fileSave = 0x0053

    /// FileSaveAs 0x0054 Saves a copy of the document in a separate file.
    case fileSaveAs = 0x0054

    /// FileSaveAll 0x0055 Saves all open files, macros, and building blocks and prompts for each one separately.
    case fileSaveAll = 0x0055

    /// FileSummaryInfo 0x0056 Shows the summary information about the active document.
    case fileSummaryInfo = 0x0056

    /// FileTemplates 0x0057 Changes the active template and the template options.
    case fileTemplates = 0x0057

    /// FilePrint 0x0058 Prints the active document.
    case filePrint = 0x0058

    /// FilePrintPreview 0x0059 Displays full pages as they will be printed.
    case filePrintPreview = 0x0059

    /// WW2_PrintMerge 0x005A Performs mail merge using header and data files.
    case ww2_PrintMerge = 0x005A

    /// WW2_PrintMergeCheck 0x005B Performs a check on a mail merge that uses header and data files.
    case ww2_PrintMergeCheck = 0x005B

    /// WW2_PrintMergeToDoc 0x005C Performs a mail merge using header and data files and places the result into the document.
    case ww2_PrintMergeToDoc = 0x005C

    /// WW2_PrintMergeToPrinter 0x005D Performs a mail merge using header and data files and sends the result to the printer.
    case ww2_PrintMergeToPrinter = 0x005D

    /// WW2_PrintMergeSelection 0x005E Sets mail merge options for mail merges using header and data files.
    case ww2_PrintMergeSelection = 0x005E

    /// WW2_PrintMergeHelper 0x005F Has no effect.
    case ww2_PrintMergeHelper = 0x005F

    /// MailMergeReset 0x0060 Resets a mail merge main document to a normal document.
    case mailMergeReset = 0x0060

    /// FilePrintSetup 0x0061 Changes the printer and the printing options.
    case filePrintSetup = 0x0061

    /// FileExit 0x0062 Quits the application and prompts to save the documents.
    case fileExit = 0x0062

    /// FileFind 0x0063 Locates the documents in any directory, drive, or folder.
    case fileFind = 0x0063

    /// FileMru 0x0064 Opens a file from the list of most-recently used files.
    case fileMru = 0x0064

    /// ApplyStyleName 0x0065 Applies the indicated style to the selected text.
    case applyStyleName = 0x0065

    /// FormatAddrFonts 0x0067 Formats the delivery address font for envelopes.
    case formatAddrFonts = 0x0067

    /// MailMergeEditDataSource 0x0068 Opens a mail merge data source.
    case mailMergeEditDataSource = 0x0068

    /// WW2_PrintMergeCreateDataSource 0x0069 Creates a data file for mail merges that use a header and data file.
    case ww2_PrintMergeCreateDataSource = 0x0069

    /// WW2_PrintMergeCreateHeaderSource 0x006A Creates a header file for mail merges that use a header and data file.
    case ww2_PrintMergeCreateHeaderSource = 0x006A

    /// EditUndo 0x006B Reverses the last action.
    case editUndo = 0x006B

    /// EditCut 0x006C Cuts the selection and puts it on the Clipboard.
    case editCut = 0x006C

    /// EditCopy 0x006D Copies the selection and puts it on the Clipboard.
    case editCopy = 0x006D

    /// EditPaste 0x006E Inserts the Clipboard contents at the insertion point.
    case editPaste = 0x006E

    /// EditPasteSpecial 0x006F Inserts the Clipboard contents as a linked object, embedded object, or other format.
    case editPasteSpecial = 0x006F

    /// EditFind 0x0070 Finds the specified text or the specified formatting.
    case editFind = 0x0070

    /// EditFindFont 0x0071 Has no effect.
    case editFindFont = 0x0071

    /// EditFindPara 0x0072 Has no effect.
    case editFindPara = 0x0072

    /// EditFindStyle 0x0073 Has no effect.
    case editFindStyle = 0x0073

    /// EditFindClearFormatting 0x0074 Has no effect.
    case editFindClearFormatting = 0x0074

    /// EditReplace 0x0075 Finds the specified text or the specified formatting and replaces it.
    case editReplace = 0x0075

    /// EditReplaceFont 0x0076 Has no effect.
    case editReplaceFont = 0x0076

    /// EditReplacePara 0x0077 Has no effect.
    case editReplacePara = 0x0077

    /// EditReplaceStyle 0x0078 Has no effect.
    case editReplaceStyle = 0x0078

    /// EditReplaceClearFormatting 0x0079 Has no effect.
    case editReplaceClearFormatting = 0x0079

    /// WW7_EditGoTo 0x007A Jumps to a specified place in the active document.
    case ww7_EditGoTo = 0x007A

    /// WW7_EditAutoText 0x007B Inserts or defines AutoText entries.
    case ww7_EditAutoText = 0x007B

    /// EditLinks 0x007C Allows links to be viewed, updated, opened, or removed.
    case editLinks = 0x007C

    /// EditObject 0x007D Opens the selected object for editing.
    case editObject = 0x007D

    /// ActivateObject 0x007E Activates an object.
    case activateObject = 0x007E

    /// TextToTable 0x007F Converts the text to table form.
    case textToTable = 0x007F

    /// TableToText 0x0080 Converts a table to text.
    case tableToText = 0x0080

    /// TableInsertTable 0x0081 Inserts a table.
    case tableInsertTable = 0x0081

    /// TableInsertCells 0x0082 Inserts one or more cells into the table.
    case tableInsertCells = 0x0082

    /// TableInsertRow 0x0083 Inserts one or more rows into the table.
    case tableInsertRow = 0x0083

    /// TableInsertColumn 0x0084 Inserts one or more columns into the table.
    case tableInsertColumn = 0x0084

    /// TableDeleteCells 0x0085 Deletes the selected cells from the table.
    case tableDeleteCells = 0x0085

    /// TableDeleteRow 0x0086 Deletes the selected rows from the table.
    case tableDeleteRow = 0x0086

    /// TableDeleteColumn 0x0087 Deletes the selected columns from the table.
    case tableDeleteColumn = 0x0087

    /// TableMergeCells 0x0088 Merges the selected table cells into a single cell.
    case tableMergeCells = 0x0088

    /// TableSplitCells 0x0089 Splits the selected table cells.
    case tableSplitCells = 0x0089

    /// TableSplit 0x008A Inserts a paragraph mark above the current row in the table.
    case tableSplit = 0x008A

    /// TableSelectTable 0x008B Selects an entire table.
    case tableSelectTable = 0x008B

    /// TableSelectRow 0x008C Selects the current row in a table.
    case tableSelectRow = 0x008C

    /// TableSelectColumn 0x008D Selects the current column in a table.
    case tableSelectColumn = 0x008D

    /// TableRowHeight 0x008E Changes the height of the rows in a table.
    case tableRowHeight = 0x008E

    /// TableColumnWidth 0x008F Changes the width of the columns in a table.
    case tableColumnWidth = 0x008F

    /// TableGridlines 0x0090 Toggles table gridlines on and off.
    case tableGridlines = 0x0090

    /// ViewNormal 0x0091 Changes the editing view to normal view.
    case viewNormal = 0x0091

    /// ViewOutline 0x0092 Displays a document outline.
    case viewOutline = 0x0092

    /// ViewPage 0x0093 Displays the page as it will be printed and allows editing.
    case viewPage = 0x0093

    /// WW2_ViewZoom 0x0094 Scales the editing view.
    case ww2_ViewZoom = 0x0094

    /// ViewDraft 0x0095 Displays the document without formatting and pictures for faster editing (toggle).
    case viewDraft = 0x0095

    /// ViewFieldCodes 0x0096 Shows the field codes or results for all fields (toggle).
    case viewFieldCodes = 0x0096

    /// Style 0x0097 Applies an existing style or records a style by example.
    case style = 0x0097

    /// ToolsCustomize 0x0098 Customizes the application user interface including menus, keyboard and toolbars.
    case toolsCustomize = 0x0098

    /// ViewRuler 0x0099 Shows or hides the ruler.
    case viewRuler = 0x0099

    /// ViewStatusBar 0x009A Shows or hides the status bar.
    case viewStatusBar = 0x009A

    /// NormalViewHeaderArea 0x009B Shows a list of headers and footers for editing.
    case normalViewHeaderArea = 0x009B

    /// ViewFootnoteArea 0x009C Opens a pane for viewing and editing the footnotes (toggle).
    case viewFootnoteArea = 0x009C

    /// ViewAnnotations 0x009D Show or hide comment markup balloons.
    case viewAnnotations = 0x009D

    /// InsertFrame 0x009E Inserts an empty frame or encloses the selected item in a frame.
    case insertFrame = 0x009E

    /// InsertBreak 0x009F Ends a page, column, or section at the insertion point.
    case insertBreak = 0x009F

    /// WW2_InsertFootnote 0x00A0 Inserts a footnote reference at the insertion point.
    case ww2_InsertFootnote = 0x00A0

    /// InsertAnnotation 0x00A1 Inserts a comment.
    case insertAnnotation = 0x00A1

    /// InsertSymbol 0x00A2 Inserts a special character.
    case insertSymbol = 0x00A2

    /// InsertPicture 0x00A3 Inserts a picture from a graphics file.
    case insertPicture = 0x00A3

    /// InsertFile 0x00A4 Inserts the text of another file into the active document.
    case insertFile = 0x00A4

    /// InsertDateTime 0x00A5 Inserts the current date, time, or both into the active document.
    case insertDateTime = 0x00A5

    /// InsertField 0x00A6 Inserts a field in the active document.
    case insertField = 0x00A6

    /// InsertMergeField 0x00A7 Inserts a mail merge field at the insertion point.
    case insertMergeField = 0x00A7

    /// EditBookmark 0x00A8 Assigns a name to the selection.
    case editBookmark = 0x00A8

    /// MarkIndexEntry 0x00A9 Marks the text to include in the index.
    case markIndexEntry = 0x00A9

    /// InsertIndex 0x00AA Collects the index entries into an index.
    case insertIndex = 0x00AA

    /// InsertTableOfContents 0x00AB Collects the headings or the table of contents entries into a table of contents.
    case insertTableOfContents = 0x00AB

    /// InsertObject 0x00AC Inserts an equation, chart, drawing, or some other object.
    case insertObject = 0x00AC

    /// ToolsCreateEnvelope 0x00AD Creates or prints an envelope.
    case toolsCreateEnvelope = 0x00AD

    /// FormatFont 0x00AE Changes the appearance of the selected characters.
    case formatFont = 0x00AE

    /// FormatParagraph 0x00AF Changes the appearance and line numbering of the selected paragraphs.
    case formatParagraph = 0x00AF

    /// FormatSectionLayout 0x00B0 Changes the page format of the selected sections.
    case formatSectionLayout = 0x00B0

    /// FormatColumns 0x00B1 Changes the column format of the selected sections.
    case formatColumns = 0x00B1

    /// FilePageSetup 0x00B2 Changes the page setup of the selected sections.
    case filePageSetup = 0x00B2

    /// FormatTabs 0x00B3 Sets and clears the tab stops for the selected paragraphs.
    case formatTabs = 0x00B3

    /// FormatStyle 0x00B4 Applies, creates, or modifies styles.
    case formatStyle = 0x00B4

    /// FormatDefineStyleFont 0x00B5 Has no effect.
    case formatDefineStyleFont = 0x00B5

    /// FormatDefineStylePara 0x00B6 Has no effect.
    case formatDefineStylePara = 0x00B6

    /// FormatDefineStyleTabs 0x00B7 Has no effect.
    case formatDefineStyleTabs = 0x00B7

    /// FormatDefineStyleFrame 0x00B8 Has no effect.
    case formatDefineStyleFrame = 0x00B8

    /// FormatDefineStyleBorders 0x00B9 Has no effect.
    case formatDefineStyleBorders = 0x00B9

    /// FormatDefineStyleLang 0x00BA Has no effect.
    case formatDefineStyleLang = 0x00BA

    /// FormatPicture 0x00BB Changes the picture scaling, size, and cropping information.
    case formatPicture = 0x00BB

    /// ToolsLanguage 0x00BC Changes the language formatting of the selected characters.
    case toolsLanguage = 0x00BC

    /// FormatBordersAndShading 0x00BD Changes the borders and shading of the selected paragraphs, table cells, and pictures.
    case formatBordersAndShading = 0x00BD

    /// FormatFrame 0x00BE Changes the options for frame formatting.
    case formatFrame = 0x00BE

    /// ToolsSpelling 0x00BF Checks the spelling in the active document.
    case toolsSpelling = 0x00BF

    /// ToolsSpellSelection 0x00C0 Checks the spelling of the selected text.
    case toolsSpellSelection = 0x00C0

    /// ToolsGrammar 0x00C1 Checks the grammar in the active document.
    case toolsGrammar = 0x00C1

    /// ToolsThesaurus 0x00C2 Finds a synonym for the selected word.
    case toolsThesaurus = 0x00C2

    /// ToolsHyphenation 0x00C3 Changes the hyphenation settings for the active document.
    case toolsHyphenation = 0x00C3

    /// ToolsBulletsNumbers 0x00C4 Changes the numbered and bulleted paragraphs.
    case toolsBulletsNumbers = 0x00C4

    /// ToolsRevisions 0x00C5 Sets track changes for the active document.
    case toolsRevisions = 0x00C5

    /// ToolsCompareVersions 0x00C6 Compares the active document with an earlier version.
    case toolsCompareVersions = 0x00C6

    /// TableSort 0x00C7 Rearranges the selection into a specified order.
    case tableSort = 0x00C7

    /// ToolsCalculate 0x00C8 Calculates expressions in the selection.
    case toolsCalculate = 0x00C8

    /// ToolsRepaginate 0x00C9 Recalculates the page breaks.
    case toolsRepaginate = 0x00C9

    /// WW7_ToolsOptions 0x00CA Changes various categories of the application options.
    case ww7_ToolsOptions = 0x00CA

    /// ToolsOptionsGeneral 0x00CB Changes the general options.
    case toolsOptionsGeneral = 0x00CB

    /// ToolsOptionsView 0x00CC Set specific view mode options.
    case toolsOptionsView = 0x00CC

    /// ToolsAdvancedSettings 0x00CE Changes advanced options.
    case toolsAdvancedSettings = 0x00CE

    /// ToolsOptionsPrint 0x00D0 Changes the printing options.
    case toolsOptionsPrint = 0x00D0

    /// ToolsOptionsSave 0x00D1 Changes the save settings.
    case toolsOptionsSave = 0x00D1

    /// WW2_ToolsOptionsToolbar 0x00D2 Changes the buttons on the toolbar.
    case ww2_ToolsOptionsToolbar = 0x00D2

    /// ToolsOptionsSpelling 0x00D3 Changes the proofreader options.
    case toolsOptionsSpelling = 0x00D3

    /// ToolsOptionsGrammar 0x00D4 Changes the proofreader options.
    case toolsOptionsGrammar = 0x00D4

    /// ToolsOptionsUserInfo 0x00D5 Changes the user information options.
    case toolsOptionsUserInfo = 0x00D5

    /// ToolsRecordMacroToggle 0x00D6 Turns macro recording on or off.
    case toolsRecordMacroToggle = 0x00D6

    /// ToolsMacro 0x00D7 Runs, creates, deletes, or revises a macro.
    case toolsMacro = 0x00D7

    /// PauseRecorder 0x00D8 Pauses the macro recorder (toggle).
    case pauseRecorder = 0x00D8

    /// WindowNewWindow 0x00D9 Opens another window for the active document.
    case windowNewWindow = 0x00D9

    /// WindowArrangeAll 0x00DA Arranges windows as non-overlapping tiles.
    case windowArrangeAll = 0x00DA

    /// MailMergeEditMainDocument 0x00DB Switches to a mail merge main document.
    case mailMergeEditMainDocument = 0x00DB

    /// WindowList 0x00DC Switches to the window containing the specified document.
    case windowList = 0x00DC

    /// FormatRetAddrFonts 0x00DD Formats the return address font for envelopes.
    case formatRetAddrFonts = 0x00DD

    /// Organizer 0x00DE Manages AutoText entries, styles, macros, and toolbars.
    case organizer = 0x00DE

    /// WW2_TableColumnWidth 0x00DF Changes the width of the columns in a table.
    case ww2_TableColumnWidth = 0x00DF

    /// ToolsOptionsEdit 0x00E0 Changes the editing options.
    case toolsOptionsEdit = 0x00E0

    /// ToolsOptionsFileLocations 0x00E1 Changes the default locations used to find files.
    case toolsOptionsFileLocations = 0x00E1

    /// RecordNextCommand 0x00E2 Records the next command executed.
    case recordNextCommand = 0x00E2

    /// ToolsAutoCorrectSmartQuotes 0x00E3 Selects or clears the AutoCorrect SmartQuotes check box.
    case toolsAutoCorrectSmartQuotes = 0x00E3

    /// ToolsWordCount 0x00E4 Displays the word count statistics of the active document.
    case toolsWordCount = 0x00E4

    /// DocSplit 0x00E5 Splits the active window horizontally and then adjusts the split.
    case docSplit = 0x00E5

    /// DocSize 0x00E6 Changes the size of the active window.
    case docSize = 0x00E6

    /// DocMove 0x00E7 Changes the position of the active window.
    case docMove = 0x00E7

    /// DocMaximize 0x00E8 Enlarges the active window to full size.
    case docMaximize = 0x00E8

    /// DocRestore 0x00E9 Restores the window to normal size.
    case docRestore = 0x00E9

    /// DocClose 0x00EA Prompts to save the document and then closes the active window.
    case docClose = 0x00EA

    /// ControlRun 0x00EB Displays the Control Panel or the Clipboard.
    case controlRun = 0x00EB

    /// ShrinkSelection 0x00EC Shrinks the selection to the next smaller unit.
    case shrinkSelection = 0x00EC

    /// EditSelectAll 0x00ED Selects the entire document.
    case editSelectAll = 0x00ED

    /// InsertPageField 0x00EF Inserts a page number field.
    case insertPageField = 0x00EF

    /// InsertDateField 0x00F0 Inserts a date field.
    case insertDateField = 0x00F0

    /// InsertTimeField 0x00F1 Inserts a time field.
    case insertTimeField = 0x00F1

    /// FormatHeaderFooterLink 0x00F2 Links this header/footer to the previous section.
    case formatHeaderFooterLink = 0x00F2

    /// ClosePane 0x00F3 Closes the active window pane.
    case closePane = 0x00F3

    /// OutlinePromote 0x00F4 Promotes the selected paragraphs one heading level.
    case outlinePromote = 0x00F4

    /// OutlineDemote 0x00F5 Demotes the selected paragraphs one heading level.
    case outlineDemote = 0x00F5

    /// OutlineMoveUp 0x00F6 Moves the selection above the previous item in the outline.
    case outlineMoveUp = 0x00F6

    /// OutlineMoveDown 0x00F7 Moves the selection below the next item in the outline.
    case outlineMoveDown = 0x00F7

    /// NormalStyle 0x00F8 Applies the Normal style.
    case normalStyle = 0x00F8

    /// OutlineExpand 0x00F9 Displays the next level of subtext of the selection.
    case outlineExpand = 0x00F9

    /// OutlineCollapse 0x00FA Hides the lowest subtext of the selection.
    case outlineCollapse = 0x00FA

    /// ShowHeading1 0x00FB Displays the level 1 headings only.
    case showHeading1 = 0x00FB

    /// ShowHeading2 0x00FC Displays the level 1 and 2 headings.
    case showHeading2 = 0x00FC

    /// ShowHeading3 0x00FD Displays the level 1 through 3 headings.
    case showHeading3 = 0x00FD

    /// ShowHeading4 0x00FE Displays the level 1 through 4 headings.
    case showHeading4 = 0x00FE

    /// ShowHeading5 0x00FF Displays the level 1 through 5 headings.
    case showHeading5 = 0x00FF

    /// ShowHeading6 0x0100 Displays the level 1 through 6 headings.
    case showHeading6 = 0x0100

    /// ShowHeading7 0x0101 Displays the level 1 through 7 headings.
    case showHeading7 = 0x0101

    /// ShowHeading8 0x0102 Displays the level 1 through 8 headings.
    case showHeading8 = 0x0102

    /// ShowHeading9 0x0103 Displays the level 1 through 9 headings.
    case showHeading9 = 0x0103

    /// ShowAllHeadings 0x0104 Displays all of the heading levels and the body text.
    case showAllHeadings = 0x0104

    /// OutlineShowFirstLine 0x0105 Toggles between showing the first line of each paragraph only or showing all of the body text in the outline.
    case outlineShowFirstLine = 0x0105

    /// OutlineShowFormat 0x0106 Toggles the display of character formatting in outline view.
    case outlineShowFormat = 0x0106

    /// ShowVars 0x0107 Has no effect.
    case showVars = 0x0107

    /// StepOver 0x0108 Has no effect.
    case stepOver = 0x0108

    /// StepIn 0x0109 Has no effect.
    case stepIn = 0x0109

    /// ContinueMacro 0x010A Has no effect.
    case continueMacro = 0x010A

    /// TraceMacro 0x010B Has no effect.
    case traceMacro = 0x010B

    /// EditObjectPrivate 0x010C Opens the selected object for editing.
    case editObjectPrivate = 0x010C

    /// NextCell 0x010E Moves to the next table cell.
    case nextCell = 0x010E

    /// PrevCell 0x010F Moves to the previous table cell.
    case prevCell = 0x010F

    /// StartOfRow 0x0110 Moves to the first cell in the current row.
    case startOfRow = 0x0110

    /// EndOfRow 0x0111 Moves to the last cell in the current row.
    case endOfRow = 0x0111

    /// StartOfColumn 0x0112 Moves to the first cell in the current column.
    case startOfColumn = 0x0112

    /// EndOfColumn 0x0113 Moves to the last cell in the current column.
    case endOfColumn = 0x0113

    /// ShowAll 0x0114 Shows or hides all nonprinting characters.
    case showAll = 0x0114

    /// WW7_InsertPageBreak 0x0115 Inserts a page break at the insertion point.
    case ww7_InsertPageBreak = 0x0115

    /// WW7_InsertColumnBreak 0x0116 Inserts a column break at the insertion point.
    case ww7_InsertColumnBreak = 0x0116

    /// AppMinimize 0x0117 Minimizes the application window to an icon.
    case appMinimize = 0x0117

    /// AppMaximize 0x0118 Enlarges the application window to full size.
    case appMaximize = 0x0118

    /// AppRestore 0x0119 Restores the application window to normal size.
    case appRestore = 0x0119

    /// DoFieldClick 0x011A Executes the action associated with the button fields.
    case doFieldClick = 0x011A

    /// FileClose 0x011B Closes all of the windows of the active document.
    case fileClose = 0x011B

    /// InsertDrawing 0x011C Inserts a Microsoft Draw object.
    case insertDrawing = 0x011C

    /// InsertChart 0x011D Inserts a Microsoft Graph object.
    case insertChart = 0x011D

    /// SelectCurFont 0x011E Selects all characters with the same font name and point size.
    case selectCurFont = 0x011E

    /// SelectCurAlignment 0x011F Selects all paragraphs with the same alignment.
    case selectCurAlignment = 0x011F

    /// SelectCurSpacing 0x0120 Selects all paragraphs with the same line spacing.
    case selectCurSpacing = 0x0120

    /// SelectCurIndent 0x0121 Selects all paragraphs with the same indentation.
    case selectCurIndent = 0x0121

    /// SelectCurTabs 0x0122 Selects all paragraphs with the same tabs.
    case selectCurTabs = 0x0122

    /// SelectCurColor 0x0123 Selects all characters with the same color.
    case selectCurColor = 0x0123

    /// RemoveFrames 0x0124 Removes frame formatting from the selection.
    case removeFrames = 0x0124

    /// MenuMode 0x0125 Makes the menu bar active.
    case menuMode = 0x0125

    /// InsertPageNumbers 0x0126 Adds page numbers to the top or the bottom of the pages.
    case insertPageNumbers = 0x0126

    /// WW2_ChangeRulerMode 0x0127 Changes the display mode of the ruler (paragraph, table, and document).
    case ww2_ChangeRulerMode = 0x0127

    /// EditPicture 0x0128 Uses the specified drawing application to edit the selected picture.
    case editPicture = 0x0128

    /// UserDialog 0x0129 Has no effect.
    case userDialog = 0x0129

    /// FormatPageNumber 0x012A Changes the appearance of page numbers.
    case formatPageNumber = 0x012A

    /// WW2_FootnoteOptions 0x012B Changes the options for footnotes.
    case ww2_FootnoteOptions = 0x012B

    /// CopyFile 0x012C Copies the specified file to the specified destination.
    case copyFile = 0x012C

    /// FileNewDefault 0x012D Creates a new document based on the NORMAL template.
    case fileNewDefault = 0x012D

    /// FilePrintDefault 0x012E Prints the active document using the current defaults.
    case filePrintDefault = 0x012E

    /// ViewZoomWholePage 0x012F Scales the editing view to see the whole page in page layout view.
    case viewZoomWholePage = 0x012F

    /// ViewZoomPageWidth 0x0130 Scales the editing view to see the width of the page.
    case viewZoomPageWidth = 0x0130

    /// ViewZoom100 0x0131 Scales the editing view to 100% in normal view.
    case viewZoom100 = 0x0131

    /// TogglePortrait 0x0132 Toggles between portrait and landscape mode.
    case togglePortrait = 0x0132

    /// ToolsBulletListDefault 0x0133 Creates a bulleted list based on the current defaults.
    case toolsBulletListDefault = 0x0133

    /// ToggleScribbleMode 0x0134 Inserts a pen comment at the location of the insertion point.
    case toggleScribbleMode = 0x0134

    /// ToolsNumberListDefault 0x0135 Creates a numbered list based on the current defaults.
    case toolsNumberListDefault = 0x0135

    /// FileAOCEAddMailer 0x0137 Has no effect.
    case fileAOCEAddMailer = 0x0137

    /// FileAOCEDeleteMailer 0x0138 Has no effect.
    case fileAOCEDeleteMailer = 0x0138

    /// FileAOCEExpandMailer 0x0139 Has no effect.
    case fileAOCEExpandMailer = 0x0139

    /// FileAOCESendMail 0x013B Has no effect.
    case fileAOCESendMail = 0x013B

    /// FileAOCEReplyMail 0x013C Has no effect.
    case fileAOCEReplyMail = 0x013C

    /// FileAOCEReplyAllMail 0x013D Has no effect.
    case fileAOCEReplyAllMail = 0x013D

    /// FileAOCEForwardMail 0x013E Has no effect.
    case fileAOCEForwardMail = 0x013E

    /// FileAOCENextLetter 0x013F Has no effect.
    case fileAOCENextLetter = 0x013F

    /// DocMinimize 0x0140 Minimizes the active window to an icon.
    case docMinimize = 0x0140

    /// FormatAutoFormatBegin 0x0141 Automatically formats a document.
    case formatAutoFormatBegin = 0x0141

    /// FormatChangeCase 0x0142 Changes the case of the letters in the selection.
    case formatChangeCase = 0x0142

    /// ViewToolbars 0x0143 Shows or hides the application toolbars.
    case viewToolbars = 0x0143

    /// TableInsertGeneral 0x0144 Inserts rows, columns, or cells in a table.
    case tableInsertGeneral = 0x0144

    /// TableDeleteGeneral 0x0145 Deletes rows, columns, or cells in a table.
    case tableDeleteGeneral = 0x0145

    /// WW2_TableRowHeight 0x0146 Changes the height of the rows in a table.
    case ww2_TableRowHeight = 0x0146

    /// TableToOrFromText 0x0147 Converts text to a table or a table to text.
    case tableToOrFromText = 0x0147

    /// EditRedo 0x0149 Redoes the last action that was undone.
    case editRedo = 0x0149

    /// EditRedoOrRepeat 0x014A Redoes the last action that was undone or repeats the last action.
    case editRedoOrRepeat = 0x014A

    /// UpdateToc 0x014B Select method of updating a table of contents or captions.
    case updateToc = 0x014B

    /// ViewEndnoteArea 0x0152 Opens a pane for viewing and editing the endnotes (toggle).
    case viewEndnoteArea = 0x0152

    /// MailMergeDataForm 0x0154 Edits a list or table in a form.
    case mailMergeDataForm = 0x0154

    /// InsertDatabase 0x0155 Inserts information from an external data source into the active document.
    case insertDatabase = 0x0155

    /// WW2_InsertTableOfContents 0x0158 Collects the headings or the table of contents entries into a table of contents.
    case ww2_InsertTableOfContents = 0x0158

    /// WW2_ToolsHyphenation 0x0159 Hyphenates the current selection. FormatFrameOrFramePicture 0x015A Puts the selected picture in a frame or formats a frame.
    case ww2_ToolsHyphenation = 0x0159

    /// WW2_ToolsOptionsPrint 0x015B Has no effect.
    case ww2_ToolsOptionsPrint = 0x015B

    /// TableFormula 0x015C Inserts a formula field into a table cell.
    case tableFormula = 0x015C

    /// TextFormField 0x015D Inserts a text form field.
    case textFormField = 0x015D

    /// CheckBoxFormField 0x015E Inserts a check box form field.
    case checkBoxFormField = 0x015E

    /// DropDownFormField 0x015F Inserts a drop-down form field.
    case dropDownFormField = 0x015F

    /// FormFieldOptions 0x0161 Changes the options for a form field.
    case formFieldOptions = 0x0161

    /// ProtectForm 0x0162 Toggles protection for the active document.
    case protectForm = 0x0162

    /// ApplyFontName 0x0164 Applies the indicated font to the selected text.
    case applyFontName = 0x0164

    /// InsertCaption 0x0165 Inserts a caption above or below a selected object.
    case insertCaption = 0x0165

    /// InsertCaptionNumbering 0x0166 Sets the number for a caption type.
    case insertCaptionNumbering = 0x0166

    /// InsertAutoCaption 0x0167 Defines which objects are inserted with a caption.
    case insertAutoCaption = 0x0167

    /// HelpPSSHelp 0x0168 Displays information about the support available for the application.
    case helpPSSHelp = 0x0168

    /// WW7_DrawTextBox 0x016B Inserts a text box drawing object.
    case ww7_DrawTextBox = 0x016B

    /// WW7_ToolsOptionsAutoFormat 0x016D Changes the AutoFormat options.
    case ww7_ToolsOptionsAutoFormat = 0x016D

    /// DemoteToBodyText 0x016E Applies the Normal style and converts the selected headings to body text.
    case demoteToBodyText = 0x016E

    /// InsertCrossReference 0x016F Inserts a cross-reference.
    case insertCrossReference = 0x016F

    /// InsertFootnoteNow 0x0170 Inserts a footnote reference at the insertion point.
    case insertFootnoteNow = 0x0170

    /// InsertEndnoteNow 0x0171 Inserts an endnote reference at the insertion point.
    case insertEndnoteNow = 0x0171

    /// InsertFootnote 0x0172 Inserts a footnote or endnote reference at the insertion point.
    case insertFootnote = 0x0172

    /// NoteOptions 0x0175 Changes the options for footnotes or endnotes.
    case noteOptions = 0x0175

    /// WW2_FormatCharacter 0x0176 Changes the appearance of the selected characters.
    case ww2_FormatCharacter = 0x0176

    /// DrawLine 0x0178 Inserts a line drawing object.
    case drawLine = 0x0178

    /// DrawRectangle 0x0179 Inserts a rectangle drawing object.
    case drawRectangle = 0x0179

    /// ToolsAutoCorrect 0x017A Adds or deletes AutoCorrect entries.
    case toolsAutoCorrect = 0x017A

    /// ToolsAutoCorrectReplaceText 0x017C Selects or clears the AutoCorrect ReplaceText check box.
    case toolsAutoCorrectReplaceText = 0x017C

    /// ToolsAutoCorrectInitialCaps 0x017D Selects or clears the AutoCorrect InitialCaps check box.
    case toolsAutoCorrectInitialCaps = 0x017D

    /// ToolsAutoCorrectSentenceCaps 0x017F Selects or clears the AutoCorrect SentenceCaps check box.
    case toolsAutoCorrectSentenceCaps = 0x017F

    /// ToolsAutoCorrectDays 0x0180 Selects or clears the AutoCorrect Days check box.
    case toolsAutoCorrectDays = 0x0180

    /// FormatAutoFormat 0x0181 Automatically formats a document.
    case formatAutoFormat = 0x0181

    /// ToolsOptionsRevisions 0x0182 Changes track changes options.
    case toolsOptionsRevisions = 0x0182

    /// WW2_ToolsOptionsGeneral 0x0183 Has no effect.
    case ww2_ToolsOptionsGeneral = 0x0183

    /// ResetNoteSepOrNotice 0x0184 Resets a separator, continuation separator, or continuation notice to the application default.
    case resetNoteSepOrNotice = 0x0184

    /// FormatBullet 0x0185 Creates a bulleted list.
    case formatBullet = 0x0185

    /// FormatNumber 0x0186 Creates a numbered list.
    case formatNumber = 0x0186

    /// FormatMultilevel 0x0187 Creates a multilevel list.
    case formatMultilevel = 0x0187

    /// ConvertObject 0x0188 Converts or activates an object as another type.
    case convertObject = 0x0188

    /// TableSortAToZ 0x0189 Sorts records in ascending order (A to Z).
    case tableSortAToZ = 0x0189

    /// TableSortZToA 0x018A Sorts records in descending order (Z to A).
    case tableSortZToA = 0x018A

    /// WW7_FormatBulletsAndNumbering 0x018D Creates a numbered or bulleted list.
    case ww7_FormatBulletsAndNumbering = 0x018D

    /// FormatSimpleNumberDefault 0x018E Creates a numbered list based on the current defaults.
    case formatSimpleNumberDefault = 0x018E

    /// FormatBulletDefault 0x018F Creates a bulleted list based on the current defaults.
    case formatBulletDefault = 0x018F

    /// InsertAddCaption 0x0192 Adds a new caption type.
    case insertAddCaption = 0x0192

    /// GoToNextPage 0x0194 Jumps to the next page in the active document.
    case goToNextPage = 0x0194

    /// GoToPreviousPage 0x0195 Jumps to the previous page in the active document.
    case goToPreviousPage = 0x0195

    /// GoToNextSection 0x0196 Jumps to the next section in the active document.
    case goToNextSection = 0x0196

    /// GoToPreviousSection 0x0197 Jumps to the previous section in the active document.
    case goToPreviousSection = 0x0197

    /// GoToNextFootnote 0x0198 Jumps to the next footnote in the active document.
    case goToNextFootnote = 0x0198

    /// GoToPreviousFootnote 0x0199 Jumps to the previous footnote in the active document.
    case goToPreviousFootnote = 0x0199

    /// GoToNextEndnote 0x019A Jumps to the next endnote in the active document.
    case goToNextEndnote = 0x019A

    /// GoToPreviousEndnote 0x019B Jumps to the previous endnote in the active document.
    case goToPreviousEndnote = 0x019B

    /// GoToNextComment 0x019C Jumps to the next comment in the active document.
    case goToNextComment = 0x019C

    /// GoToPreviousComment 0x019D Jumps to the previous comment in the active document.
    case goToPreviousComment = 0x019D

    /// WW2_FormatDefineStyleChar 0x019E Has no effect.
    case ww2_FormatDefineStyleChar = 0x019E

    /// WW2_EditFindChar 0x019F Has no effect.
    case ww2_EditFindChar = 0x019F

    /// WW2_EditReplaceChar 0x01A0 Has no effect.
    case ww2_EditReplaceChar = 0x01A0

    /// AppMove 0x01A2 Changes the position of the application window.
    case appMove = 0x01A2

    /// AppSize 0x01A3 Changes the size of the application window.
    case appSize = 0x01A3

    /// Connect 0x01A4 Connects to a network drive.
    case connect = 0x01A4

    /// WW2_EditFind 0x01A5 Has no effect.
    case ww2_EditFind = 0x01A5

    /// WW2_EditReplace 0x01A6 Has no effect.
    case ww2_EditReplace = 0x01A6

    /// EditFindLang 0x01AC Has no effect.
    case editFindLang = 0x01AC

    /// EditReplaceLang 0x01AD Has no effect.
    case editReplaceLang = 0x01AD

    /// MailMergeViewData 0x01AF Toggles between viewing merge fields and actual data.
    case mailMergeViewData = 0x01AF

    /// ToolsCustomizeKeyboard 0x01B0 Customizes the application key assignments.
    case toolsCustomizeKeyboard = 0x01B0

    /// ToolsCustomizeMenus 0x01B1 Customizes the application menu assignments.
    case toolsCustomizeMenus = 0x01B1

    /// WW2_ToolsOptionsKeyboard 0x01B2 Remaps keys within the document.
    case ww2_ToolsOptionsKeyboard = 0x01B2

    /// ToolsMergeRevisions 0x01B3 Merges changes from the active document to an earlier version.
    case toolsMergeRevisions = 0x01B3

    /// ClosePreview 0x01B5 Exits print preview.
    case closePreview = 0x01B5

    /// SkipNumbering 0x01B6 Makes the selected paragraphs skip numbering.
    case skipNumbering = 0x01B6

    /// EditConvertAllFootnotes 0x01B7 Converts all footnotes into endnotes.
    case editConvertAllFootnotes = 0x01B7

    /// EditConvertAllEndnotes 0x01B8 Converts all endnotes into footnotes.
    case editConvertAllEndnotes = 0x01B8

    /// EditSwapAllNotes 0x01B9 Changes all footnotes to endnotes and all endnotes to footnotes.
    case editSwapAllNotes = 0x01B9

    /// MarkTableOfContentsEntry 0x01BA Marks the text to include in the table of contents.
    case markTableOfContentsEntry = 0x01BA

    /// FilePgSetupGX 0x01BC Has no effect.
    case filePgSetupGX = 0x01BC

    /// FilePrintOneGX 0x01BD Has no effect.
    case filePrintOneGX = 0x01BD

    /// EditFindTabs 0x01BE Has no effect.
    case editFindTabs = 0x01BE

    /// EditFindBorder 0x01BF Has no effect.
    case editFindBorder = 0x01BF

    /// EditFindFrame 0x01C0 Has no effect.
    case editFindFrame = 0x01C0

    /// BorderOutside 0x01C1 Changes the outside borders of the selected paragraphs, table cells, and pictures.
    case borderOutside = 0x01C1

    /// BorderNone 0x01C2 Removes borders from the selected paragraphs, table cells, and pictures.
    case borderNone = 0x01C2

    /// BorderLineStyle 0x01C3 Changes border line styles of the selected paragraphs, table cells, and pictures.
    case borderLineStyle = 0x01C3

    /// ShadingPattern 0x01C4 Changes shading pattern of the selected paragraphs, table cells, and pictures.
    case shadingPattern = 0x01C4

    /// DrawEllipse 0x01C6 Inserts an ellipse drawing object.
    case drawEllipse = 0x01C6

    /// DrawArc 0x01C7 Inserts an arc drawing object.
    case drawArc = 0x01C7

    /// EditReplaceTabs 0x01C8 Has no effect.
    case editReplaceTabs = 0x01C8

    /// EditReplaceBorder 0x01C9 Has no effect.
    case editReplaceBorder = 0x01C9

    /// EditReplaceFrame 0x01CA Has no effect.
    case editReplaceFrame = 0x01CA

    /// EditOfficeClipboard 0x01CB Displays the contents of the shared application clipboard.
    case editOfficeClipboard = 0x01CB

    /// EditConvertNotes 0x01CE Converts selected footnotes into endnotes, or converts selected endnotes into footnotes.
    case editConvertNotes = 0x01CE

    /// MarkCitation 0x01CF Marks the text to include in the table of authorities.
    case markCitation = 0x01CF

    /// WW2_ToolsRevisionsMark 0x01D0 Has no effect.
    case ww2_ToolsRevisionsMark = 0x01D0

    /// DrawGroup 0x01D1 Groups the selected drawing objects.
    case drawGroup = 0x01D1

    /// DrawBringToFront 0x01D2 Brings the selected drawing objects to the front.
    case drawBringToFront = 0x01D2

    /// DrawSendToBack 0x01D3 Sends the selected drawing objects to the back.
    case drawSendToBack = 0x01D3

    /// DrawSendBehindText 0x01D4 Sends the selected drawing objects back one layer.
    case drawSendBehindText = 0x01D4

    /// DrawBringInFrontOfText 0x01D5 Brings the selected drawing objects forward one layer.
    case drawBringInFrontOfText = 0x01D5

    /// InsertTableOfAuthorities 0x01D7 Collects the table of authorities entries into a table of authorities.
    case insertTableOfAuthorities = 0x01D7

    /// InsertTableOfFigures 0x01D8 Collects captions into a table of captions.
    case insertTableOfFigures = 0x01D8

    /// InsertIndexAndTables 0x01D9 Inserts an index or a table of contents, figures, or authorities into the document.
    case insertIndexAndTables = 0x01D9

    /// MailMergeNextRecord 0x01DE Displays the next record in the active mail merge data source.
    case mailMergeNextRecord = 0x01DE

    /// MailMergePrevRecord 0x01DF Displays the previous record in the active mail merge data source.
    case mailMergePrevRecord = 0x01DF

    /// MailMergeFirstRecord 0x01E0 Displays the first record in the active mail merge data source.
    case mailMergeFirstRecord = 0x01E0

    /// MailMergeLastRecord 0x01E1 Displays the last record in the active mail merge data source.
    case mailMergeLastRecord = 0x01E1

    /// MailMergeGoToRecord 0x01E2 Displays the specified record in the active mail merge data source.
    case mailMergeGoToRecord = 0x01E2

    /// InsertFormField 0x01E3 Inserts a new form field.
    case insertFormField = 0x01E3

    /// ViewHeader 0x01E4 Displays header in page layout view.
    case viewHeader = 0x01E4

    /// DrawUngroup 0x01E5 Removes the grouping of the selected group of drawing objects.
    case drawUngroup = 0x01E5

    /// PasteFormat 0x01E6 Applies the previously copied formatting to selection.
    case pasteFormat = 0x01E6

    /// WW2_ToolsOptionsMenus 0x01E7 Has no effect.
    case ww2_ToolsOptionsMenus = 0x01E7

    /// FormatDropCap 0x01E8 Formats the first character of current paragraph as a dropped capital.
    case formatDropCap = 0x01E8

    /// ToolsCreateLabels 0x01E9 Creates or prints a label or a sheet of labels.
    case toolsCreateLabels = 0x01E9

    /// ViewMasterDocument 0x01EA Switches to master document view.
    case viewMasterDocument = 0x01EA

    /// CreateSubdocument 0x01EB Transforms the selected outline items into subdocuments.
    case createSubdocument = 0x01EB

    /// Language 0x01EC Changes the language formatting of the selected characters.
    case language = 0x01EC

    /// ViewFootnoteSeparator 0x01ED Opens a pane for viewing and editing the footnote separator.
    case viewFootnoteSeparator = 0x01ED

    /// ViewFootnoteContSeparator 0x01EE Opens a pane for viewing and editing the footnote continuation separator.
    case viewFootnoteContSeparator = 0x01EE

    /// ViewFootnoteContNotice 0x01EF Opens a pane for viewing and editing the footnote continuation notice.
    case viewFootnoteContNotice = 0x01EF

    /// ViewEndnoteSeparator 0x01F0 Opens a pane for viewing and editing the endnote separator.
    case viewEndnoteSeparator = 0x01F0

    /// ViewEndnoteContSeparator 0x01F1 Opens a pane for viewing and editing the endnote continuation separator.
    case viewEndnoteContSeparator = 0x01F1

    /// ViewEndnoteContNotice 0x01F2 Opens a pane for viewing and editing the endnote continuation notice.
    case viewEndnoteContNotice = 0x01F2

    /// WW2_ToolsOptionsView 0x01F3 Has no effect.
    case ww2_ToolsOptionsView = 0x01F3

    /// DrawBringForward 0x01F4 Brings the selected drawing objects forward.
    case drawBringForward = 0x01F4

    /// DrawSendBackward 0x01F5 Sends the selected drawing objects backward.
    case drawSendBackward = 0x01F5

    /// ViewFootnotes 0x01F6 Opens a pane for viewing and editing the notes (toggle).
    case viewFootnotes = 0x01F6

    /// ToolsProtectDocument 0x01F7 Sets protection for the active document.
    case toolsProtectDocument = 0x01F7

    /// ToolsShrinkToFit 0x01F8 Attempts to make the document fit on one less page.
    case toolsShrinkToFit = 0x01F8

    /// FormatStyleGallery 0x01F9 Apply styles from templates.
    case formatStyleGallery = 0x01F9

    /// ToolsReviewRevisions 0x01FA Reviews changes to the active document.
    case toolsReviewRevisions = 0x01FA

    /// ShowMultiplePages 0x01FD Show multiple pages.
    case showMultiplePages = 0x01FD

    /// HelpSearch 0x01FE Searches for a Help topic by typing or selecting a keyword.
    case helpSearch = 0x01FE

    /// HelpWordPerfectHelpOptions 0x01FF Has no effect.
    case helpWordPerfectHelpOptions = 0x01FF

    /// MailMergeConvertChevrons 0x0200 Toggles converting Word for the Macintosh mail merge chevrons.
    case mailMergeConvertChevrons = 0x0200

    /// GrowFontOnePoint 0x0201 Increases the font size of the selection by one point.
    case growFontOnePoint = 0x0201

    /// ShrinkFontOnePoint 0x0202 Decreases the font size of the selection by one point.
    case shrinkFontOnePoint = 0x0202

    /// Magnifier 0x0203 Toggle zoom-in / zoom-out mode.
    case magnifier = 0x0203

    /// FilePrintPreviewFullScreen 0x0204 Toggles full screen.
    case filePrintPreviewFullScreen = 0x0204

    /// InsertSound 0x0207 Inserts a sound object into the document.
    case insertSound = 0x0207

    /// ToolsProtectUnprotectDocument 0x0208 Toggles protection for the active document.
    case toolsProtectUnprotectDocument = 0x0208

    /// ToolsUnprotectDocument 0x0209 Removes protection from the active document.
    case toolsUnprotectDocument = 0x0209

    /// RemoveBulletsNumbers 0x020A Removes numbers and bullets from the selection.
    case removeBulletsNumbers = 0x020A

    /// FileCloseOrCloseAll 0x020B Closes the file, or if the user is holding down the shift key, closes all files.
    case fileCloseOrCloseAll = 0x020B

    /// FileCloseAll 0x020C Closes all of the windows of all documents.
    case fileCloseAll = 0x020C

    /// ToolsOptionsCompatibility 0x020D Changes the document compatibility options.
    case toolsOptionsCompatibility = 0x020D

    /// CopyButtonImage 0x020E Copy the image of the selected button to the Clipboard.
    case copyButtonImage = 0x020E

    /// PasteButtonImage 0x020F Paste the image on the Clipboard onto the selected button.
    case pasteButtonImage = 0x020F

    /// ResetButtonImage 0x0210 Reset the image on the selected button to the built-in image.
    case resetButtonImage = 0x0210

    /// ApplyAutoTextName 0x0211 Inserts the indicated AutoText entry in the document.
    case applyAutoTextName = 0x0211

    /// Columns 0x0212 Changes the number of columns in the selected sections.
    case columns = 0x0212

    /// Condensed 0x0213 Sets the font character spacing of the selection to condensed.
    case condensed = 0x0213

    /// Expanded 0x0214 Sets the font character spacing of the selection to expanded.
    case expanded = 0x0214

    /// FontSize 0x0215 Changes the font size of the selection.
    case fontSize = 0x0215

    /// Lowered 0x0216 Lowers the selection below the base line.
    case lowered = 0x0216

    /// Raised 0x0217 Raises the selection above the base line.
    case raised = 0x0217

    /// FileOpenFile 0x0218 Opens a document.
    case fileOpenFile = 0x0218

    /// DrawRoundRectangle 0x0219 Inserts a rounded rectangle drawing object.
    case drawRoundRectangle = 0x0219

    /// DrawFreeformPolygon 0x021A Inserts a freeform drawing object.
    case drawFreeformPolygon = 0x021A

    /// SelectDrawingObjects 0x0221 Allows the selection of multiple drawing objects.
    case selectDrawingObjects = 0x0221

    /// Shading 0x0222 Changes the background shading of paragraphs and table cells.
    case shading = 0x0222

    /// Borders 0x0223 Changes the borders of paragraphs, table cells, and pictures.
    case borders = 0x0223

    /// Color 0x0224 Changes the color of the selected text.
    case color = 0x0224

    /// DialogEditor 0x0228 Opens the macro dialog editor.
    case dialogEditor = 0x0228

    /// MacroREM 0x0229 Has no effect.
    case macroREM = 0x0229

    /// StartMacro 0x022A Has no effect.
    case startMacro = 0x022A

    /// Symbol 0x022B Inserts a special character.
    case symbol = 0x022B

    /// DrawToggleLayer 0x022C Switches whether the drawing object appears in the front of or behind the text.
    case drawToggleLayer = 0x022C

    /// ToolsCustomizeKeyboardShortcut 0x022D Shortcut method for customizing keyboard settings.
    case toolsCustomizeKeyboardShortcut = 0x022D

    /// ToolsCustomizeAddMenuShortcut 0x022E Shortcut method for customizing menus.
    case toolsCustomizeAddMenuShortcut = 0x022E

    /// DrawFlipHorizontal 0x022F Flips the selected drawing objects from left to right
    case drawFlipHorizontal = 0x022F

    /// DrawFlipVertical 0x0230 Flips the selected drawing objects from top to bottom.
    case drawFlipVertical = 0x0230

    /// DrawRotateRight 0x0231 Rotates the selected drawing objects 90 degrees to the right.
    case drawRotateRight = 0x0231

    /// DrawRotateLeft 0x0232 Rotates the selected drawing objects 90 degrees to the left.
    case drawRotateLeft = 0x0232

    /// TableAutoFormat 0x0233 Applies a set of formatting to a table.
    case tableAutoFormat = 0x0233

    /// FormatTextFlow 0x0234 Changes text flow direction and character orientation.
    case formatTextFlow = 0x0234

    /// WW7_FormatDrawingObject 0x0235 Changes the fill, line, size, and position attributes of the selected drawing objects.
    case ww7_FormatDrawingObject = 0x0235

    /// InsertExcelTable 0x0237 Inserts a Microsoft Excel worksheet object.
    case insertExcelTable = 0x0237

    /// MailMergeListWordFields 0x0238 Inserts a field at the insertion point.
    case mailMergeListWordFields = 0x0238

    /// MailMergeFindRecord 0x0239 Finds a specified record in a mail merge data source.
    case mailMergeFindRecord = 0x0239

    /// NormalFontSpacing 0x023B Removes the expanded or condensed font attribute.
    case normalFontSpacing = 0x023B

    /// NormalFontPosition 0x023C Removes the raised or lowered font attribute.
    case normalFontPosition = 0x023C

    /// ViewZoom200 0x023D Scales the editing view to 200 percent in normal view.
    case viewZoom200 = 0x023D

    /// ViewZoom75 0x023E Scales the editing view to 75 percent in normal view.
    case viewZoom75 = 0x023E

    /// DrawDisassemblePicture 0x023F Disassembles the selected metafile picture into drawing objects.
    case drawDisassemblePicture = 0x023F

    /// ViewZoom 0x0241 Scales the editing view.
    case viewZoom = 0x0241

    /// ToolsProtectSection 0x0242 Sets protection for sections of the active document.
    case toolsProtectSection = 0x0242

    /// OfficeOnTheWeb 0x0243 Opens the Microsoft Office Online web site.
    case officeOnTheWeb = 0x0243

    /// FontSubstitution 0x0245 Changes the font mapping of a document.
    case fontSubstitution = 0x0245

    /// ToggleFull 0x0246 Toggles full screen mode on and off.
    case toggleFull = 0x0246

    /// InsertSubdocument 0x0247 Opens a file and inserts it as a subdocument in a master document.
    case insertSubdocument = 0x0247

    /// MergeSubdocument 0x0248 Merges two adjacent subdocuments into one subdocument.
    case mergeSubdocument = 0x0248

    /// SplitSubdocument 0x0249 Splits the selected part of a subdocument into another subdocument at the same level.
    case splitSubdocument = 0x0249

    /// NewToolbar 0x024A Creates a new toolbar.
    case newToolbar = 0x024A

    /// ToggleMainTextLayer 0x024B Toggles showing the main text layer in page layout view.
    case toggleMainTextLayer = 0x024B

    /// ShowPrevHeaderFooter 0x024C Shows the header or footer of the previous section in page layout view.
    case showPrevHeaderFooter = 0x024C

    /// ShowNextHeaderFooter 0x024D Shows header or footer of the next section in page layout view.
    case showNextHeaderFooter = 0x024D

    /// GoToHeaderFooter 0x024E Jump between header and footer.
    case goToHeaderFooter = 0x024E

    /// PromoteList 0x024F Promotes the selection one level.
    case promoteList = 0x024F

    /// DemoteList 0x0250 Demotes the selection one level.
    case demoteList = 0x0250

    /// ApplyHeading1 0x0251 Applies Heading 1 style to the selected text.
    case applyHeading1 = 0x0251

    /// ApplyHeading2 0x0252 Applies Heading 2 style to the selected text.
    case applyHeading2 = 0x0252

    /// ApplyHeading3 0x0253 Applies Heading 3 style to the selected text.
    case applyHeading3 = 0x0253

    /// ApplyListBullet 0x0254 Applies List Bullet style to the selected text.
    case applyListBullet = 0x0254

    /// GotoCommentScope 0x0255 Highlights the text associated with an comment reference mark.
    case gotoCommentScope = 0x0255

    /// TableHeadings 0x0256 Toggles table headings attribute on and off.
    case tableHeadings = 0x0256

    /// OpenSubdocument 0x0257 Opens a subdocument in a new window.
    case openSubdocument = 0x0257

    /// LockDocument 0x0258 Toggles the file lock state of a document.
    case lockDocument = 0x0258

    /// ToolsCustomizeRemoveMenuShortcut 0x0259 Shortcut method for customizing menus.
    case toolsCustomizeRemoveMenuShortcut = 0x0259

    /// FormatDefineStyleNumbers 0x025A Has no effect.
    case formatDefineStyleNumbers = 0x025A

    /// FormatHeadingNumbering 0x025B Changes numbering options for heading level styles.
    case formatHeadingNumbering = 0x025B

    /// ViewBorderToolbar 0x025C Shows or hides the Borders/Table toolbar.
    case viewBorderToolbar = 0x025C

    /// ViewDrawingToolbar 0x025D Shows or hides the Drawing toolbar.
    case viewDrawingToolbar = 0x025D

    /// FormatHeadingNumber 0x025E Modifies Heading Numbering styles.
    case formatHeadingNumber = 0x025E

    /// ToolsEnvelopesAndLabels 0x025F Creates or prints an envelope, a label, or a sheet of labels.
    case toolsEnvelopesAndLabels = 0x025F

    /// DrawReshape 0x0260 Displays resizing handles on selected freeform drawing objects. Drag a handle to reshape the object.
    case drawReshape = 0x0260

    /// MailMergeAskToConvertChevrons 0x0261 Toggles whether to prompt the user about converting Word for the Macintosh mail merge chevrons.
    case mailMergeAskToConvertChevrons = 0x0261

    /// FormatCallout 0x0262 Formats the selected callouts or sets callout defaults.
    case formatCallout = 0x0262

    /// DrawCallout 0x0263 Inserts a callout drawing object.
    case drawCallout = 0x0263

    /// TableFormatCell 0x0264 Changes the height and width of the rows and columns in a table.
    case tableFormatCell = 0x0264

    /// FileSendMail 0x0265 Sends the active document through electronic mail.
    case fileSendMail = 0x0265

    /// EditButtonImage 0x0266 Edit the image on the selected button.
    case editButtonImage = 0x0266

    /// ToolsCustomizeMenuBar 0x0267 Has no effect.
    case toolsCustomizeMenuBar = 0x0267

    /// AutoMarkIndexEntries 0x0268 Inserts index entries using an automark file.
    case autoMarkIndexEntries = 0x0268

    /// InsertEnSpace 0x026A Inserts an EN space.
    case insertEnSpace = 0x026A

    /// InsertEmSpace 0x026B Inserts an EM space.
    case insertEmSpace = 0x026B

    /// DottedUnderline 0x026C Underlines the selection with dots (toggle).
    case dottedUnderline = 0x026C

    /// ParaKeepLinesTogether 0x026D Prevents a paragraph from splitting across page boundaries.
    case paraKeepLinesTogether = 0x026D

    /// ParaKeepWithNext 0x026E Keeps a paragraph and the following paragraph on the same page.
    case paraKeepWithNext = 0x026E

    /// ParaPageBreakBefore 0x026F Makes the current paragraph start on a new page.
    case paraPageBreakBefore = 0x026F

    /// FileRoutingSlip 0x0270 Has no effect.
    case fileRoutingSlip = 0x0270

    /// EditTOACategory 0x0271 Modifies the category names for the table of authorities.
    case editTOACategory = 0x0271

    /// TableUpdateAutoFormat 0x0272 Updates the table formatting to match the applied formatting set.
    case tableUpdateAutoFormat = 0x0272

    /// ChooseButtonImage 0x0273 Attach an image or text to the selected button.
    case chooseButtonImage = 0x0273

    /// ParaWidowOrphanControl 0x0274 Prevents a page break from leaving a single line of a paragraph on one page.
    case paraWidowOrphanControl = 0x0274

    /// ToolsAddRecordDefault 0x0275 Adds a record to a database.
    case toolsAddRecordDefault = 0x0275

    /// ToolsRemoveRecordDefault 0x0276 Removes a record from a database.
    case toolsRemoveRecordDefault = 0x0276

    /// ToolsManageFields 0x0277 Adds or deletes a field from a database.
    case toolsManageFields = 0x0277

    /// ViewToggleMasterDocument 0x0278 Switches between outline and master document views.
    case viewToggleMasterDocument = 0x0278

    /// DrawSnapToGrid 0x0279 Sets up a grid for aligning drawing objects.
    case drawSnapToGrid = 0x0279

    /// DrawAlign 0x027A Aligns the selected drawing objects with one another or the page.
    case drawAlign = 0x027A

    /// HelpTipOfTheDay 0x027B Displays a tip of the day.
    case helpTipOfTheDay = 0x027B

    /// FormShading 0x027C Changes shading options for the current form.
    case formShading = 0x027C

    /// EditUpdateIMEDic 0x027E Update .IME. dictionary.
    case editUpdateIMEDic = 0x027E

    /// RemoveSubdocument 0x027F Merges the contents of the selected subdocuments into the master document that contains them.
    case removeSubdocument = 0x027F

    /// CloseViewHeaderFooter 0x0280 Returns to document text.
    case closeViewHeaderFooter = 0x0280

    /// TableAutoSum 0x0281 Inserts an expression field that automatically sums a table row or column.
    case tableAutoSum = 0x0281

    /// MailMergeCreateDataSource 0x0282 Creates a new mail merge data source.
    case mailMergeCreateDataSource = 0x0282

    /// MailMergeCreateHeaderSource 0x0283 Creates a new mail merge header source.
    case mailMergeCreateHeaderSource = 0x0283

    /// StopMacroRunning 0x0285 Has no effect.
    case stopMacroRunning = 0x0285

    /// IMEControl 0x0286 Disable .IME.
    case iMEControl = 0x0286

    /// DrawInsertWordPicture 0x0288 Opens a separate window for creating a picture object or inserts the selected drawing objects into a picture.
    case drawInsertWordPicture = 0x0288

    /// WW7_IncreaseIndent 0x0289 Increases indent or demotes the selection one level.
    case ww7_IncreaseIndent = 0x0289

    /// WW7_DecreaseIndent 0x028A Decreases indent or promotes the selection one level.
    case ww7_DecreaseIndent = 0x028A

    /// SymbolFont 0x028B Applies the Symbol font to the selection.
    case symbolFont = 0x028B

    /// ToggleHeaderFooterLink 0x028C Links or unlinks this header/footer to or from the previous section.
    case toggleHeaderFooterLink = 0x028C

    /// AutoText 0x028D Creates or inserts an AutoText entry depending on the selection.
    case autoText = 0x028D

    /// ViewFooter 0x028E Displays footer in page layout view.
    case viewFooter = 0x028E

    /// MicrosoftMail 0x0290 Starts or switches to Microsoft Outlook.
    case microsoftMail = 0x0290

    /// MicrosoftExcel 0x0291 Starts or switches to Microsoft Excel.
    case microsoftExcel = 0x0291

    /// MicrosoftAccess 0x0292 Starts or switches to Microsoft Access.
    case microsoftAccess = 0x0292

    /// MicrosoftSchedule 0x0293 Starts or switches to Microsoft Schedule+.
    case microsoftSchedule = 0x0293

    /// MicrosoftFoxPro 0x0294 Starts or switches to Microsoft FoxPro.
    case microsoftFoxPro = 0x0294

    /// MicrosoftPowerPoint 0x0295 Starts or switches to Microsoft PowerPoint.
    case microsoftPowerPoint = 0x0295

    /// MicrosoftPublisher 0x0296 Starts or switches to Microsoft Publisher.
    case microsoftPublisher = 0x0296

    /// MicrosoftProject 0x0297 Starts or switches to Microsoft Project.
    case microsoftProject = 0x0297

    /// ListMacros 0x0298 Has no effect.
    case listMacros = 0x0298

    /// ScreenRefresh 0x0299 Refreshes the display.
    case screenRefresh = 0x0299

    /// ToolsRecordMacroStart 0x029A Turns macro recording on or off.
    case toolsRecordMacroStart = 0x029A

    /// ToolsRecordMacroStop 0x029B Turns macro recording on or off.
    case toolsRecordMacroStop = 0x029B

    /// StopMacro 0x029C Stops recording or running the current macro.
    case stopMacro = 0x029C

    /// ToggleMacroRun 0x029D Has no effect.
    case toggleMacroRun = 0x029D

    /// DrawNudgeUp 0x029E Moves the selected drawing objects up.
    case drawNudgeUp = 0x029E

    /// DrawNudgeDown 0x029F Moves the selected drawing objects down.
    case drawNudgeDown = 0x029F

    /// DrawNudgeLeft 0x02A0 Moves the selected drawing objects to the left.
    case drawNudgeLeft = 0x02A0

    /// DrawNudgeRight 0x02A1 Moves the selected drawing objects to the right.
    case drawNudgeRight = 0x02A1

    /// WW2_ToolsMacro 0x02A2 Runs, creates, deletes, or revises a macro.
    case ww2_ToolsMacro = 0x02A2

    /// MailMergeEditHeaderSource 0x02A3 Opens a mail merge header source.
    case mailMergeEditHeaderSource = 0x02A3

    /// MailMerge 0x02A4 Combines files to produce form letters, mailing labels, envelopes, and catalogs.
    case mailMerge = 0x02A4

    /// MailMergeCheck 0x02A5 Checks for errors in a mail merge.
    case mailMergeCheck = 0x02A5

    /// MailMergeToDoc 0x02A6 Collects the results of a mail merge in a document.
    case mailMergeToDoc = 0x02A6

    /// MailMergeToPrinter 0x02A7 Sends the results of a mail merge to the printer.
    case mailMergeToPrinter = 0x02A7

    /// MailMergeHelper 0x02A8 Prepares a main document for a mail merge.
    case mailMergeHelper = 0x02A8

    /// MailMergeQueryOptions 0x02A9 Sets the query options for a mail merge.
    case mailMergeQueryOptions = 0x02A9

    /// InsertWordArt 0x02AA Inserts a Microsoft WordArt object.
    case insertWordArt = 0x02AA

    /// InsertEquation 0x02AB Inserts a Microsoft Equation object.
    case insertEquation = 0x02AB

    /// RunPrintManager 0x02AC Displays the Print Manager.
    case runPrintManager = 0x02AC

    /// FileMacPageSetup 0x02AD Has no effect.
    case fileMacPageSetup = 0x02AD

    /// FileConfirmConversions 0x02AF Toggles asking the user to confirm the conversion when opening a file.
    case fileConfirmConversions = 0x02AF

    /// HelpContents 0x02B0 Displays Help contents.
    case helpContents = 0x02B0

    /// WW2_InsertSymbol 0x02B5 Inserts a special character.
    case ww2_InsertSymbol = 0x02B5

    /// FileClosePicture 0x02B6 Closes the active picture document.
    case fileClosePicture = 0x02B6

    /// WW2_InsertIndex 0x02B7 Collects the index entries into an index.
    case ww2_InsertIndex = 0x02B7

    /// DrawResetWordPicture 0x02B8 Sets document margins to enclose all drawing objects on the page.
    case drawResetWordPicture = 0x02B8

    /// WW2_FormatBordersAndShading 0x02B9 Changes the borders and shading of the selected paragraphs, table cells, and pictures.
    case ww2_FormatBordersAndShading = 0x02B9

    /// OpenOrCloseUpPara 0x02BA Sets or removes extra spacing above the selected paragraph.
    case openOrCloseUpPara = 0x02BA

    /// DrawNudgeUpPixel 0x02BC Moves the selected drawing objects up one pixel.
    case drawNudgeUpPixel = 0x02BC

    /// DrawNudgeDownPixel 0x02BD Moves the selected drawing objects down one pixel.
    case drawNudgeDownPixel = 0x02BD

    /// DrawNudgeLeftPixel 0x02BE Moves the selected drawing objects to the left one pixel.
    case drawNudgeLeftPixel = 0x02BE

    /// DrawNudgeRightPixel 0x02BF Moves the selected drawing objects to the right one pixel.
    case drawNudgeRightPixel = 0x02BF

    /// ToolsHyphenationManual 0x02C0 Hyphenates the selection or the entire document.
    case toolsHyphenationManual = 0x02C0

    /// FixMe 0x02C1 Repairs the installation of the application.
    case fixMe = 0x02C1

    /// ClearFormField 0x02C2 Deletes the selected form field.
    case clearFormField = 0x02C2

    /// InsertSectionBreak 0x02C3 Ends a section at the insertion point.
    case insertSectionBreak = 0x02C3

    /// DrawUnselect 0x02C4 Unselects a drawn object.
    case drawUnselect = 0x02C4

    /// DrawSelectNext 0x02C5 Selects the next drawn object.
    case drawSelectNext = 0x02C5

    /// DrawSelectPrevious 0x02C6 Selects the previous drawn object.
    case drawSelectPrevious = 0x02C6

    /// MicrosoftSystemInfo 0x02C7 Launches the System Information application.
    case microsoftSystemInfo = 0x02C7

    /// ToolsCustomizeToolbar 0x02CC Customizes the toolbars.
    case toolsCustomizeToolbar = 0x02CC

    /// IndentChar 0x02CF Increases the indent by width of a character.
    case indentChar = 0x02CF

    /// UnIndentChar 0x02D0 Decreases the indent by width of a character.
    case unIndentChar = 0x02D0

    /// IndentFirstChar 0x02D1 Increases the hanging indent by width of a character.
    case indentFirstChar = 0x02D1

    /// UnIndentFirstChar 0x02D2 Decreases the hanging indent by width of a character.
    case unIndentFirstChar = 0x02D2

    /// ListCommands 0x02D3 Create a table of commands, with key and menu assignments.
    case listCommands = 0x02D3

    /// HelpIchitaroHelp 0x02D8 Shows Competitor (Ichitaro, Korean WordPerfect) help.
    case helpIchitaroHelp = 0x02D8

    /// ChangeByte 0x02DA Changes between wide and narrow versions of the letters in the selection.
    case changeByte = 0x02DA

    /// ChangeKana 0x02DB Changes the characters in the selection between Katakana and Hiragana.
    case changeKana = 0x02DB

    /// EditCreatePublisher 0x02DC Has no effect.
    case editCreatePublisher = 0x02DC

    /// EditSubscribeTo 0x02DD Has no effect.
    case editSubscribeTo = 0x02DD

    /// EditPubOrSubOptions 0x02DE Has no effect.
    case editPubOrSubOptions = 0x02DE

    /// EditPublishOptions 0x02DF Has no effect.
    case editPublishOptions = 0x02DF

    /// EditSubscribeOptions 0x02E0 Has no effect.
    case editSubscribeOptions = 0x02E0

    /// FilePgSetupCustGX 0x02E1 Has no effect.
    case filePgSetupCustGX = 0x02E1

    /// WW7_DrawVerticalTextBox 0x02E2 Inserts a vertical text box drawing object.
    case ww7_DrawVerticalTextBox = 0x02E2

    /// ToolsOptionsTypography 0x02E3 Changes the Typography options.
    case toolsOptionsTypography = 0x02E3

    /// DistributePara 0x02E4 Distributed. Paragraph.
    case distributePara = 0x02E4

    /// ViewGridlines 0x02E5 Shows or hides the gridlines.
    case viewGridlines = 0x02E5

    /// Highlight 0x02E6 Applies color highlighting to the selection.
    case highlight = 0x02E6

    /// FixSpellingChange 0x02E8 Replaces this word by the selected suggestion.
    case fixSpellingChange = 0x02E8

    /// FileProperties 0x02EE Shows the properties of the active document.
    case fileProperties = 0x02EE

    /// EditCopyAsPicture 0x02EF Copies the selection and puts it on the Clipboard as a picture.
    case editCopyAsPicture = 0x02EF

    /// IndentFirstLine 0x02F2 Increases the hanging indent by width of 2 characters.
    case indentFirstLine = 0x02F2

    /// UnIndentFirstLine 0x02F3 Decreases the hanging indent by width of 2 characters.
    case unIndentFirstLine = 0x02F3

    /// IndentLine 0x02F4 Increases the indent by width of 2 characters.
    case indentLine = 0x02F4

    /// UnIndentLine 0x02F5 Decreases the indent by width of 2 characters.
    case unIndentLine = 0x02F5

    /// InsertAddress 0x02F6 Inserts an address from the user’s Personal Address Book.
    case insertAddress = 0x02F6

    /// NextMisspelling 0x02F7 Find next spelling error.
    case nextMisspelling = 0x02F7

    /// FilePost 0x02F8 Puts the active document into a Microsoft Exchange folder.
    case filePost = 0x02F8

    /// ToolsAutoCorrectExceptions 0x02FA Adds or deletes AutoCorrect Capitalization exceptions.
    case toolsAutoCorrectExceptions = 0x02FA

    /// MailHideMessageHeader 0x02FB Shows or hides the mail message header when the application is being used as an e-mail editor.
    case mailHideMessageHeader = 0x02FB

    /// MailMessageProperties 0x02FC Sets the properties of the e-mail message.
    case mailMessageProperties = 0x02FC

    /// DotAccent 0x02FD Formats the selection with dot accents (toggle).
    case dotAccent = 0x02FD

    /// CommaAccent 0x02FE Formats the selection with comma accents (toggle).
    case commaAccent = 0x02FE

    /// ToolsAutoCorrectCapsLockOff 0x02FF Selects or clears the AutoCorrect Caps Lock Off check box.
    case toolsAutoCorrectCapsLockOff = 0x02FF

    /// MailMessageReply 0x0300 Replies to a mail message.
    case mailMessageReply = 0x0300

    /// MailMessageReplyAll 0x0301 Replies All to a mail message.
    case mailMessageReplyAll = 0x0301

    /// MailMessageMove 0x0302 Moves an e-mail message.
    case mailMessageMove = 0x0302

    /// MailMessageDelete 0x0303 Deletes an e-mail message.
    case mailMessageDelete = 0x0303

    /// MailMessagePrevious 0x0304 Goes to the previous e-mail message.
    case mailMessagePrevious = 0x0304

    /// MailMessageNext 0x0305 Goes to the next e-mail message.
    case mailMessageNext = 0x0305

    /// MailCheckNames 0x0306 Checks the recipient names of an e-mail message.
    case mailCheckNames = 0x0306

    /// MailSelectNames 0x0307 Selects the recipients of an e-mail message.
    case mailSelectNames = 0x0307

    /// MailMessageForward 0x0308 Forwards an e-mail message.
    case mailMessageForward = 0x0308

    /// ToolsSpellingRecheckDocument 0x0309 Resets spelling results for the current document.
    case toolsSpellingRecheckDocument = 0x0309

    /// ToolsOptionsAutoFormatAsYouType 0x030A Changes the AutoFormat As You Type options.
    case toolsOptionsAutoFormatAsYouType = 0x030A

    /// MailMergeUseAddressBook 0x030B Opens an address book as a data source for mail merge.
    case mailMergeUseAddressBook = 0x030B

    /// EditFindHighlight 0x030C Has no effect.
    case editFindHighlight = 0x030C

    /// EditReplaceHighlight 0x030D Has no effect.
    case editReplaceHighlight = 0x030D

    /// EditFindNotHighlight 0x030E Has no effect.
    case editFindNotHighlight = 0x030E

    /// EditReplaceNotHighlight 0x030F Has no effect.
    case editReplaceNotHighlight = 0x030F

    /// ToolsHHC 0x0310 Finds a Hangul/Hanja word for the selected word.
    case toolsHHC = 0x0310

    /// UnderlineColor 0x0311 Changes the underline color of the selected text.
    case underlineColor = 0x0311

    /// ToolsOptionsHHC 0x0312 Changes the HHC options.
    case toolsOptionsHHC = 0x0312

    /// InsertVerticalFrame 0x0313 Inserts an empty vertical frame or encloses the selected item in a vertical frame.
    case insertVerticalFrame = 0x0313

    /// BorderTLtoBR 0x0314 Changes the top left to bottom right diagonal border of the selected table cells.
    case borderTLtoBR = 0x0314

    /// BorderTRtoBL 0x0315 Changes the top right to bottom left diagonal border of the selected table cells.
    case borderTRtoBL = 0x0315

    /// ToolsOptionsFuzzy 0x0316 Changes the fuzzy expressions options.
    case toolsOptionsFuzzy = 0x0316

    /// DrawBrace 0x0317 Inserts a brace drawing object.
    case drawBrace = 0x0317

    /// DrawBracket 0x0318 Inserts a bracket drawing object.
    case drawBracket = 0x0318

    /// HelpAW 0x031A Locates Help topics based on an entered question or request.
    case helpAW = 0x031A

    /// HelpMSN 0x031B Has no effect.
    case helpMSN = 0x031B

    /// CreateTable 0x031C Inserts a table.
    case createTable = 0x031C

    /// CharScale 0x031D Applies character scaling to the selection.
    case charScale = 0x031D

    /// DoubleStrikethrough 0x031E Makes the selection double strikethrough (toggle).
    case doubleStrikethrough = 0x031E

    /// TopAlign 0x031F Aligns cell content to the top of cell.
    case topAlign = 0x031F

    /// CenterAlign 0x0320 Aligns cell content to the center of cell.
    case centerAlign = 0x0320

    /// BottomAlign 0x0321 Aligns cell content to the bottom of cell.
    case bottomAlign = 0x0321

    /// ViewOutlineSplitToolbar 0x0324 Shows or hides the Borders/Table toolbar.
    case viewOutlineSplitToolbar = 0x0324

    /// DistributeColumn 0x0327 Evenly distributes selected columns.
    case distributeColumn = 0x0327

    /// ViewFormatExToolbar 0x032B Shows or hides the Extended Formatting toolbar.
    case viewFormatExToolbar = 0x032B

    /// InsertNumber 0x032C Inserts a number in the active document.
    case insertNumber = 0x032C

    /// ContextHelp 0x032D Toggles context sensitive help through F1 key.
    case contextHelp = 0x032D

    /// InsertOfficeDrawing 0x032F Inserts a Microsoft Draw object.
    case insertOfficeDrawing = 0x032F

    /// RedefineStyle 0x0330 Redefines the current style based on the selected text.
    case redefineStyle = 0x0330

    /// ViewOnline 0x0334 Displays the document optimized for reading online.
    case viewOnline = 0x0334

    /// LetterProperties 0x0335 Formats a Letter Document.
    case letterProperties = 0x0335

    /// BrowseSel 0x0336 Select the next/previous browse object.
    case browseSel = 0x0336

    /// BrowsePrev 0x0337 Jump to the previous browse object.
    case browsePrev = 0x0337

    /// FormatBulletsAndNumbering 0x0338 Creates a numbered or bulleted list.
    case formatBulletsAndNumbering = 0x0338

    /// ListOutdent 0x0339 Promotes the selection one level.
    case listOutdent = 0x0339

    /// ListIndent 0x033A Demotes the selection one level.
    case listIndent = 0x033A

    /// ToolsProofing 0x033C Checks the proofing in the active document.
    case toolsProofing = 0x033C

    /// InsertPageBreak 0x033E Inserts a page break at the insertion point.
    case insertPageBreak = 0x033E

    /// InsertColumnBreak 0x033F Inserts a column break at the insertion point.
    case insertColumnBreak = 0x033F

    /// ToolsCreateDirectory 0x0341 Creates a new directory.
    case toolsCreateDirectory = 0x0341

    /// BrowseNext 0x0342 Jump to the next browse object.
    case browseNext = 0x0342

    /// InsertNumberOfPages 0x0343 Inserts a number of pages field.
    case insertNumberOfPages = 0x0343

    /// NextInsert 0x0344 Returns to the next insertion point.
    case nextInsert = 0x0344

    /// TextBoxLinking 0x0348 Creates a forward link to another text box.
    case textBoxLinking = 0x0348

    /// TextBoxUnlinking 0x0349 Breaks the forward link to another text box.
    case textBoxUnlinking = 0x0349

    /// GotoNextLinkedTextBox 0x034A Selects the next linked text box.
    case gotoNextLinkedTextBox = 0x034A

    /// GotoPrevLinkedTextBox 0x034B Selects the previous linked text box.
    case gotoPrevLinkedTextBox = 0x034B

    /// ToolsSpellingRange 0x034E Checks the spelling on the range.
    case toolsSpellingRange = 0x034E

    /// ToolsGrammarRange 0x034F Checks the spelling and grammar on the range.
    case toolsGrammarRange = 0x034F

    /// ViewWeb 0x0350 Displays the document similarly to how a web browser would.
    case viewWeb = 0x0350

    /// ShowTableGridlines 0x0351 Toggles table gridlines on and off.
    case showTableGridlines = 0x0351

    /// BlogBlogPublish 0x0352 Sends the active document to a blog.
    case blogBlogPublish = 0x0352

    /// BlogBlogPublishDraft 0x0353 Sends the active document to a blog.
    case blogBlogPublishDraft = 0x0353

    /// BlogBlogOpenExistingDlg 0x0354 Open an existing blog.
    case blogBlogOpenExistingDlg = 0x0354

    /// BlogBlogInsertCategory 0x0355 Inserts a category dropdown into the document.
    case blogBlogInsertCategory = 0x0355

    /// TableWrapping 0x0356 Changes the wrapping in a table.
    case tableWrapping = 0x0356

    /// FormatTheme 0x0357 Has no effect.
    case formatTheme = 0x0357

    /// EditIMEReconversion 0x0359 Reconvert using IME.
    case editIMEReconversion = 0x0359

    /// HelpShowHide 0x035A Show/Hide the Office Assistant.
    case helpShowHide = 0x035A

    /// InsertPictureBullet 0x035C Inserts a picture as a bullet.
    case insertPictureBullet = 0x035C

    /// TableProperties 0x035D Changes the height and width of the rows and columns in a table.
    case tableProperties = 0x035D

    /// EmailSignatureOptions 0x035E Create or changes AutoSignature entries.
    case emailSignatureOptions = 0x035E

    /// EmailOptions 0x035F Changes various categories of e-mail options.
    case emailOptions = 0x035F

    /// ShadingColor 0x0361 Changes the shading color of the selected text.
    case shadingColor = 0x0361

    /// DistributeGeneral 0x0362 Evenly distributes selected rows/columns in a table.
    case distributeGeneral = 0x0362

    /// MergeSplitGeneral 0x0363 Merges or splits the selected table cell(s).
    case mergeSplitGeneral = 0x0363

    /// ViewTogglePageBoundaries 0x0367 Switches between showing/hiding vertical margins in Print Layout View.
    case viewTogglePageBoundaries = 0x0367

    /// CreateAutoText 0x0368 Adds an AutoText entry to the active template.
    case createAutoText = 0x0368

    /// ToggleFormsDesign 0x0369 Toggles Form Design mode.
    case toggleFormsDesign = 0x0369

    /// ToolsAutoSummarizeBegin 0x036A Automatically generates a summary of the active document.
    case toolsAutoSummarizeBegin = 0x036A

    /// EmailEnvelope 0x036B Displays the e-mail envelope.
    case emailEnvelope = 0x036B

    /// ViewCode 0x036E View code for selected control.
    case viewCode = 0x036E

    /// MenuNotesFlow 0x036F Notes Flow Menu.
    case menuNotesFlow = 0x036F

    /// UpdateFieldsVBA 0x0370 Updates and displays the results of the selected fields.
    case updateFieldsVBA = 0x0370

    /// FontColor 0x0372 Changes the color of the selected text.
    case fontColor = 0x0372

    /// UnlinkFieldsVBA 0x0373 Permanently replaces the field codes with the results.
    case unlinkFieldsVBA = 0x0373

    /// ToggleMasterSubdocs 0x0374 Switches between hyperlinks and subdocuments.
    case toggleMasterSubdocs = 0x0374

    /// ToolsGramSettings 0x0375 Customize Grammar Settings.
    case toolsGramSettings = 0x0375

    /// RemoveCellPartition 0x0378 Removes cell partitions.
    case removeCellPartition = 0x0378

    /// ShowPara 0x037A Shows/hides all non-printing paragraph marks.
    case showPara = 0x037A

    /// DistributeRow 0x037D Evenly distributes selected rows.
    case distributeRow = 0x037D

    /// EditGoTo 0x0380 Jumps to a specified place in the active document.
    case editGoTo = 0x0380

    /// DeleteHyperlink 0x0381 Replaces a hyperlink with its displayed text.
    case deleteHyperlink = 0x0381

    /// WebOptions 0x0382 Opens the Web Options Dialog.
    case webOptions = 0x0382

    /// FixSpellingLang 0x0383 Changes language of this word.
    case fixSpellingLang = 0x0383

    /// CreateTask 0x0384 Creates a task from the current selection.
    case createTask = 0x0384

    /// DisplayDetails 0x0385 Displays the Details of the selected address.
    case displayDetails = 0x0385

    /// SpellingAndAutoCorrect 0x0387 Adds selected suggestion as AutoCorrect replacement for this word.
    case spellingAndAutoCorrect = 0x0387

    /// EditPasteAsNestedTable 0x0388 Inserts the Clipboard contents at the insertion point.
    case editPasteAsNestedTable = 0x0388

    /// ToolsAutoSummarize 0x0389 Automatically generates a summary of the active document.
    case toolsAutoSummarize = 0x0389

    /// AutoSummarizeClose 0x038A Turns AutoSummarize view off.
    case autoSummarizeClose = 0x038A

    /// AutoSummarizeUpdateFileProperties 0x038C Updates File/Properties information with the current summary.
    case autoSummarizeUpdateFileProperties = 0x038C

    /// AutoSummarizePercentOfOriginal 0x038D Changes the size of the automatic summary.
    case autoSummarizePercentOfOriginal = 0x038D

    /// AutoSummarizeToggleView 0x038E Switches how the application displays a summary: highlighting summary text, or hiding everything but the summary.
    case autoSummarizeToggleView = 0x038E

    /// InsertOCX 0x0391 Inserts the selected OCX control or registers a new OCX control.
    case insertOCX = 0x0391

    /// FormatBackground 0x0392 Displays the format background submenu.
    case formatBackground = 0x0392

    /// ToolsAutoManager 0x0393 Changes various categories of automatic options, such as AutoCorrect, AutoFormat and so on.
    case toolsAutoManager = 0x0393

    /// ConvertTextBoxToFrame 0x0394 Converts a single selected textbox into a frame.
    case convertTextBoxToFrame = 0x0394

    /// OfficeDrawingCommand 0x0395 Executes a Microsoft Office drawing command with the specified arguments.
    case officeDrawingCommand = 0x0395

    /// FormatObjectCore 0x0396 Changes the properties of the selected objects.
    case formatObjectCore = 0x0396

    /// LetterWizard 0x0397 Wizard to create a Letter Document.
    case letterWizard = 0x0397

    /// HyperlinkOpen 0x0398 Open hyperlink.
    case hyperlinkOpen = 0x0398

    /// WebOpenHyperlink 0x0399 Jump to a location.
    case webOpenHyperlink = 0x0399

    /// WebOpenInNewWindow 0x039A Open in new window.
    case webOpenInNewWindow = 0x039A

    /// WebCopyHyperlink 0x039B Copy shortcut.
    case webCopyHyperlink = 0x039B

    /// WebAddToFavorites 0x039C Add to Favorites.
    case webAddToFavorites = 0x039C

    /// InsertHyperlink 0x039D Insert hyperlink.
    case insertHyperlink = 0x039D

    /// EditHyperlink 0x039E Edit hyperlink.
    case editHyperlink = 0x039E

    /// WebSelectHyperlink 0x039F Edit text.
    case webSelectHyperlink = 0x039F

    /// WebOpenFavorites 0x03A0 Open Favorites folder.
    case webOpenFavorites = 0x03A0

    /// WebHideToolbars 0x03A1 Hide other toolbars.
    case webHideToolbars = 0x03A1

    /// WebOpenStartPage 0x03A2 Open Start Page.
    case webOpenStartPage = 0x03A2

    /// WebGoBack 0x03A3 Backward hyperlink.
    case webGoBack = 0x03A3

    /// FileCloseOrExit 0x03A4 Closes the current document. If only one document is open, the application is exited.
    case fileCloseOrExit = 0x03A4

    /// WebGoForward 0x03A5 Forward hyperlink.
    case webGoForward = 0x03A5

    /// WebStopLoading 0x03A6 Stop current jump.
    case webStopLoading = 0x03A6

    /// WebRefresh 0x03A7 Refresh current page.
    case webRefresh = 0x03A7

    /// ShowAddInsXDialog 0x03A8 Displays the Office AddIn Manager dialog.
    case showAddInsXDialog = 0x03A8

    /// MenuWebFavorites 0x03A9 Represents the "Favorites" menu. Has no effect.
    case menuWebFavorites = 0x03A9

    /// WebAddress 0x03AA Hyperlink address.
    case webAddress = 0x03AA

    /// ToolsBusu 0x03AB Has no effect.
    case toolsBusu = 0x03AB

    /// SendToFax 0x03AC Send this document to fax.
    case sendToFax = 0x03AC

    /// UpdateTocFull 0x03AD Rebuild a table of contents or captions.
    case updateTocFull = 0x03AD

    /// ToolsRevisionMarksAccept 0x03AE Accepts change in current selection.
    case toolsRevisionMarksAccept = 0x03AE

    /// ToolsRevisionMarksReject 0x03AF Rejects change in current selection.
    case toolsRevisionMarksReject = 0x03AF

    /// ViewDocumentMap 0x03B0 Toggles state of the Heading Explorer.
    case viewDocumentMap = 0x03B0

    /// FileVersions 0x03B1 Manages the versions of a document.
    case fileVersions = 0x03B1

    /// FormatBackgroundWatermark 0x03B2 Watermark background.
    case formatBackgroundWatermark = 0x03B2

    /// DrawTextBox 0x03B3 Inserts an empty textbox or encloses the selected item in a textbox.
    case drawTextBox = 0x03B3

    /// ViewVBCode 0x03B4 Shows the VBA editing environment.
    case viewVBCode = 0x03B4

    /// FormatNumberDefault 0x03B6 Creates a numbered list based on the current defaults.
    case formatNumberDefault = 0x03B6

    /// FormatMultilevelDefault 0x03B7 Creates a numbered list based on the current defaults.
    case formatMultilevelDefault = 0x03B7

    /// DrawDuplicate 0x03BB Duplicates the selected drawing objects.
    case drawDuplicate = 0x03BB

    /// ToolsRevisionMarksToggle 0x03BC Toggles track changes for the active document.
    case toolsRevisionMarksToggle = 0x03BC

    /// ToolsBookshelfLookupReference 0x03BD Looks up a reference for the selected word in Microsoft Bookshelf.
    case toolsBookshelfLookupReference = 0x03BD

    /// ToolsBookshelfDefineReference 0x03BE Looks up a definition for the selected word in Microsoft Bookshelf.
    case toolsBookshelfDefineReference = 0x03BE

    /// ToolsOptionsAutoFormat 0x03BF Changes the AutoFormat options.
    case toolsOptionsAutoFormat = 0x03BF

    /// FormatDrawingObject 0x03C0 Changes the properties of the selected drawing objects.
    case formatDrawingObject = 0x03C0

    /// BorderLineWeight 0x03C1 Changes border line weights of the selected paragraphs, table cells, and pictures.
    case borderLineWeight = 0x03C1

    /// BorderHoriz 0x03C2 Changes the horizontal borders of the selected table cells.
    case borderHoriz = 0x03C2

    /// BorderVert 0x03C3 Changes the vertical borders of the selected table cells.
    case borderVert = 0x03C3

    /// BorderLineColor 0x03C4 Changes border line color of the selected paragraphs, table cells, and pictures.
    case borderLineColor = 0x03C4

    /// InsertListNumField 0x03C6 Inserts a ListNum Field.
    case insertListNumField = 0x03C6

    /// HtmlResAnchor 0x03C7 Handles Internet Assistant-style hyperlink macro buttons.
    case htmlResAnchor = 0x03C7

    /// WebOpenSearchPage 0x03C8 Open Search Page.
    case webOpenSearchPage = 0x03C8

    /// PresentIt 0x03C9 Creates a presentation from the current document.
    case presentIt = 0x03C9

    /// ToolsRevisionMarksPrev 0x03CA Find previous change.
    case toolsRevisionMarksPrev = 0x03CA

    /// ToolsRevisionMarksNext 0x03CB Find next change.
    case toolsRevisionMarksNext = 0x03CB

    /// DeleteAnnotation 0x03CD Delete comment.
    case deleteAnnotation = 0x03CD

    /// ToolsOptions 0x03CE Changes various categories of the application options.
    case toolsOptions = 0x03CE

    /// SendToOnlineMeetingParticipants 0x03CF Send this document to Online Meeting participant.
    case sendToOnlineMeetingParticipants = 0x03CF

    /// EditPasteAsHyperlink 0x03D0 Inserts the Clipboard contents as a hyperlink object.
    case editPasteAsHyperlink = 0x03D0

    /// BorderAll 0x03D1 Changes all the borders of the selected table cells.
    case borderAll = 0x03D1

    /// ToolsSpellingHide 0x03D2 Hide background spelling errors.
    case toolsSpellingHide = 0x03D2

    /// ToolsGrammarHide 0x03D3 Hide background grammar errors.
    case toolsGrammarHide = 0x03D3

    /// FormatChangeCaseFareast 0x03D4 Changes the case of the letters in the selection.
    case formatChangeCaseFareast = 0x03D4

    /// InsertImagerScan 0x03D5 Inserts one or more images from a scanner or digital camera.
    case insertImagerScan = 0x03D5

    /// InsertClipArt 0x03D6 Inserts a Microsoft Clip Art Gallery object.
    case insertClipArt = 0x03D6

    /// FormatFitText 0x03D7 Apply Fit Text Property.
    case formatFitText = 0x03D7

    /// EditAutoText 0x03D9 Inserts or defines AutoText entries.
    case editAutoText = 0x03D9

    /// FormatPhoneticGuide 0x03DA Inserts a Phonetic Guide field in the active document.
    case formatPhoneticGuide = 0x03DA

    /// FormatCombineCharacters 0x03DB Combine Characters.
    case formatCombineCharacters = 0x03DB

    /// PostcardWizard 0x03DC Starts the postcard wizard.
    case postcardWizard = 0x03DC

    /// ToolsDictionary 0x03DD Translates the selected word.
    case toolsDictionary = 0x03DD

    /// ToolsConsistency 0x03E0 Checks the consistency in the active document.
    case toolsConsistency = 0x03E0

    /// SetDrawingDefaults 0x03E1 Changes the default drawing object properties.
    case setDrawingDefaults = 0x03E1

    /// AutoScroll 0x03E2 Starts scrolling the active document.
    case autoScroll = 0x03E2

    /// EditWrapBoundary 0x03E3 Edit the wrapping boundary for a picture or drawing object.
    case editWrapBoundary = 0x03E3

    /// DrawVerticalTextBox 0x03E4 Inserts an empty vertical text box or encloses the selected item in a vertical textbox.
    case drawVerticalTextBox = 0x03E4

    /// DefaultCharBorder 0x03E5 Default character border.
    case defaultCharBorder = 0x03E5

    /// MenuWebGo 0x03E6 Represents the web options menu. Has no effect.
    case menuWebGo = 0x03E6

    /// WW7_ToolsGrammar 0x03E8 Checks the proofing in the active document.
    case ww7_ToolsGrammar = 0x03E8

    /// ToolsAutoCorrectHECorrect 0x03E9 Hangul and alphabet correction.
    case toolsAutoCorrectHECorrect = 0x03E9

    /// WebAddHyperlnkToFavorites 0x03EA Add to Favorites.
    case webAddHyperlnkToFavorites = 0x03EA

    /// FormatBackgroundSwatch 0x03EB Changes the background of the document.
    case formatBackgroundSwatch = 0x03EB

    /// FormatBackgroundNone 0x03EC Removes the background from the document.
    case formatBackgroundNone = 0x03EC

    /// FormatBackgroundMoreColors 0x03ED Provides more color choices for the background color.
    case formatBackgroundMoreColors = 0x03ED

    /// FormatBackgroundFillEffect 0x03EE Provides fill effects for the background color.
    case formatBackgroundFillEffect = 0x03EE

    /// FileSaveVersion 0x03EF Saves a new version of a document.
    case fileSaveVersion = 0x03EF

    /// WebToolbar 0x03F0 Toggle Web toolbar.
    case webToolbar = 0x03F0

    /// ToggleTextFlow 0x03F1 Changes text flow direction and character orientation.
    case toggleTextFlow = 0x03F1

    /// IncreaseIndent 0x03F2 Increases indent or demotes the selection one level.
    case increaseIndent = 0x03F2

    /// DecreaseIndent 0x03F3 Decreases indent or promotes the selection one level.
    case decreaseIndent = 0x03F3

    /// FileSaveHtml 0x03F4 Saves the file as an HTML document.
    case fileSaveHtml = 0x03F4

    /// DefaultCharShading 0x03F7 Default character shading.
    case defaultCharShading = 0x03F7

    /// ToolsFixSynonym 0x03FA Fixes a spelling mistake with a synonym suggestion.
    case toolsFixSynonym = 0x03FA

    /// ToolsOptionsBidi 0x0405 Changes the Bidirectional options.
    case toolsOptionsBidi = 0x0405

    /// ViewSecurity 0x0419 View document security options.
    case viewSecurity = 0x0419

    /// ToolsInsertScript 0x041A Has no effect.
    case toolsInsertScript = 0x041A

    /// RemoveAllScripts 0x041B Has no effect.
    case removeAllScripts = 0x041B

    /// MicrosoftScriptEditor 0x041C Has no effect.
    case microsoftScriptEditor = 0x041C

    /// RunToggle 0x041D Toggles the insertion point between right-to-left and left-to-right runs.
    case runToggle = 0x041D

    /// LtrPara 0x041E Set paragraph orientation to left-to-right.
    case ltrPara = 0x041E

    /// RtlPara 0x041F Set paragraph orientation to right-to-left.
    case rtlPara = 0x041F

    /// RtlRun 0x0422 Makes the current run right-to-left.
    case rtlRun = 0x0422

    /// LtrRun 0x0423 Makes the current run left-to-right.
    case ltrRun = 0x0423

    /// BoldRun 0x0424 Makes the current run in the selection bold (toggle).
    case boldRun = 0x0424

    /// ItalicRun 0x0425 Makes the current run in the selection italic (toggle).
    case italicRun = 0x0425

    /// FormattingProperties 0x0426 Shows or hides Formatting Properties.
    case formattingProperties = 0x0426

    /// HelpContentsArabic 0x0427 Displays Help in a context of bidirectional editing.
    case helpContentsArabic = 0x0427

    /// RTLMacroDialogs 0x0428 Makes macro dialogs display right-to-left.
    case rTLMacroDialogs = 0x0428

    /// LTRMacroDialogs 0x0429 Makes macro dialogs display left-to-right.
    case lTRMacroDialogs = 0x0429

    /// InsertHorizontalLine 0x042A Inserts a horizontal line.
    case insertHorizontalLine = 0x042A

    /// InsertGraphicalHorizontalLine 0x042B Inserts a picture horizontal line.
    case insertGraphicalHorizontalLine = 0x042B

    /// FramesetWizard 0x042C Turns the current window into a frameset.
    case framesetWizard = 0x042C

    /// FrameSplitAbove 0x042D Splits the active frame, adding the new frame above the current.
    case frameSplitAbove = 0x042D

    /// FrameSplitBelow 0x042E Splits the active frame, adding the new frame below the current.
    case frameSplitBelow = 0x042E

    /// FrameSplitLeft 0x042F Splits the active frame, adding new frame left of the current.
    case frameSplitLeft = 0x042F

    /// FrameSplitRight 0x0430 Splits the active frame, adding new frame right of the current.
    case frameSplitRight = 0x0430

    /// FrameRemoveSplit 0x0431 Removes the current frame.
    case frameRemoveSplit = 0x0431

    /// FrameProperties 0x0432 Changes the properties of the frame.
    case frameProperties = 0x0432

    /// TableSelectCell 0x0433 Selects the current cell in a table.
    case tableSelectCell = 0x0433

    /// TableInsertRowBelow 0x0434 Inserts one or more rows into the table below the current row.
    case tableInsertRowBelow = 0x0434

    /// TableInsertColumnRight 0x0435 Inserts one or more columns into the table to the right of the current column.
    case tableInsertColumnRight = 0x0435

    /// TableDeleteTable 0x0436 Deletes the selected table.
    case tableDeleteTable = 0x0436

    /// TableInsertTableEG 0x0437 Inserts a table.
    case tableInsertTableEG = 0x0437

    /// TableOptions 0x0438 Changes the height and width of the rows and columns in a table.
    case tableOptions = 0x0438

    /// CellOptions 0x0439 Changes the margins and other options of a table cell.
    case cellOptions = 0x0439

    /// EmailSend 0x043A Executes the e-mail Send command of the e-mail envelope.
    case emailSend = 0x043A

    /// EmailSelectNames 0x043B Displays the e-mail address book.
    case emailSelectNames = 0x043B

    /// EmailCheckNames 0x043C Verifies the recipient names in the e-mail envelope.
    case emailCheckNames = 0x043C

    /// EmailSelectToNames 0x043D Displays the e-mail address book to add recipients to the "To" field.
    case emailSelectToNames = 0x043D

    /// EmailSelectCcNames 0x043E Displays the e-mail address book to add recipients to the "Cc" field.
    case emailSelectCcNames = 0x043E

    /// EmailSelectBccNames 0x043F Displays the e-mail address book to add recipients to the "Bcc" field.
    case emailSelectBccNames = 0x043F

    /// EmailFocusSubject 0x0440 Switches focus to the subject field of the e-mail envelope.
    case emailFocusSubject = 0x0440

    /// EmailMessageOptions 0x0441 Displays the options dialog of the e-mail envelope.
    case emailMessageOptions = 0x0441

    /// EmailFlag 0x0442 Displays the message flag dialog of the envelope.
    case emailFlag = 0x0442

    /// EmailSaveAttachment 0x0443 Saves the attachments of an e-mail envelope message.
    case emailSaveAttachment = 0x0443

    /// FileNewEmail 0x0444 Creates a new e-mail message.
    case fileNewEmail = 0x0444

    /// WebPagePreview 0x0445 Displays full pages in a Web browser.
    case webPagePreview = 0x0445

    /// TableInsertRowAbove 0x0448 Inserts one or more rows into the table.
    case tableInsertRowAbove = 0x0448

    /// PrivFunctionkey1 0x0449 Private function for f1 key.
    case privFunctionkey1 = 0x0449

    /// PrivFunctionkey2 0x044A Private function for f2 key.
    case privFunctionkey2 = 0x044A

    /// PrivFunctionkey3 0x044B Private function for f3 key.
    case privFunctionkey3 = 0x044B

    /// PrivFunctionkey4 0x044C Private function for f4 key.
    case privFunctionkey4 = 0x044C

    /// PrivFunctionkey5 0x044D Private function for f5 key.
    case privFunctionkey5 = 0x044D

    /// PrivFunctionkey6 0x044E Private function for f6 key.
    case privFunctionkey6 = 0x044E

    /// PrivFunctionkey7 0x044F Private function for f7 key.
    case privFunctionkey7 = 0x044F

    /// PrivFunctionkey8 0x0450 Private function for f8 key.
    case privFunctionkey8 = 0x0450

    /// PrivFunctionkey9 0x0451 Private function for f9 key.
    case privFunctionkey9 = 0x0451

    /// PrivFunctionkey10 0x0452 Private function for f10 key.
    case privFunctionkey10 = 0x0452

    /// PrivFunctionkey11 0x0453 Private function for f11 key.
    case privFunctionkey11 = 0x0453

    /// PrivFunctionkey12 0x0454 Private function for f12 key.
    case privFunctionkey12 = 0x0454

    /// FileSaveFrameAs 0x0455 Saves a copy of the current frame document in a separate file.
    case fileSaveFrameAs = 0x0455

    /// ShowScriptAnchor 0x0456 Has no effect.
    case showScriptAnchor = 0x0456

    /// FramesetTOC 0x0457 Create a frameset table of content.
    case framesetTOC = 0x0457

    /// DiacriticColor 0x0458 Changes the color of the diacritics.
    case diacriticColor = 0x0458

    /// FileNewWeb 0x0459 Creates a new document based on the Normal template.
    case fileNewWeb = 0x0459

    /// FormatThemeName 0x045A Has no effect.
    case formatThemeName = 0x045A

    /// FileNewPrint 0x045B Creates a new document based on the Normal template.
    case fileNewPrint = 0x045B

    /// FileNewDialog 0x045C Creates a new document based on the Normal template.
    case fileNewDialog = 0x045C

    /// HTMLSourceRefresh 0x045E Has no effect.
    case hTMLSourceRefresh = 0x045E

    /// ToggleWebDesign 0x045F Toggles Web Design mode.
    case toggleWebDesign = 0x045F

    /// HTMLSourceDoNotRefresh 0x0460 Has no effect.
    case hTMLSourceDoNotRefresh = 0x0460

    /// ShowConsistency 0x0461 Show next formatting inconsistency.
    case showConsistency = 0x0461

    /// InsertHTMLCheckBox 0x0462 Has no effect.
    case insertHTMLCheckBox = 0x0462

    /// InsertHTMLOptionButton 0x0463 Has no effect.
    case insertHTMLOptionButton = 0x0463

    /// InsertHTMLDropdownBox 0x0464 Has no effect.
    case insertHTMLDropdownBox = 0x0464

    /// InsertHTMLListBox 0x0465 Has no effect.
    case insertHTMLListBox = 0x0465

    /// InsertHTMLTextBox 0x0466 Has no effect.
    case insertHTMLTextBox = 0x0466

    /// InsertHTMLTextArea 0x0467 Has no effect.
    case insertHTMLTextArea = 0x0467

    /// InsertHTMLSubmit 0x0468 Has no effect.
    case insertHTMLSubmit = 0x0468

    /// InsertHTMLImageSubmit 0x0469 Has no effect.
    case insertHTMLImageSubmit = 0x0469

    /// InsertHTMLReset 0x046A Has no effect.
    case insertHTMLReset = 0x046A

    /// InsertHTMLHidden 0x046B Has no effect.
    case insertHTMLHidden = 0x046B

    /// InsertHTMLPassword 0x046C Has no effect.
    case insertHTMLPassword = 0x046C

    /// InsertHTMLMovie 0x046D Has no effect.
    case insertHTMLMovie = 0x046D

    /// InsertHTMLBGSound 0x046E Has no effect.
    case insertHTMLBGSound = 0x046E

    /// InsertHTMLMarquee 0x046F Has no effect.
    case insertHTMLMarquee = 0x046F

    /// OnlineMeeting 0x0470 Has no effect.
    case onlineMeeting = 0x0470

    /// ShowAllFareast 0x0471 Shows or hides all nonprinting characters.
    case showAllFareast = 0x0471

    /// AutoFitContent 0x0475 Auto-Fit table to the contents.
    case autoFitContent = 0x0475

    /// AutoFitWindow 0x0476 Auto-Fit table to the window.
    case autoFitWindow = 0x0476

    /// AutoFitFixed 0x0478 Set table size to a fixed width.
    case autoFitFixed = 0x0478

    /// TopRightAlign 0x0479 Aligns cell content to the top-logical right of cell.
    case topRightAlign = 0x0479

    /// TopCenterAlign 0x047A Aligns cell content to the top-center of cell.
    case topCenterAlign = 0x047A

    /// TopLeftAlign 0x047B Aligns cell content to the top-logical left of cell.
    case topLeftAlign = 0x047B

    /// MiddleRightAlign 0x047C Aligns cell content to the middle-logical right of cell.
    case middleRightAlign = 0x047C

    /// MiddleCenterAlign 0x047D Aligns cell content to the middle-center of cell.
    case middleCenterAlign = 0x047D

    /// MiddleLeftAlign 0x047E Aligns cell content to the middle-logical left of cell.
    case middleLeftAlign = 0x047E

    /// BottomRightAlign 0x047F Aligns cell content to the bottom-logical right of cell.
    case bottomRightAlign = 0x047F

    /// BottomCenterAlign 0x0480 Aligns cell content to the bottom-center of cell.
    case bottomCenterAlign = 0x0480

    /// BottomLeftAlign 0x0481 Aligns cell content to the bottom-logical left of cell.
    case bottomLeftAlign = 0x0481

    /// ViewHTMLSource 0x0482 Has no effect.
    case viewHTMLSource = 0x0482

    /// ToolsTCSCTranslation 0x0484 Translates from Traditional Chinese to Simplified Chinese or vice-versa depending on the choice of the user.
    case toolsTCSCTranslation = 0x0484

    /// TableWizard 0x0485 Invokes the Table Wizard add-in (Korean and Chinese).
    case tableWizard = 0x0485

    /// HanjaDictionary 0x0486 Has no effect.
    case hanjaDictionary = 0x0486

    /// FormatHorizontalInVertical 0x0488 Apply Horizontal in Vertical property.
    case formatHorizontalInVertical = 0x0488

    /// FormatTwoLinesInOne 0x0489 Apply Two Lines in One property.
    case formatTwoLinesInOne = 0x0489

    /// FormatEncloseCharacters 0x048A Inserts an enclosed character.
    case formatEncloseCharacters = 0x048A

    /// UnderlineStyle 0x048B Formats the selection with a continuous underline.
    case underlineStyle = 0x048B

    /// FileSaveAsWebPage 0x048C Saves a copy of the document in a separate file.
    case fileSaveAsWebPage = 0x048C

    /// DrawingGrid 0x0490 Tunnel to SnapToGrid dialog.
    case drawingGrid = 0x0490

    /// ToolsTCSCTranslate 0x0491 Translates from Traditional Chinese to Simplified Chinese.
    case toolsTCSCTranslate = 0x0491

    /// ToolsSCTCTranslate 0x0492 Translates from Simplified Chinese to Traditional Chinese.
    case toolsSCTCTranslate = 0x0492

    /// ToolsTranslateChinese 0x0493 Translates from Traditional Chinese to Simplified Chinese on a computer set up with Taiwanese settings; otherwise translates from Simplified Chinese to Traditional Chinese.
    case toolsTranslateChinese = 0x0493

    /// ShowAllConsistency 0x0494 Show all format inconsistencies.
    case showAllConsistency = 0x0494

    /// InsertSpecialSymbol 0x0496 Inserts a special character.
    case insertSpecialSymbol = 0x0496

    /// EnvelopeWizard 0x0497 Invokes the Envelope Wizard add-in (Chinese).
    case envelopeWizard = 0x0497

    /// GreetingSentence 0x0498 Invokes the Japanese Greeting Wizard.
    case greetingSentence = 0x0498

    /// ViewOutlineMaster 0x0499 Displays a document outline.
    case viewOutlineMaster = 0x0499

    /// ScheduleMeeting 0x049A Schedules an Online Meeting.
    case scheduleMeeting = 0x049A

    /// WebDiscussions 0x049B Starts Web Server Discussions.
    case webDiscussions = 0x049B

    /// EditPaste2 0x049C Inserts the Clipboard contents at the insertion point.
    case editPaste2 = 0x049C

    /// ToolsProtect 0x04D8 Sets protection for the active document or selection.
    case toolsProtect = 0x04D8

    /// FileUndoCheckout 0x04D9 Undo the Check Out of a Document.
    case fileUndoCheckout = 0x04D9

    /// ShowTableTools 0x04DA Shows Table Tools in the Ribbon.
    case showTableTools = 0x04DA

    /// ShowPictureTools 0x04DB Shows Picture Tools in the Ribbon.
    case showPictureTools = 0x04DB

    /// SelectSimilarFormatting 0x04DC Select all similar formatting.
    case selectSimilarFormatting = 0x04DC

    /// MailMergeShadeFields 0x04DD Toggles shading of merge fields.
    case mailMergeShadeFields = 0x04DD

    /// MailMergeWizard 0x04DE Invokes Mail Merge.
    case mailMergeWizard = 0x04DE

    /// EditPasteOption 0x04DF Inserts the Clipboard contents at the insertion point using specific recovery option.
    case editPasteOption = 0x04DF

    /// FormatStyleVisibility 0x04E0 Changes the visibility state of the document's styles.
    case formatStyleVisibility = 0x04E0

    /// JapaneseGreetingOpeningSentence 0x04E1 Japanese Greeting Wizard Opening Sentence.
    case japaneseGreetingOpeningSentence = 0x04E1

    /// JapaneseGreetingClosingSentence 0x04E2 Japanese Greeting Wizard Closing Sentence.
    case japaneseGreetingClosingSentence = 0x04E2

    /// JapaneseGreetingPreviousGreeting 0x04E3 Japanese Greeting Wizard Previous Greeting.
    case japaneseGreetingPreviousGreeting = 0x04E3

    /// ModifyProperty 0x04E4 Brings up a dialog to modify a particular property.
    case modifyProperty = 0x04E4

    /// ApplyPropertyOfSurrounding 0x04E5 Matches formatting of current selection to formatting of surrounding text for a particular property.
    case applyPropertyOfSurrounding = 0x04E5

    /// TranslatePane 0x04E6 Opens the translation pane.
    case translatePane = 0x04E6

    /// ContinueNumbering 0x04E7 Continues paragraph numbering.
    case continueNumbering = 0x04E7

    /// ToolsSpeech 0x04EA Turns Speech Recognition on or off.
    case toolsSpeech = 0x04EA

    /// MailAsPlainText 0x04EB Converts the current message to plain text.
    case mailAsPlainText = 0x04EB

    /// MailAsHTML 0x04EC Converts the current message to HTML.
    case mailAsHTML = 0x04EC

    /// CssLinks 0x04ED Manages external CSS links.
    case cssLinks = 0x04ED

    /// ToolsFixHHC 0x04EE Insert converted Hangul or Hanja text.
    case toolsFixHHC = 0x04EE

    /// LineSpacing 0x04EF Applies line spacing to the selection.
    case lineSpacing = 0x04EF

    /// MailAsRTF 0x04F0 Converts the current message to RTF.
    case mailAsRTF = 0x04F0

    /// FileNewContext 0x04F1 Creates a new document based on the NORMAL template.
    case fileNewContext = 0x04F1

    /// ViewSignatures 0x04F3 View the signatures in this document.
    case viewSignatures = 0x04F3

    /// ReturnReview 0x04F4 Send this document under review.
    case returnReview = 0x04F4

    /// FileVersionsLocal 0x04F5 Manages the local versions of a document.
    case fileVersionsLocal = 0x04F5

    /// EndReview 0x04F6 End the review for this document.
    case endReview = 0x04F6

    /// NormalizeText 0x04F8 Make text consistent with the rest.
    case normalizeText = 0x04F8

    /// IgnoreConsistenceError 0x04F9 Ignore formatting inconsistency error.
    case ignoreConsistenceError = 0x04F9

    /// IgnoreAllConsistenceError 0x04FA Ignore all formatting inconsistency errors.
    case ignoreAllConsistenceError = 0x04FA

    /// ShrinkMultiSel 0x04FB Shrinks a multiple selection to the piece that was selected last.
    case shrinkMultiSel = 0x04FB

    /// FileCheckout 0x04FD Check out a document.
    case fileCheckout = 0x04FD

    /// FileCheckin 0x04FE Check in a document.
    case fileCheckin = 0x04FE

    /// LearnWords 0x04FF Use words from document to improve speech recognition.
    case learnWords = 0x04FF

    /// EditPictureEdit 0x0500 Converts the selected picture into a Drawing Canvas.
    case editPictureEdit = 0x0500

    /// FormatDefineStyleTable 0x0502 Has no effect.
    case formatDefineStyleTable = 0x0502

    /// FormatDefineStyleStripes 0x0503 Has no effect.
    case formatDefineStyleStripes = 0x0503

    /// ViewChanges 0x0504 Show or hide markup balloons.
    case viewChanges = 0x0504

    /// DisplayFinalDoc 0x0505 Show insertions inline and deletions in balloons.
    case displayFinalDoc = 0x0505

    /// DisplayOriginalDoc 0x0506 Show deletions inline and insertions in balloons.
    case displayOriginalDoc = 0x0506

    /// ShowChangesAndComments 0x0508 Show or hide markup balloons.
    case showChangesAndComments = 0x0508

    /// ShowComments 0x0509 Show or hide comment balloons.
    case showComments = 0x0509

    /// ShowInsertionsAndDeletions 0x050A Show or hide markup balloons.
    case showInsertionsAndDeletions = 0x050A

    /// ShowFormatting 0x050B Show or hide markup balloons.
    case showFormatting = 0x050B

    /// PreviousChangeOrComment 0x050D Go to the previous insertion, deletion, or comment.
    case previousChangeOrComment = 0x050D

    /// NextChangeOrComment 0x050E Go to the next insertion, deletion, or comment.
    case nextChangeOrComment = 0x050E

    /// AcceptChangesSelected 0x050F Accepts change in current selection.
    case acceptChangesSelected = 0x050F

    /// AcceptAllChangesShown 0x0510 Accepts all changes that are highlighted in the current filter settings.
    case acceptAllChangesShown = 0x0510

    /// AcceptAllChangesInDoc 0x0511 Accepts all changes in document, ignoring filter settings.
    case acceptAllChangesInDoc = 0x0511

    /// RejectChangesSelected 0x0512 Rejects changes and deletes comments in current selection.
    case rejectChangesSelected = 0x0512

    /// RejectAllChangesShown 0x0513 Rejects all changes that are highlighted in the current filter settings.
    case rejectAllChangesShown = 0x0513

    /// RejectAllChangesInDoc 0x0514 Rejects all changes in document, ignoring filter settings.
    case rejectAllChangesInDoc = 0x0514

    /// DeleteAllCommentsShown 0x0515 Deletes all comments that are highlighted in the current filter settings.
    case deleteAllCommentsShown = 0x0515

    /// DeleteAllCommentsInDoc 0x0516 Deletes all comments in document, ignoring filter settings.
    case deleteAllCommentsInDoc = 0x0516

    /// InsertNewComment 0x0517 Insert comment (includes menu).
    case insertNewComment = 0x0517

    /// MailMergeFieldMapping 0x0518 Mail Merge field mapping.
    case mailMergeFieldMapping = 0x0518

    /// MailMergeAddressBlock 0x0519 Mail Merge Address Block.
    case mailMergeAddressBlock = 0x0519

    /// MailMergeGreetingLine 0x051A Mail Merge Greeting Line.
    case mailMergeGreetingLine = 0x051A

    /// MailMergeInsertFields 0x051B Mail Merge Insert Fields.
    case mailMergeInsertFields = 0x051B

    /// MailMergeRecipients 0x051C Mail Merge Recipients.
    case mailMergeRecipients = 0x051C

    /// MMEmailOptions 0x051D Mail Merge E-mail Options Dialog.
    case mMEmailOptions = 0x051D

    /// MMNewDocOptions 0x051E Mail Merge New Document Merge Options Dialog.
    case mMNewDocOptions = 0x051E

    /// MMPrintOptions 0x051F Mail Merge Print Merge Options Dialog.
    case mMPrintOptions = 0x051F

    /// MMFaxOptions 0x0520 Mail Merge Fax Options Dialog.
    case mMFaxOptions = 0x0520

    /// ViewTaskPane 0x0521 Shows or hides the Task Pane.
    case viewTaskPane = 0x0521

    /// MailMergeEditAddressBlock 0x0523 Edit Address Block.
    case mailMergeEditAddressBlock = 0x0523

    /// MailMergeEditGreetingLine 0x0524 Edit Greeting Line.
    case mailMergeEditGreetingLine = 0x0524

    /// ApplyPropertyOfOriginal 0x0525 Matches formatting of current selection to formatting of original selection for a particular property.
    case applyPropertyOfOriginal = 0x0525

    /// ApplyFormattingOfSurrounding 0x0529 Applies formatting of surrounding text to current selection.
    case applyFormattingOfSurrounding = 0x0529

    /// ApplyFormattingOfOriginal 0x052A Applies formatting of original selection to current selection.
    case applyFormattingOfOriginal = 0x052A

    /// LettersWizardJToolbar 0x052B Displays or hides the Japanese Greeting Wizard Toolbar.
    case lettersWizardJToolbar = 0x052B

    /// InsertWebComponent 0x052C Has no effect.
    case insertWebComponent = 0x052C

    /// MailMergePropagateLabel 0x052D Populate all mail merge labels in the document.
    case mailMergePropagateLabel = 0x052D

    /// MailMergeFindEntry 0x052E Finds a specified entry in a mail merge data source.
    case mailMergeFindEntry = 0x052E

    /// ShowSmPane 0x052F Displays the Document Updates Pane.
    case showSmPane = 0x052F

    /// SignatureLineMenuSign 0x0530 Signs with a digital signature.
    case signatureLineMenuSign = 0x0530

    /// ResetFormField 0x0531 Resets the selected form field to its default value.
    case resetFormField = 0x0531

    /// DisplaySharedWorkspacePane 0x0532 Displays the Document Management pane.
    case displaySharedWorkspacePane = 0x0532

    /// FileVersionsServer 0x0533 Manages the server versions of a document.
    case fileVersionsServer = 0x0533

    /// DisplayForReview 0x0534 Selects viewing mode for revisions and comments.
    case displayForReview = 0x0534

    /// AnnotationEdit 0x0535 Edit comment.
    case annotationEdit = 0x0535

    /// ShowAllAuthors 0x0539 Show or hide markup balloons for all authors.
    case showAllAuthors = 0x0539

    /// Translate 0x053A Opens the translation pane.
    case translate = 0x053A

    /// MailMergeSetDocumentType 0x053B Sets or clears the Mail Merge document type.
    case mailMergeSetDocumentType = 0x053B

    /// FormatField 0x053C Inserts a field in the active document.
    case formatField = 0x053C

    /// ReplaceEmailSignature 0x053D Replaces the current AutoSignature with a different one.
    case replaceEmailSignature = 0x053D

    /// IncreaseParagraphSpacing 0x053E Increases paragraph spacing by 6 points.
    case increaseParagraphSpacing = 0x053E

    /// DecreaseParagraphSpacing 0x053F Decreases paragraph spacing by 6 points.
    case decreaseParagraphSpacing = 0x053F

    /// ReplyToAnnotation 0x0540 Reply to comment.
    case replyToAnnotation = 0x0540

    /// ToolsWordCountRecount 0x0541 Updates the word count statistics of the active document.
    case toolsWordCountRecount = 0x0541

    /// ToolsWordCountList 0x0542 Displays the word count statistics of the active document.
    case toolsWordCountList = 0x0542

    /// FormatStyleModify 0x0543 Modifies selected style.
    case formatStyleModify = 0x0543

    /// FormatStyleByExample 0x0544 Creates a style out of the currently selected text.
    case formatStyleByExample = 0x0544

    /// SelectNumber 0x0545 Selects the paragraph number.
    case selectNumber = 0x0545

    /// RestartNumbering 0x0546 Restarts paragraph numbering.
    case restartNumbering = 0x0546

    /// FixUIMChange 0x0547 Replaces this word by the selected suggestion.
    case fixUIMChange = 0x0547

    /// UIMCorrectionUI 0x0548 Brings up the correction UI for the Tablet Input Panel.
    case uIMCorrectionUI = 0x0548

    /// FixUIMDeleteWord 0x0549 Removes the word.
    case fixUIMDeleteWord = 0x0549

    /// ClearFormatting 0x054A Clears formatting and styles from selected text.
    case clearFormatting = 0x054A

    /// ToolsOptionsEditCopyPaste 0x054C Changes the editing options.
    case toolsOptionsEditCopyPaste = 0x054C

    /// TxbxAutosize 0x054D Changes the selected drawing object to autosize.
    case txbxAutosize = 0x054D

    /// EditPasteAppendTable 0x054E Inserts the clipboard contents at the insertion point.
    case editPasteAppendTable = 0x054E

    /// ReviewingPane 0x054F Opens a summary pane for viewing and editing document revisions (toggle).
    case reviewingPane = 0x054F

    /// OutlinePromoteHeading1 0x0550 Promotes the selected text to Heading 1 style.
    case outlinePromoteHeading1 = 0x0550

    /// ToolsOptionsSecurity 0x0551 Changes security options.
    case toolsOptionsSecurity = 0x0551

    /// FileSearch 0x0553 Brings up the Search UI workpane.
    case fileSearch = 0x0553

    /// FormattingPane 0x0554 Applies, creates, or modifies styles and formatting.
    case formattingPane = 0x0554

    /// DeleteStyle 0x0555 Deletes the current style.
    case deleteStyle = 0x0555

    /// RenameStyle 0x0556 Renames the current style.
    case renameStyle = 0x0556

    /// LabelOptions 0x0557 Label Options Dialog.
    case labelOptions = 0x0557

    /// EnvelopeSetup 0x0558 Envelopes Option Dialog.
    case envelopeSetup = 0x0558

    /// MailMergeToEMail 0x0559 Sends the results of the mail merge to an e-mail message.
    case mailMergeToEMail = 0x0559

    /// MailMergeToFax 0x055A Sends the results of the mail merge to Fax.
    case mailMergeToFax = 0x055A

    /// MailMergeToolbar 0x055B Displays or hides the Mail Merge Toolbar.
    case mailMergeToolbar = 0x055B

    /// MailMergeCreateList 0x055C Create an Office Address List.
    case mailMergeCreateList = 0x055C

    /// MailMergeEditList 0x055D Edit an Office Address List.
    case mailMergeEditList = 0x055D

    /// TableAutoFormatStyle 0x055F Applies a table style to a table.
    case tableAutoFormatStyle = 0x055F

    /// LicenseVerification 0x0561 Displays the dialog box for activating the product.
    case licenseVerification = 0x0561

    /// FormatConsistencyCheck 0x0562 Check for formatting consistency.
    case formatConsistencyCheck = 0x0562

    /// SendForReview 0x0563 Send this document for review.
    case sendForReview = 0x0563

    /// SignOutOfPassport 0x0564 Signs out of Windows Live ID.
    case signOutOfPassport = 0x0564

    /// ShowRepairs 0x0565 Shows all repairs made to the document during Crash Recovery.
    case showRepairs = 0x0565

    /// ToolsEServices 0x0567 Opens the eServices dialog.
    case toolsEServices = 0x0567

    /// DeleteStructure 0x0568 Remove XML Element.
    case deleteStructure = 0x0568

    /// ViewXMLStructure 0x056C Show XML Structure Pane.
    case viewXMLStructure = 0x056C

    /// GotoTableOfContents 0x056D Selects the first table of contents in the document.
    case gotoTableOfContents = 0x056D

    /// UpdateTableOfContents 0x056E Updates the first table of contents in the document.
    case updateTableOfContents = 0x056E

    /// OutlineLevel 0x056F Sets the selected paragraphs to the heading level.
    case outlineLevel = 0x056F

    /// ShowLevel 0x0570 Displays the selected level headings only.
    case showLevel = 0x0570

    /// ToggleCharacterCode 0x0571 Toggles a character code and a character.
    case toggleCharacterCode = 0x0571

    /// ToolsOptionsSmartTag 0x0573 Changes the Smart Tag options.
    case toolsOptionsSmartTag = 0x0573

    /// EmailFocusIntroduction 0x0574 Switches focus to the introduction field of the e-mail envelope.
    case emailFocusIntroduction = 0x0574

    /// EditPasteFromExcel 0x0575 Inserts the Clipboard contents at the insertion point.
    case editPasteFromExcel = 0x0575

    /// InsertStyleSeparator 0x0576 Joins two paragraphs together creating leading emphasis.
    case insertStyleSeparator = 0x0576

    /// FixBrokenText 0x0577 Has no effect.
    case fixBrokenText = 0x0577

    /// ReadingModePageview 0x0587 Show pages as they will look if printed.
    case readingModePageview = 0x0587

    /// ToggleXMLTagView 0x0588 Toggle XML Tag View on or off.
    case toggleXMLTagView = 0x0588

    /// SchemaLibrary 0x0589 Displays the Schema Library dialog.
    case schemaLibrary = 0x0589

    /// ResearchLookup 0x058A Looks up the word in the research tool.
    case researchLookup = 0x058A

    /// WindowArrangeSideBySide 0x058B Arranges two windows side by side.
    case windowArrangeSideBySide = 0x058B

    /// SqmDialog 0x058C Opens the Customer Feedback Options dialog.
    case sqmDialog = 0x058C

    /// InsertInkComment 0x058D Insert ink comment.
    case insertInkComment = 0x058D

    /// StyleLockDown 0x058E Locks styles in a document.
    case styleLockDown = 0x058E

    /// SyncScrollSideBySide 0x058F Enables synchronous scrolling of two windows sideby-side.
    case syncScrollSideBySide = 0x058F

    /// ResetSideBySide 0x0590 Resets window position for side-by-side.
    case resetSideBySide = 0x0590

    /// XMLOptions 0x0591 Changes XML settings for this document.
    case xMLOptions = 0x0591

    /// XMLDocument 0x0592 Applies XML Transforms to this document.
    case xMLDocument = 0x0592

    /// FormattingRestrictions 0x0593 Style lock down settings.
    case formattingRestrictions = 0x0593

    /// FilePermissionMenu 0x0596 File Permission Menu.
    case filePermissionMenu = 0x0596

    /// FPUnprotected 0x0597 "Unprotected" template (DRM).
    case fPUnprotected = 0x0597

    /// FPConfidential 0x0598 "Confidential" template (DRM).
    case fPConfidential = 0x0598

    /// FPAdminTemplates 0x059C Administrator-defined template (DRM).
    case fPAdminTemplates = 0x059C

    /// MyPermission 0x059D Displays the DRM usage permissions for the user.
    case myPermission = 0x059D

    /// ToggleThumbnail 0x059E Toggles thumbnail view.
    case toggleThumbnail = 0x059E

    /// ToolsThesaurusRR 0x059F Displays synonyms for the selected word in the Research pane.
    case toolsThesaurusRR = 0x059F

    /// DoNotDistribute 0x05A0 Permission toggle button on toolbar.
    case doNotDistribute = 0x05A0

    /// ToggleReadingMode2Pages 0x05A2 Toggles 2 Pages view.
    case toggleReadingMode2Pages = 0x05A2

    /// ToggleReadingModeInk 0x05A3 Enables Ink Annotation.
    case toggleReadingModeInk = 0x05A3

    /// ReadingModeInkOff 0x05A4 Unlocks document for ink.
    case readingModeInkOff = 0x05A4

    /// InsertSoundComment 0x05A5 Inserts a sound object into the document.
    case insertSoundComment = 0x05A5

    /// EditFindReadingMode 0x05A6 Finds the specified text or the specified formatting.
    case editFindReadingMode = 0x05A6

    /// UseBalloons 0x05A7 Show all revisions in balloons.
    case useBalloons = 0x05A7

    /// NeverUseBalloons 0x05A8 Show all revisions inline.
    case neverUseBalloons = 0x05A8

    /// NoInsertionDeletionBalloons 0x05A9 Show comments and formatting revisions in balloons.
    case noInsertionDeletionBalloons = 0x05A9

    /// ShowInkAnnotations 0x05AA Show or hide ink annotations.
    case showInkAnnotations = 0x05AA

    /// DeleteAllInkAnnotations 0x05AB Delete all ink annotations.
    case deleteAllInkAnnotations = 0x05AB

    /// ToggleReadingModeHelp 0x05AC Help for Ink Annotation.
    case toggleReadingModeHelp = 0x05AC

    /// HelpContactUs 0x05AD Brings up the Web browser and displays the Contact Us page.
    case helpContactUs = 0x05AD

    /// HelpCheckForUpdates 0x05AE Brings up the Web browser and displays the Product Update page.
    case helpCheckForUpdates = 0x05AE

    /// BlogBlogInsertCategories 0x05AF Inserts a category into the document.
    case blogBlogInsertCategories = 0x05AF

    /// ToggleToolbars 0x05B0 Toggles Toolbars.
    case toggleToolbars = 0x05B0

    /// ReadingMode 0x05B1 Toggles full screen reading.
    case readingMode = 0x05B1

    /// ApplyStructure 0x05B2 Apply XML Element.
    case applyStructure = 0x05B2

    /// Research 0x05B3 Initiates the Research pane.
    case research = 0x05B3

    /// XmlAttr 0x05B4 Modify attribute settings of an XML element.
    case xmlAttr = 0x05B4

    /// FPSelectUser 0x05B5 Select user in permission menu.
    case fPSelectUser = 0x05B5

    /// ViewDocumentMapReadingMode 0x05B6 Toggles state of the Heading Explorer.
    case viewDocumentMapReadingMode = 0x05B6

    /// ReadingModeMini 0x05B7 Switch to full screen reading.
    case readingModeMini = 0x05B7

    /// ReadingModeLookup 0x05B8 Lookup tools for reading.
    case readingModeLookup = 0x05B8

    /// ReadingModeGrowFont 0x05B9 Increases the font size for full screen reading.
    case readingModeGrowFont = 0x05B9

    /// ReadingModeShrinkFont 0x05BA Decreases the font size for full screen reading.
    case readingModeShrinkFont = 0x05BA

    /// FaxService 0x05BB Send this document to fax over the Internet.
    case faxService = 0x05BB

    /// GettingStartedPane 0x05BC Has no effect.
    case gettingStartedPane = 0x05BC

    /// FilePermission 0x05BD Restricts permission for a document.
    case filePermission = 0x05BD

    /// DocumentActionsPane 0x05BE Smart Document Pane.
    case documentActionsPane = 0x05BE

    /// ReadingModeLayout 0x05BF Switch to full screen reading.
    case readingModeLayout = 0x05BF

    /// AnnotInkPen 0x05C0 Ink Comment Pen.
    case annotInkPen = 0x05C0

    /// AnnotInkEraser 0x05C1 Ink Comment Eraser.
    case annotInkEraser = 0x05C1

    /// CopyInkAsText 0x05C2 Copies the ink selection and puts its text equivalent on the Clipboard.
    case copyInkAsText = 0x05C2

    /// InsertInkAnnotations 0x05C3 Insert ink annotation.
    case insertInkAnnotations = 0x05C3

    /// EmailChooseAccount 0x05C4 Allows choosing an e-mail account.
    case emailChooseAccount = 0x05C4

    /// EmailAttachmentOptions 0x05C5 Toggles display of the Attachment Options task pane.
    case emailAttachmentOptions = 0x05C5

    /// InkEraser 0x05C6 Ink Eraser.
    case inkEraser = 0x05C6

    /// CloseReadingMode 0x05C8 Stops full screen reading.
    case closeReadingMode = 0x05C8

    /// InkAnnotationEraser 0x05C9 Ink Eraser.
    case inkAnnotationEraser = 0x05C9

    /// DocInspector 0x05CA Document Inspector.
    case docInspector = 0x05CA

    /// GoToFurthestReadPg 0x05CB Goes to furthest read page.
    case goToFurthestReadPg = 0x05CB

    /// GoToFirstPg 0x05CC Goes to first page.
    case goToFirstPg = 0x05CC

    /// GoToLastPg 0x05CD Goes to last page.
    case goToLastPg = 0x05CD

    /// BackHistoryItem 0x05CE Goes back to most recent screen.
    case backHistoryItem = 0x05CE

    /// ForwardHistoryItem 0x05CF Goes forward to next visited screen.
    case forwardHistoryItem = 0x05CF

    /// JumpToScrn 0x05D0 Jump to screen label for screen navigator popup menu.
    case jumpToScrn = 0x05D0

    /// JumpToHeading 0x05D1 Jump to Heading label from screen navigator popup menu.
    case jumpToHeading = 0x05D1

    /// SaveAsQuickFormatSet 0x05D5 Saves the current Quick Style list as a new Quick Style set.
    case saveAsQuickFormatSet = 0x05D5

    /// InsertAlignmentTab 0x05DB Inserts an alignment tab at the insertion point.
    case insertAlignmentTab = 0x05DB

    /// ResetParagraphFormatting 0x076C Resets paragraph formatting.
    case resetParagraphFormatting = 0x076C

    /// CharacterRemoveStyle 0x076D Clears character style from selection.
    case characterRemoveStyle = 0x076D

    /// RestoreCharacterStyle 0x076E Restores character style and removes direct formatting.
    case restoreCharacterStyle = 0x076E

    /// CharacterClearFormatting 0x076F Clears character properties from formatting.
    case characterClearFormatting = 0x076F

    /// SeparateList 0x0770 Separates current paragraph into a new list.
    case separateList = 0x0770

    /// JoinToPreviousList 0x0771 Joins to previous list.
    case joinToPreviousList = 0x0771

    /// SetNumberingValue 0x0774 Sets the numbering value.
    case setNumberingValue = 0x0774

    /// EquationToggle 0x0775 Insert an equation.
    case equationToggle = 0x0775

    /// EquationProfessionalFormat 0x0776 Convert to Professional Format.
    case equationProfessionalFormat = 0x0776

    /// EquationLinearFormat 0x0777 Convert to Linear Format.
    case equationLinearFormat = 0x0777

    /// AdjustListIndents 0x0778 Changes the position of the list.
    case adjustListIndents = 0x0778

    /// ShowTasks 0x0779 Shows workflow tasks for this Document.
    case showTasks = 0x0779

    /// InsertSignatureLine 0x077A Insert digital signature line.
    case insertSignatureLine = 0x077A

    /// EquationMathAutoCorrect 0x077B Add or delete Math AutoCorrect entries.
    case equationMathAutoCorrect = 0x077B

    /// InsertCitation 0x077C Insert citation.
    case insertCitation = 0x077C

    /// InsertBibliography 0x077D Insert bibliography.
    case insertBibliography = 0x077D

    /// SelectBibliographyStyle 0x077E Select bibliography style.
    case selectBibliographyStyle = 0x077E

    /// BibliographySourceManager 0x0780 Opens the Source Manager dialog box.
    case bibliographySourceManager = 0x0780

    /// EquationInsertSymbol 0x0781 Insert equation symbol.
    case equationInsertSymbol = 0x0781

    /// BibliographyCreateSource 0x0782 Opens the Create Source dialog box.
    case bibliographyCreateSource = 0x0782

    /// LockPolicyLabel 0x0783 Locks .policy labels. for this document.
    case lockPolicyLabel = 0x0783

    /// UnlockPolicyLabel 0x0784 Unlocks .policy labels. for this document.
    case unlockPolicyLabel = 0x0784

    /// InsertPolicyLabel 0x0785 Inserts .policy labels. for this document.
    case insertPolicyLabel = 0x0785

    /// FillPolicyLabel 0x0786 Fills in the .policy labels. for this document.
    case fillPolicyLabel = 0x0786

    /// InsertPolicyBarcode 0x0787 Inserts barcode.
    case insertPolicyBarcode = 0x0787

    /// InsertBuildingBlockIP 0x0789 Inserts the building block at the insertion point.
    case insertBuildingBlockIP = 0x0789

    /// InsertBuildingBlockHeader 0x078A Inserts the building block in the header.
    case insertBuildingBlockHeader = 0x078A

    /// InsertBuildingBlockFooter 0x078B Inserts the building block in the footer.
    case insertBuildingBlockFooter = 0x078B

    /// InsertBuildingBlockBeginSection 0x078C Inserts the building block at the beginning of the current section.
    case insertBuildingBlockBeginSection = 0x078C

    /// InsertBuildingBlockEndSection 0x078D Inserts the building block at the end of the current section.
    case insertBuildingBlockEndSection = 0x078D

    /// InsertBuildingBlockBeginDocument 0x078E Inserts the building block at the beginning of the document.
    case insertBuildingBlockBeginDocument = 0x078E

    /// InsertBuildingBlockEndDocument 0x078F Inserts the building block at the end of a document.
    case insertBuildingBlockEndDocument = 0x078F

    /// AdvertisePublishAs 0x0790 Advertise Publish Export to PDF and XPS.
    case advertisePublishAs = 0x0790

    /// ShowMarkupArea 0x0791 Show or hide markup area highlight.
    case showMarkupArea = 0x0791

    /// SwitchNavigationWindow 0x0793 Choose navigation window.
    case switchNavigationWindow = 0x0793

    /// ToolsAutoCorrectManager 0x0794 Adds or deletes AutoCorrect or Math AutoCorrect entries.
    case toolsAutoCorrectManager = 0x0794

    /// ReadingModeAllowEditing 0x0795 Allow or disallow typing while reading.
    case readingModeAllowEditing = 0x0795

    /// ReadingModePageMarginsType 0x0796 Hide the margins on the printed page to display larger text.
    case readingModePageMarginsType = 0x0796

    /// EquationInsert 0x0797 Insert an equation.
    case equationInsert = 0x0797

    /// StartWorkflow 0x0798 Starts a workflow for this document.
    case startWorkflow = 0x0798

    /// DropCapGallery 0x0799 Opens the list of drop cap styles.
    case dropCapGallery = 0x0799

    /// PageOrientationGallery 0x079B Opens the list of options for page orientation.
    case pageOrientationGallery = 0x079B

    /// FormatStyleManagement 0x079C Manage the document or stylesheet.
    case formatStyleManagement = 0x079C

    /// UpdateStyle 0x079D Updates the current style based on the selected text.
    case updateStyle = 0x079D

    /// NewStyle 0x079E New quick style from selection.
    case newStyle = 0x079E

    /// FormattingPaneCurrent 0x079F Lists the current formatting in the document.
    case formattingPaneCurrent = 0x079F

    /// ListAdvanceToVBA 0x07A0 Advances the numbering value.
    case listAdvanceToVBA = 0x07A0

    /// ResetAdvanceToVBA 0x07A1 Resets the value of the number to advance to.
    case resetAdvanceToVBA = 0x07A1

    /// DownloadPictures 0x07A2 Reloads the e-mail message, allowing linked pictures to be downloaded from the Internet.
    case downloadPictures = 0x07A2

    /// ViewZoomTwoPage 0x07A3 Scales the editing view to see the two pages in page layout view.
    case viewZoomTwoPage = 0x07A3

    /// SymbolMRUGallery 0x07A6 Symbol MRU Gallery.
    case symbolMRUGallery = 0x07A6

    /// QuickFormatsGallery 0x07A7 Opens the list of Quick Styles.
    case QuickFormatsGallery = 0x07A7

    /// QuickFormatsThemeGallery 0x07A8 Opens the list of Quick Style sets.
    case QuickFormatsThemeGallery = 0x07A8

    /// ClearAllFormatting 0x07A9 Clears formatting and styles from selected text.
    case clearAllFormatting = 0x07A9

    /// TogglePanningHand 0x07AA Displays the panning state of the document.
    case togglePanningHand = 0x07AA

    /// BulletsGallery 0x07AB Opens the Bullet gallery.
    case bulletsGallery = 0x07AB

    /// NumberingGallery 0x07AC Opens the Numbering Gallery.
    case numberingGallery = 0x07AC

    /// MenuShowSourceDocuments 0x07AD Shows or hides source documents.
    case menuShowSourceDocuments = 0x07AD

    /// PageMarginsGallery 0x07B1 Opens the list of options for page margins.
    case pageMarginsGallery = 0x07B1

    /// CharScaleDialog 0x07B2 Opens the list of font scaling percentages.
    case charScaleDialog = 0x07B2

    /// AllShapesGallery 0x07B4 Displays the shapes that are available to insert.
    case allShapesGallery = 0x07B4

    /// RotateObjectGallery 0x07B5 Opens the list of options for rotating objects.
    case rotateObjectGallery = 0x07B5

    /// LineStyleGallery 0x07B6 Opens the list of line styles.
    case lineStyleGallery = 0x07B6

    /// LineWidthGallery 0x07B7 Opens the list of line widths.
    case lineWidthGallery = 0x07B7

    /// ArrowStyleGallery 0x07B8 Opens the list of arrow styles.
    case arrowStyleGallery = 0x07B8

    /// ChangeShapesGallery 0x07B9 Displays the shapes that are available to substitute.
    case changeShapesGallery = 0x07B9

    /// TexturesGallery 0x07BA Opens the list of textures.
    case texturesGallery = 0x07BA

    /// FontColorPicker 0x07BB Opens the list of font colors.
    case fontColorPicker = 0x07BB

    /// ColumnsGallery 0x07BC Opens the list of preset column layouts.
    case columnsGallery = 0x07BC

    /// EquationIncreaseAlignment 0x07BD Increase alignment point after a manual break.
    case equationIncreaseAlignment = 0x07BD

    /// EquationDecreaseAlignment 0x07BE Decrease alignment point after a manual break.
    case equationDecreaseAlignment = 0x07BE

    /// EquationChangeStyle 0x07BF Change equation style (Display or Inline).
    case equationChangeStyle = 0x07BF

    /// DocEncryption 0x07C0 Add document encryption.
    case docEncryption = 0x07C0

    /// BlogBlogAccountOptionsDlg 0x07C1 Changes blog account settings.
    case blogBlogAccountOptionsDlg = 0x07C1

    /// EquationInsertRowBefore 0x07C2 Insert a row into a matrix object.
    case equationInsertRowBefore = 0x07C2

    /// EquationInsertRowAfter 0x07C3 Insert a row into a matrix object.
    case equationInsertRowAfter = 0x07C3

    /// FileSendBlog 0x07C4 Sends the active document to a blog.
    case fileSendBlog = 0x07C4

    /// EquationInsertColumnBefore 0x07C5 Insert a column into a matrix object.
    case equationInsertColumnBefore = 0x07C5

    /// EquationInsertColumnAfter 0x07C6 Insert a column into a matrix object.
    case equationInsertColumnAfter = 0x07C6

    /// EquationDeleteRow 0x07C7 Delete a row from a matrix object.
    case equationDeleteRow = 0x07C7

    /// EquationDeleteColumn 0x07C8 Delete a column from a matrix object.
    case equationDeleteColumn = 0x07C8

    /// EquationVerticalCenter 0x07C9 Set equation vertical alignment to Center.
    case equationVerticalCenter = 0x07C9

    /// EquationVerticalTop 0x07CA Set equation vertical alignment to Top.
    case equationVerticalTop = 0x07CA

    /// EquationVerticalBottom 0x07CB Set equation vertical alignment to Bottom.
    case equationVerticalBottom = 0x07CB

    /// EquationHorizontalCenter 0x07CC Set equation horizontal alignment to Center.
    case equationHorizontalCenter = 0x07CC

    /// EquationHorizontalLeft 0x07CD Set equation horizontal alignment to Left.
    case equationHorizontalLeft = 0x07CD

    /// EquationHorizontalRight 0x07CE Set equation horizontal alignment to Right.
    case equationHorizontalRight = 0x07CE

    /// EquationShowHideLowerLimit 0x07CF Show/Hide N-ary lower limit.
    case equationShowHideLowerLimit = 0x07CF

    /// EquationShowHideUpperLimit 0x07D0 Show/Hide N-ary upper limit.
    case equationShowHideUpperLimit = 0x07D0

    /// EquationShowHideRadicalDegree 0x07D1 Show/Hide the radical degree.
    case equationShowHideRadicalDegree = 0x07D1

    /// EquationShowHideOpeningDelimiter 0x07D2 Show/Hide the left character.
    case equationShowHideOpeningDelimiter = 0x07D2

    /// EquationShowHideClosingDelimiter 0x07D3 Show/Hide the right character.
    case equationShowHideClosingDelimiter = 0x07D3

    /// EquationAutoProfessionalFormat 0x07D4 Automatically convert equation to Professional Format.
    case equationAutoProfessionalFormat = 0x07D4

    /// SignatureLineMenuDetails 0x07D5 Digital signature line details.
    case signatureLineMenuDetails = 0x07D5

    /// SignatureLineMenuSetup 0x07D6 Digital signature line setup.
    case signatureLineMenuSetup = 0x07D6

    /// SignatureLineMenuUnSign 0x07D7 Removes digital signature.
    case signatureLineMenuUnSign = 0x07D7

    /// EquationFractionGallery 0x07D8 Equation fraction gallery.
    case equationFractionGallery = 0x07D8

    /// EquationIntegralGallery 0x07D9 Equation integral gallery.
    case equationIntegralGallery = 0x07D9

    /// EquationRadicalGallery 0x07DA Equation radical gallery.
    case equationRadicalGallery = 0x07DA

    /// EquationNaryGallery 0x07DB Equation N-ary gallery.
    case equationNaryGallery = 0x07DB

    /// EquationDelimiterGallery 0x07DC Equation delimiter gallery.
    case equationDelimiterGallery = 0x07DC

    /// EquationScriptGallery 0x07DD Equation script gallery.
    case equationScriptGallery = 0x07DD

    /// NextComment 0x07DE Go to the next comment.
    case nextComment = 0x07DE

    /// PreviousComment 0x07DF Go to the previous comment.
    case previousComment = 0x07DF

    /// DefineNewBullet 0x07E0 Defines a new bullet.
    case defineNewBullet = 0x07E0

    /// DefineNewNumber 0x07E1 Defines a new number format.
    case defineNewNumber = 0x07E1

    /// CreateBuildingBlockFromSel 0x07E2 Creates a building block from the current selection.
    case createBuildingBlockFromSel = 0x07E2

    /// FooterGallery 0x07E3 Footer Gallery.
    case footerGallery = 0x07E3

    /// HeaderGallery 0x07E4 Header Gallery.
    case headerGallery = 0x07E4

    /// CoverPageGallery 0x07E5 Cover Page Gallery.
    case coverPageGallery = 0x07E5

    /// LegoPageNumGallery 0x07E7 Page Numbers Gallery.
    case legoPageNumGallery = 0x07E7

    /// LegoPageNumPageGallery 0x07E8 Page Numbers (Page) Gallery.
    case legoPageNumPageGallery = 0x07E8

    /// LegoWatermarkGallery 0x07E9 Watermark Gallery.
    case legoWatermarkGallery = 0x07E9

    /// LegoPageNumTopGallery 0x07EA Page Numbers (Top) Gallery.
    case legoPageNumTopGallery = 0x07EA

    /// LegoPageNumBottomGallery 0x07EB Page Numbers (Bottom) Gallery.
    case legoPageNumBottomGallery = 0x07EB

    /// LegoEquationsGallery 0x07EC Equations Gallery.
    case legoEquationsGallery = 0x07EC

    /// LegoTablesGallery 0x07EE Tables Gallery.
    case legoTablesGallery = 0x07EE

    /// LegoCommonPartsGallery 0x07F0 Common Parts Gallery.
    case legoCommonPartsGallery = 0x07F0

    /// CreateCommonFieldBlockFromSel 0x07F3 Creates a new Common Field building block from the current selection.
    case createCommonFieldBlockFromSel = 0x07F3

    /// CreateCoverPageBlockFromSel 0x07F4 Creates a new Cover Page building block from the current selection.
    case createCoverPageBlockFromSel = 0x07F4

    /// CreateEquationBlockFromSel 0x07F5 Creates a new Equation building block from the current selection.
    case createEquationBlockFromSel = 0x07F5

    /// CreateFooterBlockFromSel 0x07F6 Creates a new Footer building block from the current selection.
    case createFooterBlockFromSel = 0x07F6

    /// CreateHeaderBlockFromSel 0x07F7 Creates a new Header building block from the current selection.
    case createHeaderBlockFromSel = 0x07F7

    /// CreatePageNumFromSel 0x07F9 Creates a new Page Number building block from the current selection.
    case createPageNumFromSel = 0x07F9

    /// CreatePageNumTopFromSel 0x07FA Creates a new Page Number (Top) from the current selection.
    case createPageNumTopFromSel = 0x07FA

    /// CreatePageNumBottomFromSel 0x07FB Creates a new Page Number (Bottom) from the current selection.
    case createPageNumBottomFromSel = 0x07FB

    /// CreateTableBlockFromSel 0x07FC Creates a new Table building block from the current selection.
    case createTableBlockFromSel = 0x07FC

    /// CreatePageNumPageBlockFromSel 0x07FD Creates a new Page Number (Page) from the current selection.
    case createPageNumPageBlockFromSel = 0x07FD

    /// CreateWaterMarkBlockFromSel 0x07FF Creates a new Watermark Building Block from the current selection.
    case createWaterMarkBlockFromSel = 0x07FF

    /// EquationEdit 0x0800 Insert/Edit an equation.
    case equationEdit = 0x0800

    /// DefaultCondensed 0x0801 Sets the font character spacing of the selection to condensed.
    case defaultCondensed = 0x0801

    /// DefaultExpanded 0x0802 Sets the font character spacing of the selection to expanded.
    case defaultExpanded = 0x0802

    /// EquationSymbolsGallery 0x0803 Equation symbols gallery.
    case equationSymbolsGallery = 0x0803

    /// WordSearchLibraries 0x080D Search libraries.
    case wordSearchLibraries = 0x080D

    /// InsertOCXDialog 0x080E Inserts the selected ActiveX control.
    case insertOCXDialog = 0x080E

    /// ToggleXMLStructure 0x080F Shows/Hides XML Structure Pane.
    case toggleXMLStructure = 0x080F

    /// XmlSchema 0x0810 Changes the XML Schema options.
    case xmlSchema = 0x0810

    /// XmlExpansionPacks 0x0811 Changes the XML Expansion Pack options.
    case xmlExpansionPacks = 0x0811

    /// OartCommand 0x0812 Execute an OfficeArt undo or redo command.
    case oartCommand = 0x0812

    /// BuildingBlockOrganizer 0x0813 Manages Building Block entries.
    case buildingBlockOrganizer = 0x0813

    /// CompareDocumentsCompare 0x0814 Compare two versions of a document (legal blackline).
    case compareDocumentsCompare = 0x0814

    /// CompareDocumentsCombine 0x0815 Combine revisions from multiple authors into a single document.
    case compareDocumentsCombine = 0x0815

    /// CompareDocumentsLastMajor 0x0816 Compare this document with the last major version published on the server.
    case compareDocumentsLastMajor = 0x0816

    /// CompareDocumentsLastMinor 0x0817 Compare this document with the last version saved on the server.
    case compareDocumentsLastMinor = 0x0817

    /// CompareDocumentsVersion 0x0818 Compare this document with a specific version saved on the server.
    case compareDocumentsVersion = 0x0818

    /// InsertSignatureLineMenuItem 0x0819 Insert digital signature line.
    case insertSignatureLineMenuItem = 0x0819

    /// UpdateFieldsTable 0x081A Updates and displays the results of the selected fields.
    case updateFieldsTable = 0x081A

    /// UpdateFieldsIndex 0x081B Updates and displays the results of the selected fields.
    case updateFieldsIndex = 0x081B

    /// ToolsHyphenationAutoOn 0x081C Changes the automatic hyphenation setting for the active document.
    case toolsHyphenationAutoOn = 0x081C

    /// ToolsHyphenationAutoOff 0x081D Changes the automatic hyphenation setting for the active document.
    case toolsHyphenationAutoOff = 0x081D

    /// MailMergeClearDocumentType 0x081E Clears the Mail Merge document type.
    case mailMergeClearDocumentType = 0x081E

    /// MailMergeSetDocTypeFormLetter 0x081F Sets the Mail Merge document type to Form Letter.
    case mailMergeSetDocTypeFormLetter = 0x081F

    /// MailMergeSetDocTypeEmail 0x0820 Sets the Mail Merge document type to E-mail.
    case mailMergeSetDocTypeEmail = 0x0820

    /// MailMergeSetDocTypeFax 0x0821 Sets the Mail Merge document type to Fax.
    case mailMergeSetDocTypeFax = 0x0821

    /// MailMergeSetDocTypeEnvelope 0x0822 Sets the Mail Merge document type to Envelope.
    case mailMergeSetDocTypeEnvelope = 0x0822

    /// MailMergeSetDocTypeLabel 0x0823 Sets the Mail Merge document type to Label.
    case mailMergeSetDocTypeLabel = 0x0823

    /// MailMergeSetDocTypeDirectory 0x0824 Sets the Mail Merge document type to Directory.
    case mailMergeSetDocTypeDirectory = 0x0824

    /// UpdatePolicyLabels 0x0825 Updates .policy labels.
    case updatePolicyLabels = 0x0825

    /// BlogBlogOpenBlogSite 0x0826 Opens the blog's Web site.
    case blogBlogOpenBlogSite = 0x0826

    /// StyleQuickFormat 0x0827 Add or remove the current style from the Quick Style list.
    case styleQuickFormat = 0x0827

    /// RefTipLangGallery 0x0828 Translation ScreenTip Gallery.
    case refTipLangGallery = 0x0828

    /// RefTipSelectLang 0x0829 Show or Hide Translation ScreenTip.
    case refTipSelectLang = 0x0829

    /// EquationInsertEmptyStructure 0x082C Insert equation structure.
    case equationInsertEmptyStructure = 0x082C

    /// RemoveSimilarFormatting 0x082D Removes all similar formatting.
    case removeSimilarFormatting = 0x082D

    /// TogglePropertyPanel 0x082E Turns on or off the Property Editor.
    case togglePropertyPanel = 0x082E

    /// OutlineLevelGallery 0x082F Outline Level Gallery.
    case outlineLevelGallery = 0x082F

    /// BreaksGallery 0x0830 Breaks Gallery.
    case breaksGallery = 0x0830

    /// ToolsLineNumOff 0x0831 Turns off line numbering for the current document.
    case toolsLineNumOff = 0x0831

    /// ToolsLineNumContinuous 0x0832 Turns off line numbering for the current document.
    case toolsLineNumContinuous = 0x0832

    /// ToolsLineNumRestPage 0x0833 Turns off line numbering for the current document.
    case toolsLineNumRestPage = 0x0833

    /// ToolsLineNumResetSection 0x0834 Turns off line numbering for the current document.
    case toolsLineNumResetSection = 0x0834

    /// ToolsLineNumSuppress 0x0835 Turns off line numbering for the current document.
    case toolsLineNumSuppress = 0x0835

    /// TocOutlineLevelGallery 0x0836 Outline Level Gallery for the Table of Contents.
    case tocOutlineLevelGallery = 0x0836

    /// AcceptChangesAndAdvance 0x0837 Accepts change in current selection.
    case acceptChangesAndAdvance = 0x0837

    /// RejectChangesAndAdvance 0x0838 Rejects changes and deletes comments in current selection.
    case rejectChangesAndAdvance = 0x0838

    /// CreateSharedWorkspace 0x0839 Creates a document workspace.
    case createSharedWorkspace = 0x0839

    /// SaveToDocMgmtServer 0x083A Saves to Document Management Server.
    case saveToDocMgmtServer = 0x083A

    /// DisplayDocumentManagementPane 0x083B Displays the Document Management Pane.
    case displayDocumentManagementPane = 0x083B

    /// FreezeLayout 0x083C Freeze wrapping width.
    case freezeLayout = 0x083C

    /// NavBack 0x083D Jump back to the previous page in full screen reading.
    case navBack = 0x083D

    /// NavForward 0x083E Jump forward to the next page in full screen reading.
    case navForward = 0x083E

    /// MenuManageDocument 0x083F Manage.
    case menuManageDocument = 0x083F

    /// MenuShareDocument 0x0840 Shares a copy.
    case menuShareDocument = 0x0840

    /// MenuFinalizeDocument 0x0841 Finalize Document.
    case menuFinalizeDocument = 0x0841

    /// MenuSignaturesDocument 0x0842 View any digital signatures for this document.
    case menuSignaturesDocument = 0x0842

    /// MarkAsReadOnly 0x0843 Marks as Final.
    case markAsReadOnly = 0x0843

    /// SignDocument 0x0844 Sign this document.
    case signDocument = 0x0844

    /// AddDigitalSignature 0x0845 Add a digital signature.
    case addDigitalSignature = 0x0845

    /// ShowReviewerFilter 0x0846 Menu for showing reviewers.
    case showReviewerFilter = 0x0846

    /// SigningServices 0x0847 Signing services.
    case signingServices = 0x0847

    /// BibInsertSource 0x0848 Insert New Bibliography Source.
    case bibInsertSource = 0x0848

    /// ControlProperties 0x0849 Shows the properties of the current control.
    case controlProperties = 0x0849

    /// FillColorPicker 0x084A Fill Color Picker.
    case fillColorPicker = 0x084A

    /// LineColorPicker 0x084B Line Color Picker.
    case lineColorPicker = 0x084B

    /// ToggleDocumentText 0x084C Shows or hides the main text layer in page layout view.
    case toggleDocumentText = 0x084C

    /// HeadFootDiffFirstPage 0x084D Turns on a different header and footer for the first page.
    case headFootDiffFirstPage = 0x084D

    /// HeadFootDiffOddEvenPage 0x084E Turns on a different header and footer for odd and even pages.
    case headFootDiffOddEvenPage = 0x084E

    /// InsertNewPage 0x084F Inserts a new page break at the insertion point.
    case insertNewPage = 0x084F

    /// HideOutline 0x0850 Turns off the document outline.
    case hideOutline = 0x0850

    /// BrightnessGallery 0x0851 Brightness Gallery.
    case brightnessGallery = 0x0851

    /// ContrastGallery 0x0852 Contrast Gallery.
    case contrastGallery = 0x0852

    /// ChangeCaseGallery 0x0853 Change case gallery.
    case changeCaseGallery = 0x0853

    /// ShadingColorPicker 0x0856 Shading Color Picker.
    case shadingColorPicker = 0x0856

    /// BringForward 0x0857 Brings the selected drawing objects forward.
    case bringForward = 0x0857

    /// BringToFront 0x0858 Brings the selected drawing objects to the front.
    case bringToFront = 0x0858

    /// SendBackward 0x0859 Sends the selected drawing objects backward.
    case sendBackward = 0x0859

    /// SendToBack 0x085A Sends the selected drawing objects to the back.
    case sendToBack = 0x085A

    /// EquationInsertArgumentBefore 0x085C Insert a new argument.
    case equationInsertArgumentBefore = 0x085C

    /// EquationInsertArgumentAfter 0x085D Insert a new argument.
    case equationInsertArgumentAfter = 0x085D

    /// EquationDeleteArgument 0x085E Delete an argument.
    case equationDeleteArgument = 0x085E

    /// EquationRemoveStructure 0x085F Remove the equation structure.
    case equationRemoveStructure = 0x085F

    /// EquationRemoveSubscript 0x0860 Remove the subscript.
    case equationRemoveSubscript = 0x0860

    /// EquationRemoveSuperscript 0x0861 Remove the superscript.
    case equationRemoveSuperscript = 0x0861

    /// EquationStackedFraction 0x0862 Stacked fraction.
    case equationStackedFraction = 0x0862

    /// EquationNoBarFraction 0x0863 No-Bar fraction.
    case equationNoBarFraction = 0x0863

    /// EquationSkewedFraction 0x0864 Skewed fraction.
    case equationSkewedFraction = 0x0864

    /// EquationLinearFraction 0x0865 Linear fraction.
    case equationLinearFraction = 0x0865

    /// EquationStretchDelimiters 0x0866 Stretch delimiter characters.
    case equationStretchDelimiters = 0x0866

    /// EquationShowHidePlaceholders 0x0867 Show or hide placeholders in a matrix.
    case equationShowHidePlaceholders = 0x0867

    /// EquationScriptAlignment 0x0868 Change scripts alignment.
    case equationScriptAlignment = 0x0868

    /// OutlookInsertFile 0x0869 Launches the Insert file attachment dialog for e-mail.
    case outlookInsertFile = 0x0869

    /// EquationMatchDelimiters 0x086A Match delimiters to argument height.
    case equationMatchDelimiters = 0x086A

    /// EquationNaryLimitLocation 0x086B Change N-ary limits location.
    case equationNaryLimitLocation = 0x086B

    /// EquationLimitLocation 0x086C Change limit location.
    case equationLimitLocation = 0x086C

    /// EquationBarLocation 0x086E Change bar location.
    case equationBarLocation = 0x086E

    /// EquationStretchNaryOperator 0x086F Stretch N-ary characters.
    case equationStretchNaryOperator = 0x086F

    /// EquationGroupingCharacterLocation 0x0870 Change grouping character location.
    case equationGroupingCharacterLocation = 0x0870

    /// EquationArrayExpansion 0x0871 Expand equation array to the column width.
    case equationArrayExpansion = 0x0871

    /// EquationExpansion 0x0872 Expand equation to equation array width.
    case equationExpansion = 0x0872

    /// EquationIncreaseArgumentSize 0x0873 Increase argument size.
    case equationIncreaseArgumentSize = 0x0873

    /// EquationDecreaseArgumentSize 0x0874 Decrease argument size.
    case equationDecreaseArgumentSize = 0x0874

    /// EquationRecognizedFunctions 0x0875 Add or delete equation recognized functions.
    case equationRecognizedFunctions = 0x0875

    /// SearchOfficeOnline 0x0876 Opens the Search Office Online page.
    case searchOfficeOnline = 0x0876

    /// BrowseForThemes 0x0877 Opens a dialog to browse for themes.
    case browseForThemes = 0x0877

    /// ListLevelGallery 0x0878 Opens the List Level Gallery.
    case listLevelGallery = 0x0878

    /// OutlineNumberingGallery 0x0879 Opens the Multilevel List Gallery.
    case outlineNumberingGallery = 0x0879

    /// DefineNewList 0x087A Defines a new list.
    case defineNewList = 0x087A

    /// DefineNewListStyle 0x087B Defines a new list style.
    case defineNewListStyle = 0x087B

    /// AddToContacts 0x087C Adds selected business card to Contacts.
    case addToContacts = 0x087C

    /// PropertiesGallery 0x087D Properties Gallery.
    case propertiesGallery = 0x087D

    /// ToggleDocumentActionBar 0x087E Shows or hides the Message Bar.
    case toggleDocumentActionBar = 0x087E

    /// StyleApplyPane 0x087F Applies, creates, or modifies styles and formatting.
    case styleApplyPane = 0x087F

    /// EquationManualBreak 0x0881 Insert or remove a manual break in equations.
    case equationManualBreak = 0x0881

    /// EquationAlignThisCharacter 0x0882 Insert or remove an alignment point in equations.
    case equationAlignThisCharacter = 0x0882

    /// EquationAlignAtEquals 0x0883 Insert or remove an alignment point in equations.
    case equationAlignAtEquals = 0x0883

    /// EmailStationeryOptions 0x0884 Creates or changes Stationery entries.
    case emailStationeryOptions = 0x0884

    /// SetListLevelVBA 0x0885 Sets the list level.
    case setListLevelVBA = 0x0885

    /// ApplyQuickFormat 0x0887 Applies the selected style from the Quick Style set.
    case applyQuickFormat = 0x0887

    /// ApplyQuickStyleSet 0x0888 Applies the selected Quick Style set.
    case applyQuickStyleSet = 0x0888

    /// OutlookViewZoom 0x0889 Scales the editing view.
    case outlookViewZoom = 0x0889

    /// DeleteBuildingBlock 0x088A Deletes the surrounding building block.
    case deleteBuildingBlock = 0x088A

    /// EquationNormalText 0x088B Make the selection Normal Text (toggle).
    case equationNormalText = 0x088B

    /// EquationFunctionGallery 0x088C Equation function gallery.
    case equationFunctionGallery = 0x088C

    /// EquationAccentGallery 0x088D Equation accent gallery.
    case equationAccentGallery = 0x088D

    /// EquationLimitGallery 0x088E Equation limit gallery.
    case equationLimitGallery = 0x088E

    /// EquationOperatorGallery 0x088F Equation operator gallery.
    case equationOperatorGallery = 0x088F

    /// EquationMatrixGallery 0x0890 Equation matrix gallery.
    case equationMatrixGallery = 0x0890

    /// MenuReadingTools 0x0891 Reading tools for full screen reading.
    case menuReadingTools = 0x0891

    /// GoToNextReadingPage 0x0892 Moves to the next page in full screen reading.
    case goToNextReadingPage = 0x0892

    /// GoToPrevReadingPage 0x0893 Moves to the previous page in full screen reading.
    case goToPrevReadingPage = 0x0893

    /// ReadingMode1Page 0x0894 Show 1 Page view.
    case readingMode1Page = 0x0894

    /// ReadingMode2Pages 0x0895 Show 2 Pages view.
    case readingMode2Pages = 0x0895

    /// MenuReadingViewOptions 0x0896 View options for full screen reading.
    case menuReadingViewOptions = 0x0896

    /// ScrnNav 0x0897 Display Screen Navigator Menu.
    case scrnNav = 0x0897

    /// ReadingModePageMargins 0x0898 Show the actual page unaltered.
    case readingModePageMargins = 0x0898

    /// ReadingModePageNoMargins 0x0899 Zoom in, making the text larger, and suppress the margins to make sure the page remains visible.
    case readingModePageNoMargins = 0x0899

    /// ReadingModePageAutoMargins 0x089A Hide the margins if the page display is too small to read.
    case readingModePageAutoMargins = 0x089A

    /// ToggleDontOpenAttachInFullScreen 0x089C Prevents opening of attachments in full screen.
    case toggleDontOpenAttachInFullScreen = 0x089C

    /// TrackChangesOptions 0x089F Changes track changes options.
    case trackChangesOptions = 0x089F

    /// ColorPickerShadowE1o 0x08A0 Opens the shadow color picker.
    case colorPickerShadowE1o = 0x08A0

    /// ColorPicker3DE1o 0x08A1 Opens the 3-D color picker.
    case colorPicker3DE1o = 0x08A1

    /// GradientGallery 0x08A2 Gradient Gallery.
    case gradientGallery = 0x08A2

    /// BarCodeGroup 0x08A3 Has no effect.
    case barCodeGroup = 0x08A3

    /// AsianLayoutFlyout 0x08A4 Asian Layout Menu.
    case asianLayoutFlyout = 0x08A4

    /// JustifyFlyout 0x08A5 Displays the Justify menu for East Asian languages.
    case justifyFlyout = 0x08A5

    /// TOAGroup 0x08A6 Has no effect.
    case tOAGroup = 0x08A6

    /// JapaneseGreetingFlyout 0x08A7 Japanese Greeting flyout anchor.
    case japaneseGreetingFlyout = 0x08A7

    /// JustifyParaSpecial 0x08A8 Aligns the paragraph at both the left and the right indent.
    case justifyParaSpecial = 0x08A8

    /// JustifyParaLow 0x08A9 Aligns the paragraph - Arabic setting.
    case justifyParaLow = 0x08A9

    /// JustifyParaMedium 0x08AA Aligns the paragraph - Arabic setting.
    case justifyParaMedium = 0x08AA

    /// JustifyParaHigh 0x08AB Aligns the paragraph - Arabic setting.
    case justifyParaHigh = 0x08AB

    /// JustifyParaThai 0x08AC Aligns the paragraph - Thai setting.
    case justifyParaThai = 0x08AC

    /// IndentLeftSpinner 0x08AD Has no effect.
    case indentLeftSpinner = 0x08AD

    /// IndentRightSpinner 0x08AE Has no effect.
    case indentRightSpinner = 0x08AE

    /// SpacingBeforeSpinner 0x08AF Has no effect.
    case spacingBeforeSpinner = 0x08AF

    /// SpacingAfterSpinner 0x08B0 Has no effect.
    case spacingAfterSpinner = 0x08B0

    /// HeaderPositionSpinner 0x08B1 Has no effect.
    case headerPositionSpinner = 0x08B1

    /// FooterPositionSpinner 0x08B2 Has no effect.
    case footerPositionSpinner = 0x08B2

    /// SpacingLabel 0x08B3 Has no effect.
    case spacingLabel = 0x08B3

    /// IndentLabel 0x08B4 Has no effect.
    case indentLabel = 0x08B4

    /// InsertFormControlsGallery 0x08B5 Opens the list of form controls.
    case insertFormControlsGallery = 0x08B5

    /// ShapeHeightSpinner 0x08B6 Displays the Shape Height spin box.
    case shapeHeightSpinner = 0x08B6

    /// ShapeWidthSpinner 0x08B7 Displays the Shape Width spin box.
    case shapeWidthSpinner = 0x08B7

    /// HighlightColorPicker 0x08B8 Opens the highlight color picker.
    case highlightColorPicker = 0x08B8

    /// BorderColorPicker 0x08B9 Opens the border color picker.
    case borderColorPicker = 0x08B9

    /// BackgroundColorPicker 0x08BA Opens the background color picker.
    case backgroundColorPicker = 0x08BA

    /// GoToHeader 0x08BB Move between the header and footer.
    case goToHeader = 0x08BB

    /// GoToFooter 0x08BC Move between the header and footer.
    case goToFooter = 0x08BC

    /// FormatBackgroundColor 0x08BD Sets the document background color.
    case formatBackgroundColor = 0x08BD

    /// CancelHighlightMode 0x08BE Applies color highlighting to the selection.
    case cancelHighlightMode = 0x08BE

    /// UnderlineGallery 0x08BF Opens the list of underline styles.
    case underlineGallery = 0x08BF

    /// UnderlineColorPicker 0x08C0 Opens the underline color picker.
    case underlineColorPicker = 0x08C0

    /// TextFlowGallery 0x08C1 Opens the list of text flow options.
    case textFlowGallery = 0x08C1

    /// CellAlignmentGallery 0x08C2 Opens the list of table cell alignment options.
    case cellAlignmentGallery = 0x08C2

    /// PicturePositionGallery 0x08C3 Opens the list of picture position options.
    case picturePositionGallery = 0x08C3

    /// InkingGroup 0x08C4 Has no effect.
    case inkingGroup = 0x08C4

    /// AdvancedBrightnessContrast 0x08C5 Changes the properties of the selected drawing objects.
    case advancedBrightnessContrast = 0x08C5

    /// RecolorGallery 0x08C7 Recolor Gallery.
    case recolorGallery = 0x08C7

    /// ShadowStyleGallery 0x08C8 Opens the list of shadow styles.
    case shadowStyleGallery = 0x08C8

    /// Style3DGallery 0x08C9 Opens the list of 3-D style options.
    case style3DGallery = 0x08C9

    /// Direction3DGallery 0x08CA Opens the list of 3-D direction options.
    case direction3DGallery = 0x08CA

    /// DepthGallery 0x08CB Opens the extrusion depth gallery.
    case depthGallery = 0x08CB

    /// SurfaceMatGallery 0x08CC Opens the 3D surface material gallery.
    case surfaceMatGallery = 0x08CC

    /// Lighting3DGallery 0x08CD Opens the list of 3-D lighting options.
    case lighting3DGallery = 0x08CD

    /// WordArtGallery 0x08CE Opens the list of WordArt options.
    case wordArtGallery = 0x08CE

    /// InsertWordArtGallery 0x08CF Represents a Microsoft WordArt Gallery.
    case insertWordArtGallery = 0x08CF

    /// PageSizeGallery 0x08D0 Opens the list of page size options.
    case pageSizeGallery = 0x08D0

    /// InsertTableGallery 0x08D1 Opens the list of table templates.
    case insertTableGallery = 0x08D1

    /// ShapeStyleGallery 0x08D2 Opens the list of shape styles.
    case shapeStyleGallery = 0x08D2

    /// WordArtShapeGallery 0x08D3 Opens the list of WordArt shapes.
    case wordArtShapeGallery = 0x08D3

    /// XMLGroup 0x08D4 Has no effect.
    case xMLGroup = 0x08D4

    /// ReviewingPaneHorizontal 0x08D6 Shows or hides a summary pane for viewing and editing document revisions (horizontal).
    case reviewingPaneHorizontal = 0x08D6

    /// ReviewingPaneVertical 0x08D7 Shows or hides a summary pane for viewing and editing document revisions (vertical).
    case reviewingPaneVertical = 0x08D7

    /// EquationScriptLocation 0x08D8 Change scripts location.
    case equationScriptLocation = 0x08D8

    /// EquationInsertStructure 0x08D9 Insert equation structure.
    case equationInsertStructure = 0x08D9

    /// BulletsNumberingStyleDialog 0x08DA Bullets and Numbering Style Definition Dialog Box.
    case bulletsNumberingStyleDialog = 0x08DA

    /// SaveCurrentTheme 0x08DB Saves the current theme.
    case saveCurrentTheme = 0x08DB

    /// AutoTextGallery 0x08DE AutoText Gallery.
    case autoTextGallery = 0x08DE

    /// TextBoxGallery 0x08DF Text Box Gallery.
    case textBoxGallery = 0x08DF

    /// BibliographyGallery 0x08E0 Bibliography Gallery.
    case bibliographyGallery = 0x08E0

    /// CreateAutoTextBlockFromSel 0x08E1 Creates a new AutoText Building Block from the current selection.
    case createAutoTextBlockFromSel = 0x08E1

    /// CreateTextBoxBlockFromSel 0x08E2 Creates a new Text Box Building Block from the current selection.
    case createTextBoxBlockFromSel = 0x08E2

    /// CreateLayoutBlockFromSel 0x08E3 Creates a new Layout Building Block from the current selection.
    case createLayoutBlockFromSel = 0x08E3

    /// SaveCoverPageBlock 0x08E4 Saves the current cover page as a new building block.
    case saveCoverPageBlock = 0x08E4

    /// SaveHeaderBlock 0x08E5 Saves the current header as a new building block.
    case saveHeaderBlock = 0x08E5

    /// SaveFooterBlock 0x08E6 Saves the current footer as a new building block.
    case saveFooterBlock = 0x08E6

    /// SavePageNumTopBlock 0x08E7 Saves the current page number (top) as a new building block.
    case savePageNumTopBlock = 0x08E7

    /// SavePageNumBottomBlock 0x08E8 Saves the current page number (bottom) as a new building block.
    case savePageNumBottomBlock = 0x08E8

    /// SavePageNumBlock 0x08E9 Saves the current page number as a new building block.
    case savePageNumBlock = 0x08E9

    /// ViewHeaderOnly 0x08EA Displays the header in page layout view.
    case viewHeaderOnly = 0x08EA

    /// EquationLeftJustification 0x08EB Left-align equation.
    case equationLeftJustification = 0x08EB

    /// EquationRightJustification 0x08EC Right-align equation.
    case equationRightJustification = 0x08EC

    /// EquationCenteredJustification 0x08ED Center equation.
    case equationCenteredJustification = 0x08ED

    /// EquationCenteredAsGroupJustification 0x08EE Center equations as a group.
    case equationCenteredAsGroupJustification = 0x08EE

    /// UxGalWordTableStyles 0x08EF Opens the list of table styles.
    case uxGalWordTableStyles = 0x08EF

    /// WordTableStylesHeaderRow 0x08F0 Header Row.
    case wordTableStylesHeaderRow = 0x08F0

    /// WordTableStylesTotalRow 0x08F1 Total Row.
    case wordTableStylesTotalRow = 0x08F1

    /// WordTableStylesFirstColumn 0x08F2 First Column.
    case wordTableStylesFirstColumn = 0x08F2

    /// WordTableStylesLastColumn 0x08F3 Last Column.
    case wordTableStylesLastColumn = 0x08F3

    /// WordTableStylesBandedRows 0x08F4 Banded Rows.
    case wordTableStylesBandedRows = 0x08F4

    /// WordTableStylesBandedColumns 0x08F5 Banded Columns.
    case wordTableStylesBandedColumns = 0x08F5

    /// ClearTableStyle 0x08F6 Clears table style formatting.
    case clearTableStyle = 0x08F6

    /// ApplyTableStyle 0x08F7 Applies the selected table style.
    case applyTableStyle = 0x08F7

    /// ModifyTableStyle 0x08F8 Modifies the table style.
    case modifyTableStyle = 0x08F8

    /// CheckCompatibility 0x08F9 Check document compatibility.
    case checkCompatibility = 0x08F9

    /// CompareTranslationBaseDocuments 0x08FA View changes in the source document.
    case compareTranslationBaseDocuments = 0x08FA

    /// FontSchemePicker 0x08FB Opens the font scheme picker.
    case fontSchemePicker = 0x08FB

    /// ColorSchemePicker 0x08FC Opens the color scheme picker.
    case colorSchemePicker = 0x08FC

    /// StyleMatrixPicker 0x08FD Opens the style matrix picker.
    case styleMatrixPicker = 0x08FD

    /// ThemeGallery 0x08FE Opens the list of available themes.
    case themeGallery = 0x08FE

    /// EquationMatrixSpacing 0x08FF Set the spacing of a matrix.
    case equationMatrixSpacing = 0x08FF

    /// EquationEquationArraySpacing 0x0900 Set the spacing of an equation array.
    case equationEquationArraySpacing = 0x0900

    /// DrawingAdvancedLayout 0x0901 Changes the advanced layout properties of the selected drawing objects.
    case drawingAdvancedLayout = 0x0901

    /// ReadingModeToPrintView 0x0902 Switch from full screen reading mode to print view.
    case readingModeToPrintView = 0x0902

    /// LineSpacingMenu 0x0904 Applies line spacing to the selection.
    case lineSpacingMenu = 0x0904

    /// FileSendPdf 0x0905 Sends the active document through e-mail as PDF attachment.
    case fileSendPdf = 0x0905

    /// FileSendXps 0x0906 Sends the active document through e-mail as XPS attachment.
    case fileSendXps = 0x0906

    /// CreateNewColorScheme 0x0909 Opens the create new color scheme dialog.
    case createNewColorScheme = 0x0909

    /// FileSaveWordDotx 0x090A Save file as a [ECMA-376] template.
    case fileSaveWordDotx = 0x090A

    /// FileSaveWordDocx 0x090B Save file as a [ECMA-376] document.
    case fileSaveWordDocx = 0x090B

    /// FileSaveWord11 0x090C Save file in Word Binary File format.
    case fileSaveWord11 = 0x090C

    /// InsertPicture3 0x090D Inserts a picture.
    case insertPicture3 = 0x090D

    /// SaveEquation 0x090E Saves the current Equation as a new building block.
    case saveEquation = 0x090E

    /// ViewFooterOnly 0x090F Displays footer in page layout view.
    case viewFooterOnly = 0x090F

    /// EngWritingAssistant 0x0910 English Assistant.
    case engWritingAssistant = 0x0910

    /// TableOfContentsGallery 0x0911 Table Of Contents Gallery.
    case tableOfContentsGallery = 0x0911

    /// FileSaveAsOtherFormats 0x0912 Saves a copy of the document in a separate file.
    case fileSaveAsOtherFormats = 0x0912

    /// CreateTableOfContentsFromSel 0x0915 Creates a new table of contents building block from the current selection.
    case createTableOfContentsFromSel = 0x0915

    /// SaveTableOfContentsBlock 0x0919 Saves the current table of contents as a new building block.
    case saveTableOfContentsBlock = 0x0919

    /// TextboxPositionGallery 0x091D Opens the list of textbox position options.
    case textboxPositionGallery = 0x091D

    /// TextboxStyleGallery 0x091E Opens the list of textbox styles.
    case textboxStyleGallery = 0x091E

    /// TableColumnWidthSpinner 0x091F Changes the width of the columns in a table.
    case tableColumnWidthSpinner = 0x091F

    /// TableRowHeightSpinner 0x0920 Changes the height of the row in a table.
    case tableRowHeightSpinner = 0x0920

    /// RibbonFilePermissionMenu 0x0921 File Permission Menu.
    case ribbonFilePermissionMenu = 0x0921

    /// MailMergeInsertMergeKeyword 0x0922 Mail Merge Insert Merge Keywords.
    case mailMergeInsertMergeKeyword = 0x0922

    /// InsertTableOfContentsMenu 0x0923 Collects the headings or the table of contents entries into a table of contents.
    case insertTableOfContentsMenu = 0x0923

    /// WordSetDefaultPaste 0x0924 Allows setting the default paste action.
    case wordSetDefaultPaste = 0x0924

    /// ReadingTrackChanges 0x0926 Menu for tracking changes.
    case readingTrackChanges = 0x0926

    /// ReadingFlyoutAnchorShowAcetateMarkup 0x0927 Show comments and changes.
    case readingFlyoutAnchorShowAcetateMarkup = 0x0927

    /// ReadingInkTools 0x0928 Menu for Ink tools.
    case readingInkTools = 0x0928

    /// ViewEmailSource 0x0929 View the HTML source of this e-mail message.
    case viewEmailSource = 0x0929

    /// ParagraphRemoveStyle 0x092A Clears paragraph style from selection (restores the normal style).
    case paragraphRemoveStyle = 0x092A

    /// RestoreParagraphStyle 0x092B Restores paragraph style and removes direct formatting.
    case restoreParagraphStyle = 0x092B

    /// MSWordBibAddNewPlaceholder 0x092C Add new placeholder.
    case mSWordBibAddNewPlaceholder = 0x092C

    /// DocExport 0x092D Publish current document as XPS or PDF.
    case docExport = 0x092D

    /// RemoveWatermark 0x092E Removes the Watermarks from the current section.
    case removeWatermark = 0x092E

    /// RemoveCoverPage 0x092F Removes the Cover Page from the document.
    case removeCoverPage = 0x092F

    /// RemoveHeader 0x0930 Removes the header in the current section.
    case removeHeader = 0x0930

    /// RemoveFooter 0x0931 Removes the footer in the current section.
    case removeFooter = 0x0931

    /// RemovePageNumbers 0x0932 Removes Page Number building block from the document.
    case removePageNumbers = 0x0932

    /// RemoveCurrentBuildingBlock 0x0933 Removes the current building block from the document.
    case removeCurrentBuildingBlock = 0x0933

    /// RemoveTableOfContents 0x0934 Removes Table of Contents building block from the document.
    case removeTableOfContents = 0x0934

    /// ApplyQFSetInitial 0x0935 Applies the initial Quick Style set.
    case applyQFSetInitial = 0x0935

    /// ApplyQFSetTemplate 0x0936 Applies the document template Quick Style set.
    case applyQFSetTemplate = 0x0936

    /// CreateNewFontScheme 0x0937 Opens the Create New Font Scheme dialog.
    case createNewFontScheme = 0x0937

    /// RemoveCitation 0x0938 Remove bibliography citation.
    case removeCitation = 0x0938

    /// EditCitation 0x0939 Edit bibliography citation.
    case editCitation = 0x0939

    /// EditSource 0x093A Opens the Edit Source dialog box.
    case editSource = 0x093A

    /// BibliographyCitationToText 0x093B Converts bibliography citation to static text.
    case bibliographyCitationToText = 0x093B

    /// BibliographyEditSource 0x093C Opens the Edit Source dialog box.
    case bibliographyEditSource = 0x093C

    /// SaveOssThemeToTemplate 0x093D Save OSS Theme to Template.
    case saveOssThemeToTemplate = 0x093D

    /// LoadOssThemeFromTemplate 0x093E Load OSS Theme to Template.
    case loadOssThemeFromTemplate = 0x093E

    /// OutlookInsertFile2 0x093F Inserts the text of another file into the active document.
    case outlookInsertFile2 = 0x093F

    /// UpgradeDocument 0x0940 Upgrade Document to current file format.
    case upgradeDocument = 0x0940

    /// UpdateFieldsToa 0x0947 Updates and displays the results of the selected fields.
    case updateFieldsToa = 0x0947

    /// UpdateFieldsTof 0x0948 Updates and displays the results of the selected fields.
    case updateFieldsTof = 0x0948

    /// NavigateMove 0x0949 Navigate to the opposite Move location.
    case navigateMove = 0x0949

    /// ContentControlGroup 0x094A Group the selection into a rich text content control with locked contents.
    case contentControlGroup = 0x094A

    /// FormatPageBordersAndShading 0x094B Changes the borders and shading of the selected paragraphs, table cells, and pictures.
    case formatPageBordersAndShading = 0x094B

    /// DrawVerticalTextBox2 0x094C Inserts an empty vertical text box or encloses the selected item in a vertical textbox.
    case drawVerticalTextBox2 = 0x094C

    /// ViewPageFromOutline 0x094D Displays the page as it will be printed and allows editing.
    case viewPageFromOutline = 0x094D

    /// StylePaneNewStyle 0x094E Creates a new style out of the currently selected text.
    case stylePaneNewStyle = 0x094E

    /// ContentControlRichText 0x094F Insert a rich text content control.
    case contentControlRichText = 0x094F

    /// ContentControlText 0x0950 Insert a plain text content control.
    case contentControlText = 0x0950

    /// ContentControlPicture 0x0951 Insert a picture content control.
    case contentControlPicture = 0x0951

    /// ContentControlComboBox 0x0952 Insert a combo box content control.
    case contentControlComboBox = 0x0952

    /// ContentControlDropdownList 0x0953 Insert a dropdown content control.
    case contentControlDropdownList = 0x0953

    /// ContentControlBuildingBlockGallery 0x0954 Insert a building block content control.
    case contentControlBuildingBlockGallery = 0x0954

    /// ContentControlDate 0x0955 Insert a date picker content control.
    case contentControlDate = 0x0955

    /// ToggleRibbon 0x0956 Shows or hides the Ribbon.
    case toggleRibbon = 0x0956

    /// InkColorPicker 0x0957 Ink Color Picker.
    case inkColorPicker = 0x0957

    /// EATextBoxMenu 0x0958 Insert Textbox menu.
    case eATextBoxMenu = 0x0958

    /// DrawTextBox2 0x0959 Inserts an empty textbox or encloses the selected item in a textbox.
    case drawTextBox2 = 0x0959

    /// BBPropertiesDlg 0x095A Building block properties dialog.
    case bBPropertiesDlg = 0x095A

    /// EquationsOptions 0x095B Equation Options.
    case equationsOptions = 0x095B

    /// ReapplyTableStyle 0x095C Reapplies the selected table style (keeping direct formatting intact).
    case reapplyTableStyle = 0x095C

    /// CustomHeaderGallery 0x095D Custom Header Gallery.
    case customHeaderGallery = 0x095D

    /// CustomFooterGallery 0x095E Custom Footer Gallery.
    case customFooterGallery = 0x095E

    /// CustomCoverPageGallery 0x095F Custom Cover Page Gallery.
    case customCoverPageGallery = 0x095F

    /// CustomPageNumGallery 0x0960 Custom Page Number Gallery.
    case customPageNumGallery = 0x0960

    /// CustomPageNumTopGallery 0x0961 Custom Page Number Top Gallery.
    case customPageNumTopGallery = 0x0961

    /// CustomPageNumBottomGallery 0x0962 Custom Page Number Bottom Gallery.
    case customPageNumBottomGallery = 0x0962

    /// CustomPageNumPageGallery 0x0963 Custom Page Number Page Gallery.
    case customPageNumPageGallery = 0x0963

    /// CustomWatermarkGallery 0x0964 Custom Watermark Gallery.
    case customWatermarkGallery = 0x0964

    /// CustomEquationsGallery 0x0965 Custom Equations Gallery.
    case customEquationsGallery = 0x0965

    /// CustomTablesGallery 0x0966 Custom Tables Gallery.
    case customTablesGallery = 0x0966

    /// CustomQuickPartsGallery 0x0967 Custom Quick Parts Gallery.
    case customQuickPartsGallery = 0x0967

    /// CustomAutoTextGallery 0x0968 Custom AutoText Gallery.
    case customAutoTextGallery = 0x0968

    /// CustomTextBoxGallery 0x0969 Custom Text Box Gallery.
    case customTextBoxGallery = 0x0969

    /// CustomTableOfContentsGallery 0x096A Custom Table of Contents Gallery.
    case customTableOfContentsGallery = 0x096A

    /// CustomBibliographyGallery 0x096B Custom Bibliography Gallery.
    case customBibliographyGallery = 0x096B

    /// Custom1Gallery 0x096C Custom 1 Gallery.
    case custom1Gallery = 0x096C

    /// Custom2Gallery 0x096D Custom 2 Gallery.
    case custom2Gallery = 0x096D

    /// Custom3Gallery 0x096E Custom 3 Gallery.
    case custom3Gallery = 0x096E

    /// Custom4Gallery 0x096F Custom 4 Gallery.
    case custom4Gallery = 0x096F

    /// Custom5Gallery 0x0970 Custom 5 Gallery.
    case custom5Gallery = 0x0970

    /// CreateBibliographyFromSel 0x0971 Creates a new bibliography building block from the current selection.
    case createBibliographyFromSel = 0x0971

    /// SaveBibliographyBlock 0x0972 Saves the current bibliography as a new building block.
    case saveBibliographyBlock = 0x0972

    /// MailMergeUseOutlookContacts 0x0974 Opens Outlook contacts as a data source for mail merge.
    case mailMergeUseOutlookContacts = 0x0974

    /// ChineseTranslationGroup 0x0976 Has no effect.
    case chineseTranslationGroup = 0x0976

    /// TableInsertCells2 0x0977 Inserts one or more cells into the table.
    case tableInsertCells2 = 0x0977

    /// ContentControlUngroup 0x0978 Remove a content control group.
    case contentControlUngroup = 0x0978

    /// BibliographyEditCitationButton 0x0979 Edit bibliography Citation.
    case bibliographyEditCitationButton = 0x0979

    /// BibliographyEditSourceButton 0x097A Opens the Edit Source dialog box.
    case bibliographyEditSourceButton = 0x097A

    /// BibliographyEditCitationToolbar 0x097B Edit bibliography Citation.
    case bibliographyEditCitationToolbar = 0x097B

    /// BibliographyEditSourceToolbar 0x097C Opens the Edit Source dialog box.
    case bibliographyEditSourceToolbar = 0x097C

    /// EquationShowHideBorderTop 0x097D Show or hide the top edge.
    case equationShowHideBorderTop = 0x097D

    /// EquationShowHideBorderBottom 0x097E Show or hide the bottom edge.
    case equationShowHideBorderBottom = 0x097E

    /// EquationShowHideBorderLeft 0x097F Show or hide the left edge.
    case equationShowHideBorderLeft = 0x097F

    /// EquationShowHideBorderRight 0x0980 Show or hide the right edge.
    case equationShowHideBorderRight = 0x0980

    /// EquationShowHideBorderHorizontalStrike 0x0981 Add or remove horizontal strike.
    case equationShowHideBorderHorizontalStrike = 0x0981

    /// EquationShowHideBorderVerticalStrike 0x0982 Add or remove vertical strike.
    case equationShowHideBorderVerticalStrike = 0x0982

    /// EquationShowHideBorderTLBRStrike 0x0983 Add or remove strike from top left.
    case equationShowHideBorderTLBRStrike = 0x0983

    /// EquationShowHideBorderBLTRStrike 0x0984 Add or remove strike from bottom left.
    case equationShowHideBorderBLTRStrike = 0x0984

    /// BibliographyBibliographyToText 0x0985 Converts bibliography to static text.
    case bibliographyBibliographyToText = 0x0985

    /// QFSetAsDefault 0x0986 Saves the current Quick Styles to the document template.
    case QFSetAsDefault = 0x0986

    /// CompatChkr 0x0987 Compatibility check.
    case compatChkr = 0x0987

    /// MailMergeInsertFieldsFlyout 0x0988 Mail Merge Insert Fields.
    case mailMergeInsertFieldsFlyout = 0x0988

    /// AcceptChangesOrAdvance 0x0989 Accepts change in current selection.
    case acceptChangesOrAdvance = 0x0989

    /// RejectChangesOrAdvance 0x098A Rejects changes and deletes comments in current selection.
    case rejectChangesOrAdvance = 0x098A

    /// NavBackMenu 0x098B Menu for jumping back to the previous page in full screen reading.
    case navBackMenu = 0x098B

    /// NavForwardMenu 0x098C Menu for jumping forward to the next page in full screen reading.
    case navForwardMenu = 0x098C

    /// ReadModeShowMarkup 0x098D Menu for viewing mode for revisions and comments in reading mode.
    case readModeShowMarkup = 0x098D

    /// ReadModeMarkupFinal 0x098E Menu item for showing final view in reading mode.
    case readModeMarkupFinal = 0x098E

    /// ReadModeMarkupFinalMarkup 0x098F Menu item for showing final+markup view in reading mode.
    case readModeMarkupFinalMarkup = 0x098F

    /// ReadModeMarkupOriginal 0x0990 Menu item for Original view in reading mode.
    case readModeMarkupOriginal = 0x0990

    /// ReadModeMarkupOriginalMarkup 0x0991 Menu item for Original+markup view in reading mode.
    case readModeMarkupOriginalMarkup = 0x0991

    /// OpenOrCloseParaAbove 0x0992 Sets or removes extra spacing above the selected paragraph.
    case openOrCloseParaAbove = 0x0992

    /// OpenOrCloseParaBelow 0x0993 Sets or removes extra spacing below the selected paragraph.
    case openOrCloseParaBelow = 0x0993

    /// OpenParaAbove 0x0994 Adds extra spacing above the selected paragraph.
    case openParaAbove = 0x0994

    /// CloseParaAbove 0x0995 Removes extra spacing above the selected paragraph.
    case closeParaAbove = 0x0995

    /// OpenParaBelow 0x0996 Adds extra spacing below the selected paragraph.
    case openParaBelow = 0x0996

    /// CloseParaBelow 0x0997 Removes extra spacing below the selected  paragraph.
    case closeParaBelow = 0x0997

    /// NextPane 0x0999 Switches to the next window pane or taskpane.
    case nextPane = 0x0999

    /// PrevPane 0x099A Switches to the previous window pane or taskpane.
    case prevPane = 0x099A

    /// CheckDocumentParts 0x099B Goes to Office Online to Check for New Document Building Blocks.
    case checkDocumentParts = 0x099B

    /// BibliographyFilterLanguages 0x099C Filter Languages.
    case bibliographyFilterLanguages = 0x099C

    /// RaiseTextBaseline 0x099F Moves text baseline up.
    case raiseTextBaseline = 0x099F

    /// LowerTextBaseline 0x09A0 Moves text baseline down.
    case lowerTextBaseline = 0x09A0

    /// BibUpdateLang 0x09A1 Update Bibliography Language.
    case bibUpdateLang = 0x09A1

    /// TableStyleNew 0x09A2 Creates a new table style.
    case tableStyleNew = 0x09A2

    /// Zoom100 0x09A3 Scales the current view to 100%.
    case Zoom100 = 0x09A3

    /// UpdateBibliography 0x09A6 Update bibliography.
    case updateBibliography = 0x09A6

    /// RibbonReviewProtectDocumentMenu 0x09A7 Review Protect Document Menu.
    case ribbonReviewProtectDocumentMenu = 0x09A7

    /// RibbonReviewRestrictFormatting 0x09A8 Restrict Formatting and Editing in the Protect Document menu.
    case ribbonReviewRestrictFormatting = 0x09A8

    /// ToggleOptimizeForLayout 0x09A9 Toggles optimize for layout option.
    case toggleOptimizeForLayout = 0x09A9

    /// CharLeft 0x0FA0 Moves the insertion point to the left one character.
    case charLeft = 0x0FA0

    /// CharRight 0x0FA1 Moves the insertion point to the right one character.
    case charRight = 0x0FA1

    /// WordLeft 0x0FA2 Moves the insertion point to the left one word.
    case wordLeft = 0x0FA2

    /// WordRight 0x0FA3 Moves the insertion point to the right one word.
    case wordRight = 0x0FA3

    /// SentLeft 0x0FA4 Moves the insertion point to the beginning of the previous sentence.
    case sentLeft = 0x0FA4

    /// SentRight 0x0FA5 Moves the insertion point to beginning of the next sentence.
    case sentRight = 0x0FA5

    /// ParaUp 0x0FA6 Moves the insertion point to the beginning of the previous paragraph.
    case paraUp = 0x0FA6

    /// ParaDown 0x0FA7 Moves the insertion point to the beginning of the next paragraph.
    case paraDown = 0x0FA7

    /// LineUp 0x0FA8 Moves the insertion point up one line.
    case lineUp = 0x0FA8

    /// LineDown 0x0FA9 Moves the insertion point down one line.
    case lineDown = 0x0FA9

    /// PageUp 0x0FAA Moves the insertion point and document display to the previous screen of text.
    case pageUp = 0x0FAA

    /// PageDown 0x0FAB Moves the insertion point and document display to the next screen of text.
    case pageDown = 0x0FAB

    /// StartOfLine 0x0FAC Moves the insertion point to the beginning of the current line.
    case startOfLine = 0x0FAC

    /// EndOfLine 0x0FAD Moves the insertion point to the end of the current line.
    case endOfLine = 0x0FAD

    /// StartOfWindow 0x0FAE Moves the insertion point to the beginning of the first visible line on the screen.
    case startOfWindow = 0x0FAE

    /// EndOfWindow 0x0FAF Moves the insertion point to the end of the last visible line on the screen.
    case endOfWindow = 0x0FAF

    /// StartOfDocument 0x0FB0 Moves the insertion point to the beginning of the first line of the document.
    case startOfDocument = 0x0FB0

    /// EndOfDocument 0x0FB1 Moves the insertion point to the end of the last line of the document.
    case endOfDocument = 0x0FB1

    /// CharLeftExtend 0x0FB2 Extends the selection to the left one character.
    case charLeftExtend = 0x0FB2

    /// CharRightExtend 0x0FB3 Extends the selection to the right one character.
    case charRightExtend = 0x0FB3

    /// WordLeftExtend 0x0FB4 Extends the selection to the left one word.
    case wordLeftExtend = 0x0FB4

    /// WordRightExtend 0x0FB5 Extends the selection to the right one word.
    case wordRightExtend = 0x0FB5

    /// SentLeftExtend 0x0FB6 Extends the selection to the beginning of the previous sentence.
    case sentLeftExtend = 0x0FB6

    /// SentRightExtend 0x0FB7 Extends the selection to beginning of the next sentence.
    case sentRightExtend = 0x0FB7

    /// ParaUpExtend 0x0FB8 Extends the selection to the beginning of the previous paragraph.
    case paraUpExtend = 0x0FB8

    /// ParaDownExtend 0x0FB9 Extends the selection to the beginning of the next paragraph.
    case paraDownExtend = 0x0FB9

    /// LineUpExtend 0x0FBA Extends the selection up one line.
    case lineUpExtend = 0x0FBA

    /// LineDownExtend 0x0FBB Extends the selection down one line.
    case lineDownExtend = 0x0FBB

    /// PageUpExtend 0x0FBC Extends the selection and changes the document display to the previous screen of text.
    case pageUpExtend = 0x0FBC

    /// PageDownExtend 0x0FBD Extends the selection and changes the document display to the next screen of text.
    case pageDownExtend = 0x0FBD

    /// StartOfLineExtend 0x0FBE Extends the selection to the beginning of the current line.
    case startOfLineExtend = 0x0FBE

    /// EndOfLineExtend 0x0FBF Extends the selection to the end of the current line.
    case endOfLineExtend = 0x0FBF

    /// StartOfWindowExtend 0x0FC0 Extends the selection to the beginning of the first visible line on the screen.
    case startOfWindowExtend = 0x0FC0

    /// EndOfWindowExtend 0x0FC1 Extends the selection to the end of the last visible line on the screen.
    case endOfWindowExtend = 0x0FC1

    /// StartOfDocExtend 0x0FC2 Extends the selection to the beginning of the first line of the document.
    case startOfDocExtend = 0x0FC2

    /// EndOfDocExtend 0x0FC3 Extends the selection to the end of the last line of the document.
    case endOfDocExtend = 0x0FC3

    /// File1 0x0FC5 Opens this document.
    case file1 = 0x0FC5

    /// File2 0x0FC6 Opens this document.
    case file2 = 0x0FC6

    /// File3 0x0FC7 Opens this document.
    case file3 = 0x0FC7

    /// File4 0x0FC8 Opens this document.
    case file4 = 0x0FC8

    /// File5 0x0FC9 Opens this document.
    case file5 = 0x0FC9

    /// File6 0x0FCA Opens this document.
    case file6 = 0x0FCA

    /// File7 0x0FCB Opens this document.
    case file7 = 0x0FCB

    /// File8 0x0FCC Opens this document.
    case file8 = 0x0FCC

    /// File9 0x0FCD Opens this document.
    case file9 = 0x0FCD

    /// MailMergeInsertAsk 0x0FCF Inserts an Ask field at the insertion point.
    case mailMergeInsertAsk = 0x0FCF

    /// MailMergeInsertFillIn 0x0FD0 Inserts a Fill-in field at the insertion point.
    case mailMergeInsertFillIn = 0x0FD0

    /// MailMergeInsertIf 0x0FD1 Inserts an If field at the insertion point.
    case mailMergeInsertIf = 0x0FD1

    /// MailMergeInsertMergeRec 0x0FD2 Inserts a MergeRec field at the insertion point.
    case mailMergeInsertMergeRec = 0x0FD2

    /// MailMergeInsertMergeSeq 0x0FD3 Inserts a MergeSeq field at the insertion point.
    case mailMergeInsertMergeSeq = 0x0FD3

    /// MailMergeInsertNext 0x0FD4 Inserts a Next field at the insertion point.
    case mailMergeInsertNext = 0x0FD4

    /// MailMergeInsertNextIf 0x0FD5 Inserts a NextIf field at the insertion point.
    case mailMergeInsertNextIf = 0x0FD5

    /// MailMergeInsertSet 0x0FD6 Inserts a Set field at the insertion point.
    case mailMergeInsertSet = 0x0FD6

    /// MailMergeInsertSkipIf 0x0FD7 Inserts a SkipIf field at the insertion point.
    case mailMergeInsertSkipIf = 0x0FD7

    /// BorderTop 0x0FDE Changes the top borders of the selected paragraphs, table cells, and pictures.
    case borderTop = 0x0FDE

    /// BorderLeft 0x0FDF Changes the left border of the selected paragraphs, table cells, and pictures.
    case borderLeft = 0x0FDF

    /// BorderBottom 0x0FE0 Changes the bottom border of the selected paragraphs, table cells, and pictures.
    case borderBottom = 0x0FE0

    /// BorderRight 0x0FE1 Changes the right border of the selected paragraphs, table cells, and pictures.
    case borderRight = 0x0FE1

    /// BorderInside 0x0FE2 Changes the inside borders of the selected paragraphs, table cells, and pictures.
    case borderInside = 0x0FE2

    /// ShowMe 0x0FE4 Gives an in-depth explanation of the suggested tip.
    case showMe = 0x0FE4

    /// AutomaticChange 0x0FE6 Performs the suggested AutoFormat action.
    case automaticChange = 0x0FE6

    /// FormatDrawingObjectWrapSquare 0x0FF8 Changes the selected drawing objects to square wrapping.
    case formatDrawingObjectWrapSquare = 0x0FF8

    /// FormatDrawingObjectWrapTight 0x0FF9 Changes the selected drawing objects to tight wrapping.
    case formatDrawingObjectWrapTight = 0x0FF9

    /// FormatDrawingObjectWrapThrough 0x0FFA Changes the selected drawing objects to tight through wrapping.
    case formatDrawingObjectWrapThrough = 0x0FFA

    /// FormatDrawingObjectWrapNone 0x0FFB Changes the selected drawing objects to no  wrapping.
    case formatDrawingObjectWrapNone = 0x0FFB

    /// FormatDrawingObjectWrapTopBottom 0x0FFC Changes the selected drawing objects to top/bottom wrapping.
    case formatDrawingObjectWrapTopBottom = 0x0FFC

    /// MicrosoftOnTheWeb1 0x0FFE Browse to an application-related Web site.
    case microsoftOnTheWeb1 = 0x0FFE

    /// MicrosoftOnTheWeb2 0x0FFF Browse to an application-related Web site.
    case microsoftOnTheWeb2 = 0x0FFF

    /// MicrosoftOnTheWeb3 0x1000 Browse to an application-related Web site.
    case microsoftOnTheWeb3 = 0x1000

    /// MicrosoftOnTheWeb4 0x1001 Browse to an application-related Web site.
    case microsoftOnTheWeb4 = 0x1001

    /// MicrosoftOnTheWeb5 0x1002 Browse to an application-related Web site.
    case microsoftOnTheWeb5 = 0x1002

    /// MicrosoftOnTheWeb6 0x1003 Browse to an application-related Web site.
    case microsoftOnTheWeb6 = 0x1003

    /// MicrosoftOnTheWeb7 0x1004 Browse to an application-related Web site.
    case microsoftOnTheWeb7 = 0x1004

    /// MicrosoftOnTheWeb8 0x1005 Browse to an application-related Web site.
    case microsoftOnTheWeb8 = 0x1005

    /// MicrosoftOnTheWeb9 0x1006 Browse to an application-related Web site.
    case microsoftOnTheWeb9 = 0x1006

    /// MicrosoftOnTheWeb10 0x1007 Browse to an application-related Web site.
    case microsoftOnTheWeb10 = 0x1007

    /// MicrosoftOnTheWeb11 0x1008 Browse to an application-related Web site.
    case microsoftOnTheWeb11 = 0x1008

    /// MicrosoftOnTheWeb12 0x1009 Browse to an application-related Web site.
    case microsoftOnTheWeb12 = 0x1009

    /// MicrosoftOnTheWeb13 0x100A Browse to an application-related Web site.
    case microsoftOnTheWeb13 = 0x100A

    /// MicrosoftOnTheWeb14 0x100B Browse to an application related Web site.
    case microsoftOnTheWeb14 = 0x100B

    /// MicrosoftOnTheWeb15 0x100C Browse to an application related Web site.
    case microsoftOnTheWeb15 = 0x100C

    /// MicrosoftOnTheWeb16 0x100D Browse to an application related Web site.
    case microsoftOnTheWeb16 = 0x100D

    /// MicrosoftOnTheWeb17 0x100E Browse to an application related Web site.
    case microsoftOnTheWeb17 = 0x100E

    /// FormatDrawingObjectWrapFront 0x100F Changes the selected drawing objects to no wrapping in front of text.
    case formatDrawingObjectWrapFront = 0x100F

    /// FormatDrawingObjectWrapBehind 0x1010 Changes the selected drawing objects to no wrapping behind text.
    case formatDrawingObjectWrapBehind = 0x1010

    /// FormatDrawingObjectWrapInline 0x1011 Changes the selected drawing object to inline wrapping.
    case formatDrawingObjectWrapInline = 0x1011

    /// File10 0x10CC Opens this document.
    case file10 = 0x10CC

    /// File11 0x10CD Opens this document.
    case file11 = 0x10CD

    /// File12 0x10CE Opens this document.
    case file12 = 0x10CE

    /// File13 0x10CF Opens this document.
    case file13 = 0x10CF

    /// File14 0x10D0 Opens this document.
    case file14 = 0x10D0

    /// File15 0x10D1 Opens this document.
    case file15 = 0x10D1

    /// File16 0x10D2 Opens this document.
    case file16 = 0x10D2

    /// File17 0x10D3 Opens this document.
    case file17 = 0x10D3

    /// File18 0x10D4 Opens this document.
    case file18 = 0x10D4

    /// File19 0x10D5 Opens this document.
    case file19 = 0x10D5

    /// File20 0x10D6 Opens this document.
    case file20 = 0x10D6

    /// File21 0x10D7 Opens this document.
    case file21 = 0x10D7

    /// File22 0x10D8 Opens this document.
    case file22 = 0x10D8

    /// File23 0x10D9 Opens this document.
    case file23 = 0x10D9

    /// File24 0x10DA Opens this document.
    case file24 = 0x10DA

    /// File25 0x10DB Opens this document.
    case file25 = 0x10DB

    /// File26 0x10DC Opens this document.
    case file26 = 0x10DC

    /// File27 0x10DD Opens this document.
    case file27 = 0x10DD

    /// File28 0x10DE Opens this document.
    case file28 = 0x10DE

    /// File29 0x10DF Opens this document.
    case file29 = 0x10DF

    /// File30 0x10E0 Opens this document.
    case file30 = 0x10E0

    /// File31 0x10E1 Opens this document.
    case file31 = 0x10E1

    /// File32 0x10E2 Opens this document.
    case file32 = 0x10E2

    /// File33 0x10E3 Opens this document.
    case file33 = 0x10E3

    /// File34 0x10E4 Opens this document.
    case file34 = 0x10E4

    /// File35 0x10E5 Opens this document.
    case file35 = 0x10E5

    /// File36 0x10E6 Opens this document.
    case file36 = 0x10E6

    /// File37 0x10E7 Opens this document.
    case file37 = 0x10E7

    /// File38 0x10E8 Opens this document.
    case file38 = 0x10E8

    /// File39 0x10E9 Opens this document.
    case file39 = 0x10E9

    /// File40 0x10EA Opens this document.
    case file40 = 0x10EA

    /// File41 0x10EB Opens this document.
    case file41 = 0x10EB

    /// File42 0x10EC Opens this document.
    case file42 = 0x10EC

    /// File43 0x10ED Opens this document.
    case file43 = 0x10ED

    /// File44 0x10EE Opens this document.
    case file44 = 0x10EE

    /// File45 0x10EF Opens this document.
    case file45 = 0x10EF

    /// File46 0x10F0 Opens this document.
    case file46 = 0x10F0

    /// File47 0x10F1 Opens this document.
    case file47 = 0x10F1

    /// File48 0x10F2 Opens this document.
    case file48 = 0x10F2

    /// File49 0x10F3 Opens this document.
    case file49 = 0x10F3

    /// File50 0x10F4 Opens this document.
    case file50 = 0x10F4

    /// PageSetupMargins 0x10F5 Changes the page setup of the selected sections.
    case pageSetupMargins = 0x10F5

    /// PageSetupPaper 0x10F6 Changes the page setup of the selected sections.
    case pageSetupPaper = 0x10F6

    /// PageSetupLayout 0x10F7 Changes the page setup of the selected sections.
    case pageSetupLayout = 0x10F7

    /// LegacyFileMru 0x10F8 Opens this document.
    case legacyFileMru = 0x10F8

    /// MenuFile 0x1644 File Menu.
    case menuFile = 0x1644

    /// MenuEdit 0x1645 Edit Menu.
    case menuEdit = 0x1645

    /// MenuView 0x1646 View Menu.
    case menuView = 0x1646

    /// MenuInsert 0x1647 Insert Menu.
    case menuInsert = 0x1647

    /// MenuFormat 0x1648 Format Menu.
    case menuFormat = 0x1648

    /// MenuTools 0x1649 Tools Menu.
    case menuTools = 0x1649

    /// MenuTable 0x164A Table Menu.
    case menuTable = 0x164A

    /// MenuWindow 0x164B Window Menu.
    case menuWindow = 0x164B

    /// MenuHelp 0x164C Help Menu.
    case menuHelp = 0x164C

    /// MenuWork 0x164D Work Menu.
    case menuWork = 0x164D

    /// MenuFont 0x164E Font Menu.
    case menuFont = 0x164E

    /// MenuLanguage 0x1650 Language Submenu.
    case menuLanguage = 0x1650

    /// MenuMicrosoftOnTheWeb 0x1651 Microsoft On the Web Menu.
    case menuMicrosoftOnTheWeb = 0x1651

    /// MenuBorder 0x1652 Has no effect.
    case menuBorder = 0x1652

    /// MenuInsertTextBox 0x1653 Insert Textbox Submenu.
    case menuInsertTextBox = 0x1653

    /// MenuInsertFrame 0x1654 Insert Frame Submenu.
    case menuInsertFrame = 0x1654

    /// MenuDraw 0x1655 Has no effect.
    case menuDraw = 0x1655

    /// DrawMenuTextWrapping 0x1656 Has no effect.
    case drawMenuTextWrapping = 0x1656

    /// DrawMenuOrder 0x1657 Has no effect.
    case drawMenuOrder = 0x1657

    /// DrawMenuGrouping 0x1658 Has no effect.
    case drawMenuGrouping = 0x1658

    /// DrawMenuAlignDistribute 0x1659 Has no effect.
    case drawMenuAlignDistribute = 0x1659

    /// DrawMenuRotateFlip 0x165A Has no effect.
    case drawMenuRotateFlip = 0x165A

    /// DrawMenuNudge 0x165B Has no effect.
    case drawMenuNudge = 0x165B

    /// FormatFillColor 0x165C Applies the most recently used fill color to the selected AutoShape.
    case formatFillColor = 0x165C

    /// FormatLineColor 0x165D Applies the most recently used line color to the selected AutoShape.
    case formatLineColor = 0x165D

    /// DrawMenuShadows 0x165E Has no effect.
    case drawMenuShadows = 0x165E

    /// FormatLineStyle 0x165F Has no effect.
    case formatLineStyle = 0x165F

    /// DrawMenuLineDash 0x1660 Has no effect.
    case drawMenuLineDash = 0x1660

    /// DrawMenuArrows 0x1661 Has no effect.
    case drawMenuArrows = 0x1661

    /// DrawMenu3D 0x1662 Has no effect.
    case drawMenu3D = 0x1662

    /// DrawMenuShadowColor 0x1663 Applies the most recently used shadow color to the selected AutoShape.
    case drawMenuShadowColor = 0x1663

    /// DrawMenuImageControl 0x1664 Has no effect.
    case drawMenuImageControl = 0x1664

    /// DrawMenuChangeShape 0x1665 Has no effect.
    case drawMenuChangeShape = 0x1665

    /// DrawMenuChangeShape0 0x1666 Has no effect.
    case drawMenuChangeShape0 = 0x1666

    /// DrawMenuChangeShape1 0x1667 Has no effect.
    case drawMenuChangeShape1 = 0x1667

    /// DrawMenuChangeShape2 0x1668 Has no effect.
    case drawMenuChangeShape2 = 0x1668

    /// DrawMenuChangeShape3 0x1669 Has no effect.
    case drawMenuChangeShape3 = 0x1669

    /// DrawMenuChangeShape4 0x166A Has no effect.
    case drawMenuChangeShape4 = 0x166A

    /// DrawMenuAutoShapes 0x166B Has no effect.
    case drawMenuAutoShapes = 0x166B

    /// DrawMenuMoreShapes1 0x166C Has no effect.
    case drawMenuMoreShapes1 = 0x166C

    /// DrawMenuMoreShapes2 0x166D Has no effect.
    case drawMenuMoreShapes2 = 0x166D

    /// DrawMenuMoreShapes3 0x166E Has no effect.
    case drawMenuMoreShapes3 = 0x166E

    /// DrawMenuMoreShapes4 0x166F Has no effect.
    case drawMenuMoreShapes4 = 0x166F

    /// DrawMenuMoreShapes5 0x1670 Has no effect.
    case drawMenuMoreShapes5 = 0x1670

    /// DrawMenuMoreShapes6 0x1671 Has no effect.
    case drawMenuMoreShapes6 = 0x1671

    /// DrawMenuTextShape 0x1672 Has no effect.
    case drawMenuTextShape = 0x1672

    /// DrawMenuTextAlignment 0x1673 Has no effect.
    case drawMenuTextAlignment = 0x1673

    /// DrawMenuTextTracking 0x1674 Has no effect.
    case drawMenuTextTracking = 0x1674

    /// DrawMenu3DDepth 0x1675 Has no effect.
    case drawMenu3DDepth = 0x1675

    /// DrawMenu3DDirection 0x1676 Has no effect.
    case drawMenu3DDirection = 0x1676

    /// DrawMenu3DColor 0x1677 Applies the most recently used 3-D color to the selected AutoShape.
    case drawMenu3DColor = 0x1677

    /// DrawMenu3DLighting 0x1678 Has no effect.
    case drawMenu3DLighting = 0x1678

    /// DrawMenu3DSurface 0x1679 Has no effect.
    case drawMenu3DSurface = 0x1679

    /// MenuOrgChartSelect 0x167A Has no effect.
    case menuOrgChartSelect = 0x167A

    /// MenuTableInsert 0x167B Macro Submenu.
    case menuTableInsert = 0x167B

    /// MenuTableDelete 0x167C Macro Submenu.
    case menuTableDelete = 0x167C

    /// AutoSignatureList 0x167D Email AutoSignatures menu.
    case autoSignatureList = 0x167D

    /// MenuFrameset 0x167E Format Frameset Submenu.
    case menuFrameset = 0x167E

    /// FilePreview 0x167F File Preview Menu.
    case filePreview = 0x167F

    /// MenuFixSpellingLang 0x1680 Represents a menu. Has no effect.
    case menuFixSpellingLang = 0x1680

    /// MenuRevisions 0x1681 Revisions Submenu.
    case menuRevisions = 0x1681

    /// MenuFormatBackground 0x1682 Format Background Submenu.
    case menuFormatBackground = 0x1682

    /// MenuFixSpellingAC 0x1683 Represents a menu. Has no effect.
    case menuFixSpellingAC = 0x1683

    /// MenuPicture 0x1684 Insert Picture Submenu.
    case menuPicture = 0x1684

    /// MenuAutoText 0x1685 Insert AutoText Submenu.
    case menuAutoText = 0x1685

    /// MenuMacro 0x1686 Macro Submenu.
    case menuMacro = 0x1686

    /// MenuPowerTalk 0x1687 PowerTalk Submenu.
    case menuPowerTalk = 0x1687

    /// MenuHyperlinkSub 0x1688 Hyperlink.
    case menuHyperlinkSub = 0x1688

    /// MenuCellVerticalAlign 0x1689 Cell Vertical Alignment Submenu.
    case menuCellVerticalAlign = 0x1689

    /// MenuEditObject 0x168A Represents a menu. Has no effect.
    case menuEditObject = 0x168A

    /// MenuSendTo 0x168B Represents a menu. Has no effect.
    case menuSendTo = 0x168B

    /// MenuAutoTextList 0x168D Has no effect.
    case menuAutoTextList = 0x168D

    /// MenuTableSelect 0x1696 Macro Submenu.
    case menuTableSelect = 0x1696

    /// MenuTableConvert 0x1697 Macro Submenu.
    case menuTableConvert = 0x1697

    /// MenuTableInsertPalette 0x1698 Has no effect.
    case menuTableInsertPalette = 0x1698

    /// FixHHCMenu 0x1699 Represents a menu. Has no effect.
    case fixHHCMenu = 0x1699

    /// MenuTableAutoFitShort 0x169A Macro Submenu.
    case menuTableAutoFitShort = 0x169A

    /// MenuTableAutoFitLong 0x169B Macro Submenu.
    case menuTableAutoFitLong = 0x169B

    /// MenuCellAlignment 0x169C Has no effect.
    case menuCellAlignment = 0x169C

    /// MenuTableInsertLong 0x169D Macro Submenu.
    case menuTableInsertLong = 0x169D

    /// MenuCollaboration 0x169E Collaboration Submenu.
    case menuCollaboration = 0x169E

    /// MenuAsianLayout 0x169F Asian Layout Submenu.
    case menuAsianLayout = 0x169F

    /// FixSynonymMenu 0x16A0 Represents a menu. Has no effect.
    case fixSynonymMenu = 0x16A0

    /// MenuOrgChartLayout 0x16AB Has no effect.
    case menuOrgChartLayout = 0x16AB

    /// DrawMenuMoreShapes7 0x16AC Has no effect.
    case drawMenuMoreShapes7 = 0x16AC

    /// MenuReference 0x16AE Insert Reference Submenu.
    case menuReference = 0x16AE

    /// MenuLettersMail 0x16AF Tools Letters and Mailings Submenu.
    case menuLettersMail = 0x16AF

    /// MenuClear 0x16B0 Clear Submenu.
    case menuClear = 0x16B0

    /// MenuDiagramLayout 0x16B1 Diagram Layout.
    case menuDiagramLayout = 0x16B1

    /// MenuShowChanges 0x16B3 Fine tune which balloons are shown.
    case menuShowChanges = 0x16B3

    /// MenuShowReviewers 0x16B4 Fine tune which balloons are shown.
    case menuShowReviewers = 0x16B4

    /// ResolveMenu 0x16B5 Accept/Reject Changes and Delete Comments.
    case resolveMenu = 0x16B5

    /// MenuOrgChartInsert 0x16B6 Inserts an additional box to the organization chart.
    case menuOrgChartInsert = 0x16B6

    /// MenuDiagramConvertTo 0x16B7 Convert To.
    case menuDiagramConvertTo = 0x16B7

    /// ApplyXMLStructureMenu 0x16B8 Represents a menu. Has no effect.
    case applyXMLStructureMenu = 0x16B8

    /// FormatInkColor 0x16B9 Brings up the format ink color dialog.
    case formatInkColor = 0x16B9

    /// MenuVersion 0x16BA Manages the versions of a document.
    case menuVersion = 0x16BA

    /// FormatInkAnnotColor 0x16BB Brings up the format ink annotation color dialog.
    case formatInkAnnotColor = 0x16BB

    /// MenuShowBalloons 0x16BC Fine tune which balloons are shown.
    case menuShowBalloons = 0x16BC

    /// InsertInkSplitMenu 0x16BD Adds the Ink Tools tab to the Ribbon.
    case insertInkSplitMenu = 0x16BD

    /// ReadingModeViewAllMenu 0x16C0 Produces a submenu of Heading1 or 2.
    case readingModeViewAllMenu = 0x16C0

    /// EquationVerticalMenu 0x16C2 Equation vertical alignment menu.
    case equationVerticalMenu = 0x16C2

    /// EquationHorizontalMenu 0x16C3 Equation horizontal alignment menu.
    case equationHorizontalMenu = 0x16C3

    /// RefTipLangMenu 0x16C4 Translation.
    case refTipLangMenu = 0x16C4

    /// MenuTableInsertIntoTable 0x16C5 Menu for inserting rows, columns, or cells into a table.
    case menuTableInsertIntoTable = 0x16C5

    /// MenuCellAlignmentNoTearoff 0x16C6 Menu for table cell alignment in dialog boxes.
    case menuCellAlignmentNoTearoff = 0x16C6

    /// EquationJustificationMenu 0x16C7 Equation justification.
    case equationJustificationMenu = 0x16C7

    /// EquationInsertMenu 0x16C8 Matrix insert menu.
    case equationInsertMenu = 0x16C8

    /// EquationDeleteMenu 0x16C9 Matrix delete menu.
    case equationDeleteMenu = 0x16C9

    /// EquationBorderPropertiesMenu 0x16CA Equation border properties menu.
    case equationBorderPropertiesMenu = 0x16CA

    /// MenuWordQFStyles 0x16CB Quick formatting menu.
    case menuWordQFStyles = 0x16CB

    /// WW2_FileTemplates 0x17A6 Changes the active template and the template options.
    case ww2_FileTemplates = 0x17A6

    /// TrustCenter 0x17C7 Changes various security and privacy options.
    case trustCenter = 0x17C7

    /// OfficeCenter 0x17D0 Changes various categories of the application options.
    case officeCenter = 0x17D0

    /// InsertOCXCheckbox 0x1BA5 Inserts a Checkbox Control.
    case insertOCXCheckbox = 0x1BA5

    /// InsertOCXSpin 0x1BA6 Inserts a Spin Control.
    case insertOCXSpin = 0x1BA6

    /// InsertOCXScrollbar 0x1BA7 Inserts a Scrollbar Control.
    case insertOCXScrollbar = 0x1BA7

    /// InsertOCXLabel 0x1BA8 Inserts a Label Control.
    case insertOCXLabel = 0x1BA8

    /// InsertOCXTextBox 0x1BA9 Inserts a Text Box Control.
    case insertOCXTextBox = 0x1BA9

    /// InsertOCXButton 0x1BAA Inserts a Button Control.
    case insertOCXButton = 0x1BAA

    /// InsertOCXOptionButton 0x1BAB Inserts a RadioButton Control.
    case insertOCXOptionButton = 0x1BAB

    /// InsertOCXListBox 0x1BAC Inserts a Listbox Control.
    case insertOCXListBox = 0x1BAC

    /// InsertOCXDropdownCombo 0x1BAD Inserts a Combobox Control.
    case insertOCXDropdownCombo = 0x1BAD

    /// InsertOCXToggleButton 0x1BAE Inserts a Toggle Button Control.
    case insertOCXToggleButton = 0x1BAE

    /// ViewControlToolbox 0x1BAF Shows or hides the Control Toolbox.
    case viewControlToolbox = 0x1BAF

    /// ShowPropertyBrowser 0x1BB0 Shows the Property Browser.
    case showPropertyBrowser = 0x1BB0

    /// InsertOCXFrame 0x1BB1 Inserts a Frame Control.
    case insertOCXFrame = 0x1BB1

    /// InsertOCXImage 0x1BB2 Inserts an Image Control.
    case insertOCXImage = 0x1BB2

    /// ToolbarLabel 0x1BB4 Represents a toolbar label control. Has no effect.
    case toolbarLabel = 0x1BB4

    /// ViewWebToolbox 0x1BC4 Shows or hides the Web Toolbox.
    case viewWebToolbox = 0x1BC4

    /// ChangeMailFormat 0x1BC9 Changes the current message format.
    case changeMailFormat = 0x1BC9

    /// DeleteSchema 0x1BD1 Deletes an XML Schema from the document.
    case deleteSchema = 0x1BD1

    /// AlignLeft 0x1BDD Aligns the selected drawing objects to the left.
    case alignLeft = 0x1BDD

    /// AlignCenterHorizontal 0x1BDE Aligns the selected drawing objects horizontally to the center.
    case alignCenterHorizontal = 0x1BDE

    /// AlignRight 0x1BDF Aligns the selected drawing objects to the right.
    case alignRight = 0x1BDF

    /// AlignTop 0x1BE0 Aligns the selected drawing objects to the top.
    case alignTop = 0x1BE0

    /// AlignCenterVertical 0x1BE1 Aligns the selected drawing objects vertically to the center.
    case alignCenterVertical = 0x1BE1

    /// AlignBottom 0x1BE2 Aligns the selected drawing objects to the bottom.
    case alignBottom = 0x1BE2

    /// PPPropertyEditorDlg 0x1BE3 Show property editor = dialog.
    case pPPropertyEditorDlg = 0x1BE3
}
