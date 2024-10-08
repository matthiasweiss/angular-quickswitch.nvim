# About

This plugin is a clone of other popular Angular QuickSwitch plugins, e.g.:

* [Angular CLI QuickSwitch](https://plugins.jetbrains.com/plugin/10587-angular-cli-quickswitch)
* [Angular QuickSwitch](https://marketplace.visualstudio.com/items?itemName=erhise.vs-ng-quick-switch)

While there are similar plugins for NeoVim, e.g. [nvim-quick-switcher](https://github.com/Everduin94/nvim-quick-switcher) 
or [ngswitcher](https://github.com/softoika/ngswitcher.vim), I usually only use the shortcut to toggle
between the class definition and template of an Angular component.
## Installation

[lazy.nvim](https://github.com/folke/lazy.nvim)

```
{ "matthiasweiss/angular-quickswitch.nvim", opts = {} }
```

## Usage

`:NgQuickSwitchToggle` has the following behavior: 

* For components it toggles between the class definition and the template of your Angular component
(assumes that the files are in the same folder and that the filenames are identical, 
e.g. `src/example.component.html` and `src/example.component.ts`)
* For any other TypeScript file (e.g. services, pipes, guards, etc.) it toggles between the file and 
its associated test file, it assumes the test suffix to be `.spec.ts`, e.g. `src/example.service.ts` 
and `src/example.service.spec.ts`.

All of the following commands switch to one specific file:

| command                   | file                                                                     |
|---------------------------|--------------------------------------------------------------------------|
| `:NgQuickSwitchClass`     | Class, e.g. `example.component.ts` or `example.service.ts`          |
| `:NgQuickSwitchTemplate`  | Template, e.g. `example.component.html`                             |
| `:NgQuickSwitchTest`      | Test, e.g. `example.component.spec.ts` or `example.service.spec.ts` |

## Keymaps

Since calling the commands manually each time is quite cumbersome, I use the following keymaps:

| command                | keymap       |
|------------------------|--------------|
| `:NgQuickSwitchToggle` | `<leader>qs` |

If you want to use the same keymaps, you can pass `use_default_keymaps=true` as follows:

```
{ "matthiasweiss/angular-quickswitch.nvim", opts = { use_default_keymaps = true } }
```
