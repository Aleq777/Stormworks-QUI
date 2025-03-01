# Contributing to QUI



Thank you for considering contributing to QUI!

Please take a moment to read through this document to understand how you can contribute effectively and ensure a smooth collaboration with the project maintainers.

## How to Contribute

### 1. Fork the repository
To contribute to this project, you will need to:
1. For the repository
2. Use codespace or clone the repository to your local machine:
```bash
git clone https://github.com/Aleq777/Stormworks-QUI.git
```

### 2. Create a new branch


### 3. Make changes
Now that you're on your own branch, make the necessary changes to improve the project. Here are a few important things to keep in mind while making your changes:

- **Follow the coding style**: Ensure that your code follows the style and conventions used in the project. This helps maintain consistency across the codebase.
- **Write meaningful commit messages**: When committing your changes, write clear and concise commit messages that describe the purpose of the change.
- **Update documentation**: If your changes affect the usage of the project, make sure to update the documentation accordingly.






# Contributting to QUI
Thank you for considering contributing to QUI!

Read this document - it contains helpful information about how to contribute.

## What to contribute
QUI 2 is created with a `Template` and `Object` concept.

You can create your own `Community Template` and **contribute** it, so everyone will be able to use it.

You can also extend QUI 2's concept by **contributting a Community Extension**.

## Requirements
There are some requirements that your contribution must fulfill:

1. The code **must be readable** and **not minified**.
2. Indent of 4 spaces is a preference. It would be nice to see that indent.
3. Comment those parts of code, that aren't easy to understand from just reading. Don't overcomment too.
4. Try to use [**LLS annotations**](https://luals.github.io/wiki/annotations/) - it may help you and others to understand, how your code works.
5. I recommend joining [QUI Discord server](), so you can contact with me faster. Also, it'll be easier for other people to reach out for you.

## Rules

1. I - @Aleq777 - won't make changes to your code. If something isn't right for me - I'll contact you before accepting a PR. Also, you will be the one to resolve issues with your contribution. You cannot transfer Author status - anyone can make their contribution based on someone's else, including you.
2. Contributions can only add, edit or remove **YOUR CONTRIBUTIONS**. Also, they can only affect **Community Extensions** and **Community Templates** folders.


## How to contribute in general

### 1. Fork the repository
Start with basic:
1. For the repository with **Fork** button.
2. Use codespace or clone the repository to your local machine:
```bash
git clone https://github.com/Aleq777/Stormworks-QUI.git
```

### 2. Create a new branch

> [!TPI]
> Before making any changes, it's best practice to create a new branch for each feature or bug fix. This will help keep your work organized and separate from the main project.

Create a new branch in your forked repository or by running:
```bash
git checkout -b feature/your-feature-name
```

### 3. Write the code

- **Follow the coding style**: Ensure that your code follows the style and conventions used in the project. This helps maintain consistency across the codebase.
- **Write meaningful commit messages**: When committing your changes, write clear and concise commit messages that describe the purpose of the change.
- **Additional:** You can write a documentation, which will be included in the contribution.

### 4. Commit
Once you've made the necessary changes, commit them to your branch. Make sure your commit message is clear and concise.

- **Keep commits small and focused**: Each commit should represent a single logical change. Avoid large commits that cover multiple unrelated changes.
- **Commit frequently**: Commit your changes as you go to ensure that your progress is saved. This also makes it easier to review smaller changes.
- **Follow conventional commit messages**: A good commit message should answer the question: "What did you do?" For example:

### 5. Debug
Before making a PR, you **__MUST__** be sure that your code works well.

- Test it in the game, on different monitors.
- Check, how your functions work with different values.

### 6. Push
Everything's ready? **Push** them to your forked repository!

### 7. Pull-Request (PR)
Now, create a Pull-Request.

Here are the steps to create a PR:

- Go to the original repository on GitHub.
- Click on the **Pull requests** tab.
- Click the **New pull request** button.
- Select your branch from the "compare" dropdown and the main branch (e.g., `main`) from the "base" dropdown.
- Add a clear title and description for your pull request. Be sure to explain what your adding and how it works.
- Click **Create pull request** to submit your PR.

After submitting your PR, It'll be reviewed and confirmed or denied. In either case, you'll be contacted by me - @Aleq777.

# Community Template

> [!TIP]
> About creating your own Templates: [Click here]()

## Contribute Template

### Rules

1. Templates should be "simple" - contain only 1 Template (or many, if they're similar).
2. Main Template file should have a heading:
```lua
--- QUI: <QUI VERSION>
--- Community Template: <NAME OF YOUR TEMPLATE>
--- Author: @<YOUR GITHUB NAME>
--- Discord: <YOUR DISCORD NAME (YOU CAN ALSO TYPE YOUR DISCORD ID)>
--- -OTHER WAYS OF CONTACT- not necessary
--- Includes:
---     <THE TEMPLATE> - <SHORT DESCRIPTION>
---@module 'MODULE NAME' REQUIRED -- REQUIRED MODULES
--- OTHER INFO
```

Example:
```lua
--- QUI: 2.0.0
--- Community Template: Mouse
--- Author: @Aleq777
--- Discord: aleq777
--- Includes:
---     Mouse - looks like a Windows cursor and it's following user's pressing location
---@module 'Base' REQUIRED
---@module 'Templates/Interactive/Button' REQUIRED IF you want a fancy mouse
--- DISCLAIMER!
---     This is the best Template! Everyone should use it!
```

# Community Extension

> [!TIP]
> About creating your own Extensions: [Click here]()

## Contribue Extension

### Rules

1. Extensions should be compatible with main QUI scripts.
2. If Extensions override already existing functions - they must be still compatible. Example:
> [!NOTE]
> Let's consider this code as the original part of QUI

```lua
function Draw(x, y, obj)
    -- do smth
    return true
end
```

> [!WARNING]
> This is bad - incompatible

```lua
Draw = function (x, y, z, obj) -- arguments are in a different arrengment
    -- do smth 2
    return false -- function returns unexpected value
end
```

> [!TIP]
> This is good

```lua
Draw = function (x, y, obj, id, z) -- New argument is at the end. It may cause problems, but it isn't much.
    -- do smth 2
    if --[[smth]] then -- new returned value occurs only in a new circumstances
        return true
    end

    return false -- fuction returns expected value normally
end
```

3. Main Extension file should have a heading:
```lua
--- QUI: <QUI VERSION>
--- Community Extension: <NAME OF THE EXTENSION>
--- Author: @<YOUR GITHUB NAME>
--- Discord: <YOUR DISCORD NAME (YOU CAN ALSO TYPE YOUR DISCORD ID)>
--- -OTHER WAYS OF CONTACT- not necessary
---@module 'MODULE NAME' REQUIRED -- required modules
---     A description of the extension. It may be long, short or whatever.
```

Example:
```lua
--- QUI: 2.0
--- Official Extension: Thirt Touch
--- Author: @Aleq777
--- Discord: aleq777
---     Gives the possibility for easy detecting a "Trouch" (E and Q and R pressed at once (is that even possible???))
---@module 'Extensions/Second Touch' REQUIRED
---@module 'Community Extensions/Multi Touch' REQUIRED IF you want to use `MultiTouch` function
```

4. 