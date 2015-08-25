function [theChosen, theChosenIDX] = uicellect(theCell, varargin)
% UICELLECT Present dialogue for selecting cells from a cell array
%
%  USAGE: [theChosen, theChosenIDX] = uicellect(theCell, varargin)
%
%  OUTPUT
%	theChosen:     cell array of chosen items (empty if none chosen)
%	theChosenIDX:  idx to input cell array of choices
%
% ________________________________________________________________________________________
%  INPUTS
%	theCell:  cell array of items to choose from
%
% ________________________________________________________________________________________
%  VARARGIN
%	Prompt:  
%	MultiSelect:   
%
% ________________________________________________________________________________________
%  EXAMPLES
%	>> cellect
%

% ----------------------------- Copyright (C) 2015 Bob Spunt -----------------------------
%	Created:  2015-08-23
%	Email:     spunt@caltech.edu
% ________________________________________________________________________________________
def = { ... 
	'Prompt',           'Select from the following:',	...
    'MultiSelect',      true, ...
    'MaxPerColumn',     10, ...
    'rowpixelheight',   40, ...
    'colpixelwidth',    300, ...
    'basefontsize',     14, ...
    'backgroundcolor',  [20/255 23/255 24/255], ...
    'foregroundcolor',  [1 1 1] ...
	};
vals = setargs(def, varargin);
if nargin < 1, mfile_showhelp; fprintf('\t| - VARARGIN DEFAULTS - |\n'); disp(vals); return; end
nopt = length(theCell);
if nopt > MaxPerColumn
    ncol = ceil(nopt/MaxPerColumn);
    nrow = ceil(nopt/ncol); 
else
    ncol = 1; 
    nrow = nopt; 
end
screenPos = get(0, 'ScreenSize');
screenW = screenPos(3);
screenH = screenPos(4);
uiW     = 300*ncol;
uiH     = 40*nrow;

figpos = [(screenW/2)-(uiW/2) (screenH/2)-(uiH/2) uiW uiH]; % centered middle
figpos = [1 (screenH/2)-(uiH/2) uiW uiH]; % left middle
figpos = [(screenW)-(uiW) (screenH/2)-(uiH/2) uiW uiH]; % right middle

fige  =  figure( ...
    'Name'                     ,        'UICELLECT'           ,...
    'Units'                    ,        'pix'               ,...
    'Position'                 ,        figpos              ,...
    'Resize'                   ,        'on'                ,...
    'Color'                    ,        backgroundcolor     ,...
    'NumberTitle'              ,        'off'               ,...
    'DockControls'             ,        'off'               ,...
    'MenuBar'                  ,        'none'              ,...
    'Toolbar'                  ,        'none'              ,...
    'Tag'                      ,        'uicellect dialogue'  ,...
    'WindowStyle'              ,        'normal'            ,...
    'UserData'                 ,        1);
                    
[pbase, pidx] = pgrid(3, 1, ...
    'margin', .01, ...
    'panelsep', .025, ...
    'parent', fige, ...
    'relheight', [1 nrow 1], ...
    'backg', backgroundcolor, ...
    'foreg', foregroundcolor); 

ht  =  uicontrol( ...
               'Style'   ,     'text'                                 ,...
              'Parent'   ,     pbase(1)                           ,...
                 'Tag'   ,     'Prompt'                        ,...
              'String'   ,     Prompt                       ,...
               'Units'   ,     'normalized'                           ,...
            'Position'   ,     [0 0 1 1]         ,...
     'BackgroundColor'   ,     backgroundcolor               ,...
     'ForegroundColor'   ,     foregroundcolor              ,...
               'Value'   ,     0                                      ,...
 'HorizontalAlignment'   ,     'left'                                 ,...
              'Enable'   ,     'on'                                   ,...
           'FontAngle'   ,     'normal'                               ,...
            'FontName'   ,     'fixed-width'                          ,...
            'FontSize'   ,     basefontsize*1.25                      ,...
           'FontUnits'   ,     'points'                               ,...
          'FontWeight'   ,     'normal'                               ...
                    );

[popt, poptidx] = pgrid(nrow, ncol, 'parent', pbase(2), 'backg', backgroundcolor, 'foreg', foregroundcolor); 
set(pbase(2), 'bordertype', 'line');
for i = 1:nopt
  
    opth(i)  =  uicontrol( ...
                   'Style'   ,     'check'                                ,...
                  'Parent'   ,     popt(i)                            ,...
                     'Tag'   ,     'opt'                        ,...
                  'String'   ,      theCell{i}                      ,...
                   'Units'   ,     'normalized'                           ,...
                'Position'   ,     [0 0 1 1]          ,...
         'BackgroundColor'   ,     backgroundcolor               ,...
         'ForegroundColor'   ,     foregroundcolor              ,...
                   'Value'   ,     0                                      ,...
     'HorizontalAlignment'   ,     'center'                               ,...
                  'Enable'   ,     'on'                                   ,...
           'TooltipString'   ,     ''                                     ,...
                'Callback'   ,     ''                                     ,...
               'FontAngle'   ,     'normal'                               ,...
                'FontName'   ,     'fixed-width'                          ,...
                'FontSize'   ,     basefontsize                               ,...
               'FontUnits'   ,     'points'                               ,...
              'FontWeight'   ,     'normal'                               ,...
                'UserData'   ,     []                                     ,...
                 'Visible'   ,     'on'                                    ...
                        );                    
