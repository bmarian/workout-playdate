import "libraries/noble/Noble"

import "lib/store"

import "scenes/LibraryScene"

if Store.load() then
    Noble.new(LibraryScene)
end
