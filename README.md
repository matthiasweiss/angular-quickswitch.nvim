# About

This plugin is a clone of other popular Angular QuickSwitch plugins, e.g.:

* [Angular CLI QuickSwitch](https://plugins.jetbrains.com/plugin/10587-angular-cli-quickswitch)
* [Angular QuickSwitch](https://marketplace.visualstudio.com/items?itemName=erhise.vs-ng-quick-switch)

While there are similar plugins for NeoVim, e.g. [nvim-quick-switcher](https://github.com/Everduin94/nvim-quick-switcher) 
or [ngswitcher](https://github.com/softoika/ngswitcher.vim), I usually only use the shortcut to toggle
between the class definition and template of an Angular component. However, since this project also
serves as an experiment to get into NeoVim plugin development, I'll probably add the possibility to
switch to all different files directly at some point.

## Usage

`:NgQuickSwitchToggle` toggles between the class definition and the template of your Angular component
(assumes that the files are in the same folder and that the filenames are identical, 
e.g. `src/example.component.html` and `src/example.component.ts`)
