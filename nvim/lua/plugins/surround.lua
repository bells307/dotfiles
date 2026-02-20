return {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            aliases = {
                ["a"] = ">", -- angle brackets
                ["b"] = ")",
                ["B"] = "}",
                ["r"] = "]",
                ["q"] = { '"', "'", "`" }, -- любые кавычки
                ["s"] = { "}", "]", ")", ">", '"', "'", "`" }, -- любые surrounds
            },
            -- Кастомные surrounds
            surrounds = {
                -- Markdown
                ["l"] = {
                    add = function()
                        local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                        return {
                            { "[" },
                            { "](" .. clipboard .. ")" },
                        }
                    end,
                    find = "%b[]%b()",
                    delete = "^(%[)().-(%]%b())()$",
                    change = {
                        target = "^()()%b[]%((.-)%)()()$",
                        replacement = function()
                            local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                            return {
                                { "" },
                                { clipboard },
                            }
                        end,
                    },
                },
                -- Markdown bold
                ["*"] = {
                    add = { "**", "**" },
                    find = "%*%*.-%*%*",
                    delete = "^(%*%*)().-(%*%*)()$",
                    change = {
                        target = "^(%*%*)().-(%*%*)()$",
                    },
                },
                -- Markdown italic
                ["_"] = {
                    add = { "_", "_" },
                    find = "_.-_",
                    delete = "^(_)().-(_)()$",
                    change = {
                        target = "^(_)().-(_)()$",
                    },
                },
                -- Markdown code
                ["c"] = {
                    add = { "`", "`" },
                    find = "`.-`",
                    delete = "^(`)().-(`)()",
                    change = {
                        target = "^(`)().-(`)()",
                    },
                },
                -- Markdown code block
                ["C"] = {
                    add = { "```\n", "\n```" },
                    find = "```.-```",
                    delete = "^(```%s*)().-(%s*```)()$",
                    change = {
                        target = "^(```%s*)().-(%s*```)()$",
                    },
                },
                -- HTML/JSX comment
                ["!"] = {
                    add = { "<!-- ", " -->" },
                    find = "<!%-%-.-%-%->" ,
                    delete = "^(<!%-%-%s*)().-(%s*%-%->)()$",
                    change = {
                        target = "^(<!%-%-%s*)().-(%s*%-%->)()$",
                    },
                },
            },
            -- Подсветка при операциях
            highlight = {
                duration = 200,
            },
            -- Перемещение курсора после операции
            move_cursor = "begin",
        })
    end,
}