end
     
[pui, puiidx] = pgrid(1, ncol+2, 'parent', pbase(3), 'backg', backgroundcolor, 'foreg', foregroundcolor); 

htog  =  uicontrol( ...
               'Style'   ,     'toggle'                                 ,...
              'Parent'   ,     pui(end-1)                            ,...
                 'Tag'   ,     'toggle'                        ,...
              'String'   ,     'Select All'                      ,...
               'Units'   ,     'normalized'                           ,...
            'Position'   ,     [.10 0 .80 1]         ,...
     'BackgroundColor'   ,         foregroundcolor           ,...
     'ForegroundColor'   ,        backgroundcolor          ,...
               'Value'   ,     0                                      ,...
 'HorizontalAlignment'   ,     'center'                               ,...
              'Enable'   ,     'on'                                   ,...
       'TooltipString'   ,     ''                                     ,...
            'Callback'   ,     ''                                     ,...
           'FontAngle'   ,     'normal'                               ,...
            'FontName'   ,     'fixed-width'                          ,...
            'FontSize'   ,     basefontsize*1.1                               ,...
           'FontUnits'   ,     'points'                               ,...
          'FontWeight'   ,     'bold'                               ,...
            'UserData'   ,     []                                     ,...
             'Visible'   ,     'on'                                    ...
                    );
hok  =  uicontrol( ...
               'Style'   ,     'push'                                 ,...
              'Parent'   ,     pui(end)                            ,...
                 'Tag'   ,     'okbutton'                        ,...
              'String'   ,     'FINISH'                      ,...
               'Units'   ,     'normalized'                           ,...
            'Position'   ,     [.05 0 .90 1]          ,...
     'BackgroundColor'   ,     backgroundcolor              ,...
     'ForegroundColor'   ,     foregroundcolor             ,...
               'Value'   ,     0                                      ,...
 'HorizontalAlignment'   ,     'center'                               ,...
              'Enable'   ,     'on'                                   ,...
       'TooltipString'   ,     ''                                     ,...
            'Callback'   ,     ''                                     ,...
           'FontAngle'   ,     'normal'                               ,...
            'FontName'   ,     'fixed-width'                          ,...
            'FontSize'   ,     basefontsize*1.1                              ,...
           'FontUnits'   ,     'points'                               ,...
          'FontWeight'   ,     'bold'                               ,...
            'UserData'   ,     []                                     ,...
             'Visible'   ,     'on'                                    ...
                    );

set(fige, 'CloseRequestFcn', {@cb_closefig, fige, 0})
set(htog, 'Callback', {@cb_selectall, opth});
set(hok, 'Callback', {@cb_closefig, fige, 1})
drawnow
uiwait(fige)
theChosen       = [];
theChosenIDX    = []; 
if ishandle(fige)
    if get(fige, 'UserData')
        idx = cell2mat(get(opth, 'Value'));
        if any(idx)
            str = get(opth, 'string');
            theChosen       = str(find(idx));
            theChosenIDX    = find(idx);
        end
    end
    delete(fige)
end
end
% ========================================================================================
%
% ------------------------------------- SUBFUNCTIONS -------------------------------------
%
% ========================================================================================
function mfile_showhelp(varargin)
% MFILE_SHOWHELP
ST = dbstack('-completenames');
if isempty(ST), fprintf('\nYou must call this within a function\n\n'); return; end
eval(sprintf('help %s', ST(2).file));
end
function argstruct = setargs(defaults, optargs)
% SETARGS Name/value parsing and assignment of varargin with default values
if nargin < 1, mfile_showhelp; return; end
if nargin < 2, optargs = []; end
defaults = reshape(defaults, 2, length(defaults)/2)'; 
if ~isempty(optargs)
    if mod(length(optargs), 2)
        error('Optional inputs must be entered as Name, Value pairs, e.g., myfunction(''name'', value)'); 
    end
    arg = reshape(optargs, 2, length(optargs)/2)';
    for i = 1:size(arg,1)
       idx = strncmpi(defaults(:,1), arg{i,1}, length(arg{i,1}));
       if sum(idx) > 1
           error(['Input "%s" matches multiple valid inputs:' repmat('  %s', 1, sum(idx))], arg{i,1}, defaults{idx, 1});
       elseif ~any(idx)
           error('Input "%s" does not match a valid input.', arg{i,1});
       else
           defaults{idx,2} = arg{i,2};
       end  
    end
end
for i = 1:size(defaults,1), assignin('caller', defaults{i,1}, defaults{i,2}); end
if nargout>0, argstruct = cell2struct(defaults(:,2), defaults(:,1)); end
end
function cb_closefig(varargin)
  set(varargin{3}, 'UserData', varargin{4});
  uiresume(varargin{3})
end
function cb_selectall(varargin)
h = varargin{3}; 
if get(varargin{1}, 'Value')
    for i = 1:length(h)
        set(h, 'Value', 1);
        drawnow; 
    end
    set(varargin{1}, 'String', 'De-Select All'); 
else
    for i = 1:length(h)
        set(h, 'Value', 0);
        drawnow; 
    end
    set(varargin{1}, 'String', 'Select All'); 
end
drawnow
end