Store = Store or {}

local FREE_EXERCISE_DB <const> = "free-exercise-db.json"

Store.exercises = nil
Store.userExercises = nil

-- loads and caches free-exercise-db list
function Store.loadFreeExerciseDb()
    if Store.exercises then
        return Store.exercises
    end

    local exercises, err = json.decodeFile("data/" .. FREE_EXERCISE_DB)
    if not exercises then
        Store.exercises = {}
        print("Failed to load Free Exercise DB " .. tostring(err))
    else
        Store.exercises = exercises
        print("Succesfully loaded " .. table.getSize(Store.exercises) .. " exercises from Free Exercise DB.")
    end

    return Store.exercises
end

function Store.load()
    Store.loadFreeExerciseDb()
    return true
end
