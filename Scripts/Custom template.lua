--- Hi!
--- You probably want to create your own Template.
---@see README.md
---@see Wiki for more help
---@see QUI_Discord_Server for additional help (name is written with _ so it displayes colored)

-- If you want to create it and publish it on Github, you should include the following:
-- (also, remember - by publishing it you give permission to others to edit it and make subversions of your work.)
-- (your Template will go into the "Community Templates" folder. In the future, it may be moved to a subfolder.)
-- (as a Contributor, you should join QUI Discord: , so other people can easily ask questions and contribute.)

--- QUI 2
--- Community Template: <NAME YOUR TEMPLATE>
--- Author: <@YOUR_GITHUB_NAME>
--- Includes:
---     <TEMPLATE NAME> - <TEMPLATE DESCRIPTION>
-- It's better to create one Template for one file. if your Template requires another, use this: ---@module 'MODULE (file) NAME' REQUIRED and your comment
---@module 'Base' REQUIRED


-- Here, you define your Template behaviour. So, you must write, how should it display and how it interracts with user and environment
---@see OPTIMISE_ME.md
PushDict(Templates, {
    ["YOUR TEMPLATE NAME"] = function (x, y, obj, id)
        -- x is a horizontal position, where user wants to draw Object of this Template
        -- y is a vertical position -||-
        -- obj contains Object's properties. You can define them below.
        -- id is not required. It's for interactive objects and defines, where values and behaviour is stored.
    end
})


-- With that function, users can create an Object from your Template easily. They can draw it with using it.

--- Describe here your template
---@param YOUR_PARAM TYPE description of the parameter
---@return Object|number
---@nodiscard
function YourTemplateName(here_write_properties, isAnon)
    return Object("YOUR TEMPLATE NAME", {
        -- Define here the properties
    }, isAnon)
end


-- With that function, users can draw an Object from your Template anonymously, so no varaible involving. Easier for using it once.

--- Describe here your template
---@param x number Position
---@param y number Position
---@param YOUR_PARAM TYPE description of the parameter
---@param id any -- you can add id parameter (AS THIRD PARAMETER, AFTER y) if you make an interactive Tempalte.
function DrawYourTemplateName(x, y, here_write_properties)
    Draw(x, y,
        YourTemplateName(here_write_properties, true) --, id
    )
end


-- Test your Template. It should be easy to use, short and it shouldn't contain bugs. It may also contain exception handling.
-- Commit and make Pull Request.
-- If any questions, ask.
-- If I will have questions, I will contact with you.