function fish_echo_colors
for i in (set -n | string match 'fish*_color*')
echo "set -U $i $$i"
end
end
