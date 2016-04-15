exec = require('child_process').exec

module.exports =

	config:
		rainmeterPath:
			type: 'string'
			default: 'C:\\Program Files\\Rainmeter\\Rainmeter.exe'

	refreshCmd: null

	activate: ->
		refreshCmd = atom.commands.add 'atom-workspace', 'rainmeter:refresh', @refresh

	deactivate: ->
		refreshCmd.dispose()
		refreshCmd = null

	refresh: ->
		filepath = ''
		if editor = atom.workspace.getActiveTextEditor()
			filepath = editor.getPath()
		if filepath != ''
			if filepath.substr(-4) == '.ini'
				config = filepath.substring filepath.indexOf('Rainmeter\\Skins\\')+16, filepath.lastIndexOf('\\')
				skin = filepath.substr filepath.lastIndexOf('\\')+1
				rmpath = atom.config.get('language-rainmeter.rainmeterPath')
				exec("\"#{rmpath}\" !ActivateConfig \"#{config}\" \"#{skin}\"")
				exec("\"#{rmpath}\" !Refresh \"#{config}\"")
			else
				atom.notifications.addWarning 'Not a rainmeter skin',
					detail: 'You can only refresh skin while in the .ini file'
