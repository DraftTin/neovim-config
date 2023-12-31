return {
    "nvim-tree/nvim-web-devicons",
    config = function()
        require("nvim-web-devicons").set_icon({
            gql = {
                icon = "",
                color = "#e535ab",
                cterm_color = "199",
                name = "GraphQL",
            },
            dockerfile = {
                icon = "🐳",
                -- color = "#e535ab",
                cterm_color = "199",
                name = "Dockerfile",
            },
        })
    end,
}
