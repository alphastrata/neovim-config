#!/bin/bash

echo "copying nvim dir here..."
rsync -avP ~/.config/nvim neovim


echo "copying helix"
rsync -avP ~/.config/helix hx

# we don't want their runtime submodules...
rm -rf hx/helix/runtime
