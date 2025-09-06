# Nousigi Hub UI Library Documentation

## Overview
The Nousigi Hub UI Library is a comprehensive Roblox GUI framework that provides a modern, customizable interface for creating in-game menus, controls, and notifications. It features a draggable main window, toggleable visibility, multiple pages, sections, and various UI elements.

## Initialization

### Basic Setup
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/.../library.lua"))()
```

### Configuration
The library supports two color themes:
- **T1 Theme**: Red accent colors
- **Index Theme**: Blue accent colors (default)

Toggle between themes:
```lua
getgenv().T1 = true  -- Enable T1 theme (red)
getgenv().T1 = false -- Enable Index theme (blue, default)
```

## Core Functions

### CreateMain(Setting)
Creates the main GUI window.

**Parameters:**
- `Setting` (table): Configuration table with:
  - `Title` (string): Window title
  - `Desc` (string): Window description

**Example:**
```lua
local Main = Library.CreateMain({
    Title = "My Script",
    Desc = "Control Panel"
})
```

### CreateNoti(Setting, bypass)
Creates a notification.

**Parameters:**
- `Setting` (table): Notification settings:
  - `Title` (string): Notification title
  - `Desc` (string): Notification description
  - `ShowTime` (number): Duration in seconds
- `bypass` (boolean): Whether to bypass config checks

**Example:**
```lua
Library.CreateNoti({
    Title = "Success",
    Desc = "Operation completed successfully",
    ShowTime = 5
})
```

### ToggleUI()
Toggles the visibility of the main GUI.

**Example:**
```lua
Library.ToggleUI()
```

### DestroyUI()
Destroys all Nousigi Hub UI elements.

**Example:**
```lua
Library.DestroyUI()
```

## Page Management

### CreatePage(Setting)
Creates a new page in the main GUI.

**Parameters:**
- `Setting` (table): Page configuration:
  - `Page_Name` (string): Internal page name
  - `Page_Title` (string): Displayed page title

**Returns:** Page functions object

**Example:**
```lua
local Page = Main.CreatePage({
    Page_Name = "Combat",
    Page_Title = "Combat Settings"
})
```

## Section Management

### CreateSection(Section_Name, Toggleable, SectionGap, SectionColor)
Creates a section within a page.

**Parameters:**
- `Section_Name` (string): Name of the section
- `Toggleable` (boolean): Whether the section can be collapsed
- `SectionGap` (boolean): Add extra spacing
- `SectionColor` (Color3): Custom section color

**Returns:** Section functions object

**Example:**
```lua
local Section = Page.CreateSection("Weapons", true)
```

## UI Elements

### CreateToggle(Setting, Callback)
Creates a toggle switch.

**Parameters:**
- `Setting` (table): Toggle settings:
  - `Title` (string): Toggle label
  - `Desc` (string): Description text (optional)
  - `Default` (boolean): Initial state
- `Callback` (function): Function called when toggle changes

**Returns:** Toggle control functions

**Example:**
```lua
local Toggle = Section.CreateToggle({
    Title = "God Mode",
    Desc = "Become invincible",
    Default = false
}, function(state)
    print("God Mode:", state)
end)

-- Programmatically change state
Toggle.SetStage(true)
```

### CreateButton(Setting, Callback)
Creates a button.

**Parameters:**
- `Setting` (table): Button settings:
  - `Title` (string): Button text
- `Callback` (function): Function called when clicked

**Example:**
```lua
Section.CreateButton({
    Title = "Teleport to Base"
}, function()
    print("Teleporting...")
end)
```

### CreateLabel(Setting)
Creates a text label.

**Parameters:**
- `Setting` (table): Label settings:
  - `Title` (string): Label text

**Returns:** Label control functions

**Example:**
```lua
local Label = Section.CreateLabel({
    Title = "Status: Ready"
})

-- Update label text
Label.SetText("Status: In Combat")

-- Change label color
Label.SetColor(Color3.fromRGB(255, 0, 0))
```

### CreateDropdown(Setting, Callback)
Creates a dropdown menu.

**Parameters:**
- `Setting` (table): Dropdown settings:
  - `Title` (string): Dropdown label
  - `List` (table): Options list
  - `Search` (boolean): Enable search functionality
  - `Selected` (boolean): Multi-select mode
  - `Slider` (boolean): Show sliders instead of options
  - `SliderRelease` (boolean): Update on release only
  - `Default` (any): Default selection
  - `IndexTable` (table): Key-value pairs for complex data
  - `SortPairs` (function): Custom sorting function
- `Callback` (function): Function called when selection changes

**Returns:** Dropdown control functions

**Examples:**
```lua
-- Simple dropdown
local Dropdown = Section.CreateDropdown({
    Title = "Weapon Selection",
    List = {"Sword", "Axe", "Bow", "Staff"},
    Default = "Sword"
}, function(selected)
    print("Selected:", selected)
end)

