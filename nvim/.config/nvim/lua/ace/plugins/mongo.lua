return {
    'thibthib18/mongo-nvim', 
    config = function()
        require('mongo-nvim').setup({
            connection_string = "mongodb://cats_backend:innoflight@10.254.14.11:27017,10.254.14.17:27017,10.254.14.23:27017/",
            list_document_key = {
                cats = {}
            },
        })
    end
}
