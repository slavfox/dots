function add_to_path --description 'Add to user paths if not already added'
    for p in $argv
        if test -d p
            set abs (realpath $p)
            if not string match -q "*$abs*" $fish_user_paths
                set -xU fish_user_paths $fish_user_paths $abs
            end
        end
    end
end