-- Multi-select dropdown
local MultiDropdown = Section.CreateDropdown({
    Title = "Enabled Features",
    List = {"Fly", "Noclip", "Speed", "Jump"},
    Selected = true,
    Default = {Fly = true, Speed = true}
}, function(option, state)
    print(option, ":", state)
end)

-- Slider dropdown
local SliderDropdown = Section.CreateDropdown({
    Title = "Settings",
    List = {
        {Title = "WalkSpeed", Min = 16, Max = 200, Default = 50},
        {Title = "JumpPower", Min = 50, Max = 200, Default = 100}
    },
    Slider = true
}, function(setting, value)
    print(setting, ":", value)
end)

-- Update dropdown options
Dropdown.GetNewList({"Pistol", "Rifle", "Shotgun", "Sniper"})
```

### CreateBind(Setting, Callback)
Creates a keybind selector.

**Parameters:**
- `Setting` (table): Keybind settings:
  - `Title` (string): Keybind label
  - `Key` (Enum): Default key
  - `Default` (Enum): Default key (alternative to Key)
- `Callback` (function): Function called when key is pressed

**Example:**
```lua
Section.CreateBind({
    Title = "Toggle Menu",
    Key = Enum.KeyCode.RightShift
}, function(key)
    print("Pressed:", key)
    Library.ToggleUI()
end)
```

### CreateBox(Setting, Callback)
Creates a text input box.

**Parameters:**
- `Setting` (table): Textbox settings:
  - `Title` (string): Textbox label
  - `Placeholder` (string): Placeholder text
  - `Default` (string): Default value
  - `Number` (boolean): Restrict to numbers only
- `Callback` (function): Function called when text is entered

**Returns:** Textbox control functions

**Example:**
```lua
local Textbox = Section.CreateBox({
    Title = "Player Name",
    Placeholder = "Enter username",
    Number = false
}, function(text)
    print("Entered:", text)
end)

-- Programmatically set value
Textbox.SetValue("DefaultPlayer")
```

### CreateSlider(Setting, Callback)
Creates a slider control.

**Parameters:**
- `Setting` (table): Slider settings:
  - `Title` (string): Slider label
  - `Min` (number): Minimum value
  - `Max` (number): Maximum value
  - `Precise` (boolean): Allow decimal values
  - `Default` (number): Default value
- `Callback` (function): Function called when value changes

**Returns:** Slider control functions

**Example:**
```lua
local Slider = Section.CreateSlider({
    Title = "Field of View",
    Min = 50,
    Max = 120,
    Default = 70,
    Precise = true
}, function(value)
    print("FOV:", value)
end)

-- Programmatically set value
Slider.SetValue(90)
```

## Advanced Features

### Customization
The library uses a global `UIColor` table for theming. You can customize colors:

```lua
getgenv().UIColor["Title Text Color"] = Color3.fromRGB(255, 255, 0)
getgenv().UIColor["Background Main Color"] = Color3.fromRGB(30, 30, 30)
```

### Animation Control
Disable animations for better performance:
```lua
getgenv().UIColor["Tween Animation 1 Speed"] = 0
getgenv().UIColor["Tween Animation 2 Speed"] = 0
getgenv().UIColor["Tween Animation 3 Speed"] = 0
```

### UI Positioning
The UI includes a toggle button at the bottom-left corner of the screen. Users can:
- Click to show/hide the main GUI
- Click and hold to drag the button to a new position

## Best Practices

1. **Initialize once**: Check if the library is already loaded before initializing
2. **Use proper callbacks**: Handle errors in callback functions
3. **Memory management**: Use `DestroyUI()` when the UI is no longer needed
4. **Performance**: Disable animations on low-end devices
5. **Organization**: Use pages and sections to logically group controls

## Example Complete Implementation

```lua
-- Load library
if getgenv().Nousigi then return end
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/.../library.lua"))()

-- Create main window
local Main = Library.CreateMain({
    Title = "Combat Script",
    Desc = "v2.0.1"
})

-- Create pages
local CombatPage = Main.CreatePage({
    Page_Name = "Combat",
    Page_Title = "Combat Settings"
})

local VisualsPage = Main.CreatePage({
    Page_Name = "Visuals",
    Page_Title = "Visual Settings"
})

-- Add sections and controls
local AimbotSection = CombatPage.CreateSection("Aimbot", true)

local AimbotToggle = AimbotSection.CreateToggle({
    Title = "Enable Aimbot",
    Desc = "Automatically aim at enemies",
    Default = false
}, function(state)
    -- Aimbot logic here
end)

local FOVSlider = AimbotSection.CreateSlider({
    Title = "Aimbot FOV",
    Min = 1,
    Max = 360,
    Default = 90
}, function(value)
    -- FOV change logic
end)

-- Show notification
Library.CreateNoti({
    Title = "Script Loaded",
    Desc = "Combat script initialized successfully!",
    ShowTime = 5
})
```

This documentation covers the core functionality of the Nousigi Hub UI Library. For advanced usage, examine the source code directly to understand all available options and customization possibilities.
