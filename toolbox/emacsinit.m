function emacsinit(clientcommand, withGraphicalDebugging)
% EMACSINIT Initialize the current MATLAB session for matlab-shell-mode.
%     Defaultly, the builtin editor is disable and the graphical debugging is enable.
% 
%     EMACSINIT('Default') Enable the builtin editor.
% 
%     EMACSINIT('', 'true') Use the default client editor and enable the
%     graphical debuggin.
% 
    
%% Parset argmuments.
    withBuiltinEditor = false;
    withGraphicalDebugging = true;
    % Use emacsclient no-wait to send edit requests to a runnig emacs.
    defaultClientEditorCommand = 'emacsclient -n';
    if nargin >= 1
        if strcmp(clientcommand, lower('Defualt')) == 1
            withBuiltinEditor = true;
        elseif strcmp(clientcommand, '') == 1
            clientcommand = defaultClientEditorCommand;
        end
    end
  
    %% Configure the matlab. 
    if usejava('jvm')
        % Enable/Disable built-in editor showing up for debugging.
        com.mathworks.services.Prefs.setBooleanPref('EditorGraphicalDebugging', withGraphicalDebugging);
        % Enable/Disable the build-in editor.
        com.mathworks.services.Prefs.setBooleanPref('EditorBuiltinEditor', withBuiltinEditor);
        if ~withBuiltinEditor
            % Set the command for the client editor. 
            com.mathworks.services.Prefs.setStringPref('EditorOtherEditor', clientcommand)
        end
    end

    %% Use the desktop hotlinking system in MATLAB Shell.  matlab-shell
    % will interpret them, and provide clickable areas.
    % NOTE: This doesn't work in all cases where HotLinks are used.
    feature('HotLinks','on');
end