Id = {}
vim.api.nvim_create_user_command('Spoiler', function()
        buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, true, { "test" })
        opts = { relative = 'cursor', width = 20, height = 1, col = 0, row = 1, anchor = 'NW', style = 'minimal' }

        Id = vim.api.nvim_create_autocmd({ 'CursorHold' },
            {
                callback = function(ev)
                    oldreg = vim.fn.getreg('a')
                    vim.api.nvim_feedkeys('"ayaw', 'nx', false)

                    w = vim.fn.getreg('a')
                    vim.fn.setreg('a', oldreg)
                    vim.api.nvim_buf_set_lines(buf, 0, -1, true, { w })
                    vim.api.nvim_buf_call(buf,
                        function()
                            vim.api.nvim_feedkeys('g??', 'nx', false)
                        end
                    )


                    win = vim.api.nvim_open_win(buf, false, opts)


                    vim.api.nvim_create_autocmd({ 'CursorMoved' },
                        {
                            callback = function()
                                vim.api.nvim_win_close(win, false)
                            end,
                            once = true
                        })
                end
            })
    end,
    {})

vim.api.nvim_create_user_command('NoSpoiler', function()
    vim.api.nvim_del_autocmd(Id)
end, {})
