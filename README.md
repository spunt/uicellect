# UICELLECT

MATLAB: Give a cell array, get a UI for selecting ("cellecting") contents of one or more cells and returning the contents and their indices. Automated layout of lengthy cell arrays in multiple columns. Option to enable/disable multi-selection. When multi-selection is enabled, uicontrol to select all/de-select all is automatically created.

#### USAGE

    [theChosen, theChosenIDX] = uicellect(theCell, varargin)

#### OUTPUTS
- **theChosen**:     cell array of chosen items (empty if none chosen)
- **theChosenIDX**:  idx to input cell array of choices

#### INPUT
- **theCell**:  cell array of items to choose from

#### VARARGIN 
- these are optional arguments entered as "name, value" pairs
- to see default values, run UICELLECT without any arguments

| NAME            | DESCRIPTION
|:-----------------|:---------------------------------------------------------------------
| **Prompt**          | message to present to user at top of gui
| **MultiSelect**     | if true (or 1), user allowed to select multiple items           
| **MaxPerColumn**    | max items per column (if more than # of items, one column layout)
| **RowPixelHeight**  | height of gui rows (one item per row/column), in pixels     
| **ColPixelWidth**   | width of gui columns, in pixels        
| **BaseFontSize**    | base font size (used for item labels)  
| **hAlign**          | gui horizontal alignment, can be: middle,top,upper,bottom,lower
| **vAlign**          | gui vertical alignment, can be: center, left, right
| **BackgroundColor** | gui background color             
| **ForegroundColor** | gui foreground color

#### USAGE EXAMPLES

    % Create a length 25 cell array of Items (for all examples):
    theCell = cellfun(@sprintf,repmat({'Item %d'},25,1), num2cell((1:25)'),'Unif',false);

    % Present in GUI using Default Settings
    [theChosen, theChosenIDX] = uicellect(theCell); 

    % Present in GUI and disable Multi-Selection
    [theChosen, theChosenIDX] = uicellect(theCell, 'Multi', 0); 

    % Present in GUI but Change How it Looks
    [theChosen, theChosenIDX] = uicellect(theCell, 'MaxPer', 15, 'RowPix', 35, 'ColPix', 150); 

