sampleProjectUrl =
  "#{window.location.protocol}//#{window.location.host}/assets/nt-modelslib/Biology/Wolves and Sheep.ntjson"

RactiveBuilderMenu = Ractive.extend({

  data: () -> {
    canUndo:     false     # Boolean
    canRedo:     false     # Boolean
    isDebugMode: false     # Boolean
    popupMenu:   undefined # RactivePopupMenu
    runtimeMode: "dev"     # String
  }

  on: {

    'ntb-show-file-operations': ({ event: { pageX, pageY } }) ->
      popupMenu = @get("popupMenu")
      items = [
        { eventName: 'ntb-clear-all-check', name: 'Clear model and spaces' }
        { spacerText: '-' }

        { eventName: 'ntb-import-json-prompt',   name: 'Import NetTango project' }
        { eventName: 'ntb-load-remote-project',  name: 'Load Wolves and Sheep sample project', data: sampleProjectUrl }
        { eventName: 'ntb-choose-ntjson-prompt', name: 'Choose NetTango library project' }
        { spacerText: '-' }

        { eventName: 'ntb-import-netlogo-prompt', name: 'Import NetLogo model' }
        { eventName: 'ntb-choose-netlogo-prompt', name: 'Choose NetLogo library model' }
        { spacerText: '-' }

        { eventName: 'ntb-export-json', name: 'Export NetTango project' }
        { eventName: 'ntb-export-page', name: 'Export standalone HTML file' }
        { name: 'Preview standalone HTML page', url: '/nettango-player?playMode=true' }
        { spacerText: '-' }

        { eventName: 'ntb-export-netlogo', name: 'Export NetLogo model' }
      ]
      fileOperations = {
        name: "File Operations"
        items: items
      }
      popupMenu.popup(this, pageX, pageY, fileOperations)
      return false

    'ntb-show-help': ({ event: { pageX, pageY } }) ->
      popupMenu = @get("popupMenu")
      helpOptions = {
        name: "Help"
        items: [
          {
              name: 'About the NetTango Builder'
            , url: 'https://github.com/NetLogo/Galapagos/wiki/NetTango-Builder'
          }
          {
              name: 'NetTango Builder tutorial'
            , url: 'https://anttango.netlify.com'
          }
        ]
      }

      if @get('runtimeMode') is 'dev'
        helpOptions.items.push({
            name: 'Toggle web console debug'
          , eventName: 'ntb-toggle-debug'
        })

      popupMenu.popup(this, pageX, pageY, helpOptions)
      return false

    'ntb-toggle-debug': () ->
      @set('isDebugMode', not @get('isDebugMode'))
      return

  }

  template:
    # coffeelint: disable=max_line_length
    """
    <div class="ntb-block-defs-controls">
      <button class="ntb-button" type="button" on-click="ntb-show-file-operations">Files ▼</button>
      <button class="ntb-button" type="button" on-click="ntb-undo"{{# !canUndo }} disabled{{/}}>Undo</button>
      <button class="ntb-button" type="button" on-click="ntb-redo"{{# !canRedo }} disabled{{/}}>Redo</button>
      <button class="ntb-button" type="button" on-click="ntb-show-options">Options...</button>
      <button class="ntb-button" type="button" on-click="ntb-create-blockspace" >Add New Block Space</button>
      <button class="ntb-button" type="button" on-click="ntb-show-help">Help ▼</button>
    </div>
    """
})

export default RactiveBuilderMenu
